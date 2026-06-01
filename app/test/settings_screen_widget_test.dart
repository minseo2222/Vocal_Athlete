/// Task 4 — 설정 화면 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/home_screen.dart';
import 'package:vocal_athlete/main.dart';

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
}
