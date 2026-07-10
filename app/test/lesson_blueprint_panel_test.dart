import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/curriculum/lesson_blueprint.dart';
import 'package:vocal_athlete/lesson/lesson_blueprint_panel.dart';
import 'package:vocal_athlete/recording/audio_io.dart';

void main() {
  testWidgets('v10 blueprint panel shows steps, self-check and plays cue',
      (tester) async {
    final playback = FakeTrainingAudioPlaybackAdapter();
    LessonPracticeSnapshot latest = const LessonPracticeSnapshot();
    var beforePlay = 0;
    const blueprint = LessonBlueprint(
      day: 1,
      cardId: 'UC-01',
      title: '4박을 편하게 남기기',
      primarySkill: '호흡 배분',
      secondarySkill: '프레이즈 마무리',
      objective: '4박을 편하게 낸다.',
      attempts: 3,
      steps: ['말로 세기', '/m/', '/u/'],
      feedbackPrompt: '편하게 멈췄는지 확인',
      selfCheck: ['끝에 숨이 남았다', '어깨가 들리지 않았다'],
      recoveryAlternative: '무성 날숨만 한다.',
      evidence: 'E1',
      audioCues: [
        LessonAudioCue(
          label: '예시',
          path: 'assets/training/universal_core_cycle_01/phrase_4beat_u_mid.wav',
        ),
      ],
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LessonBlueprintPanel(
          track: 'universalCore',
          cycle: 1,
          day: 1,
          blueprint: blueprint,
          playbackAdapter: playback,
          onBeforeAudioPlay: () async => beforePlay++,
          onSnapshotChanged: (snapshot) => latest = snapshot,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('lesson-blueprint-panel')), findsOneWidget);
    expect(find.byKey(const Key('lesson-blueprint-step-3')), findsOneWidget);
    await tester.tap(find.byKey(const Key('lesson-audio-phrase_4beat_u_mid.wav')));
    await tester.pump();
    expect(beforePlay, 1);
    expect(playback.playedAssets.single,
        'assets/training/universal_core_cycle_01/phrase_4beat_u_mid.wav');
    await tester.tap(find.byKey(const Key('lesson-attempt-add')));
    await tester.pump();
    expect(latest.attemptsUsed, 1);
    await tester.tap(find.byKey(const Key('lesson-self-check-1')));
    await tester.pump();
    final chip = tester.widget<FilterChip>(
        find.byKey(const Key('lesson-self-check-1')));
    expect(chip.selected, isTrue);
    expect(latest.selfCheckIndexes, contains(0));
    expect(latest.playedAudioPaths, contains(
      'assets/training/universal_core_cycle_01/phrase_4beat_u_mid.wav',
    ));
  });
}
