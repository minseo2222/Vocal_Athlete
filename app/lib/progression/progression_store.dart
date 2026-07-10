/// v14 — Progression 영속화 어댑터.
///
/// 작은 진행 메타데이터만 SharedPreferencesAsync 계층에 저장한다. legacy
/// `progression_v1` 값은 최초 읽기 때 무손실 이전되며, 손상 JSON은 백업 키로
/// 격리한 뒤 신규 진행 상태로 안전하게 폴백한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';
import 'progression_state.dart';

class ProgressionStore {
  ProgressionStore({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'progression_v1';
  final AppMetadataStore _metadataStore;

  Future<Progression?> load() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) throw const FormatException('progression is not a map');
      return Progression.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return null;
    }
  }

  Future<void> save(Progression progression) => _metadataStore.writeString(
        storageKey,
        jsonEncode(progression.toJson()),
      );

  Future<void> clear() => _metadataStore.remove(storageKey);
}
