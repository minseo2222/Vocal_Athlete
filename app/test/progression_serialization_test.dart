/// Task 2 — Progression 직렬화 round-trip (순수).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/path.dart';
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

  test('S1b beginner restore records stable courseId', () {
    final p = Progression.beginner();
    p.completeLesson();

    final json = p.toJson();
    final restored = Progression.fromJson(json);

    expect(json['courseId'], 'beginner');
    expect(restored.currentIndex, 1);
    expect(restored.total, pathLength);
    expect(restored.todaysLesson.cardId, p.todaysLesson.cardId);
  });

  test('S1c graduation without genre restores beginner graduation state', () {
    final p = Progression.from(
      buildPlaceholderManifest(),
      currentIndex: pathLength - 1,
    );
    expect(p.completeLesson(), CompleteOutcome.graduated);

    final restored = Progression.fromJson(p.toJson());

    expect(restored.graduated, isTrue);
    expect(restored.genre, isNull);
    expect(restored.maintenance, isFalse);
    expect(restored.currentIndex, pathLength - 1);
    expect(restored.total, pathLength);
  });

  test('S1d maintenance after unreleased genre restores waiting state', () {
    final p = Progression.from(
      buildPlaceholderManifest(),
      currentIndex: pathLength - 1,
      graduated: true,
    );
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);

    final restored = Progression.fromJson(p.toJson());

    expect(restored.genre, Genre.musical);
    expect(restored.graduated, isTrue);
    expect(restored.maintenance, isTrue);
    expect(restored.currentIndex, pathLength - 1);
    expect(restored.total, pathLength);
  });

  test('S1e released genre course restores active manifest and index', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    for (var i = 0; i < 5; i++) {
      p.completeLesson();
      p.advanceDay();
    }

    final json = p.toJson();
    final restored = Progression.fromJson(
      json,
      releasedGenres: {Genre.musical},
    );

    expect(json['courseId'], 'musical');
    expect(restored.genre, Genre.musical);
    expect(restored.graduated, isFalse);
    expect(restored.maintenance, isFalse);
    expect(restored.currentIndex, p.currentIndex);
    expect(restored.total, p.total);
    expect(restored.todaysLesson.cardId, p.todaysLesson.cardId);
  });

  test(
    'S1f currentIndex beyond manifest length clamps instead of crashing',
    () {
      final json = Progression.beginner().toJson()..['currentIndex'] = 999;

      final restored = Progression.fromJson(json);

      expect(restored.currentIndex, pathLength - 1);
      expect(() => restored.todaysLesson, returnsNormally);
    },
  );

  test('S1g unreleased saved genre course falls back to safe maintenance', () {
    final json = Progression.beginner().toJson()
      ..['courseId'] = 'musical'
      ..['currentIndex'] = 12
      ..['genre'] = 'musical'
      ..['graduated'] = false
      ..['maintenance'] = false
      ..['released'] = ['musical'];

    final restored = Progression.fromJson(json);

    expect(restored.isReleased(Genre.musical), isFalse);
    expect(restored.genre, Genre.musical);
    expect(restored.graduated, isTrue);
    expect(restored.maintenance, isTrue);
    expect(restored.total, pathLength);
    expect(restored.currentIndex, pathLength - 1);
  });

  test('S1h released genre course out-of-range index clamps to course end', () {
    final json = Progression.beginner().toJson()
      ..['courseId'] = 'gayo'
      ..['currentIndex'] = 999
      ..['genre'] = 'gayo'
      ..['graduated'] = false
      ..['maintenance'] = false;

    final restored = Progression.fromJson(json, releasedGenres: {Genre.gayo});

    expect(restored.genre, Genre.gayo);
    expect(restored.total, lessThan(buildGayoManifest().length));
    expect(restored.currentIndex, restored.total - 1);
    expect(() => restored.todaysLesson, returnsNormally);
  });
}
