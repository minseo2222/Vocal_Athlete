import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('v15 timbre cards expose safe layer, tag and take metadata', () {
    final tone07 = kCardLibrary['TONE-07']!;
    expect(tone07.timbreLayer, 'filter');
    expect(tone07.toneSequence, ['bright', 'warm']);
    expect(tone07.maxTakeCount, 2);

    final tone12 = kCardLibrary['TONE-12']!;
    expect(tone12.toneSequence, ['clean', 'warm', 'speechLike']);
    expect(tone12.maxTakeCount, 3);
    expect(tone12.requiresSameRecordingCondition, isTrue);

    final tone13 = kCardLibrary['TONE-13']!;
    expect(tone13.safetyIntensity, 'moderate');
    expect(tone13.weeklyCap, 2);
    expect(tone13.fallbackCardId, 'TONE-12');
  });

  test('v15 timbre learning is distributed across the long path', () {
    final beginner = buildPlaceholderManifest().map((slot) => slot.cardId).toList();
    expect(beginner[36], 'TONE-02');
    expect(beginner[37], 'TONE-03');

    final core = buildUniversalCoreManifest();
    final toneByCycle = <int, Set<String>>{};
    for (final slot in core) {
      if (slot.cardId.startsWith('TONE-')) {
        toneByCycle.putIfAbsent(slot.cycle, () => <String>{}).add(slot.cardId);
      }
    }
    // Universal Core 12개 microcycle 중 11개에 음색 카드가 배치된다.
    // cycle 5는 현재 음색 카드가 없다(v15 나선형 설계상 보완 후보 — 커리큘럼 검토 필요).
    expect(toneByCycle.length, 11);
    expect(toneByCycle.containsKey(5), isFalse);
    expect(toneByCycle[7], contains('TONE-08'));
    expect(toneByCycle[8], containsAll(<String>['TONE-09', 'TONE-10']));
    expect(toneByCycle[12], contains('TONE-12'));

    final repertoire = buildRepertoireApplicationManifest();
    final project5 = repertoire.where((slot) => slot.cycle == 5).map((s) => s.cardId);
    final project6 = repertoire.where((slot) => slot.cycle == 6).map((s) => s.cardId);
    expect(project5, contains('TONE-11'));
    expect(project6, contains('TONE-12'));
  });
}
