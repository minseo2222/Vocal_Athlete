import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('C2.1 CARD-01 present with non-empty cue and voicedMicroWin', () {
    final c = kCardLibrary['CARD-01'];
    expect(c, isNotNull);
    expect(c!.cue, isNotEmpty);
    expect(c.voicedMicroWin, isNotEmpty);
  });

  test('C2.3 all manifest cardIds resolve to a card with non-empty fields',
      () {
    final ids = {
      for (final s in buildPlaceholderManifest()) s.cardId,
      for (final s in buildUniversalCoreManifest()) s.cardId,
      for (final s in buildRepertoireApplicationManifest()) s.cardId,
      for (final s in buildAdvancedGayoManifest()) s.cardId,
      for (final s in buildAdvancedMusicalManifest()) s.cardId,
      for (final s in buildAdvancedClassicalManifest()) s.cardId,
      for (final s in buildAdvancedRbSoulManifest()) s.cardId,
      for (final s in buildAdvancedRockManifest()) s.cardId,
      for (final s in buildAdvancedCcmManifest()) s.cardId,
      for (final s in buildAdvancedUserSongManifest()) s.cardId,
    };
    for (final id in ids) {
      final c = kCardLibrary[id];
      expect(c, isNotNull, reason: '$id missing in library');
      expect(c!.cue, isNotEmpty, reason: '$id empty cue');
      expect(c.voicedMicroWin, isNotEmpty, reason: '$id empty voicedMicroWin');
    }
  });

  test('C2.4 resolveCard returns the card whose id matches the slot', () {
    final manifest = buildPlaceholderManifest();
    for (final slot in manifest.take(5)) {
      expect(resolveCard(slot).id, slot.cardId);
    }
  });

  test('C3.6 variableAxes values contain no rationale tokens (ADR-0002)', () {
    const banned = ['왜', '이유', '때문', '위해서', '효과'];
    for (final entry in kCardLibrary.entries) {
      for (final axis in entry.value.variableAxes.entries) {
        for (final v in axis.value) {
          for (final token in banned) {
            expect(v.contains(token), isFalse,
                reason:
                    '${entry.key} axis ${axis.key} value "$v" contains "$token"');
          }
        }
      }
    }
  });

  test('U3.6 all cards have non-empty anatomy{entry,main,cooldown}', () {
    for (final entry in kCardLibrary.entries) {
      final c = entry.value;
      expect(c.anatomyEntry, isNotEmpty, reason: '${entry.key} anatomyEntry empty');
      expect(c.anatomyMain, isNotEmpty, reason: '${entry.key} anatomyMain empty');
      expect(c.anatomyCooldown, isNotEmpty,
          reason: '${entry.key} anatomyCooldown empty');
    }
  });

  test('U2.3 no card cue contains rationale/motivation tokens (ADR-0002)',
      () {
    // 무납득 구조 강제 — cue는 지시문만, "왜"/정당화 어휘 미포함.
    const banned = ['왜', '이유', '때문', '위해서', '효과'];
    for (final entry in kCardLibrary.entries) {
      for (final line in entry.value.cue) {
        for (final token in banned) {
          expect(line.contains(token), isFalse,
              reason: '${entry.key} cue line "$line" contains "$token"');
        }
      }
    }
  });



  test('R2 beginner transfer cards and relative pitch card are configured', () {
    for (var i = 14; i <= 18; i++) {
      final id = 'CARD-${i.toString().padLeft(2, '0')}';
      expect(kCardLibrary[id], isNotNull, reason: '$id missing');
    }
    expect(kCardLibrary['CARD-12']!.relativePitchTarget, isTrue);
    expect(kCardLibrary['CARD-12']!.deferredVisualFeedback, isTrue);
    expect(kCardLibrary['CARD-14']!.deferredVisualFeedback, isTrue);
    expect(kCardLibrary['CARD-16']!.deferredVisualFeedback, isTrue);
  });

  test('v9 all universal/repertoire/timbre/advanced cards present', () {
    final ids = <String>[
      for (var i = 1; i <= 25; i++) 'UC-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 13; i++) 'TONE-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 10; i++) 'RA-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 12; i++) 'IC-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 12; i++) 'IM-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'CL-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'GY-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 6; i++) 'RB-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 6; i++) 'RK-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 6; i++) 'WC-${i.toString().padLeft(2, '0')}',
    ];
    for (final id in ids) {
      final c = kCardLibrary[id];
      expect(c, isNotNull, reason: '$id missing in library');
      expect(c!.cue, isNotEmpty, reason: '$id empty cue');
      expect(c.voicedMicroWin, isNotEmpty, reason: '$id empty voicedMicroWin');
    }
  });

  test('v9 recovery card is library-only and phonation contrast is safe', () {
    final scheduled = {
      for (final s in buildPlaceholderManifest()) s.cardId,
      for (final s in buildUniversalCoreManifest()) s.cardId,
      for (final s in buildRepertoireApplicationManifest()) s.cardId,
      for (final s in buildAdvancedGayoManifest()) s.cardId,
      for (final s in buildAdvancedMusicalManifest()) s.cardId,
      for (final s in buildAdvancedClassicalManifest()) s.cardId,
      for (final s in buildAdvancedRbSoulManifest()) s.cardId,
      for (final s in buildAdvancedRockManifest()) s.cardId,
      for (final s in buildAdvancedCcmManifest()) s.cardId,
      for (final s in buildAdvancedUserSongManifest()) s.cardId,
    };
    expect(scheduled.contains('CARD-18'), isFalse);
    expect(kCardLibrary['CARD-18'], isNotNull);
    expect(
      kCardLibrary['UC-04']!.variableAxes['onset'],
      contains('pressed_listening_only'),
    );
  });

  test('I6.1 every cardId in all course manifests resolves (no dangling)', () {
    final manifests = <String, List<PathSlot>>{
      'beginner': buildPlaceholderManifest(),
      'universalCore': buildUniversalCoreManifest(),
      'repertoireApplication': buildRepertoireApplicationManifest(),
      'advancedMusical': buildAdvancedMusicalManifest(),
      'advancedClassical': buildAdvancedClassicalManifest(),
      'advancedGayo': buildAdvancedGayoManifest(),
      'advancedRbSoul': buildAdvancedRbSoulManifest(),
      'advancedRock': buildAdvancedRockManifest(),
      'advancedCcm': buildAdvancedCcmManifest(),
      'advancedUserSong': buildAdvancedUserSongManifest(),
    };
    for (final entry in manifests.entries) {
      for (final slot in entry.value) {
        expect(() => resolveCard(slot), returnsNormally,
            reason: '${entry.key}: ${slot.cardId} not in library');
      }
    }
  });

  test('R3 tone cards use self-tag/A-B metadata, not score metadata', () {
    final toneIds = [for (var i = 1; i <= 13; i++) 'TONE-${i.toString().padLeft(2, '0')}'];
    for (final id in toneIds) {
      final c = kCardLibrary[id]!;
      expect(c.timbreTags, isNotEmpty, reason: '$id has no timbre tags');
      expect(c.acousticFeedbackLevel == 'basic' ||
          c.acousticFeedbackLevel == 'ab' ||
          c.acousticFeedbackLevel == 'internalOnly', isTrue);
    }
    expect(kCardLibrary['TONE-12']!.allowsToneAB, isTrue);
    expect(kCardLibrary['CARD-13']!.requiresSameRecordingCondition, isTrue);
  });

  test('I1.2 HITL-SIGNOFF safety cards flagged pending; others none', () {
    const pending = {
      'IM-02', 'IM-03', 'IM-05', 'IM-12',
      'CL-01', 'CL-08',
      'GY-04', 'GY-05', 'GY-06', 'GY-09',
    };
    for (final entry in kCardLibrary.entries) {
      final expected =
          pending.contains(entry.key) ? SafetyReview.pending : SafetyReview.none;
      expect(entry.value.safetyReview, expected,
          reason: '${entry.key} safetyReview mismatch');
    }
  });

  test('R4 pending high-risk cards have fallback and runtime cap metadata', () {
    final pending = safetyGatedCardIds();
    for (final id in pending) {
      final c = kCardLibrary[id]!;
      expect(c.fallbackCardId, isNotNull, reason: '$id needs safe fallback');
      expect(kCardLibrary[c.fallbackCardId], isNotNull,
          reason: '$id fallback ${c.fallbackCardId} missing');
      expect(c.safetyIntensity, 'gated', reason: '$id should be gated');
      expect(c.weeklyCap, isNotNull, reason: '$id needs weekly cap');
    }
  });

  test('v15 tone cards expose bounded self-tag and reproduction metadata', () {
    const allowedLayers = {'source', 'filter', 'style', 'learningSafety'};
    for (var i = 1; i <= 13; i++) {
      final id = 'TONE-${i.toString().padLeft(2, '0')}';
      final card = kCardLibrary[id]!;
      expect(allowedLayers, contains(card.timbreLayer),
          reason: '$id invalid timbre layer');
      expect(card.toneTagOptions, isNotEmpty,
          reason: '$id needs user-selectable tags');
      expect(card.maxTakeCount, isNotNull,
          reason: '$id needs a bounded take count');
      expect(card.maxTakeCount!, lessThanOrEqualTo(3),
          reason: '$id must not encourage unlimited retakes');
    }
    expect(kCardLibrary['TONE-07']!.toneSequence, ['bright', 'warm']);
    expect(kCardLibrary['TONE-12']!.toneSequence,
        ['clean', 'warm', 'speechLike']);
    expect(kCardLibrary['TONE-12']!.maxTakeCount, 3);
    expect(kCardLibrary['TONE-13']!.safetyIntensity, 'moderate');
  });

  test('v15 tone cards do not expose diagnostic or celebrity-match goals', () {
    const banned = [
      '성대 접촉률',
      '폐쇄율',
      '진단',
      '건강 점수',
      '가수 매칭',
      '아이돌 매칭',
    ];
    for (var i = 1; i <= 13; i++) {
      final id = 'TONE-${i.toString().padLeft(2, '0')}';
      final card = kCardLibrary[id]!;
      final text = [...card.cue, card.toneGoal].join(' ');
      for (final token in banned) {
        expect(text.contains(token), isFalse,
            reason: '$id contains banned product claim $token');
      }
    }
  });

}

