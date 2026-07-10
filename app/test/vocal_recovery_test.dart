/// F2 — 회복 윈도우 · VFI · 음역 경계 승격 순수 도메인 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';

void main() {
  group('recoveryStatusAfterHighLoad', () {
    test('F2.1 <24h 회복 중, 24~72h 부분 회복, ≥72h 완전 회복', () {
      expect(recoveryStatusAfterHighLoad(0), RecoveryStatus.recovering);
      expect(recoveryStatusAfterHighLoad(23), RecoveryStatus.recovering);
      expect(recoveryStatusAfterHighLoad(24), RecoveryStatus.partiallyRecovered);
      expect(recoveryStatusAfterHighLoad(71), RecoveryStatus.partiallyRecovered);
      expect(recoveryStatusAfterHighLoad(72), RecoveryStatus.recovered);
    });
  });

  group('recoveryStatusAfterHighLoadDays', () {
    test('F2.x 일 단위 매핑(0=회복중, 1·2=부분, 3=완전)', () {
      expect(recoveryStatusAfterHighLoadDays(0), RecoveryStatus.recovering);
      expect(recoveryStatusAfterHighLoadDays(1), RecoveryStatus.partiallyRecovered);
      expect(recoveryStatusAfterHighLoadDays(2), RecoveryStatus.partiallyRecovered);
      expect(recoveryStatusAfterHighLoadDays(3), RecoveryStatus.recovered);
    });
  });

  group('VocalFatigueReport (VFI)', () {
    test('F2.2 모든 요인 정상 → escalation 불필요', () {
      const r = VocalFatigueReport(
        factor1Tiredness: 10,
        factor2Discomfort: 3,
        factor3RestRecovery: 15,
      );
      expect(r.needsEscalation, isFalse);
    });

    test('F2.3 F1≥24 컷오프 → escalation', () {
      const r = VocalFatigueReport(
        factor1Tiredness: 24,
        factor2Discomfort: 0,
        factor3RestRecovery: 20,
      );
      expect(r.factor1Elevated, isTrue);
      expect(r.needsEscalation, isTrue);
    });

    test('F2.4 F2≥7 컷오프 → escalation', () {
      const r = VocalFatigueReport(
        factor1Tiredness: 0,
        factor2Discomfort: 7,
        factor3RestRecovery: 20,
      );
      expect(r.factor2Elevated, isTrue);
      expect(r.needsEscalation, isTrue);
    });

    test('F2.5 F3≤7(회복 저조, 역방향) → escalation', () {
      const r = VocalFatigueReport(
        factor1Tiredness: 0,
        factor2Discomfort: 0,
        factor3RestRecovery: 7,
      );
      expect(r.factor3PoorRecovery, isTrue);
      expect(r.needsEscalation, isTrue);
    });

    test('F2.6 VFI json round-trip', () {
      const r = VocalFatigueReport(
        factor1Tiredness: 24,
        factor2Discomfort: 8,
        factor3RestRecovery: 5,
        epochDay: 42,
      );
      final back = VocalFatigueReport.fromJson(r.toJson());
      expect(back.factor1Tiredness, 24);
      expect(back.factor2Discomfort, 8);
      expect(back.factor3RestRecovery, 5);
      expect(back.epochDay, 42);
      expect(back.needsEscalation, isTrue);
    });
  });

  group('VocalFatigueSelfCheck (경량)', () {
    test('F2.12 모든 문항 임계 미만 → escalation 불필요', () {
      const c = VocalFatigueSelfCheck(
        tiredness: 6,
        discomfort: 0,
        poorRecovery: 3,
      );
      expect(c.needsEscalation, isFalse);
    });

    test('F2.13 한 문항이라도 임계(7) 이상 → escalation', () {
      const c = VocalFatigueSelfCheck(
        tiredness: 0,
        discomfort: 7,
        poorRecovery: 0,
      );
      expect(c.needsEscalation, isTrue);
    });

    test('F2.14 self-check json round-trip', () {
      const c = VocalFatigueSelfCheck(
        tiredness: 8,
        discomfort: 2,
        poorRecovery: 9,
        epochDay: 50,
      );
      final back = VocalFatigueSelfCheck.fromJson(c.toJson());
      expect(back.tiredness, 8);
      expect(back.poorRecovery, 9);
      expect(back.epochDay, 50);
      expect(back.needsEscalation, isTrue);
    });
  });

  group('evaluateSymptomLock', () {
    test('S0 정상 → none, soft 초과 → softReduce', () {
      expect(evaluateSymptomLock(vfcScore: 4), SymptomLock.none);
      expect(evaluateSymptomLock(vfcScore: 6), SymptomLock.softReduce); // >5
    });

    test('S0 VFC hard·통증·쉰목소리·VFI컷오프 → hardLockout', () {
      expect(evaluateSymptomLock(vfcScore: 8), SymptomLock.hardLockout);
      expect(evaluateSymptomLock(vfcScore: 0, painReported: true),
          SymptomLock.hardLockout);
      expect(evaluateSymptomLock(vfcScore: 0, hoarsenessDays: 3),
          SymptomLock.hardLockout);
      expect(evaluateSymptomLock(vfcScore: 0, vfiCutoffCrossed: true),
          SymptomLock.hardLockout);
    });

    test('S0 반복 트리거 누적 → referral', () {
      expect(
        evaluateSymptomLock(vfcScore: 8, recentTriggerCount: 3),
        SymptomLock.referral,
      );
    });

    test('S0 lockoutUntil = 증상잠금 vs 회복윈도우 max', () {
      // 증상 잠금 24h(=1일): triggered=100 → 101.
      expect(lockoutUntilEpochDay(triggeredEpochDay: 100), 101);
      // 회복 윈도우(72h=3일)가 더 늦으면 그쪽: lastHigh=100 → 103 > 101.
      expect(
        lockoutUntilEpochDay(triggeredEpochDay: 100, lastHighEpochDay: 100),
        103,
      );
    });

    test('S0 SymptomState isLockedAt + json round-trip', () {
      const s = SymptomState(
          lockoutUntilEpochDay: 105, triggerCount: 2, lastTriggerEpochDay: 100);
      expect(s.isLockedAt(104), isTrue);
      expect(s.isLockedAt(105), isFalse);
      final back = SymptomState.fromJson(s.toJson());
      expect(back.lockoutUntilEpochDay, 105);
      expect(back.triggerCount, 2);
    });
  });

  group('RangeBoundaryTracker', () {
    BoundaryVerification pass() => const BoundaryVerification(
          nextDayRecovered: true,
          qualityMaintained: true,
          f0StableNoFatigue: true,
        );

    test('F2.7 연속 충족 누적 → trial에서 usable 승격', () {
      var t = const RangeBoundaryTracker();
      expect(t.status, BoundaryStatus.trial);
      t = t.record(pass());
      expect(t.status, BoundaryStatus.trial); // streak 1
      expect(t.passStreak, 1);
      t = t.record(pass());
      expect(t.status, BoundaryStatus.usable); // streak 2 → 승격
    });

    test('F2.8 한 항목 실패는 연속 streak 리셋', () {
      var t = const RangeBoundaryTracker().record(pass());
      expect(t.passStreak, 1);
      t = t.record(const BoundaryVerification(
        nextDayRecovered: true,
        qualityMaintained: false, // 음질 미유지
        f0StableNoFatigue: true,
      ));
      expect(t.passStreak, 0);
      expect(t.status, BoundaryStatus.trial);
    });

    test('F2.9 같은 부위 통증 2회 재발 → 확장 중단 + 48h 경감', () {
      var t = const RangeBoundaryTracker().record(
        const BoundaryVerification(
          nextDayRecovered: false,
          qualityMaintained: true,
          f0StableNoFatigue: true,
          painArea: 'throat',
        ),
      );
      expect(t.status, BoundaryStatus.trial); // 1회는 아직 중단 아님
      expect(t.painCount, 1);
      t = t.record(
        const BoundaryVerification(
          nextDayRecovered: false,
          qualityMaintained: true,
          f0StableNoFatigue: true,
          painArea: 'throat', // 같은 부위 재발
        ),
      );
      expect(t.status, BoundaryStatus.stopped);
      expect(t.recommendedDeloadHours, kBoundaryDeloadHours);
      // 중단 상태는 이후 충족이 와도 유지.
      expect(t.record(pass()).status, BoundaryStatus.stopped);
    });

    test('F2.10 다른 부위 통증은 재발로 누적되지 않음', () {
      var t = const RangeBoundaryTracker().record(
        const BoundaryVerification(
          nextDayRecovered: false,
          qualityMaintained: true,
          f0StableNoFatigue: true,
          painArea: 'throat',
        ),
      );
      t = t.record(
        const BoundaryVerification(
          nextDayRecovered: false,
          qualityMaintained: true,
          f0StableNoFatigue: true,
          painArea: 'jaw', // 다른 부위 → 카운트 새로 시작
        ),
      );
      expect(t.status, BoundaryStatus.trial);
      expect(t.painArea, 'jaw');
      expect(t.painCount, 1);
    });

    test('F2.11 tracker json round-trip', () {
      final t = const RangeBoundaryTracker().record(pass()).record(pass());
      final back = RangeBoundaryTracker.fromJson(t.toJson());
      expect(back.status, BoundaryStatus.usable);
      expect(back.passStreak, 2);
    });
  });
}
