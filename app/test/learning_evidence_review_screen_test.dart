import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/lesson/learning_evidence_review_screen.dart';

void _tallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1200, 3600);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('v11 learning evidence screen shows practice metadata',
      (tester) async {
    final repository = InMemoryLearningEvidenceRepository();
    await repository.saveRecord(const LearningEvidenceRecord(
      id: 'record-1',
      track: 'repertoireApplication',
      cycle: 1,
      day: 12,
      cardId: 'RA-10',
      targetEvidence: LearningEvidenceLevel.e3,
      completedEpochMs: 2000,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: LessonPracticeSnapshot(
        attemptsUsed: 2,
        selfCheckIndexes: <int>[0],
        selectedKey: 'low',
        recordedTakeCount: 2,
      ),
    ));
    await tester.pumpWidget(MaterialApp(
      home: LearningEvidenceReviewScreen(
        repository: repository,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('learning-evidence-review-screen')),
        findsOneWidget);
    expect(find.textContaining('곡 적용 훈련'), findsOneWidget);
    expect(find.textContaining('시도 2회'), findsOneWidget);
    expect(find.textContaining('낮은 키'), findsOneWidget);
  });

  testWidgets('v11 learning evidence clear requires confirmation',
      (tester) async {
    _tallViewport(tester);
    final repository = InMemoryLearningEvidenceRepository();
    await repository.saveRecord(const LearningEvidenceRecord(
      id: 'record-clear',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      targetEvidence: LearningEvidenceLevel.e1,
      completedEpochMs: 1000,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: LessonPracticeSnapshot(attemptsUsed: 1),
    ));
    await tester.pumpWidget(MaterialApp(
      home: LearningEvidenceReviewScreen(
        repository: repository,
        onBack: () {},
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('learning-evidence-clear')));
    await tester.pumpAndSettle();
    expect(find.text('학습 기록을 삭제할까요?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('learning-evidence-clear-confirm')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('learning-evidence-empty')), findsOneWidget);
    expect(await repository.listRecords(), isEmpty);
  });
}
