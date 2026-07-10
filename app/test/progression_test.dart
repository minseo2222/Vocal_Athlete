import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('completeLesson advances pointer by 1', () {
    final p = Progression.beginner();
    expect(p.currentIndex, 0);
    p.completeLesson();
    expect(p.currentIndex, 1);
  });

  test('completeLesson is quality-agnostic', () {
    final p = Progression.beginner();
    expect(p.completeLesson(), CompleteOutcome.advanced);
  });

  test('1/day cap holds', () {
    final p = Progression.beginner();
    p.completeLesson();
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.capped);
    expect(p.currentIndex, i);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, i + 1);
  });

  test('return review after gap does not advance new lesson', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 9);
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review);
    expect(p.currentIndex, i);
  });

  test('graduation only at end of current manifest', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 2);
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.graduated, isFalse);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
  });

  test('R4 beginner graduation can start Universal Core, not genre branch', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.canStartUniversalCore, isTrue);
    p.startUniversalCore();
    expect(p.stage, LearningStage.universalCore);
    expect(p.total, universalCoreLength);
    expect(p.genre, isNull);
    expect(p.todaysLesson.cardId.startsWith('UC-') ||
        p.todaysLesson.cardId.startsWith('IC-') ||
        p.todaysLesson.cardId.startsWith('TONE-'), isTrue);
  });

  test('R4 chooseGenre is ignored before Repertoire Application completion', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.gayo);
    expect(p.genre, isNull);
    expect(p.stage, LearningStage.beginnerFoundation);
    p.startUniversalCore();
    p.chooseGenre(Genre.gayo);
    expect(p.genre, isNull);
    expect(p.stage, LearningStage.universalCore);
  });

  test('R4 Universal Core completion can start Repertoire Application', () {
    final p = Progression.from(buildUniversalCoreManifest(),
        currentIndex: universalCoreLength - 1,
        stage: LearningStage.universalCore);
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.canStartRepertoireApplication, isTrue);
    p.startRepertoireApplication();
    expect(p.stage, LearningStage.repertoireApplication);
    expect(p.total, repertoireApplicationLength);
    expect(p.todaysLesson.cardId.startsWith('RA-') ||
        p.todaysLesson.cardId.startsWith('UC-'), isTrue);
  });

  test('R4 Repertoire Application completion opens advanced genre picker', () {
    final p = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication);
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.canPickAdvancedGenre, isTrue);
  });

  test('R4 unreleased advanced genre → maintenance wait', () {
    final p = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication);
    p.completeLesson();
    p.chooseGenre(Genre.gayo);
    expect(p.genre, Genre.gayo);
    expect(p.stage, LearningStage.maintenance);
    expect(p.maintenance, isTrue);
  });

  test('R4 released advanced genre enters advanced cycle', () {
    final p = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication,
        safetyApproved: true);
    p.completeLesson();
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo);
    expect(p.stage, LearningStage.advancedGenre);
    expect(p.maintenance, isFalse);
    expect(p.total, advancedCycleLength);
  });

  test('R4 advanced cycle repeats when completed', () {
    final p = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication,
        safetyApproved: true);
    p.completeLesson();
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo);
    while (!p.atEnd) {
      p.completeLesson();
      p.advanceDay();
    }
    final cycle = p.advancedCycle;
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.stage, LearningStage.advancedGenre);
    expect(p.graduated, isFalse);
    expect(p.advancedCycle, cycle + 1);
    expect(p.currentIndex, 0);
  });

  test('R4 safetyApproved=false gates high-risk advanced cards', () {
    final locked = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication);
    locked.completeLesson();
    locked.toggleRelease(Genre.gayo);
    locked.chooseGenre(Genre.gayo);

    final approved = Progression.from(buildRepertoireApplicationManifest(),
        currentIndex: repertoireApplicationLength - 1,
        stage: LearningStage.repertoireApplication,
        safetyApproved: true);
    approved.completeLesson();
    approved.toggleRelease(Genre.gayo);
    approved.chooseGenre(Genre.gayo);

    expect(locked.total, approved.total);
    final gated = safetyGatedCardIds();
    final seen = {for (final s in locked.slots) s.cardId};
    expect(seen.intersection(gated), isEmpty);
    expect(seen.contains('GY-08') || seen.contains('TONE-07') || seen.contains('CARD-16'), isTrue);
  });
}
