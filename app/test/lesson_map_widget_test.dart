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
}
