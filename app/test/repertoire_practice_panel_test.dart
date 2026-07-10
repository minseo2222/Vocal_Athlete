import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/repertoire_practice_panel.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/repertoire/repertoire_asset.dart';

void main() {
  const asset = RepertoireAsset(
    id: 'neutral_001',
    title: 'Neutral 4-Bar Phrase 1',
    language: 'ko',
    bars: 4,
    tempoBpm: 72,
    countInBeats: 4,
    assetStatus: 'prototype_audio_ready',
    recommendedKeys: ['low', 'mid'],
    audioAssets: {
      'guideHumLow': 'assets/repertoire/neutral_001/guide_hum_low.wav',
      'guideHumMid': 'assets/repertoire/neutral_001/guide_hum_mid.wav',
      'backingTrackLow': 'assets/repertoire/neutral_001/backing_track_low.wav',
      'backingTrackMid': 'assets/repertoire/neutral_001/backing_track_mid.wav',
    },
    lyricTiming: [
      LyricCue(bar: 1, text: '오늘은', beat: 1),
      LyricCue(bar: 2, text: '편하게', beat: 1),
    ],
    breathMarks: [BreathMark(beforeBar: 1, cue: '작게 준비')],
    rightsRecord: 'assets/repertoire/neutral_001/rights.json',
  );

  testWidgets('v10 repertoire panel plays selected bundled guide',
      (tester) async {
    final playback = FakeTrainingAudioPlaybackAdapter();
    var beforePlay = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepertoirePracticePanel(
          assetId: 'neutral_001',
          guideState: 'full',
          asset: asset,
          playbackAdapter: playback,
          onBeforeAudioPlay: () async => beforePlay++,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('repertoire-practice-panel')), findsOneWidget);
    expect(find.byKey(const Key('lyric-bar-1')), findsOneWidget);
    expect(find.byKey(const Key('repertoire-key-selector')), findsOneWidget);
    await tester.tap(find.byKey(const Key('training-audio-guideHumMid')));
    await tester.pump();
    expect(beforePlay, 1);
    expect(playback.playedAssets.single,
        'assets/repertoire/neutral_001/guide_hum_mid.wav');
  });

  testWidgets('v11 key selector reports selected comfortable key',
      (tester) async {
    final playback = FakeTrainingAudioPlaybackAdapter();
    String? selectedKey;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepertoirePracticePanel(
          assetId: 'neutral_001',
          guideState: 'full',
          asset: asset,
          playbackAdapter: playback,
          onKeyChanged: (key) => selectedKey = key,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('repertoire-key-low')));
    await tester.pump();
    expect(find.byKey(const Key('training-audio-guideHumLow')), findsOneWidget);
    expect(find.byKey(const Key('training-audio-backingTrackLow')), findsOneWidget);
    expect(selectedKey, 'low');
  });

  testWidgets('v10 transfer day keeps backing but removes vocal guide',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: RepertoirePracticePanel(
          assetId: 'neutral_001',
          guideState: 'transfer',
          asset: asset,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('transfer-guide-notice')), findsOneWidget);
    expect(find.byKey(const Key('training-audio-backingTrackMid')), findsOneWidget);
    expect(find.byKey(const Key('training-audio-guideHumMid')), findsNothing);
  });

  testWidgets('v10 no-guide day displays guide fade notice', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: RepertoirePracticePanel(
          assetId: 'neutral_001',
          guideState: 'none',
          asset: asset,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('guide-faded-notice')), findsOneWidget);
  });
}
