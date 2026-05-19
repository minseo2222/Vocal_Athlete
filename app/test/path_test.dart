import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('manifest = pathLength slots, contiguous 0-based index', () {
    final m = buildPlaceholderManifest();
    expect(m.length, pathLength);
    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
  });

  test('blocks span 1..5 in order, ratio decreases monotonically', () {
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

  test('variation escalates blocked -> variable', () {
    final m = buildPlaceholderManifest();
    expect(m.first.variationLevel, VariationLevel.blocked);
    expect(m.last.variationLevel, VariationLevel.variable);
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
}
