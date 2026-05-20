/// U7 — 졸업 화면(장르 픽커) 위젯 테스트.
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

Progression _graduatedNoGenre() {
  const slot = PathSlot(
    index: 0,
    cardId: 'CARD-01',
    block: 1,
    bodyVoicedRatio: 0.70,
    variationLevel: VariationLevel.blocked,
  );
  return Progression.from([slot], graduated: true);
}

void main() {
  testWidgets('G2 three genre buttons + tap musical → Progression.genre=musical',
      (tester) async {
    _phoneViewport(tester);
    final p = _graduatedNoGenre();
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('genre-musical')), findsOneWidget);
    expect(find.byKey(const Key('genre-classical')), findsOneWidget);
    expect(find.byKey(const Key('genre-gayo')), findsOneWidget);
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.musical);
  });

  testWidgets('G1 graduated + genre=null → graduation screen, no lesson screen',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(DebugApp(initialProgression: _graduatedNoGenre()));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('graduation-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
  });
}
