import 'package:flutter_test/flutter_test.dart';
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
}

