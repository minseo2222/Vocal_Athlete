/// U7 — 단계 전이 화면 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Progression _beginnerGraduated() => Progression.from(
      buildPlaceholderManifest(),
      currentIndex: pathLength - 1,
      graduated: true,
    );

Progression _repertoireApplicationGraduated() => Progression.from(
      buildRepertoireApplicationManifest(),
      currentIndex: repertoireApplicationLength - 1,
      graduated: true,
      stage: LearningStage.repertoireApplication,
    );

void main() {
  testWidgets('R4 beginner graduation shows Universal Core CTA, no genre buttons',
      (tester) async {
    _phoneViewport(tester);
    final p = _beginnerGraduated();
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('start-universal-core')), findsOneWidget);
    expect(find.byKey(const Key('genre-gayo')), findsNothing);
    await tester.tap(find.byKey(const Key('start-universal-core')));
    await tester.pumpAndSettle();
    expect(p.stage, LearningStage.universalCore);
  });

  testWidgets('R4 Repertoire Application graduation shows advanced genre picker',
      (tester) async {
    _phoneViewport(tester);
    final p = _repertoireApplicationGraduated();
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('genre-gayo')), findsOneWidget);
    expect(find.byKey(const Key('genre-rb-soul')), findsOneWidget);
    await tester.tap(find.byKey(const Key('genre-gayo')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.gayo);
    expect(p.maintenance, isTrue); // default advanced rollout config empty
  });

  testWidgets('R4 graduated transition screen appears, no lesson screen',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(DebugApp(initialProgression: _beginnerGraduated()));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('course-transition-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
  });
}
