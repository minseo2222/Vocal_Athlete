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
    // so performance cannot block the unlock — calling it (with nothing
    // to grade) advances. (Multi-day advancement is gated by the P3 cap,
    // covered separately.)
    final p = Progression.beginner();
    p.completeLesson();
    expect(p.currentIndex, 1);
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

  // --- P3: 1일 1레슨 캡 ---

  test('P3.1 first completeLesson marks didToday', () {
    final p = Progression.beginner();
    expect(p.didToday, isFalse);
    p.completeLesson();
    expect(p.didToday, isTrue);
  });

  test('P3.2 second completeLesson same day does not advance (cap)', () {
    final p = Progression.beginner();
    p.completeLesson();
    expect(p.currentIndex, 1);
    p.completeLesson(); // same day → capped
    expect(p.currentIndex, 1);
  });

  test('P3.3 advanceDay releases the cap', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // capped
    expect(p.currentIndex, 1);
    p.advanceDay();
    expect(p.didToday, isFalse);
    p.completeLesson(); // next day → advances
    expect(p.currentIndex, 2);
  });

  test('P3.4 at path end: cap independent of end/unlock', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.didToday, isTrue); // trained today
    expect(p.currentIndex, pathLength - 1); // no advance at end
    p.completeLesson(); // same day → still capped, no crash
    expect(p.currentIndex, pathLength - 1);
  });

  test('P3.5 advanceDay alone does not change currentIndex (orthogonal)', () {
    final p = Progression.beginner();
    final i = p.currentIndex;
    p.advanceDay();
    p.advanceDay();
    expect(p.currentIndex, i);
  });
}
