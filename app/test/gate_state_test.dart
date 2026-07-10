/// Stage 0 — 게이트 상태·카드 잠금 가드 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/gate_state.dart';

void main() {
  group('evaluateCardGate', () {
    test('S0.1 영구 잠금 기법은 어떤 상태에서도 locked', () {
      for (final g in GateState.values) {
        expect(
          evaluateCardGate(
            gateState: g,
            flagEnabled: true,
            isCandidate: true, // 후보로 표시돼도
            isPermanentlyLocked: true, // 영구 잠금이 최우선
          ),
          CardLockState.locked,
          reason: '$g 에서도 영구 잠금은 unlock 금지',
        );
      }
    });

    test('S0.2 후보 아님 → 기본 잠금', () {
      expect(
        evaluateCardGate(
          gateState: GateState.released,
          flagEnabled: true,
          isCandidate: false,
          isPermanentlyLocked: false,
        ),
        CardLockState.locked,
      );
    });

    test('S0.3 후보 + enforced + 플래그 통과 → unlocked', () {
      expect(
        evaluateCardGate(
          gateState: GateState.enforced,
          flagEnabled: true,
          isCandidate: true,
          isPermanentlyLocked: false,
        ),
        CardLockState.unlocked,
      );
      expect(
        evaluateCardGate(
          gateState: GateState.released,
          flagEnabled: true,
          isCandidate: true,
          isPermanentlyLocked: false,
        ),
        CardLockState.unlocked,
      );
    });

    test('S0.4 후보라도 플래그 꺼지면 잠금', () {
      expect(
        evaluateCardGate(
          gateState: GateState.enforced,
          flagEnabled: false,
          isCandidate: true,
          isPermanentlyLocked: false,
        ),
        CardLockState.locked,
      );
    });

    test('S0.5 enforced 이전 단계는 후보여도 잠금', () {
      for (final g in [
        GateState.none,
        GateState.pending,
        GateState.signedOff,
        GateState.revoked,
      ]) {
        expect(
          evaluateCardGate(
            gateState: g,
            flagEnabled: true,
            isCandidate: true,
            isPermanentlyLocked: false,
          ),
          CardLockState.locked,
          reason: '$g 는 enforced 미만/revoked → 잠금',
        );
      }
    });

    test('S0.6 영구 잠금 식별자 집합에 고강도 3종 포함', () {
      expect(kPermanentlyLockedTechniques, contains('belt_high'));
      expect(kPermanentlyLockedTechniques, contains('chest_dominant_high'));
      expect(kPermanentlyLockedTechniques, contains('hard_glottal_onset'));
    });
  });
}
