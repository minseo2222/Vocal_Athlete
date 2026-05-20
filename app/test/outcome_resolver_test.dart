/// resolveOutcome — completeLesson 분류 로직(7-state graph) 단위 검증.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/outcome_resolver.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('R7 active + atEnd, no maintenance/review → graduated', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: true,
      ),
      CompleteOutcome.graduated,
    );
  });

  test('R6 active + !atEnd, no maintenance/review → advanced', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.advanced,
    );
  });

  test('R5 active + pendingReview>0 → review', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 2,
        atEnd: false,
      ),
      CompleteOutcome.review,
    );
  });

  test('R4 active + maintenance → maintenance', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: true,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.maintenance,
    );
  });

  test('R3 didToday + neither graduated nor transitionDayHit → capped', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.capped,
    );
  });

  test('R2 didToday + transitionDayHit (not graduated) → transitionToNext', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: false,
        transitionDayHit: true,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.transitionToNext,
    );
  });

  test('R1 didToday + graduated → transitionGraduated', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: true,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.transitionGraduated,
    );
  });
}
