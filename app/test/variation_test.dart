/// C3 — 변주 엔진 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/variation.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('C3.4 CARD-12 (variable) rotates all axes by day', () {
    final card = kCardLibrary['CARD-12']!;
    const slot = PathSlot(
      index: 45,
      cardId: 'CARD-12',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    final d0 = selectVariation(card, slot, 0);
    final d1 = selectVariation(card, slot, 1);
    final diffs = d0.keys.where((k) => d0[k] != d1[k]).toList();
    expect(diffs.length, greaterThanOrEqualTo(2),
        reason: 'variable should rotate ≥2 axes: d0=$d0 d1=$d1');
  });

  test('C3.3 CARD-08 (lightVariable) rotates first axis only by day', () {
    final card = kCardLibrary['CARD-08']!;
    const slot = PathSlot(
      index: 25,
      cardId: 'CARD-08',
      block: 3,
      bodyVoicedRatio: 0.40,
      variationLevel: VariationLevel.lightVariable,
    );
    final d0 = selectVariation(card, slot, 0);
    final d1 = selectVariation(card, slot, 1);
    expect(d0.length, greaterThanOrEqualTo(2));
    final diffs = d0.keys.where((k) => d0[k] != d1[k]).toList();
    expect(diffs.length, 1,
        reason: 'lightVariable should rotate exactly one axis: diffs=$diffs');
    expect(diffs.first, card.variableAxes.keys.first,
        reason: 'lightVariable should rotate the FIRST axis');
  });

  test('C3.2 CARD-01 (blocked) day-invariant first values', () {
    final card = kCardLibrary['CARD-01']!;
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    expect(selectVariation(card, slot, 0), {'sessionPos': '워밍업'});
    expect(selectVariation(card, slot, 5), {'sessionPos': '워밍업'});
  });

  test('C3.1 CARD-13 (empty axes) → selectVariation == {}', () {
    final card = kCardLibrary['CARD-13']!;
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-13',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    expect(selectVariation(card, slot, 0), isEmpty);
    expect(selectVariation(card, slot, 7), isEmpty);
  });
}
