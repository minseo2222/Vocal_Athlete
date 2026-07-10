/// F2 — 음역 확장 기록 화면 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/range_boundary_check_screen.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';

void main() {
  testWidgets('F2 3중 검증 모두 통과 기록 → onRecord allPassed', (tester) async {
    BoundaryVerification? recorded;
    await tester.pumpWidget(MaterialApp(
      home: RangeBoundaryCheckScreen(
        tracker: const RangeBoundaryTracker(),
        onBack: () {},
        onRecord: (v) => recorded = v,
      ),
    ));
    // 기본 스위치는 모두 ON(통과) → 바로 기록.
    await tester.tap(find.byKey(const Key('rb-record')));
    await tester.pump();
    expect(recorded, isNotNull);
    expect(recorded!.allPassed, isTrue);
    expect(recorded!.painArea, isNull);
  });

  testWidgets('F2 회복 스위치 OFF → 통증 부위 칩 노출 + painArea 기록', (tester) async {
    BoundaryVerification? recorded;
    await tester.pumpWidget(MaterialApp(
      home: RangeBoundaryCheckScreen(
        tracker: const RangeBoundaryTracker(),
        onBack: () {},
        onRecord: (v) => recorded = v,
      ),
    ));
    await tester.tap(find.byKey(const Key('rb-recovered')));
    await tester.pump();
    expect(find.byKey(const Key('rb-area-목')), findsOneWidget);
    await tester.tap(find.byKey(const Key('rb-area-턱')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('rb-record')));
    await tester.pump();
    expect(recorded!.allPassed, isFalse);
    expect(recorded!.painArea, '턱');
  });

  testWidgets('F2 중단 상태 → 기록 버튼 비활성 + 경감 안내', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RangeBoundaryCheckScreen(
        tracker: const RangeBoundaryTracker(
          status: BoundaryStatus.stopped,
          painArea: '목',
          painCount: 2,
        ),
        onBack: () {},
        onRecord: (_) {},
      ),
    ));
    final button = tester.widget<FilledButton>(find.byKey(const Key('rb-record')));
    expect(button.onPressed, isNull);
    expect(find.textContaining('경감'), findsOneWidget);
  });
}
