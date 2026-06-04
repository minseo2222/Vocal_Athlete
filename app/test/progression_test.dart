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

  // --- P4: 졸업/전이 메시지 ---

  test('P4.1 graduated + no genre + capped → transitionGraduated', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1,
        didToday: true,
        graduated: true);
    expect(p.completeLesson(), CompleteOutcome.transitionGraduated);
  });

  test('P4.2 transitionDay == day + capped → transitionToNext', () {
    final p = Progression.from(buildPlaceholderManifest(),
        didToday: true, day: 5, transitionDay: 5);
    expect(p.completeLesson(), CompleteOutcome.transitionToNext);
  });

  test('P4.3 ordinary same-day 2nd (mid-path, no transition) → capped', () {
    final p = Progression.from(buildPlaceholderManifest(), didToday: true);
    expect(p.completeLesson(), CompleteOutcome.capped);
  });

  test('P4.4 first complete of day → advanced (regression)', () {
    final p = Progression.beginner();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, 1);
  });

  test('P4.5 transition not "today" after advanceDay (day increments)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        day: 5, transitionDay: 5);
    p.completeLesson(); // day 5: advances (not capped yet)
    p.advanceDay(); // → day 6
    p.completeLesson(); // day 6: advances
    p.completeLesson(); // day 6 2nd: capped, transitionDay(5) != day(6)
    expect(p.completeLesson(), CompleteOutcome.capped);
  });

  // --- P5: 관대 스트릭 ---

  test('P5.1 streak 0 → 1 on first completeLesson', () {
    final p = Progression.beginner();
    expect(p.streak, 0);
    p.completeLesson();
    expect(p.streak, 1);
  });

  test('P5.2 +1 per active day', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.advanceDay();
    p.completeLesson();
    expect(p.streak, 2);
  });

  test('P5.3 capped same-day 2nd does not increment streak', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // capped
    expect(p.streak, 1);
  });

  test('P5.4 gap does not reset streak (lenient, no freeze)', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // build to streak 1
    p.advanceDay();
    p.completeLesson();
    expect(p.streak, 2);
    p.advanceDay();
    p.advanceDay();
    p.advanceDay(); // 3-day gap, no completion
    expect(p.streak, 2); // not reset
    p.completeLesson(); // resume
    expect(p.streak, 3);
  });

  test('P5.5 streak increments at path end, capped after stays', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.streak, 1); // trained today even with no advance
    p.completeLesson(); // capped
    expect(p.streak, 1);
  });

  // --- P6: 복귀 복습 ---

  test('P6.1 gap >= 7 → return review, no advance', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 9); // gap = 9 - 1 - 1 = 7
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review);
    expect(p.currentIndex, i); // review consumes the day, no new unlock
  });

  test('P6.2 gap 7-14 → owed 1: review then next day advances', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 10); // gap = 8
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review);
    expect(p.currentIndex, i);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, i + 1);
  });

  test('P6.3 gap > 14 → owed 2: two review days then advance', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 22); // gap = 20
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review); // owed 2 → 1 left
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.review); // 1 → 0
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, i + 1);
  });

  test('P6.4 gap < 7 → no review trigger', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 5); // gap = 3
    expect(p.completeLesson(), CompleteOutcome.advanced);
  });

  test('P6.5 streak still +1 on a review day (lenient)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 9);
    final s = p.streak;
    p.completeLesson(); // review day
    expect(p.streak, s + 1);
  });

  test('P6.6 graduated → no review trigger', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 22, graduated: true);
    // graduated + !didToday path: gap large but excluded → not review
    expect(p.completeLesson(), isNot(CompleteOutcome.review));
  });

  // --- P7: 졸업 감지 ---

  test('P7.1 completing the last slot graduates', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.graduated, isFalse);
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
    expect(p.currentIndex, i); // no advance past end
  });

  test('P7.2 mid-path completion does not graduate', () {
    final p = Progression.beginner();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.graduated, isFalse);
  });

  test('P7.3 graduation only on path completion (not before)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 2);
    expect(p.completeLesson(), CompleteOutcome.advanced); // → last slot
    expect(p.graduated, isFalse);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
  });

  test('P7.4 post-graduation fresh day is idempotent (no advance)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1, graduated: true);
    final i = p.currentIndex;
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
    expect(p.currentIndex, i);
  });

  test('P7.5 graduated + same-day 2nd → transitionGraduated (P4 regress)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1, didToday: true, graduated: true);
    expect(p.completeLesson(), CompleteOutcome.transitionGraduated);
  });

  // --- P8: 비구속 장르 선택 ---

  test('P8.1 graduated → chooseGenre records genre', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(p.genre, isNull);
    p.chooseGenre(Genre.musical);
    expect(p.genre, Genre.musical);
  });

  test('P8.2 chooseGenre ignored before graduation', () {
    final p = Progression.beginner();
    expect(p.graduated, isFalse);
    p.chooseGenre(Genre.musical);
    expect(p.genre, isNull);
  });

  test('P8.3 nonbinding — genre can be changed', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.chooseGenre(Genre.gayo);
    expect(p.genre, Genre.gayo);
  });

  test('P8.4 choosing genre does not penalize progression', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true);
    final i = p.currentIndex;
    final s = p.streak;
    p.chooseGenre(Genre.classical);
    p.chooseGenre(Genre.musical);
    expect(p.currentIndex, i);
    expect(p.streak, s);
    expect(p.graduated, isTrue);
  });

  // --- P9: 유지 모드 ---

  test('P9.1 graduated → chooseGenre enters maintenance (V1: no course)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(p.maintenance, isFalse);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
  });

  test('P9.2 maintenance lesson: maintenance outcome, no new unlock', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true);
    p.chooseGenre(Genre.musical);
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.maintenance);
    expect(p.currentIndex, i); // 신규 해금 없음
  });

  test('P9.3 maintenance lesson still counts streak (lenient P5)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    final s = p.streak;
    p.completeLesson();
    expect(p.streak, s + 1);
  });

  test('P9.4 1/day cap holds in maintenance', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.completeLesson(); // maintenance lesson today
    final s = p.streak;
    final i = p.currentIndex;
    p.completeLesson(); // same day → capped
    expect(p.streak, s); // no extra increment
    expect(p.currentIndex, i);
  });

  test('P9.5 maintenance only via genre choice after graduation', () {
    final pre = Progression.beginner();
    pre.chooseGenre(Genre.musical); // not graduated → ignored
    expect(pre.maintenance, isFalse);
    final grad =
        Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(grad.maintenance, isFalse); // graduated but no genre yet
  });

  // --- P10: 출시 자동연결 (V1 stub) ---

  test('P10.2 released genre → chooseGenre enters course directly', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isFalse); // 직접 진입(유지 모드 아님)
    expect(p.graduated, isFalse); // 다음 코스로 이동
  });

  test('P10.3 auto-connect: release while waiting in maintenance', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
    p.toggleRelease(Genre.musical); // 출시 → 자동연결
    expect(p.maintenance, isFalse);
    expect(p.graduated, isFalse);
  });

  test('P10.1 not released → maintenance (V1 default, regression-safe)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
  });

  test('P10.4 release of other genre / no genre → no auto-connect', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.toggleRelease(Genre.gayo); // 다른 장르
    expect(p.maintenance, isTrue); // 자동연결 없음
    final q = Progression.from(buildPlaceholderManifest(), graduated: true);
    q.toggleRelease(Genre.musical); // 장르 미선택
    expect(q.maintenance, isFalse);
    expect(q.graduated, isTrue); // 전이 없음
  });

  test('P10.5 after auto-connect, same-day cap → transitionToNext (P4)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.completeLesson(); // maintenance lesson (didToday=true)
    p.toggleRelease(Genre.musical); // auto-connect (graduated=false, txnDay=day)
    expect(p.completeLesson(), CompleteOutcome.transitionToNext);
  });

  // --- I3: 졸업→분기 코스 manifest 로드 ---

  test('I3.1 released musical → course manifest loaded (total 74, index 0)',
      () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true);
    expect(p.total, 48); // 초급
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    expect(p.total, 74); // 뮤지컬 코스(코어32+분기42)
    expect(p.currentIndex, 0); // 새 코스 1과
    expect(p.maintenance, isFalse);
    expect(p.todaysLesson.cardId, startsWith('IC-')); // 코어부터
  });

  test('I3.2 each genre loads its course length', () {
    for (final (g, len) in [
      (Genre.musical, 74),
      (Genre.classical, 68),
      (Genre.gayo, 64),
    ]) {
      final p = Progression.from(buildPlaceholderManifest(), graduated: true);
      p.toggleRelease(g);
      p.chooseGenre(g);
      expect(p.total, len, reason: '$g course length');
    }
  });

  test('I3.3 course progression: complete advances within loaded course', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo);
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, 1);
  });
}
