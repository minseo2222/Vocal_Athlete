import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/voice_state.dart';
import 'package:vocal_athlete/safety/vocal_load_budget.dart';

Card _card({
  int? maxDurationSec,
  int? maxSustainSec,
  int? maxReps,
  int? maxTakeCount,
  int? weeklyCap,
  int? requiredRestHours,
}) =>
    Card(
      id: 'X',
      cue: const ['c'],
      voicedMicroWin: const ['w'],
      maxDurationSec: maxDurationSec,
      maxSustainSec: maxSustainSec,
      maxReps: maxReps,
      maxTakeCount: maxTakeCount,
      weeklyCap: weeklyCap,
      requiredRestHours: requiredRestHours,
    );

void main() {
  test('v5 vocal load maps card safety intensity to point cost', () {
    final low = kCardLibrary['CARD-01']!;
    final moderate = kCardLibrary['TONE-08']!;
    final gated = kCardLibrary['GY-05']!;
    expect(VocalLoadPolicy.intensityForCard(low), VocalLoadIntensity.low);
    expect(VocalLoadPolicy.intensityForCard(moderate), VocalLoadIntensity.moderate);
    expect(VocalLoadPolicy.intensityForCard(gated), VocalLoadIntensity.gated);
    expect(VocalLoadPolicy.costForIntensity(VocalLoadIntensity.gated), 5);
  });

  test('v5 hoarse state turns any vocal load into recovery mode', () {
    final decision = const VocalLoadPolicy().evaluate(
      card: kCardLibrary['GY-05']!,
      ledger: const VocalLoadLedger(),
      voiceState: VoiceState.hoarse,
    );
    expect(decision.allowed, isTrue);
    expect(decision.mode, VocalLoadMode.recovery);
  });

  test('v5 gated cards are blocked when gated daily cap is zero', () {
    final decision = const VocalLoadPolicy().evaluate(
      card: kCardLibrary['GY-05']!,
      ledger: const VocalLoadLedger(),
      voiceState: VoiceState.ok,
    );
    expect(decision.allowed, isFalse);
    expect(decision.mode, VocalLoadMode.blocked);
    expect(decision.fallbackCardId, isNotNull);
  });

  test('v5 ledger records points, high counts, full takes, and json', () {
    final ledger = const VocalLoadLedger()
        .add(intensity: VocalLoadIntensity.low, epochDay: 10)
        .add(intensity: VocalLoadIntensity.high, fullTake: true, epochDay: 10);
    expect(ledger.points, 5);
    expect(ledger.highCount, 1);
    expect(ledger.fullTakeCount, 1);
    expect(VocalLoadLedger.fromJson(ledger.toJson()).points, 5);
  });

  test('F2 ledger accumulates session phonation seconds + json round-trip', () {
    final ledger = const VocalLoadLedger()
        .add(intensity: VocalLoadIntensity.low, phonationSeconds: 120)
        .add(intensity: VocalLoadIntensity.low, phonationSeconds: 200);
    expect(ledger.sessionPhonationSeconds, 320);
    final restored = VocalLoadLedger.fromJson(ledger.toJson());
    expect(restored.sessionPhonationSeconds, 320);
    // 구버전 json(필드 없음)은 0으로 폴백 — 하위호환.
    expect(VocalLoadLedger.fromJson({'points': 3}).sessionPhonationSeconds, 0);
  });

  test('F2 estimatePhonationSeconds — 카드 메타 기반 보수 추정', () {
    expect(estimatePhonationSeconds(_card(maxDurationSec: 180)), 180);
    expect(estimatePhonationSeconds(_card(maxSustainSec: 3, maxReps: 4)), 12);
    // maxReps 없으면 기본 반복 수(5) 사용.
    expect(estimatePhonationSeconds(_card(maxSustainSec: 2)), 10);
    // 시간 단서 전무 → 기본값.
    expect(estimatePhonationSeconds(_card()), kDefaultCardPhonationSeconds);
  });

  test('S0 도즈 하드락: 발성시간 캡 도달(경계)·연속고음·full-take → doseLock', () {
    const policy = VocalLoadPolicy();
    // 발성시간 == maxDurationSec (경계) → doseLock
    expect(
      policy.evaluateDoseHardLock(
        card: _card(maxDurationSec: 180),
        ledger: const VocalLoadLedger(sessionPhonationSeconds: 180),
      ),
      LockAction.doseLock,
    );
    // 미만이면 allow
    expect(
      policy.evaluateDoseHardLock(
        card: _card(maxDurationSec: 180),
        ledger: const VocalLoadLedger(sessionPhonationSeconds: 179),
      ),
      LockAction.allow,
    );
    // 연속 고음 sustain 초과
    expect(
      policy.evaluateDoseHardLock(
        card: _card(maxSustainSec: 3),
        ledger: const VocalLoadLedger(continuousHighPitchSustainSecMax: 4),
      ),
      LockAction.doseLock,
    );
    // full-take 캡
    expect(
      policy.evaluateDoseHardLock(
        card: _card(maxTakeCount: 2),
        ledger: const VocalLoadLedger().add(
          intensity: VocalLoadIntensity.low,
          fullTake: true,
        ).add(intensity: VocalLoadIntensity.low, fullTake: true),
      ),
      LockAction.doseLock,
    );
  });

  test('S0 강제 휴식: requiredRestHours 미경과 → forcedRestLock, 경과 → allow', () {
    const policy = VocalLoadPolicy();
    final card = _card(requiredRestHours: 48); // 2일
    // 같은 날 고부하 → 0h < 48h → lock
    expect(
      policy.evaluateForcedRest(
        card: card,
        ledger: const VocalLoadLedger(lastHighEpochDay: 100),
        todayEpochDay: 100,
      ),
      LockAction.forcedRestLock,
    );
    // 1일 경과 → 24h < 48h → lock
    expect(
      policy.evaluateForcedRest(
        card: card,
        ledger: const VocalLoadLedger(lastHighEpochDay: 100),
        todayEpochDay: 101,
      ),
      LockAction.forcedRestLock,
    );
    // 2일 경과 → 48h ≥ 48h → allow
    expect(
      policy.evaluateForcedRest(
        card: card,
        ledger: const VocalLoadLedger(lastHighEpochDay: 100),
        todayEpochDay: 102,
      ),
      LockAction.allow,
    );
  });

  test('S0 주간 캡: 최근 7일 활동일이 weeklyCap 이상 → weeklyCapLock', () {
    const policy = VocalLoadPolicy();
    final card = _card(weeklyCap: 2);
    expect(
      policy.evaluateWeeklyCap(
        card: card,
        ledger: const VocalLoadLedger(last7DaysPhonationSec: [60, 0, 90, 0, 0, 0, 0]),
      ),
      LockAction.weeklyCapLock, // 활동일 2 ≥ 2
    );
    expect(
      policy.evaluateWeeklyCap(
        card: card,
        ledger: const VocalLoadLedger(last7DaysPhonationSec: [60, 0, 0, 0, 0, 0, 0]),
      ),
      LockAction.allow, // 활동일 1
    );
  });

  test('S0 신규 ledger 필드 json round-trip + 하위호환', () {
    const ledger = VocalLoadLedger(
      continuousHighPitchSustainSecMax: 5,
      last7DaysPhonationSec: [10, 20],
      f0WeightedTimeDoseMilli: 1234,
    );
    final back = VocalLoadLedger.fromJson(ledger.toJson());
    expect(back.continuousHighPitchSustainSecMax, 5);
    expect(back.last7DaysPhonationSec, [10, 20]);
    expect(back.f0WeightedTimeDoseMilli, 1234);
    // 구버전 json(필드 없음) → 기본값.
    final old = VocalLoadLedger.fromJson({'points': 1});
    expect(old.continuousHighPitchSustainSecMax, 0);
    expect(old.last7DaysPhonationSec, isEmpty);
  });

  test('F2 session phonation over cap → reduced, under cap → normal', () {
    const policy = VocalLoadPolicy();
    final over = const VocalLoadLedger()
        .add(intensity: VocalLoadIntensity.low, phonationSeconds: 700);
    final under = const VocalLoadLedger()
        .add(intensity: VocalLoadIntensity.low, phonationSeconds: 500);
    expect(
      policy.evaluateSessionPhonation(ledger: over).mode,
      VocalLoadMode.reduced,
    );
    expect(
      policy.evaluateSessionPhonation(ledger: under).mode,
      VocalLoadMode.normal,
    );
  });
}
