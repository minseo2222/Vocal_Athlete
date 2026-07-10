import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/recording/audio_io.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 5400);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('v11 completion saves attempts and self-check as metadata',
      (tester) async {
    _phoneViewport(tester);
    final evidence = InMemoryLearningEvidenceRepository();
    final reviewQueue = InMemoryReviewQueueRepository();
    final progression = Progression.from(
      buildUniversalCoreManifest(),
      stage: LearningStage.universalCore,
    );
    await tester.pumpWidget(DebugApp(
      initialProgression: progression,
      startInLesson: true,
      evidenceRepository: evidence,
      reviewQueueRepository: reviewQueue,
      trainingAudioPlaybackAdapter: FakeTrainingAudioPlaybackAdapter(),
    ));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('lesson-attempt-add')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('lesson-self-check-1')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();

    final records = await evidence.listRecords();
    expect(records, hasLength(1));
    expect(records.single.track, 'universalCore');
    expect(records.single.day, 1);
    expect(records.single.snapshot.attemptsUsed, 1);
    expect(records.single.snapshot.selfCheckIndexes, contains(0));
    expect(records.single.targetEvidence, LearningEvidenceLevel.e1);
    expect(records.single.contentRevision, contains('universalCore:1:'));
    final reviews = await reviewQueue.listItems(status: ReviewTaskStatus.pending);
    expect(reviews, hasLength(1));
    expect(reviews.single.kind, ReviewTaskKind.retention);
  });

  testWidgets('v11 app pause stops training audio and cancels capture',
      (tester) async {
    final training = FakeTrainingAudioPlaybackAdapter();
    final capture = FakeAudioCaptureAdapter();
    await tester.pumpWidget(DebugApp(
      recordingCaptureAdapter: capture,
      trainingAudioPlaybackAdapter: training,
    ));
    await tester.pumpAndSettle();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    expect(training.stopCalls, greaterThanOrEqualTo(1));
    expect(capture.cancelCalls, greaterThanOrEqualTo(1));
  });
}
