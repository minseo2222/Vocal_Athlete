/// v14 — 복습 task를 원 카드의 핵심 cue와 안전한 단일 전이 조건으로 변환.
///
/// 자동 실력 판정이나 음역 상승을 제안하지 않는다. 조건 전이는 한 번에 하나만
/// 바꾸며, 높은 키보다 같은/낮은 편안한 조건과 가이드 감소를 우선한다.
library;

import 'learning_evidence.dart';
import 'review_queue.dart';
import '../curriculum/lesson_blueprint.dart';

class ReviewInstructionPlan {
  const ReviewInstructionPlan({
    required this.primaryCue,
    required this.steps,
    this.transferCondition,
  });

  final String primaryCue;
  final List<String> steps;
  final String? transferCondition;

  String get displayText {
    final lines = <String>['핵심 cue · $primaryCue'];
    if (transferCondition != null) {
      lines.add('오늘 바꿀 조건 · $transferCondition');
    }
    for (var i = 0; i < steps.length; i++) {
      lines.add('${i + 1}. ${steps[i]}');
    }
    return lines.join('\n');
  }
}

class ReviewInstructionResolver {
  const ReviewInstructionResolver();

  ReviewInstructionPlan resolve({
    required ReviewQueueItem item,
    LessonBlueprintEntry? currentEntry,
    LearningEvidenceRecord? sourceEvidence,
  }) {
    final blueprint = currentEntry?.blueprint;
    final cue = blueprint?.objective.trim().isNotEmpty == true
        ? blueprint!.objective.trim()
        : _fallbackCue(item.cardId);
    if (item.kind == ReviewTaskKind.retention) {
      return ReviewInstructionPlan(
        primaryCue: cue,
        steps: <String>[
          '이전 take나 가이드 없이 cue를 먼저 떠올립니다.',
          '편안한 범위에서 1회만 재현합니다.',
          '필요할 때만 이전 기록을 듣고 자기점검을 남깁니다.',
        ],
      );
    }
    return ReviewInstructionPlan(
      primaryCue: cue,
      transferCondition: _transferCondition(
        item: item,
        sourceEvidence: sourceEvidence,
      ),
      steps: <String>[
        '원래 cue는 그대로 두고 아래 조건 하나만 바꿉니다.',
        '편안한 범위에서 최대 2회만 확인합니다.',
        '변경 조건보다 목의 편안함이 먼저 무너지면 중단합니다.',
      ],
    );
  }

  String _transferCondition({
    required ReviewQueueItem item,
    LearningEvidenceRecord? sourceEvidence,
  }) {
    if (item.track == 'repertoireApplication') {
      final sourceKey = sourceEvidence?.snapshot.selectedKey;
      if (sourceKey == 'mid') {
        return '같은 키에서 가이드를 한 단계 줄이거나 낮은 키로 바꾸기';
      }
      return '같은 편안한 키에서 가이드를 한 단계 줄이기';
    }
    if (item.cardId == 'UC-19') {
      return '시작음을 편안한 범위에서 한 단계 낮춰 보기';
    }
    if (item.cardId == 'UC-20' || item.cardId == 'CARD-15') {
      return 'tempo를 조금 느리게 하고 같은 박 구조 유지하기';
    }
    if (item.cardId.startsWith('TONE-') || item.cardId == 'UC-21') {
      return '모음 하나만 바꾸고 같은 힘과 길이 유지하기';
    }
    return 'tempo 또는 모음 중 하나만 바꾸기';
  }

  String _fallbackCue(String cardId) => switch (cardId) {
        'UC-01' => '숨을 크게 모으기보다 편안한 시작과 끝을 유지합니다.',
        'UC-24' => 'SOVT의 편안함을 짧은 가사까지 옮깁니다.',
        'RA-09' => '전체 프레이즈의 호흡·박자·가사 흐름을 먼저 봅니다.',
        'RA-10' => '도움을 줄인 상태에서 같은 프레이즈를 다시 재현합니다.',
        _ => '원 레슨에서 사용한 핵심 cue 하나만 다시 떠올립니다.',
      };
}
