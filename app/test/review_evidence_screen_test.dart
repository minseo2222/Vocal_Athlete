import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/review_evidence_screen.dart';

void main() {
  testWidgets('v13 review evidence screen renders local review trace',
      (tester) async {
    final repository = InMemoryReviewEvidenceRepository();
    await repository.saveRecord(const ReviewEvidenceRecord(
      id: 'review_1',
      reviewTaskId: 'task_1',
      sourceEvidenceId: 'source_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      kind: ReviewTaskKind.retention,
      targetEvidence: LearningEvidenceLevel.e2,
      completedEpochMs: 2000,
      voiceState: 'ok',
      adaptationMode: 'normal',
      sourceContentRevision: 'same',
      currentContentRevision: 'same',
      snapshot: ReviewPracticeSnapshot(
        attemptsUsed: 1,
        selfCheckIndexes: <int>[0],
        playedSourceTakeIds: <String>['source_take'],
      ),
    ));

    await tester.pumpWidget(MaterialApp(
      home: ReviewEvidenceScreen(repository: repository, onBack: () {}),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('review-evidence-screen')), findsOneWidget);
    expect(find.textContaining('지연 재현'), findsOneWidget);
    expect(find.textContaining('이전 take 재생 1개'), findsOneWidget);
    expect(find.text('원래 배운 내용 그대로 복습했어요'), findsOneWidget);
  });
}
