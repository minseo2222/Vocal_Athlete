/// C3 — 변주 엔진. (Card, PathSlot, day) → 선택된 축 값 맵.
///
/// 결정적·무난수. variationLevel(blocked/lightVariable/variable)이 회전 범위 결정.
library;

import 'card.dart';
import '../progression/path.dart';

Map<String, String> selectVariation(Card card, PathSlot slot, int day) {
  if (card.variableAxes.isEmpty) return const {};
  final out = <String, String>{};
  var i = 0;
  for (final entry in card.variableAxes.entries) {
    final values = entry.value;
    if (values.isEmpty) continue;
    final rotate = switch (slot.variationLevel) {
      VariationLevel.blocked => false,
      VariationLevel.lightVariable => i == 0,
      VariationLevel.variable => true,
    };
    out[entry.key] = rotate ? values[day % values.length] : values.first;
    i++;
  }
  return out;
}
