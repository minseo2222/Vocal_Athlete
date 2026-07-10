/// F2 — 보컬 부하 ledger 영속화 어댑터.
///
/// 부하 예산(VocalLoadLedger)을 작은 로컬 메타데이터로 저장한다. 저장 시 소유
/// 학습일(epochDay)을 함께 기록하고, 로드 시 오늘과 다르면 새 일자로 보고 빈
/// ledger를 돌려준다(일일 리셋 — 발성시간·포인트·고강도/full-take 카운트 모두).
/// 손상 JSON은 백업 키로 격리하고 안전하게 빈 ledger로 폴백한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';
import 'vocal_load_budget.dart';

class VocalLoadStore {
  VocalLoadStore({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'vocal_load_v1';
  final AppMetadataStore _metadataStore;

  /// 오늘 학습일 기준으로 ledger를 로드한다. 저장된 소유 학습일이 다르면
  /// (날짜가 바뀌었으면) 빈 ledger를 반환한다.
  Future<VocalLoadLedger> load({required int todayEpochDay}) async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return const VocalLoadLedger();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) throw const FormatException('vocal load is not a map');
      final map = Map<String, dynamic>.from(decoded);
      final ledgerJson = map['ledger'];
      final stored = ledgerJson is Map
          ? VocalLoadLedger.fromJson(Map<String, dynamic>.from(ledgerJson))
          : const VocalLoadLedger();
      if (map['epochDay'] != todayEpochDay) {
        // 일일 리셋: 포인트·카운트·세션 발성시간은 비우되, 회복 윈도우 앵커인
        // lastHighEpochDay는 보존해야 다일(24~72h) 회복 권고가 작동한다.
        return VocalLoadLedger(lastHighEpochDay: stored.lastHighEpochDay);
      }
      return stored;
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return const VocalLoadLedger();
    }
  }

  Future<void> save(
    VocalLoadLedger ledger, {
    required int todayEpochDay,
  }) =>
      _metadataStore.writeString(
        storageKey,
        jsonEncode({'epochDay': todayEpochDay, 'ledger': ledger.toJson()}),
      );

  Future<void> clear() => _metadataStore.remove(storageKey);
}
