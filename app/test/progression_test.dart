import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('completeLesson advances pointer by 1', () {
    final p = Progression.beginner();
    expect(p.currentIndex, 0);
    p.completeLesson();
    expect(p.currentIndex, 1);
    expect(p.todaysLesson.index, 1);
  });

  test('completeLesson is quality-agnostic (no input to gate on)', () {
    // Structural guarantee: the API takes no quality/score argument,
    // so performance cannot block the unlock.
    final p = Progression.beginner();
    for (var i = 0; i < 5; i++) {
      p.completeLesson();
    }
    expect(p.currentIndex, 5);
  });

  test('does not advance past the last slot (graduation = P7)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.currentIndex, pathLength - 1);
  });

  test('selector reflects the new current after completion', () {
    final p = Progression.beginner();
    final before = p.todaysLesson.cardId;
    p.completeLesson();
    expect(p.todaysLesson.index, 1);
    // index moved; cardId may or may not differ but slot is the new one
    expect(p.todaysLesson, isNot(same(before)));
  });
}
