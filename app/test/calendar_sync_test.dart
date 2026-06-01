/// Task 3 — 실 캘린더 동기화(syncToToday) 순수 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('C1 same day no-op, next day releases cap, unlock preserved', () {
    final p = Progression.beginner();
    p.syncToToday(100); // 첫 설정 — 기준만 잡고 no-op
    p.completeLesson(); // didToday=true, index 0→1
    expect(p.didToday, isTrue);

    p.syncToToday(100); // 같은 날 재실행 → 캡 유지
    expect(p.didToday, isTrue);

    p.syncToToday(101); // 다음날 → 캡 해제
    expect(p.didToday, isFalse);
    expect(p.currentIndex, 1); // 해금은 보존
  });

  test('C2 7-day gap triggers return-review (gap 로직 재사용)', () {
    final p = Progression.beginner();
    p.syncToToday(100);
    p.completeLesson(); // day1 활동
    p.syncToToday(108); // 8일 점프(공백 7일) → 복귀 복습 트리거
    final outcome = p.completeLesson();
    expect(outcome, CompleteOutcome.review);
  });
}
