import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/repertoire_application_review_screen.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void main() {
  testWidgets('v7 repertoire application review lists phrase takes',
      (tester) async {
    final repo = InMemoryRecordingRepository();
    final playback = FakeAudioPlaybackAdapter();

    await tester.pumpWidget(MaterialApp(
      home: RepertoireApplicationReviewScreen(
        repository: repo,
        playbackAdapter: playback,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('repertoire-review-empty')), findsOneWidget);

    await repo.saveTake(const RecordingTake(
      id: 'RA-01_take_01',
      cardId: 'RA-01',
      purpose: RecordingPurpose.repertoirePhrase,
      slot: RecordingSlot.a,
      localPath: '/tmp/ra1.m4a',
      createdEpochMs: 1,
      durationMs: 4200,
      fileSizeBytes: 512,
      toneTags: [ToneTag.warm, ToneTag.clear],
      comfortRating: 4,
    ));

    // 화면을 닫았다가 다시 열어 새로 저장된 take를 로드한다.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(MaterialApp(
      home: RepertoireApplicationReviewScreen(
        repository: repo,
        playbackAdapter: playback,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('repertoire-section-RA-01')), findsOneWidget);
    expect(find.byKey(const Key('repertoire-take-RA-01_take_01')), findsOneWidget);
    await tester.tap(find.byKey(const Key('repertoire-play-RA-01_take_01')));
    await tester.pump();
    expect(playback.played.single, '/tmp/ra1.m4a');
  });
}
