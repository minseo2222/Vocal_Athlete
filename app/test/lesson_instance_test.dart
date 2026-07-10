/// LessonInstance — Card·variation·anatomy를 (slot, day)로 묶은 런타임 모델.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/lesson_instance.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('resolveLessonInstance exposes card + variation for slot/day', () {
    final manifest = buildPlaceholderManifest();
    final slot = manifest.first; // R2 Day 1 CARD-13 baseline sample
    final i = resolveLessonInstance(slot, 1);
    expect(i.card.id, 'CARD-13');
    expect(i.variation, isEmpty);
    expect(i.variationLabel, '');
    expect(i.hasVoicedMicroWin, isTrue);
  });

  test('variationLabel empty when card has no variableAxes (CARD-13)', () {
    final card13 = kCardLibrary['CARD-13']!;
    const slot = PathSlot(
      index: 47,
      cardId: 'CARD-13',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    final i = buildLessonInstance(card13, slot, 0);
    expect(i.variation, isEmpty);
    expect(i.variationLabel, '');
  });
}
