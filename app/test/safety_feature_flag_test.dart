/// Stage 0 — 안전 피처플래그·킬스위치 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/gate_state.dart';
import 'package:vocal_athlete/safety/safety_feature_flag.dart';

SafetyFeatureFlag _flag({
  double rollout = 1.0,
  bool kill = false,
  GateState minGate = GateState.enforced,
  Set<String> allow = const {},
}) =>
    SafetyFeatureFlag(
      key: 'enforced.lowIntensityTwang',
      minGateState: minGate,
      rolloutPercent: rollout,
      killSwitch: kill,
      cohortAllowlist: allow,
    );

void main() {
  test('S0.7 stableBucket는 결정적이고 [0,1)', () {
    expect(stableBucket('user-1'), stableBucket('user-1'));
    final b = stableBucket('user-42');
    expect(b, greaterThanOrEqualTo(0));
    expect(b, lessThan(1));
  });

  test('S0.8 config 불가 → fail-safe OFF', () {
    expect(
      isFlagEnabled(
        flag: _flag(),
        gateState: GateState.enforced,
        userId: 'u',
        configReachable: false,
      ),
      isFalse,
    );
  });

  test('S0.9 killSwitch → OFF', () {
    expect(
      isFlagEnabled(
        flag: _flag(kill: true),
        gateState: GateState.released,
        userId: 'u',
      ),
      isFalse,
    );
  });

  test('S0.10 revoked → OFF(재잠금)', () {
    expect(
      isFlagEnabled(
        flag: _flag(),
        gateState: GateState.revoked,
        userId: 'u',
      ),
      isFalse,
    );
  });

  test('S0.11 gate가 min 미만이면 OFF', () {
    expect(
      isFlagEnabled(
        flag: _flag(minGate: GateState.enforced),
        gateState: GateState.signedOff,
        userId: 'u',
      ),
      isFalse,
    );
  });

  test('S0.12 enforced + rollout 100% → ON', () {
    expect(
      isFlagEnabled(
        flag: _flag(rollout: 1.0),
        gateState: GateState.enforced,
        userId: 'u',
      ),
      isTrue,
    );
  });

  test('S0.13 rollout 0%이면 allowlist만 ON', () {
    expect(
      isFlagEnabled(
        flag: _flag(rollout: 0),
        gateState: GateState.enforced,
        userId: 'vip',
      ),
      isFalse,
    );
    expect(
      isFlagEnabled(
        flag: _flag(rollout: 0, allow: {'vip'}),
        gateState: GateState.enforced,
        userId: 'vip',
      ),
      isTrue,
    );
  });

  test('S0.14 ≤1% 카나리: 대부분 OFF, 버킷 미만만 ON', () {
    // 1000개 합성 ID 중 1% 롤아웃이면 대략 소수만 통과(결정적·버킷 기반).
    var on = 0;
    for (var i = 0; i < 1000; i++) {
      if (isFlagEnabled(
        flag: _flag(rollout: 0.01),
        gateState: GateState.enforced,
        userId: 'user-$i',
      )) {
        on++;
      }
    }
    expect(on, lessThan(50)); // 1% 근방 — 절대 다수 OFF
  });

  test('S0.15 flag json round-trip', () {
    final f = _flag(rollout: 0.01, allow: {'a', 'b'});
    final back = SafetyFeatureFlag.fromJson(f.toJson());
    expect(back.key, f.key);
    expect(back.minGateState, GateState.enforced);
    expect(back.rolloutPercent, 0.01);
    expect(back.cohortAllowlist, {'a', 'b'});
  });
}
