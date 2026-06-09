import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) =>
      MaterialApp(home: Scaffold(body: JourneyPreview(progression: p)));

  testWidgets('JP1 미리보기 + 블록 칩(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('JP2 오늘 중심 윈도우 — currentIndex 3: 완료 2·오늘 1·미래 2',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNWidgets(2));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
    expect(find.byKey(const Key('node-future')), findsNWidgets(2));
  });

  testWidgets('JP3 시작점 currentIndex 0: 완료 0·오늘 1', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 0);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNothing);
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('JP4 탭 불가(노드에 onTap/InkWell 없음)', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byType(InkWell), findsNothing);
    expect(find.byType(GestureDetector), findsNothing);
  });
}
