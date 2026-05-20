/// resolveOutcome — `completeLesson`의 분류 로직을 순수 함수로 분리한 *전이 그래프*.
///
/// 부수효과(인덱스/스트릭 변이)는 호출자(`Progression.completeLesson`)에 남고,
/// 본 함수는 *오직 분류*. Flutter import 없음.
library;

import 'progression_state.dart';

CompleteOutcome resolveOutcome({
  required bool didToday,
  required bool graduated,
  required bool transitionDayHit,
  required bool maintenance,
  required int pendingReview,
  required bool atEnd,
}) {
  if (didToday) {
    if (graduated) return CompleteOutcome.transitionGraduated;
    if (transitionDayHit) return CompleteOutcome.transitionToNext;
    return CompleteOutcome.capped;
  }
  if (maintenance) return CompleteOutcome.maintenance;
  if (pendingReview > 0) return CompleteOutcome.review;
  if (!atEnd) return CompleteOutcome.advanced;
  return CompleteOutcome.graduated;
}
