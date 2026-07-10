/// Stage 0 — 전역 안전 불변식: 고강도 belt/통성/하드글로탈은 어떤 상태에서도 unlock 안 됨.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/gate_state.dart';
import 'package:vocal_athlete/safety/safety_feature_flag.dart';

void main() {
  test('GLOBAL: 영구 잠금 기법은 모든 게이트·플래그 조합에서 locked', () {
    // 후보로 표시하고 플래그를 최대 허용(enforced 이상·rollout 100%·kill 없음)으로 켜도,
    // 영구 잠금이면 어떤 GateState에서도 unlock 되지 않아야 한다.
    const maxFlag = SafetyFeatureFlag(
      key: 'enforced.x',
      minGateState: GateState.enforced,
      rolloutPercent: 1.0,
    );
    for (final tech in kPermanentlyLockedTechniques) {
      for (final gate in GateState.values) {
        for (final reachable in [true, false]) {
          final flagOn = isFlagEnabled(
            flag: maxFlag,
            gateState: gate,
            userId: 'u',
            configReachable: reachable,
          );
          final lock = evaluateCardGate(
            gateState: gate,
            flagEnabled: flagOn,
            isCandidate: true, // 후보로 잘못 표시돼도
            isPermanentlyLocked: true, // tech ∈ kPermanentlyLockedTechniques
          );
          expect(
            lock,
            CardLockState.locked,
            reason: '$tech @ gate=$gate reachable=$reachable 에서 unlock 금지',
          );
        }
      }
    }
  });

  test('GLOBAL: 영구 잠금 집합이 고강도 3종을 포함(빠지면 실패)', () {
    expect(
      kPermanentlyLockedTechniques,
      containsAll(['belt_high', 'chest_dominant_high', 'hard_glottal_onset']),
    );
  });
}
