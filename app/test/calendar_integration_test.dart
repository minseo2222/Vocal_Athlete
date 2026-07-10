/// Task 3 — 실 캘린더 바인딩 통합: dev 버튼 제거 + 날짜로 캡 해제.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

import 'support/flow_app.dart';

void main() {
  testWidgets('C3a dev 다음날 button removed from lesson', (tester) async {
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('dev-advance-day')), findsNothing);
  });

  testWidgets('C3b new calendar day releases cap (can complete again)',
      (tester) async {
    final metadata = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    final store = ProgressionStore(metadataStore: metadata);
    // 어제(epoch 100) 완료한 상태 저장
    final seeded = Progression.beginner();
    seeded.syncToToday(100);
    seeded.completeLesson(); // streak 1, didToday true
    await store.save(seeded);

    // 오늘(epoch 101)로 실행 → 캡 해제되어 다시 완료 가능
    await tester.pumpWidget(
        flowApp(store: store, todayEpochDay: 101));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();

    final reloaded = await store.load();
    expect(reloaded!.streak, 2); // 어제1 + 오늘1
  });
}
