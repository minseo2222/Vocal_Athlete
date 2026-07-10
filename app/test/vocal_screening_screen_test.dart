/// Stage 0 — A2 스크리닝 화면 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/vocal_screening_screen.dart';
import 'package:vocal_athlete/safety/vocal_screening.dart';

void _tall(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 8000);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('S0 전부 아니오 → 점검 통과(상담 권고 아님)', (tester) async {
    _tall(tester);
    ScreeningResult? submitted;
    await tester.pumpWidget(MaterialApp(
      home: VocalScreeningScreen(
        todayEpochDay: 100,
        onBack: () {},
        onSubmit: (r) => submitted = r,
      ),
    ));
    await tester.tap(find.byKey(const Key('screen-submit')));
    await tester.pump();
    expect(submitted!.outcome, ScreeningOutcome.pass);
    expect(find.byKey(const Key('screen-result')), findsOneWidget);
    expect(find.textContaining('특이 적신호'), findsOneWidget);
  });

  testWidgets('S0 hardBlock 항목 켜고 점검 → 상담 권고', (tester) async {
    _tall(tester);
    ScreeningResult? submitted;
    await tester.pumpWidget(MaterialApp(
      home: VocalScreeningScreen(
        todayEpochDay: 100,
        onBack: () {},
        onSubmit: (r) => submitted = r,
      ),
    ));
    await tester.tap(find.byKey(const Key('screen-item-neck_mass')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('screen-submit')));
    await tester.pump();
    expect(submitted!.outcome, ScreeningOutcome.hardBlock);
    expect(submitted!.referralAdvised, isTrue);
    expect(find.textContaining('이비인후과(후두) 진료'), findsOneWidget);
  });
}
