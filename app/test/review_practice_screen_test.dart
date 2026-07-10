import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/review_practice_screen.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

// universal_core_cycle_01.json(v16) + content_manifest_v18.json의 sha256에서 도출.
// 에셋/매니페스트가 바뀌면 이 값을 갱신해야 revision 일치 검증이 유지된다.
const revision =
    'universalCore:1:v16:day_1:UC-01:sha256_f872c4e8d7ad';

LearningEvidenceRecord _sourceEvidence() => const LearningEvidenceRecord(
      id: 'source_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      targetEvidence: LearningEvidenceLevel.e1,
      completedEpochMs: 1000,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: LessonPracticeSnapshot(
        attemptsUsed: 1,
        selfCheckIndexes: <int>[0],
        recordedTakeIds: <String>['source_take_1'],
        bestTakeSelected: true,
        bestTakeId: 'source_take_1',
      ),
      contentRevision: revision,
    );

ReviewQueueItem _item() => const ReviewQueueItem(
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
    );

Future<void> _pumpScreen(
  WidgetTester tester, {
  required InMemoryReviewQueueRepository queue,
  required InMemoryLearningEvidenceRepository learning,
  required InMemoryReviewEvidenceRepository reviewEvidence,
  required InMemoryRecordingRepository recordings,
  required FakeAudioPlaybackAdapter playback,
  required VoidCallback onFinished,
}) async {
  tester.view.physicalSize = const Size(1200, 3600);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MaterialApp(
    home: ReviewPracticeScreen(
      item: _item(),
      reviewQueueRepository: queue,
      learningEvidenceRepository: learning,
      reviewEvidenceRepository: reviewEvidence,
      recordingRepository: recordings,
      playbackAdapter: playback,
      todayEpochDay: 10,
      onBack: () {},
      onFinished: onFinished,
    ),
  ));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('v13 review session records a trace and completes the task',
      (tester) async {
    final queue = InMemoryReviewQueueRepository();
    final learning = InMemoryLearningEvidenceRepository();
    final reviewEvidence = InMemoryReviewEvidenceRepository();
    final recordings = InMemoryRecordingRepository();
    final playback = FakeAudioPlaybackAdapter();
    var finished = false;

    await queue.saveItem(_item());
    await learning.saveRecord(_sourceEvidence());
    await recordings.saveTake(const RecordingTake(
      id: 'source_take_1',
      cardId: 'UC-01',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: '/tmp/source_take_1.m4a',
      createdEpochMs: 1000,
      durationMs: 2200,
      isBest: true,
    ));

    await _pumpScreen(
      tester,
      queue: queue,
      learning: learning,
      reviewEvidence: reviewEvidence,
      recordings: recordings,
      playback: playback,
      onFinished: () => finished = true,
    );

    expect(find.byKey(const Key('review-practice-screen')), findsOneWidget);
    expect(find.byKey(const Key('review-revision-warning')), findsNothing);

    await tester.tap(find.byKey(const Key('review-voice-ok')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('review-attempt-add')));
    await tester.pump();

    final sourceButton = find.byKey(
      const Key('review-source-play-source_take_1'),
    );
    await tester.ensureVisible(sourceButton);
    await tester.tap(sourceButton);
    await tester.pump();
    expect(playback.played, <String>['/tmp/source_take_1.m4a']);

    final check = find.byKey(const Key('review-self-check-1'));
    await tester.ensureVisible(check);
    await tester.tap(check);
    await tester.pump();

    final finish = find.byKey(const Key('review-finish'));
    await tester.ensureVisible(finish);
    await tester.tap(finish);
    await tester.pumpAndSettle();

    expect(finished, isTrue);
    expect(
      await queue.listItems(status: ReviewTaskStatus.completed),
      hasLength(1),
    );
    final records = await reviewEvidence.listRecords();
    expect(records, hasLength(1));
    expect(records.single.snapshot.attemptsUsed, 1);
    expect(
      records.single.snapshot.playedSourceTakeIds,
      <String>['source_take_1'],
    );
    expect(records.single.revisionMatched, isTrue);
  });

  testWidgets('v13 hoarse review requires a no-voice action and postpones',
      (tester) async {
    final queue = InMemoryReviewQueueRepository();
    final learning = InMemoryLearningEvidenceRepository();
    final reviewEvidence = InMemoryReviewEvidenceRepository();
    final recordings = InMemoryRecordingRepository();
    final playback = FakeAudioPlaybackAdapter();

    await queue.saveItem(_item());
    await learning.saveRecord(_sourceEvidence());

    await _pumpScreen(
      tester,
      queue: queue,
      learning: learning,
      reviewEvidence: reviewEvidence,
      recordings: recordings,
      playback: playback,
      onFinished: () {},
    );

    await tester.tap(find.byKey(const Key('review-voice-hoarse')));
    await tester.pump();
    expect(find.byKey(const Key('review-recovery-notice')), findsOneWidget);

    var finishButton = tester.widget<FilledButton>(
      find.byKey(const Key('review-finish')),
    );
    expect(finishButton.onPressed, isNull);

    final noVoiceCheck = find.byKey(const Key('review-self-check-1'));
    await tester.ensureVisible(noVoiceCheck);
    await tester.tap(noVoiceCheck);
    await tester.pump();
    finishButton = tester.widget<FilledButton>(
      find.byKey(const Key('review-finish')),
    );
    expect(finishButton.onPressed, isNotNull);

    await tester.tap(find.byKey(const Key('review-finish')));
    await tester.pumpAndSettle();

    final pending = await queue.listItems(status: ReviewTaskStatus.pending);
    expect(pending.single.dueEpochDay, 11);
    expect(pending.single.note, contains('recovery'));
    final records = await reviewEvidence.listRecords();
    expect(records.single.isRecovery, isTrue);
    expect(records.single.snapshot.attemptsUsed, 0);
  });

  testWidgets(
      'v13 switching to hoarse discards voiced trace as completion evidence',
      (tester) async {
    final queue = InMemoryReviewQueueRepository();
    final learning = InMemoryLearningEvidenceRepository();
    final reviewEvidence = InMemoryReviewEvidenceRepository();
    final recordings = InMemoryRecordingRepository();
    final playback = FakeAudioPlaybackAdapter();

    await queue.saveItem(_item());
    await learning.saveRecord(_sourceEvidence());

    await _pumpScreen(
      tester,
      queue: queue,
      learning: learning,
      reviewEvidence: reviewEvidence,
      recordings: recordings,
      playback: playback,
      onFinished: () {},
    );

    await tester.tap(find.byKey(const Key('review-voice-ok')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('review-attempt-add')));
    await tester.pump();

    var finishButton = tester.widget<FilledButton>(
      find.byKey(const Key('review-finish')),
    );
    expect(finishButton.onPressed, isNotNull);

    await tester.tap(find.byKey(const Key('review-voice-hoarse')));
    await tester.pump();
    finishButton = tester.widget<FilledButton>(
      find.byKey(const Key('review-finish')),
    );
    expect(finishButton.onPressed, isNull);

    final noVoiceCheck = find.byKey(const Key('review-self-check-2'));
    await tester.ensureVisible(noVoiceCheck);
    await tester.tap(noVoiceCheck);
    await tester.pump();
    finishButton = tester.widget<FilledButton>(
      find.byKey(const Key('review-finish')),
    );
    expect(finishButton.onPressed, isNotNull);
  });

}
