/// 규제 카피 lint — 카드 사용자 대면 문구에 의료기기 전환 트리거 표현이 없는지 단언.
///
/// 근거: docs/verification/CLINICAL-SIGNOFF-PACKET-2026.md §3 (MFDS 웰니스 유지 — 금지 카피).
/// 무점수·비진단 포지셔닝을 깨는 "주장형" 표현만 차단한다. "진단이 아닙니다"·"점수 없음"
/// 같은 면책/강조는 정상이므로, 단어가 아니라 **명확한 주장 구절**만 금지 목록에 둔다.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';

// 사용자 대면 카드 문구에 절대 들어가면 안 되는 주장형 표현(맥락 무관 위반).
const List<String> _forbidden = [
  'medical-grade',
  '의료급',
  '건강 점수',
  '위험도',
  '의학적으로 입증',
  '임상적으로 입증',
  '병원 갈 필요 없',
  '전문가 대체',
  '성대결절 예방',
  '쉰목소리 치료',
  '후두질환 모니터',
  '음성장애 치료',
];

void main() {
  test('규제 카피 lint — 카드 사용자 문구에 금지 주장 표현 없음', () {
    final violations = <String>[];
    for (final entry in kCardLibrary.entries) {
      final card = entry.value;
      final texts = <String>[
        ...card.cue,
        ...card.voicedMicroWin,
        card.anatomyEntry,
        card.anatomyMain,
        card.anatomyCooldown,
        card.toneGoal,
      ];
      for (final t in texts) {
        for (final bad in _forbidden) {
          if (t.contains(bad)) {
            violations.add('${entry.key}: "$bad" in "$t"');
          }
        }
      }
    }
    expect(violations, isEmpty,
        reason: '카드 사용자 문구에 의료기기 전환 트리거 표현이 있음:\n${violations.join('\n')}');
  });
}
