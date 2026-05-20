/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/lesson_screen.dart';
import 'progression/progression_state.dart';
import 'safety/launch_warning.dart';

void main() => runApp(const DebugApp());

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(),
      );
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell();
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  bool _ack = false;
  final Progression _p = Progression.beginner();
  @override
  Widget build(BuildContext context) => _ack
      ? LessonScreen(
          progression: _p,
          onComplete: () => setState(_p.completeLesson),
        )
      : LaunchWarning(onConfirm: () => setState(() => _ack = true));
}
