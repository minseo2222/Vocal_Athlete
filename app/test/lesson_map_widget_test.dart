import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) => MaterialApp(
        home: Scaffold(body: LessonMap(progression: p)),
      );

  testWidgets('LM1 맵 렌더 + 섹션 라벨(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('LM2 완료/오늘/미래 노드 수 = currentIndex 정합', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNWidgets(3));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('LM2b currentIndex 0 → 완료 0, 오늘 1', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 0);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNothing);
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('LM2c 마지막 슬롯 → 미래 0', (tester) async {
    final total = Progression.beginner().total;
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: total - 1);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-future')), findsNothing);
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('LM3 오늘 노드 등장 애니가 정착 후에도 존재(pumpAndSettle 안전)',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 2);
    await tester.pumpWidget(host(p));
    await tester.pumpAndSettle(); // 무한 반복이면 여기서 타임아웃
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });
}
