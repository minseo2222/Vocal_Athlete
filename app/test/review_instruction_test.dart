import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_instruction.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';

ReviewQueueItem _item({
  ReviewTaskKind kind = ReviewTaskKind.retention,
  String track = 'universalCore',
  String cardId = 'UC-19',
}) =>
    ReviewQueueItem(
      id: 'task',
      sourceEvidenceId: 'source',
      track: track,
      cycle: 1,
      day: 1,
      cardId: cardId,
      kind: kind,
      targetEvidence: kind == ReviewTaskKind.retention
          ? LearningEvidenceLevel.e2
          : LearningEvidenceLevel.e3,
      dueEpochDay: 1,
      createdEpochMs: 1,
      contentRevision: 'revision',
    );

void main() {
  test('v14 retention starts without guide and keeps one core cue', () {
    final plan = const ReviewInstructionResolver().resolve(item: _item());
    expect(plan.transferCondition, isNull);
    expect(plan.displayText, contains('이전 take나 가이드 없이'));
    expect(plan.displayText, contains('1회'));
  });

  test('v14 pitch transfer changes downward rather than suggesting a higher key', () {
    final plan = const ReviewInstructionResolver().resolve(
      item: _item(kind: ReviewTaskKind.transfer),
    );
    expect(plan.transferCondition, contains('낮춰'));
    expect(plan.displayText, isNot(contains('높여')));
  });

  test('v14 repertoire transfer reduces guide or uses a lower key', () {
    final source = LearningEvidenceRecord(
      id: 'source',
      track: 'repertoireApplication',
      cycle: 1,
      day: 1,
      cardId: 'RA-09',
      targetEvidence: LearningEvidenceLevel.e1,
      completedEpochMs: 1,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: const LessonPracticeSnapshot(selectedKey: 'mid'),
    );
    final plan = const ReviewInstructionResolver().resolve(
      item: _item(
        kind: ReviewTaskKind.transfer,
        track: 'repertoireApplication',
        cardId: 'RA-09',
      ),
      sourceEvidence: source,
    );
    expect(plan.transferCondition, contains('가이드'));
    expect(plan.transferCondition, contains('낮은 키'));
  });
}
