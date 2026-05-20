/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/lesson_screen.dart';
import 'progression/progression_state.dart';
import 'safety/launch_warning.dart';

void main() => runApp(const DebugApp());

class DebugApp extends StatelessWidget {
  const DebugApp({super.key, this.initialProgression});

  /// 테스트 seam — 주입 시 사용, 없으면 기본 `Progression.beginner()`.
  final Progression? initialProgression;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(initial: initialProgression),
      );
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell({this.initial});
  final Progression? initial;
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  bool _ack = false;
  late final Progression _p = widget.initial ?? Progression.beginner();

  void _onComplete() {
    final outcome = _p.completeLesson();
    setState(() {});
    final msg = kOutcomeMessage[outcome] ?? '';
    if (msg.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: const Key('outcome-snack'),
        content: Text(msg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _ack
      ? LessonScreen(
          progression: _p,
          onComplete: _onComplete,
          onAdvanceDay: () => setState(_p.advanceDay), // dev 임시(ADR-0016)
        )
      : LaunchWarning(onConfirm: () => setState(() => _ack = true));
}
