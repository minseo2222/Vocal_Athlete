/// Task 1 — 홈 화면 위젯 테스트 (경고→홈→레슨 라우팅).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/main.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('H1 ack → home screen (not lesson) with today card + 오늘 시작',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
    // 오늘 카드 프리뷰 — CARD-01 anatomyMain "6점 정렬 관찰"
    expect(find.textContaining('6점 정렬 관찰'), findsOneWidget);
    expect(find.byKey(const Key('start-today')), findsOneWidget);
  });

  testWidgets('H2 tap 오늘 시작 → lesson screen', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('home-screen')), findsNothing);
  });

  testWidgets('H3 home shows streak + 5 progress blocks', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-streak')), findsOneWidget);
    expect(find.byKey(const Key('progress-blocks')), findsOneWidget);
    // 5블록 라벨
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });
}
