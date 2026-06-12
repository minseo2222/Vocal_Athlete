/// Task 4 — 설정 화면 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/home_screen.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _toHome(WidgetTester tester) async {
  await tester.pumpWidget(const DebugApp());
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, '확인'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('SET1 home gear → settings, back → home', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-screen')), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    await tester.tap(find.byKey(const Key('settings-back')));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('SET2 settings shows mic permission + version', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.textContaining('마이크'), findsOneWidget);
    expect(find.textContaining('버전'), findsOneWidget);
  });

  testWidgets('GC1 graduated → settings 장르 변경 → re-pick changes genre',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 졸업 화면 → 뮤지컬 선택(미출시 → 유지 모드, genre=musical)
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.musical);
    // 홈 → 설정 → 장르 변경 → 가요 재선택
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-change-genre')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-gayo')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.gayo);
  });

  testWidgets('GC2 genre course in progress hides genre change entry',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    expect(p.genre, Genre.musical);
    expect(p.graduated, isFalse);
    expect(p.maintenance, isFalse);

    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('settings-screen')), findsOneWidget);
    expect(find.byKey(const Key('settings-change-genre')), findsNothing);
  });
}
