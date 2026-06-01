/// Task 2 — 영속화 통합: 재시작 복원 + 변이 저장.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

void main() {
  testWidgets('S3a launch restores saved streak from store', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();
    // 사전 저장: 며칠 진행한 상태
    final seeded = Progression.beginner();
    seeded.completeLesson(); // streak 1
    seeded.advanceDay();
    seeded.completeLesson(); // streak 2
    await store.save(seeded);

    await tester.pumpWidget(DebugApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 홈 스트릭이 복원된 2
    expect(find.text('🔥 2일'), findsOneWidget);
  });

  testWidgets('S3b completing a lesson persists to store', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();

    await tester.pumpWidget(DebugApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();

    final reloaded = await store.load();
    expect(reloaded, isNotNull);
    expect(reloaded!.didToday, isTrue);
    expect(reloaded.streak, 1);
  });
}
