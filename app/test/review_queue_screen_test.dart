import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/review_queue_screen.dart';

ReviewQueueItem _item() => const ReviewQueueItem(
      id: 'task_1',
      sourceEvidenceId: 'evidence_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      kind: ReviewTaskKind.retention,
      targetEvidence: LearningEvidenceLevel.e2,
      dueEpochDay: 10,
      createdEpochMs: 1000,
      contentRevision:
          'universalCore:1:v10:day_1:UC-01:sha256_b00bafa4a975',
    );

void main() {
  testWidgets('v13 due task opens the actual review session callback',
      (tester) async {
    final repository = InMemoryReviewQueueRepository();
    ReviewQueueItem? selected;
    await repository.saveItem(_item());
    await tester.pumpWidget(MaterialApp(
      home: ReviewQueueScreen(
        repository: repository,
        todayEpochDay: 10,
        onStartReview: (item) => selected = item,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('review-queue-screen')), findsOneWidget);
    expect(find.textContaining('지연 재현'), findsOneWidget);
    await tester.tap(find.byKey(const Key('review-task-complete-task_1')));
    await tester.pump();

    expect(selected?.id, 'task_1');
    expect(
      await repository.listItems(status: ReviewTaskStatus.completed),
      isEmpty,
    );
  });

  testWidgets('v13 today skip postpones without dismissing the task',
      (tester) async {
    final repository = InMemoryReviewQueueRepository();
    await repository.saveItem(_item());
    await tester.pumpWidget(MaterialApp(
      home: ReviewQueueScreen(
        repository: repository,
        todayEpochDay: 10,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('review-task-skip-task_1')));
    await tester.pumpAndSettle();
    final pending = await repository.listItems(
      status: ReviewTaskStatus.pending,
    );
    expect(pending.single.dueEpochDay, 11);
    expect(pending.single.note, contains('without_streak_loss'));
  });

  testWidgets('v13 Today queue hides future tasks', (tester) async {
    final repository = InMemoryReviewQueueRepository();
    await repository.saveItem(_item());
    await repository.saveItem(ReviewQueueItem(
      id: 'future_task',
      sourceEvidenceId: 'evidence_2',
      track: 'universalCore',
      cycle: 1,
      day: 2,
      cardId: 'UC-02',
      kind: ReviewTaskKind.transfer,
      targetEvidence: LearningEvidenceLevel.e3,
      dueEpochDay: 13,
      createdEpochMs: 1001,
      contentRevision:
          'universalCore:1:v10:day_2:UC-02:sha256_b00bafa4a975',
    ));
    await tester.pumpWidget(MaterialApp(
      home: ReviewQueueScreen(
        repository: repository,
        todayEpochDay: 10,
        dueOnly: true,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('오늘의 선택 복습'), findsOneWidget);
    expect(find.byKey(const Key('review-task-task_1')), findsOneWidget);
    expect(find.byKey(const Key('review-task-future_task')), findsNothing);
  });

}
