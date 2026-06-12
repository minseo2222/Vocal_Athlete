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
    final ids = {for (final s in buildPlaceholderManifest()) s.cardId};
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

  test('I1.1 all intermediate cards present (IC/IM/CL/GY)', () {
    final ids = <String>[
      for (var i = 1; i <= 12; i++) 'IC-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 12; i++) 'IM-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'CL-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'GY-${i.toString().padLeft(2, '0')}',
    ];
    for (final id in ids) {
      final c = kCardLibrary[id];
      expect(c, isNotNull, reason: '$id missing in library');
      expect(c!.cue, isNotEmpty, reason: '$id empty cue');
      expect(c.voicedMicroWin, isNotEmpty, reason: '$id empty voicedMicroWin');
    }
  });

  test('I6.1 every cardId in all course manifests resolves (no dangling)', () {
    final manifests = <String, List<PathSlot>>{
      'beginner': buildPlaceholderManifest(),
      'core': buildCoreManifest(),
      'musical': buildMusicalManifest(),
      'classical': buildClassicalManifest(),
      'gayo': buildGayoManifest(),
    };
    for (final entry in manifests.entries) {
      for (final slot in entry.value) {
        expect(() => resolveCard(slot), returnsNormally,
            reason: '${entry.key}: ${slot.cardId} not in library');
      }
    }
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

  test('P8 cards promising a target line provide targetHz', () {
    const targetLineTokens = ['목표선', 'target line'];
    for (final entry in kCardLibrary.entries) {
      final c = entry.value;
      final text = [
        ...c.cue,
        ...c.voicedMicroWin,
        c.anatomyEntry,
        c.anatomyMain,
        c.anatomyCooldown,
        for (final values in c.variableAxes.values) ...values,
      ].join('\n').toLowerCase();
      final promisesTargetLine = targetLineTokens.any(text.contains);
      if (promisesTargetLine) {
        expect(c.targetHz, isNotNull,
            reason: '${entry.key} mentions a target line but has no targetHz');
      }
    }
  });
}
