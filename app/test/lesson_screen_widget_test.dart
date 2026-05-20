/// U1 — 레슨 화면 D 셸 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('U1.1 launch → confirm → LessonScreen shown',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
  });

  testWidgets('U1.2 header shows current slot cardId + idx/total',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget); // P1 manifest slot 0
    expect(find.textContaining('1/48'), findsOneWidget);
  });

  testWidgets('U1.3 tap 완료 → header advances to next slot',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget);
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-02'), findsOneWidget); // P1 slot 1
    expect(find.textContaining('2/48'), findsOneWidget);
  });

  testWidgets('U1.4 D structural elements present (stepper, cue, sheet)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-stepper')), findsOneWidget);
    expect(find.byKey(const Key('lesson-cue')), findsOneWidget);
    expect(find.byKey(const Key('lesson-sheet')), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('C2.2 cue area renders resolved card cue (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // CARD-01 cue 일부
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
    expect(find.textContaining('턱·어깨 힘 빼기'), findsOneWidget);
    // placeholder 사라짐
    expect(find.textContaining('운동 cue 자리'), findsNothing);
  });

  testWidgets('U2.2 sheet shows voicedMicroWin body (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // CARD-01 voicedMicroWin: "끝에 편한 /m/ 3회(각 2–3초)"
    expect(find.textContaining('/m/ 3회'), findsOneWidget);
  });

  testWidgets('U6.1 header shows streak (starts at 0)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    final streak = find.byKey(const Key('streak'));
    expect(streak, findsOneWidget);
    expect(find.descendant(of: streak, matching: find.text('🔥 0')),
        findsOneWidget);
  });

  testWidgets('U6.2 streak updates 0→1 after complete (P5 sync)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    final streak = find.byKey(const Key('streak'));
    expect(find.descendant(of: streak, matching: find.text('🔥 1')),
        findsOneWidget);
  });

  testWidgets('U3.1 initial step is entry — shows 워밍업 + 다음 button',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget);
  });

  testWidgets('U3.5 main 쿨다운 스킵 chip 탭 → 즉시 다음 카드(CARD-02, entry)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-02'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget); // entry 리셋
  });

  testWidgets('U3.4 cooldown 완료 → 다음 카드(CARD-02) + step=entry 리셋',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main→cooldown
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-02'), findsOneWidget);
    // step=entry로 리셋되어 next 버튼 다시 보임, 쿨다운 텍스트 없음
    expect(find.byKey(const Key('next-button')), findsOneWidget);
    expect(find.textContaining('쿨다운:'), findsNothing);
  });

  testWidgets('U3.3 tap 다음 at main → step=cooldown (쿨다운 텍스트 + 다음 버튼 사라짐)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry → main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main → cooldown
    await tester.pumpAndSettle();
    expect(find.textContaining('쿨다운:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsNothing);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('U3.2 tap 다음 at entry → step=main (워밍업 사라지고 cue 유지)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsNothing);
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
  });
}
