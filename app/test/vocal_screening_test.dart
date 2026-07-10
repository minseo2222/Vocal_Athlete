/// Stage 0 — A2 적신호 스크리닝 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/safety_params.dart';
import 'package:vocal_athlete/safety/vocal_screening.dart';

Map<String, bool?> _allNegative() =>
    {for (final i in kRedFlagScreening) i.id: false};

void main() {
  test('S0 전부 음성 → pass + validUntil = today + 재스크린일', () {
    final r = evaluateScreening(answers: _allNegative(), todayEpochDay: 100);
    expect(r.outcome, ScreeningOutcome.pass);
    expect(r.referralAdvised, isFalse);
    expect(r.validUntilEpochDay, 100 + kScreenRescreenDays);
    expect(r.isValidAt(100 + kScreenRescreenDays - 1), isTrue);
    expect(r.isValidAt(100 + kScreenRescreenDays), isFalse);
  });

  test('S0 hardBlock 1개 양성 → hardBlock + referral', () {
    final a = _allNegative()..['neck_mass'] = true;
    final r = evaluateScreening(answers: a, todayEpochDay: 1);
    expect(r.outcome, ScreeningOutcome.hardBlock);
    expect(r.referralAdvised, isTrue);
    expect(r.triggeredItemIds, contains('neck_mass'));
  });

  test('S0 soft만 양성 → softCaution(의뢰 아님)', () {
    final a = _allNegative()..['tobacco'] = true;
    final r = evaluateScreening(answers: a, todayEpochDay: 1);
    expect(r.outcome, ScreeningOutcome.softCaution);
    expect(r.referralAdvised, isFalse);
  });

  test('S0 미응답 hardBlock → 긍정 처리(잠금)', () {
    // 응답 맵을 비워 hardBlock 항목이 미응답이면 hardBlock으로 잠긴다.
    final r = evaluateScreening(answers: const {}, todayEpochDay: 1);
    expect(r.outcome, ScreeningOutcome.hardBlock);
    expect(r.referralAdvised, isTrue);
  });

  test('S0 미응답 soft는 음성 취급(soft만 미응답이면 pass)', () {
    // 모든 hardBlock은 음성, soft만 미응답.
    final a = <String, bool?>{
      for (final i in kRedFlagScreening)
        if (i.blockType == ScreeningBlockType.hardBlock) i.id: false,
    };
    final r = evaluateScreening(answers: a, todayEpochDay: 1);
    expect(r.outcome, ScreeningOutcome.pass);
  });

  test('S0 ScreeningResult json round-trip', () {
    final a = _allNegative()..['hoarse2w'] = true;
    final r = evaluateScreening(answers: a, todayEpochDay: 50);
    final back = ScreeningResult.fromJson(r.toJson());
    expect(back.outcome, ScreeningOutcome.hardBlock);
    expect(back.triggeredItemIds, contains('hoarse2w'));
    expect(back.validUntilEpochDay, r.validUntilEpochDay);
  });
}
