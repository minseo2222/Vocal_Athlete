/// F2 — 음성 컨디션 자가점검 화면 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/vocal_fatigue_check_screen.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';

void main() {
  testWidgets('F2 우려 값으로 저장 → 경감 권고 안내 + onSubmit 호출', (tester) async {
    VocalFatigueSelfCheck? submitted;
    await tester.pumpWidget(MaterialApp(
      home: VocalFatigueCheckScreen(
        initial: const VocalFatigueSelfCheck(
          tiredness: 8, // ≥7 → escalation
          discomfort: 1,
          poorRecovery: 2,
        ),
        onBack: () {},
        onSubmit: (c) => submitted = c,
      ),
    ));
    expect(find.byKey(const Key('vfi-guidance')), findsNothing);
    await tester.tap(find.byKey(const Key('vfi-save')));
    await tester.pump();
    expect(submitted, isNotNull);
    expect(submitted!.needsEscalation, isTrue);
    expect(find.byKey(const Key('vfi-guidance')), findsOneWidget);
    expect(find.textContaining('회복'), findsWidgets);
  });

  testWidgets('a11y 뒤로 tooltip(스크린리더 라벨) + 주 CTA 라벨 노출', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(MaterialApp(
      home: VocalFatigueCheckScreen(onBack: () {}, onSubmit: (_) {}),
    ));
    await tester.pumpAndSettle();
    // 뒤로 아이콘 버튼의 스크린리더 라벨(tooltip).
    expect(find.byTooltip('뒤로'), findsOneWidget);
    // 주 CTA가 스크린리더에 '저장'으로 노출(FilledButton = button role).
    expect(find.bySemanticsLabel('저장'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('F2 양호 값으로 저장 → 양호 안내', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: VocalFatigueCheckScreen(
        initial: const VocalFatigueSelfCheck(
          tiredness: 2,
          discomfort: 1,
          poorRecovery: 0,
        ),
        onBack: () {},
        onSubmit: (_) {},
      ),
    ));
    await tester.tap(find.byKey(const Key('vfi-save')));
    await tester.pump();
    expect(find.byKey(const Key('vfi-guidance')), findsOneWidget);
    expect(find.textContaining('양호'), findsOneWidget);
  });
}
