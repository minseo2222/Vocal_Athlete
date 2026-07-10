import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('v13 Today optional review creates linked review evidence',
      (tester) async {
    final learning = InMemoryLearningEvidenceRepository();
    final queue = InMemoryReviewQueueRepository();
    final reviews = InMemoryReviewEvidenceRepository();
    const revision =
        'universalCore:1:v10:day_1:UC-01:sha256_b00bafa4a975';

    await learning.saveRecord(const LearningEvidenceRecord(
      id: 'source_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      targetEvidence: LearningEvidenceLevel.e1,
      completedEpochMs: 1000,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: LessonPracticeSnapshot(attemptsUsed: 1),
      contentRevision: revision,
    ));
    await queue.saveItem(const ReviewQueueItem(
      id: 'task_1',
      sourceEvidenceId: 'source_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      kind: ReviewTaskKind.retention,
      targetEvidence: LearningEvidenceLevel.e2,
      dueEpochDay: 10,
      createdEpochMs: 1000,
      contentRevision: revision,
    ));

    await tester.pumpWidget(DebugApp(
      evidenceRepository: learning,
      reviewQueueRepository: queue,
      reviewEvidenceRepository: reviews,
      todayEpochDay: 10,
    ));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('today-review-card')), findsOneWidget);
    await tester.tap(find.byKey(const Key('today-review-open')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('review-task-complete-task_1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('review-voice-ok')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('review-attempt-add')));
    await tester.pump();
    final check = find.byKey(const Key('review-self-check-1'));
    await tester.ensureVisible(check);
    await tester.tap(check);
    await tester.pump();
    final finish = find.byKey(const Key('review-finish'));
    await tester.ensureVisible(finish);
    await tester.tap(finish);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('review-queue-empty')), findsOneWidget);
    expect(await reviews.listRecords(), hasLength(1));
    expect(
      await queue.listItems(status: ReviewTaskStatus.completed),
      hasLength(1),
    );
  });
}
