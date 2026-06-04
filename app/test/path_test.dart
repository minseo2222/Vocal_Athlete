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

  test('I2 core manifest = 32 slots, blocks 1-2, IC cards', () {
    final m = buildCoreManifest();
    expect(m.length, 32);
    expect(m.first.block, 1);
    expect(m.last.block, 2);
    expect(m.every((s) => s.cardId.startsWith('IC-')), isTrue);
    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
  });

  test('I2 genre course manifests = core(32) + branch, contiguous', () {
    final musical = buildMusicalManifest();
    final classical = buildClassicalManifest();
    final gayo = buildGayoManifest();
    expect(musical.length, 74); // 코어32 + 뮤지컬42
    expect(classical.length, 68); // 코어32 + 성악36
    expect(gayo.length, 64); // 코어32 + 가요32
    for (final m in [musical, classical, gayo]) {
      // 첫 32은 코어(IC), 이후 분기 카드, 블록 1→4 단조 증가
      expect(m.take(32).every((s) => s.cardId.startsWith('IC-')), isTrue);
      expect(m.first.block, 1);
      expect(m.last.block, 4);
      var prev = 0;
      for (final s in m) {
        expect(s.block, greaterThanOrEqualTo(prev));
        prev = s.block;
      }
    }
    expect(musical.any((s) => s.cardId.startsWith('IM-')), isTrue);
    expect(classical.any((s) => s.cardId.startsWith('CL-')), isTrue);
    expect(gayo.any((s) => s.cardId.startsWith('GY-')), isTrue);
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
