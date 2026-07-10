/// Task 2 — Progression 직렬화 round-trip (순수).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('S1 toJson → fromJson preserves mutable state', () {
    final p = Progression.beginner();
    // 며칠 진행: 완료 → 다음날 → 완료 (streak·index·day 변화)
    p.completeLesson();
    p.advanceDay();
    p.completeLesson();
    p.advanceDay();

    final restored = Progression.fromJson(p.toJson());

    expect(restored.currentIndex, p.currentIndex);
    expect(restored.day, p.day);
    expect(restored.streak, p.streak);
    expect(restored.didToday, p.didToday);
    expect(restored.graduated, p.graduated);
    expect(restored.genre, p.genre);
    expect(restored.maintenance, p.maintenance);
    expect(restored.pendingReview, p.pendingReview);
    expect(restored.total, p.total); // manifest 복원(고정 경로)
  });
}
