/// F2 — 음역 경계 승격 추적기 영속화 어댑터.
///
/// 현재 확장 시도 중인 단일 경계의 추적 상태(trial/usable/stopped·streak·통증)를
/// 작은 로컬 메타데이터로 저장한다. 손상 JSON은 백업 키로 격리한 뒤 새 trial
/// 추적기로 안전하게 폴백한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';
import 'vocal_recovery.dart';

class RangeBoundaryStore {
  RangeBoundaryStore({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'range_boundary_v1';
  final AppMetadataStore _metadataStore;

  Future<RangeBoundaryTracker> load() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return const RangeBoundaryTracker();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) throw const FormatException('not a map');
      return RangeBoundaryTracker.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return const RangeBoundaryTracker();
    }
  }

  Future<void> save(RangeBoundaryTracker tracker) => _metadataStore.writeString(
        storageKey,
        jsonEncode(tracker.toJson()),
      );

  Future<void> clear() => _metadataStore.remove(storageKey);
}
