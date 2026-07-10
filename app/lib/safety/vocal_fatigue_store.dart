/// F2 — 경량 음성 피로 자가체크 영속화 어댑터.
///
/// 가장 최근 자가체크 1건만 작은 로컬 메타데이터로 저장한다(진단 아님, 소프트
/// 신호). 손상 JSON은 백업 키로 격리한 뒤 null로 안전하게 폴백한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';
import 'vocal_recovery.dart';

class VocalFatigueStore {
  VocalFatigueStore({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'vocal_fatigue_v1';
  final AppMetadataStore _metadataStore;

  Future<VocalFatigueSelfCheck?> load() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) throw const FormatException('not a map');
      return VocalFatigueSelfCheck.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return null;
    }
  }

  Future<void> save(VocalFatigueSelfCheck check) => _metadataStore.writeString(
        storageKey,
        jsonEncode(check.toJson()),
      );

  Future<void> clear() => _metadataStore.remove(storageKey);
}
