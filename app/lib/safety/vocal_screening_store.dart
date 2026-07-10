/// Stage 0 — A2 적신호 스크리닝 결과 영속화 어댑터.
///
/// 가장 최근 스크리닝 결과 1건만 저장한다(진단 아님 — 적신호 자가점검). 손상 JSON은
/// 백업 키로 격리한 뒤 **보수적으로 null(=미스크리닝, 재스크린 필요)** 로 폴백한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';
import 'vocal_screening.dart';

class VocalScreeningStore {
  VocalScreeningStore({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'vocal_screening_v1';
  final AppMetadataStore _metadataStore;

  Future<ScreeningResult?> load() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) throw const FormatException('not a map');
      return ScreeningResult.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return null;
    }
  }

  Future<void> save(ScreeningResult result) => _metadataStore.writeString(
        storageKey,
        jsonEncode(result.toJson()),
      );

  Future<void> clear() => _metadataStore.remove(storageKey);
}
