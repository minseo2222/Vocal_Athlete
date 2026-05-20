/// F2 — 앱 실행 경고 화면 위젯 테스트 (TDD).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700); // 420 x 900 logical @ DPR 3
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('F2.1 app launch shows warning with hard-stops + 18+ + disclaimer + confirm',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    expect(find.textContaining('통증'), findsOneWidget);
    expect(find.textContaining('어지럼'), findsOneWidget);
    expect(find.textContaining('호흡곤란'), findsOneWidget);
    expect(find.textContaining('각혈'), findsOneWidget);
    expect(find.textContaining('만 18세'), findsOneWidget);
    expect(find.textContaining('의료·진단 도구가 아닙니다'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '확인'), findsOneWidget);
  });

  testWidgets('F2.2 tap 확인 → home shown, warning gone', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, '확인'), findsNothing);
    expect(find.textContaining('P1/P2 디버그'), findsOneWidget);
  });

  testWidgets('F2.3 no medical/onboarding inputs on warning screen',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    expect(find.byType(TextField), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byType(Radio), findsNothing);
  });

  testWidgets('F2.4 after confirm, warning does not reappear in same run',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 추가 펌프 — 같은 run 내 상태 유지, 경고 재등장 없음
    await tester.pump(const Duration(seconds: 1));
    expect(find.widgetWithText(FilledButton, '확인'), findsNothing);
    expect(find.textContaining('P1/P2 디버그'), findsOneWidget);
  });
}
