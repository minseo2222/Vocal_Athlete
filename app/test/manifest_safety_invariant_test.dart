/// 방어 심층 — 사용자 대면 트랙(초급·코어·곡적용)에 미사인오프 고위험 카드가
/// 절대 스케줄되지 않음을 빌드타임에 고정. 고위험(belt·트웽·cover·messa·통성 등)은
/// safetyReview=pending 또는 safetyIntensity='gated'로 표시되며, 이들은 오직 고급
/// 장르 블록에만 있어야 하고 그 장르는 kReleasedAdvancedGenres로 잠겨 있다.
/// 매니페스트 실수로 이런 카드가 일반 사용자 경로에 새어들면 이 테스트가 잡는다.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('사용자 대면 매니페스트에 미사인오프 고위험(pending/gated) 카드 없음', () {
    final manifests = <String, List<PathSlot>>{
      'beginner': buildPlaceholderManifest(),
      'core': buildUniversalCoreManifest(),
      'repertoire': buildRepertoireApplicationManifest(),
    };
    final violations = <String>[];
    for (final entry in manifests.entries) {
      for (final slot in entry.value) {
        final card = kCardLibrary[slot.cardId];
        // 매니페스트 카드는 라이브러리에 반드시 존재해야 한다.
        expect(card, isNotNull,
            reason: '${entry.key} 매니페스트의 ${slot.cardId}가 kCardLibrary에 없음');
        if (card == null) continue;
        if (card.safetyReview == SafetyReview.pending ||
            card.safetyIntensity == 'gated') {
          violations.add('${entry.key}: ${slot.cardId} '
              '(review=${card.safetyReview.name}, intensity=${card.safetyIntensity})');
        }
      }
    }
    expect(violations, isEmpty,
        reason: '사용자 대면 트랙에 고위험 카드가 스케줄됨:\n${violations.join('\n')}');
  });
}
