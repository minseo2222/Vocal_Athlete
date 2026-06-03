/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/graduation_screen.dart';
import 'lesson/home_screen.dart';
import 'lesson/lesson_screen.dart';
import 'lesson/settings_screen.dart';
import 'lesson/pitch/pitch_source.dart';
import 'lesson/pitch/recording_pitch_source.dart';
import 'progression/progression_state.dart';
import 'progression/progression_store.dart';
import 'safety/launch_warning.dart';

void main() => runApp(DebugApp(
    pitchSource: RecordingPitchSource(), store: ProgressionStore()));

class DebugApp extends StatelessWidget {
  const DebugApp({
    super.key,
    this.initialProgression,
    this.pitchSource,
    this.store,
    this.todayEpochDay,
    this.startInLesson = false,
  });

  /// 테스트 seam — 주입 시 사용, 없으면 기본 `Progression.beginner()`.
  final Progression? initialProgression;

  /// U4 — pitch source. 기본 null(테스트). 프로덕션 main()이 StubPitchSource 주입.
  final PitchSource? pitchSource;

  /// Task 2 — 영속화 store. 주입 시 시작 때 load·변이 때 save.
  /// null이면 인메모리(기존 테스트 동작 유지).
  final ProgressionStore? store;

  /// Task 3 — 오늘 날짜(epoch day) 주입 seam. null이면 DateTime.now()로 계산.
  final int? todayEpochDay;

  /// 테스트 seam — true면 홈을 건너뛰고 곧장 레슨(레슨 동작 테스트용).
  final bool startInLesson;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(
            initial: initialProgression,
            pitchSource: pitchSource,
            store: store,
            todayEpochDay: todayEpochDay,
            startInLesson: startInLesson),
      );
}

/// 로컬 자정 기준 epoch day(1970-01-01부터의 일수).
int currentEpochDay() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell(
      {this.initial,
      this.pitchSource,
      this.store,
      this.todayEpochDay,
      this.startInLesson = false});
  final Progression? initial;
  final PitchSource? pitchSource;
  final ProgressionStore? store;
  final int? todayEpochDay;
  final bool startInLesson;
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  bool _ack = false;
  late bool _started = widget.startInLesson; // 홈 "오늘 시작" 탭 시 레슨 진입
  bool _showSettings = false;
  bool _pitchReady = false;
  Progression? _p; // store load 전엔 null(로딩 표시)

  @override
  void initState() {
    super.initState();
    _initProgression();
  }

  Future<void> _initProgression() async {
    final store = widget.store;
    final loaded = store == null ? null : await store.load();
    if (!mounted) return;
    final p = loaded ?? widget.initial ?? Progression.beginner();
    // Task 3 — 실 날짜 동기화: 흐른 날만큼 캡 해제·gap 반영.
    p.syncToToday(widget.todayEpochDay ?? currentEpochDay());
    setState(() => _p = p);
    _persist();
  }

  /// 변이 후 영속화(store 있을 때만). fire-and-forget.
  void _persist() {
    final p = _p;
    if (widget.store == null || p == null) return;
    // ignore: discarded_futures
    widget.store!.save(p);
  }

  Future<void> _onAck() async {
    setState(() => _ack = true);
    final src = widget.pitchSource;
    if (src == null) return;
    final ok = await src.start();
    if (!mounted) return;
    setState(() => _pitchReady = ok);
  }

  void _onComplete() {
    final outcome = _p!.completeLesson();
    _persist();
    setState(() => _started = false); // 오늘 레슨 끝 → 홈(또는 졸업 화면) 복귀
    final msg = kOutcomeMessage[outcome] ?? '';
    if (msg.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: const Key('outcome-snack'),
        content: Text(msg),
      ),
    );
  }

  void _onPickGenre(Genre g) {
    setState(() => _p!.chooseGenre(g));
    _persist();
  }

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
    final p = _p;
    if (p == null) {
      // store load 대기 — 짧은 빈 화면.
      return const Scaffold(backgroundColor: Color(0xFF0E0F13));
    }
    if (!_ack) {
      return LaunchWarning(onConfirm: _onAck);
    }
    if (p.graduated && p.genre == null) {
      return GraduationScreen(onPick: _onPickGenre);
    }
    if (_showSettings) {
      return SettingsScreen(
        micGranted: _pitchReady,
        onBack: () => setState(() => _showSettings = false),
      );
    }
    if (!_started) {
      return HomeScreen(
        progression: p,
        onStart: () => setState(() => _started = true),
        onSettings: () => setState(() => _showSettings = true),
      );
    }
    return LessonScreen(
      progression: p,
      pitchSource: _pitchReady ? widget.pitchSource : null,
      onComplete: _onComplete,
    );
  }
}
