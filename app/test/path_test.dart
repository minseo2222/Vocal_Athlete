import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('beginner manifest = 48 slots, contiguous 0-based index', () {
    final m = buildPlaceholderManifest();
    expect(m.length, pathLength);
    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
  });

  test('beginner blocks span 1..5 in order, ratio decreases monotonically', () {
    final m = buildPlaceholderManifest();
    expect(m.first.block, 1);
    expect(m.last.block, 5);
    var prevBlock = 0;
    double? prevRatio;
    for (final s in m) {
      expect(s.block, greaterThanOrEqualTo(prevBlock));
      prevBlock = s.block;
      if (prevRatio != null) {
        expect(s.bodyVoicedRatio, lessThanOrEqualTo(prevRatio));
      }
      prevRatio = s.bodyVoicedRatio;
    }
    expect(m.first.bodyVoicedRatio, 0.70);
    expect(m.last.bodyVoicedRatio, 0.20);
  });

  test('beginner standard samples are fixed at Day 1, 24, 48 only', () {
    final m = buildPlaceholderManifest();
    expect(m[0].cardId, 'CARD-13');
    expect(m[23].cardId, 'CARD-13');
    expect(m[47].cardId, 'CARD-13');
    expect(m.where((s) => s.cardId == 'CARD-13').length, 3);
    expect(m[0].learningIntent, LearningIntent.checkpoint);
    expect(m[23].learningIntent, LearningIntent.checkpoint);
    expect(m[47].learningIntent, LearningIntent.checkpoint);
  });

  test('v9 beginner schedules musical transfer but recovery is state-driven', () {
    final m = buildPlaceholderManifest();
    final ids = {for (final s in m) s.cardId};
    for (final id in ['CARD-14', 'CARD-15', 'CARD-16', 'CARD-17']) {
      expect(ids.contains(id), isTrue, reason: '$id missing');
    }
    expect(ids.contains('CARD-18'), isFalse,
        reason: 'CARD-18 must remain a runtime recovery fallback');
    expect(m.where((s) => s.cardId == 'CARD-14').length,
        greaterThanOrEqualTo(3));
  });

  test('v9 universal core = twelve 12-day microcycles', () {
    final m = buildUniversalCoreManifest();
    expect(m.length, universalCoreLength);
    expect(m.first.block, 1);
    expect(m.last.block, 4);
    expect({for (final s in m) s.cycle},
        {for (var i = 1; i <= universalCoreCycleCount; i++) i});

    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
    for (var cycle = 1; cycle <= universalCoreCycleCount; cycle++) {
      expect(m.where((s) => s.cycle == cycle).length,
          universalCoreCycleLength,
          reason: 'cycle $cycle must contain 12 lessons');
    }
  });

  test('v9 universal formal checkpoints occur only at Days 36/72/108/144', () {
    final m = buildUniversalCoreManifest();
    final checkpointIndices = [
      for (var i = 0; i < m.length; i++)
        if (m[i].cardId == 'UC-17') i,
    ];
    expect(checkpointIndices, [35, 71, 107, 143]);
    expect(m.where((s) => s.cardId == 'UC-17').length, 4);
    expect(m.any((s) => s.cardId == 'CARD-18'), isFalse);
  });

  test('each universal microcycle revisits pitch, rhythm, phrase, and review', () {
    final m = buildUniversalCoreManifest();
    const pitchIds = {
      'CARD-12', 'CARD-14', 'UC-06', 'UC-07', 'UC-19'
    };
    const rhythmIds = {'CARD-15', 'UC-08', 'UC-09', 'UC-20'};
    const phraseIds = {'UC-16', 'UC-18', 'UC-23', 'UC-24'};
    const reviewIds = {'UC-17', 'UC-25'};

    for (var cycle = 1; cycle <= universalCoreCycleCount; cycle++) {
      final ids = {
        for (final s in m.where((s) => s.cycle == cycle)) s.cardId,
      };
      expect(ids.intersection(pitchIds), isNotEmpty,
          reason: 'cycle $cycle needs pitch/ear work');
      expect(ids.intersection(rhythmIds), isNotEmpty,
          reason: 'cycle $cycle needs rhythm/time work');
      expect(ids.intersection(phraseIds), isNotEmpty,
          reason: 'cycle $cycle needs phrase transfer');
      expect(ids.intersection(reviewIds), isNotEmpty,
          reason: 'cycle $cycle needs retrieval/review');
    }
  });

  test('v9 repertoire application = six complete 12-day phrase projects', () {
    final m = buildRepertoireApplicationManifest();
    expect(m.length, repertoireApplicationLength);
    expect({for (final s in m) s.cycle},
        {for (var i = 1; i <= repertoireProjectCount; i++) i});
    expect(m.any((s) => s.cardId == 'CARD-18'), isFalse);
    expect(m.any((s) => s.cardId == 'IC-12'), isFalse);

    for (var project = 1; project <= repertoireProjectCount; project++) {
      final slots = m.where((s) => s.cycle == project).toList();
      expect(slots.length, repertoireProjectLength);
      expect(slots.first.cardId, 'RA-09',
          reason: 'project $project needs a whole-phrase baseline');
      expect(slots.last.cardId, 'RA-10',
          reason: 'project $project needs delayed retrieval/transfer');
      expect(slots.any((s) => s.cardId == 'RA-07'), isTrue);
      expect(slots.any((s) => s.cardId == 'RA-08'), isTrue);
    }
  });

  test('v9 advanced genre cycles = 40 slots, no scheduled recovery card', () {
    final manifests = [
      buildAdvancedGayoManifest(),
      buildAdvancedMusicalManifest(),
      buildAdvancedClassicalManifest(),
      buildAdvancedRbSoulManifest(),
      buildAdvancedRockManifest(),
      buildAdvancedCcmManifest(),
      buildAdvancedUserSongManifest(),
    ];
    for (final m in manifests) {
      expect(m.length, advancedCycleLength);
      expect(m.first.block, 1);
      expect(m.last.block, 4);
      expect(m.any((s) => s.cardId == 'CARD-18'), isFalse);
      for (var i = 0; i < m.length; i++) {
        expect(m[i].index, i);
      }
    }
  });

  test('safe advanced cards are scheduled into their genre manifests', () {
    final gayo = {for (final s in buildAdvancedGayoManifest()) s.cardId};
    final musical = {for (final s in buildAdvancedMusicalManifest()) s.cardId};
    final classical = {for (final s in buildAdvancedClassicalManifest()) s.cardId};
    expect(gayo, containsAll(
        ['GY-10', 'GY-11', 'GY-12', 'GY-13', 'GY-14', 'GY-15', 'GY-16']));
    expect(musical, containsAll(['IM-13', 'IM-14']));
    expect(classical, containsAll(['CL-10', 'CL-11', 'CL-12']));
  });

  test('v9 R&B, Rock, and Worship labs use dedicated low-risk cards', () {
    final rb = {for (final s in buildAdvancedRbSoulManifest()) s.cardId};
    final rock = {for (final s in buildAdvancedRockManifest()) s.cardId};
    final worship = {for (final s in buildAdvancedCcmManifest()) s.cardId};

    expect(rb.any((id) => id.startsWith('RB-')), isTrue);
    expect(rock.any((id) => id.startsWith('RK-')), isTrue);
    expect(worship.any((id) => id.startsWith('WC-')), isTrue);
  });

  test('todaysLesson selector returns current slot', () {
    final p = Progression.beginner();
    expect(p.currentIndex, 0);
    expect(p.todaysLesson.index, 0);
    expect(p.total, pathLength);
    expect(p.atEnd, isFalse);

    final p2 = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p2.todaysLesson.index, pathLength - 1);
    expect(p2.atEnd, isTrue);
  });

  test('v15 beginner introduces observation-only timbre bridges late in block 4', () {
    final m = buildPlaceholderManifest();
    expect(m[36].cardId, 'TONE-02');
    expect(m[37].cardId, 'TONE-03');
    expect(m.where((slot) => slot.cardId == 'TONE-02').length, 1);
    expect(m.where((slot) => slot.cardId == 'TONE-03').length, 1);
    expect(m.take(30).any((slot) => slot.cardId.startsWith('TONE-')), isFalse);
  });

  test('v15 timbre progression reaches phrase reproduction before advanced style', () {
    final core = buildUniversalCoreManifest();
    final repertoire = buildRepertoireApplicationManifest();
    expect(core.any((slot) => slot.cardId == 'TONE-07'), isTrue);
    expect(core.any((slot) => slot.cardId == 'TONE-12'), isTrue);
    expect(
      repertoire.where((slot) => slot.cycle == 5).any((slot) => slot.cardId == 'TONE-11'),
      isTrue,
    );
    expect(
      repertoire.where((slot) => slot.cycle == 6).any((slot) => slot.cardId == 'TONE-12'),
      isTrue,
    );
    expect(core.any((slot) => slot.cardId == 'TONE-13'), isFalse,
        reason: 'genre tone must remain advanced-only');
  });

}
