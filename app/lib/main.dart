/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/graduation_screen.dart';
import 'lesson/home_screen.dart';
import 'lesson/lesson_screen.dart';
import 'lesson/pitch/pitch_source.dart';
import 'progression/progression_state.dart';
import 'safety/launch_warning.dart';

void main() => runApp(DebugApp(pitchSource: StubPitchSource()));

class DebugApp extends StatelessWidget {
  const DebugApp({
    super.key,
    this.initialProgression,
    this.pitchSource,
    this.startInLesson = false,
  });

  /// 테스트 seam — 주입 시 사용, 없으면 기본 `Progression.beginner()`.
  final Progression? initialProgression;

  /// U4 — pitch source. 기본 null(테스트). 프로덕션 main()이 StubPitchSource 주입.
  final PitchSource? pitchSource;

  /// 테스트 seam — true면 홈을 건너뛰고 곧장 레슨(레슨 동작 테스트용).
  final bool startInLesson;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(
            initial: initialProgression,
            pitchSource: pitchSource,
            startInLesson: startInLesson),
      );
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell({this.initial, this.pitchSource, this.startInLesson = false});
  final Progression? initial;
  final PitchSource? pitchSource;
  final bool startInLesson;
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  bool _ack = false;
  late bool _started = widget.startInLesson; // 홈 "오늘 시작" 탭 시 레슨 진입
  bool _pitchReady = false;
  late final Progression _p = widget.initial ?? Progression.beginner();

  Future<void> _onAck() async {
    setState(() => _ack = true);
    final src = widget.pitchSource;
    if (src == null) return;
    final ok = await src.start();
    if (!mounted) return;
    setState(() => _pitchReady = ok);
  }

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
  void dispose() {
    final src = widget.pitchSource;
    if (src != null) {
      // unawaited — dispose는 sync. stop은 fire-and-forget.
      // ignore: discarded_futures
      src.stop();
      src.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ack) {
      return LaunchWarning(onConfirm: _onAck);
    }
    if (_p.graduated && _p.genre == null) {
      return GraduationScreen(onPick: _onPickGenre);
    }
    if (!_started) {
      return HomeScreen(
        progression: _p,
        onStart: () => setState(() => _started = true),
      );
    }
    return LessonScreen(
      progression: _p,
      pitchSource: _pitchReady ? widget.pitchSource : null,
      onComplete: _onComplete,
      onAdvanceDay: () => setState(_p.advanceDay), // dev 임시(ADR-0016)
    );
  }
}
