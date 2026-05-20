/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/graduation_screen.dart';
import 'lesson/lesson_screen.dart';
import 'lesson/pitch/pitch_source.dart';
import 'progression/progression_state.dart';
import 'safety/launch_warning.dart';

void main() => runApp(DebugApp(pitchSource: StubPitchSource()));

class DebugApp extends StatelessWidget {
  const DebugApp({super.key, this.initialProgression, this.pitchSource});

  /// 테스트 seam — 주입 시 사용, 없으면 기본 `Progression.beginner()`.
  final Progression? initialProgression;

  /// U4 — pitch source. 기본 null(테스트). 프로덕션 main()이 StubPitchSource 주입.
  final PitchSource? pitchSource;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(initial: initialProgression, pitchSource: pitchSource),
      );
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell({this.initial, this.pitchSource});
  final Progression? initial;
  final PitchSource? pitchSource;
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

  void _onPickGenre(Genre g) => setState(() => _p.chooseGenre(g));

  @override
  Widget build(BuildContext context) {
    if (!_ack) {
      return LaunchWarning(onConfirm: () => setState(() => _ack = true));
    }
    if (_p.graduated && _p.genre == null) {
      return GraduationScreen(onPick: _onPickGenre);
    }
    return LessonScreen(
      progression: _p,
      pitchSource: widget.pitchSource,
      onComplete: _onComplete,
      onAdvanceDay: () => setState(_p.advanceDay), // dev 임시(ADR-0016)
    );
  }
}
