import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/today_hero.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  Widget host(Progression p, {VoidCallback? onStart}) => MaterialApp(
      home: Scaffold(body: TodayHero(progression: p, onStart: onStart ?? () {})));

  testWidgets('TH1 오늘 — 제목(anatomyMain)·시작 버튼 활성', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.textContaining('고정 과제 녹음'), findsOneWidget); // R2 Day 1 CARD-13 anatomyMain
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNotNull);
  });

  testWidgets('TH2 시작 탭 → onStart 호출', (tester) async {
    var tapped = false;
    await tester.pumpWidget(host(Progression.beginner(), onStart: () => tapped = true));
    await tester.tap(find.byKey(const Key('start-today')));
    expect(tapped, isTrue);
  });

  testWidgets('TH3 오늘 완료 — today-done 표시·시작 비활성', (tester) async {
    final p = Progression.beginner()..completeLesson();
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('today-done')), findsOneWidget);
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNull);
  });
}
