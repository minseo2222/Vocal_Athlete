/// Stage 0 — 안전 피처플래그 + 킬스위치 (Flutter import 없음).
///
/// fail-closed 설계: 원격 config 불가 → OFF(잠금). killSwitch·revoked → OFF.
/// 카나리 롤아웃은 안정 해시 버킷으로 같은 사용자가 항상 같은 결과를 받게 한다.
/// 근거: docs/research/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md (A8/A9).
library;

import 'gate_state.dart';

class SafetyFeatureFlag {
  const SafetyFeatureFlag({
    required this.key,
    required this.minGateState,
    this.rolloutPercent = 0,
    this.killSwitch = false,
    this.cohortAllowlist = const {},
  });

  final String key;
  final GateState minGateState;

  /// 0.0~1.0. 카나리는 ≤0.01에서 시작.
  final double rolloutPercent;
  final bool killSwitch;
  final Set<String> cohortAllowlist;

  Map<String, dynamic> toJson() => {
        'key': key,
        'minGateState': minGateState.name,
        'rolloutPercent': rolloutPercent,
        'killSwitch': killSwitch,
        'cohortAllowlist': cohortAllowlist.toList(),
      };

  static SafetyFeatureFlag fromJson(Map<String, dynamic> j) => SafetyFeatureFlag(
        key: (j['key'] as String?) ?? '',
        minGateState: GateState.values.firstWhere(
          (s) => s.name == j['minGateState'],
          orElse: () => GateState.enforced,
        ),
        rolloutPercent: (j['rolloutPercent'] as num?)?.toDouble() ?? 0,
        killSwitch: (j['killSwitch'] as bool?) ?? false,
        cohortAllowlist: {
          for (final id in (j['cohortAllowlist'] as List? ?? const []))
            id as String,
        },
      );
}

/// 안정 해시 버킷 → [0,1). 같은 userId는 항상 같은 값(롤아웃 안정성). FNV-1a 32bit.
double stableBucket(String userId) {
  var h = 0x811c9dc5;
  for (final c in userId.codeUnits) {
    h ^= c;
    h = (h * 0x01000193) & 0xFFFFFFFF;
  }
  return h / 0x100000000;
}

/// 플래그 활성 여부. fail-closed: config 불가·kill·gate 미만·revoked는 모두 OFF.
bool isFlagEnabled({
  required SafetyFeatureFlag flag,
  required GateState gateState,
  required String userId,
  bool configReachable = true,
}) {
  if (!configReachable) return false; // fail-safe 잠금
  if (flag.killSwitch) return false;
  if (gateState == GateState.revoked) return false; // 명시적 재잠금
  if (gateState.index < flag.minGateState.index) return false;
  if (flag.cohortAllowlist.contains(userId)) return true;
  return stableBucket(userId) < flag.rolloutPercent;
}
