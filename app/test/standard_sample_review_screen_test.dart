import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/standard_sample_review_screen.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void main() {
  testWidgets('v6 standard sample review shows empty state and saved takes',
      (tester) async {
    final repo = InMemoryRecordingRepository();
    final playback = FakeAudioPlaybackAdapter();

    await tester.pumpWidget(MaterialApp(
      home: StandardSampleReviewScreen(
        repository: repo,
        playbackAdapter: playback,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('standard-review-empty')), findsOneWidget);

    await repo.saveTake(const RecordingTake(
      id: 'CARD-13_baseline_take_01',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: '/tmp/sample.m4a',
      createdEpochMs: 1,
      durationMs: 3000,
      fileSizeBytes: 128,
      toneTags: [ToneTag.clear],
      comfortRating: 4,
      sameConditionConfirmed: true,
    ));


    await repo.saveTake(const RecordingTake(
      id: 'CARD-13_midpoint_take_01',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.midpoint,
      localPath: '/tmp/midpoint.m4a',
      createdEpochMs: 2,
      durationMs: 3000,
      toneTags: [ToneTag.warm],
      comfortRating: 4,
      sameConditionConfirmed: true,
    ));
    await repo.saveTake(const RecordingTake(
      id: 'CARD-13_graduation_take_01',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.graduation,
      localPath: '/tmp/graduation.m4a',
      createdEpochMs: 3,
      durationMs: 3000,
      toneTags: [ToneTag.clean],
      comfortRating: 5,
      sameConditionConfirmed: true,
    ));

    // 화면을 닫았다가 다시 열어 새로 저장된 take를 로드한다.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(MaterialApp(
      home: StandardSampleReviewScreen(
        repository: repo,
        playbackAdapter: playback,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('standard-take-CARD-13_baseline_take_01')), findsOneWidget);
    expect(find.textContaining('Baseline'), findsOneWidget);
    expect(find.byKey(const Key('standard-take-CARD-13_midpoint_take_01')), findsOneWidget);
    expect(find.byKey(const Key('standard-take-CARD-13_graduation_take_01')), findsOneWidget);

    await tester.tap(find.byKey(const Key('standard-play-CARD-13_baseline_take_01')));
    await tester.pump();
    expect(playback.played.single, '/tmp/sample.m4a');
  });
}
