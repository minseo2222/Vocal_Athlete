/// v11 — 실제 앱 셸을 통과하는 첫 학습 기록 integration test scaffold.
///
/// fake audio adapters를 사용하므로 native 마이크 정확도 검증은 아니다. Flutter
/// integration_test runner와 실제 device/emulator에서 화면 전이·저장 흐름을 재현한다.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/recording/audio_io.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Universal Core Day 1 completion leaves a local practice trace',
      (tester) async {
    final evidence = InMemoryLearningEvidenceRepository();
    final progression = Progression.from(
      buildUniversalCoreManifest(),
      stage: LearningStage.universalCore,
    );

    await tester.pumpWidget(DebugApp(
      initialProgression: progression,
      startInLesson: true,
      evidenceRepository: evidence,
      trainingAudioPlaybackAdapter: FakeTrainingAudioPlaybackAdapter(),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('lesson-attempt-add')));
    await tester.tap(find.byKey(const Key('lesson-self-check-1')));
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();

    final records = await evidence.listRecords();
    expect(records, hasLength(1));
    expect(records.single.snapshot.attemptsUsed, 1);
    expect(records.single.snapshot.selfCheckIndexes, contains(0));
  });
}
