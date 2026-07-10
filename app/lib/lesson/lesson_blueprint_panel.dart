/// v11 — asset 기반 날짜별 레슨 설계·시도·자기점검 기록 패널.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assessment/learning_evidence.dart';
import '../curriculum/lesson_blueprint.dart';
import '../recording/audio_io.dart';
import '../recording/audio_session_coordinator.dart';
import '../theme/app_theme.dart';

class LessonBlueprintPanel extends StatefulWidget {
  const LessonBlueprintPanel({
    required this.track,
    required this.cycle,
    required this.day,
    this.recoveryMode = false,
    this.repository = const LessonBlueprintAssetRepository(),
    this.blueprint,
    this.playbackAdapter,
    this.initialSnapshot = const LessonPracticeSnapshot(),
    this.onSnapshotChanged,
    this.onBeforeAudioPlay,
    this.audioSessionCoordinator,
    super.key,
  });

  final String track;
  final int cycle;
  final int day;
  final bool recoveryMode;
  final LessonBlueprintAssetRepository repository;
  final LessonBlueprint? blueprint;
  final TrainingAudioPlaybackAdapter? playbackAdapter;
  final LessonPracticeSnapshot initialSnapshot;
  final ValueChanged<LessonPracticeSnapshot>? onSnapshotChanged;
  final Future<void> Function()? onBeforeAudioPlay;
  final AudioSessionCoordinator? audioSessionCoordinator;

  @override
  State<LessonBlueprintPanel> createState() => _LessonBlueprintPanelState();
}

class _LessonBlueprintPanelState extends State<LessonBlueprintPanel> {
  late Future<LessonBlueprint?> _future;
  late LessonPracticeSnapshot _snapshot;
  String? _playingPath;
  String? _audioError;
  int _lastAudioSessionSequence = 0;

  @override
  void initState() {
    super.initState();
    _snapshot = widget.initialSnapshot;
    _future = _load();
    _attachAudioSession(widget.audioSessionCoordinator);
  }

  void _attachAudioSession(AudioSessionCoordinator? coordinator) {
    coordinator?.addListener(_onAudioSessionEvent);
    _lastAudioSessionSequence = coordinator?.event.sequence ?? 0;
  }

  void _detachAudioSession(AudioSessionCoordinator? coordinator) {
    coordinator?.removeListener(_onAudioSessionEvent);
  }

  void _onAudioSessionEvent() {
    final coordinator = widget.audioSessionCoordinator;
    if (coordinator == null ||
        coordinator.event.sequence <= _lastAudioSessionSequence) {
      return;
    }
    _lastAudioSessionSequence = coordinator.event.sequence;
    final action = coordinator.event.action;
    if (action == AudioSessionAction.trainingStopped ||
        action == AudioSessionAction.allStopped) {
      if (mounted && _playingPath != null) {
        setState(() => _playingPath = null);
      }
    }
  }

  @override
  void didUpdateWidget(covariant LessonBlueprintPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioSessionCoordinator != widget.audioSessionCoordinator) {
      _detachAudioSession(oldWidget.audioSessionCoordinator);
      _attachAudioSession(widget.audioSessionCoordinator);
    }
    if (oldWidget.track != widget.track ||
        oldWidget.cycle != widget.cycle ||
        oldWidget.day != widget.day ||
        oldWidget.blueprint != widget.blueprint) {
      _future = _load();
      _snapshot = widget.initialSnapshot;
      _playingPath = null;
      _audioError = null;
    } else if (!identical(oldWidget.initialSnapshot, widget.initialSnapshot)) {
      // 다른 패널(키 선택·녹음)이 추가한 메타데이터를 오래된 로컬 사본으로
      // 덮어쓰지 않도록 부모 snapshot을 다시 병합한다.
      _snapshot = widget.initialSnapshot;
    }
  }

  Future<LessonBlueprint?> _load() async => widget.blueprint ??
      widget.repository.loadLesson(
          track: widget.track, cycle: widget.cycle, day: widget.day);

  void _publish(LessonPracticeSnapshot next) {
    setState(() => _snapshot = next);
    widget.onSnapshotChanged?.call(next);
  }

  Future<void> _playCue(LessonAudioCue cue) async {
    final adapter = widget.playbackAdapter;
    if (adapter == null) return;
    try {
      await widget.onBeforeAudioPlay?.call();
      await adapter.playAsset(cue.path);
      if (!mounted) return;
      final paths = <String>{..._snapshot.playedAudioPaths, cue.path}.toList();
      _publish(_snapshot.copyWith(playedAudioPaths: paths));
      setState(() {
        _playingPath = cue.path;
        _audioError = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _audioError = '예시 음원을 재생하지 못했습니다.');
    }
  }

  Future<void> _stopCue() async {
    await widget.playbackAdapter?.stop();
    if (!mounted) return;
    setState(() => _playingPath = null);
  }

  void _recordAttempt(LessonBlueprint plan) {
    if (_snapshot.attemptsUsed >= plan.attempts) return;
    _publish(_snapshot.copyWith(attemptsUsed: _snapshot.attemptsUsed + 1));
  }

  void _toggleSelfCheck(int index, bool selected) {
    final values = <int>{..._snapshot.selfCheckIndexes};
    if (selected) {
      values.add(index);
    } else {
      values.remove(index);
    }
    final sorted = values.toList()..sort();
    _publish(_snapshot.copyWith(selfCheckIndexes: sorted));
  }

  @override
  void dispose() {
    // 공유 player의 현재 레슨 cue만 정지하고 adapter 자체는 AppShell이 소유한다.
    // ignore: discarded_futures
    _detachAudioSession(widget.audioSessionCoordinator);
    widget.playbackAdapter?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<LessonBlueprint?>(
        future: _future,
        builder: (context, snapshot) {
          final plan = snapshot.data;
          if (plan == null) return const SizedBox.shrink();
          return Container(
            key: const Key('lesson-blueprint-panel'),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Sun.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Sun.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.title,
                    style: const TextStyle(
                        color: Sun.ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  '주 목표 · ${plan.primarySkill}  |  보조 · ${plan.secondarySkill}',
                  key: const Key('lesson-blueprint-focus'),
                  style: const TextStyle(color: Sun.coral, fontSize: 11),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.recoveryMode
                      ? plan.recoveryAlternative
                      : plan.objective,
                  style: const TextStyle(
                      color: Sun.ink, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 8),
                if (!widget.recoveryMode)
                  ...plan.steps.asMap().entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('${entry.key + 1}. ${entry.value}',
                            key: Key('lesson-blueprint-step-${entry.key + 1}'),
                            style: const TextStyle(
                                color: Sun.inkMid,
                                fontSize: 12,
                                height: 1.35,
                                fontFeatures: Sun.tnum)),
                      )),
                if (!widget.recoveryMode && plan.audioCues.isNotEmpty) ...[
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      ...plan.audioCues.map((cue) => OutlinedButton.icon(
                            key: Key('lesson-audio-${cue.path.split('/').last}'),
                            onPressed: widget.playbackAdapter == null
                                ? null
                                : () {
                                    HapticFeedback.lightImpact();
                                    _playCue(cue);
                                  },
                            icon: Icon(
                              _playingPath == cue.path
                                  ? Icons.graphic_eq
                                  : Icons.play_arrow,
                              size: 15,
                            ),
                            label: Text(cue.label,
                                style: const TextStyle(fontSize: 10)),
                          )),
                      if (_playingPath != null)
                        TextButton.icon(
                          key: const Key('lesson-audio-stop'),
                          onPressed: _stopCue,
                          icon: const Icon(Icons.stop, size: 15),
                          label: const Text('정지',
                              style: TextStyle(fontSize: 10)),
                        ),
                    ],
                  ),
                  const Text('볼륨을 편한 수준으로 낮춰 사용 · 예시가 불편하면 듣기만 합니다.',
                      key: Key('lesson-audio-safety-notice'),
                      style: TextStyle(color: Sun.inkLow, fontSize: 9)),
                  if (widget.playbackAdapter == null)
                    const Text('예시 음원은 실제 앱 오디오 연결 후 활성화됩니다.',
                        key: Key('lesson-audio-unavailable'),
                        style: TextStyle(color: Sun.inkLow, fontSize: 9)),
                  if (_audioError != null)
                    Text(_audioError!,
                        style: const TextStyle(
                            color: Sun.coral, fontSize: 10)),
                ],
                if (!widget.recoveryMode) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '시도 ${_snapshot.attemptsUsed}/${plan.attempts} · 목표 증거 ${plan.evidence}',
                          key: const Key('lesson-attempt-count'),
                          style: const TextStyle(
                              color: Sun.inkLow,
                              fontSize: 11,
                              fontFeatures: Sun.tnum),
                        ),
                      ),
                      OutlinedButton.icon(
                        key: const Key('lesson-attempt-add'),
                        onPressed: _snapshot.attemptsUsed >= plan.attempts
                            ? null
                            : () {
                                HapticFeedback.lightImpact();
                                _recordAttempt(plan);
                              },
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text('시도 기록',
                            style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  const Text(
                    '시도 기록은 품질 점수가 아니며 진도 해금을 막지 않습니다.',
                    key: Key('attempt-not-score-notice'),
                    style: TextStyle(color: Sun.inkLow, fontSize: 9),
                  ),
                  const SizedBox(height: 6),
                  Text('시도 후 확인 · ${plan.feedbackPrompt}',
                      key: const Key('lesson-blueprint-feedback'),
                      style: const TextStyle(
                          color: Sun.mint, fontSize: 11, height: 1.35)),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: plan.selfCheck.asMap().entries.map((entry) {
                      final selected =
                          _snapshot.selfCheckIndexes.contains(entry.key);
                      return FilterChip(
                        key: Key('lesson-self-check-${entry.key + 1}'),
                        selected: selected,
                        onSelected: (value) {
                          HapticFeedback.selectionClick();
                          _toggleSelfCheck(entry.key, value);
                        },
                        label: Text(entry.value,
                            style: const TextStyle(fontSize: 10)),
                        selectedColor: Sun.mintSoft,
                        backgroundColor: Sun.surfaceSoft,
                      );
                    }).toList(growable: false),
                  ),
                ],
              ],
            ),
          );
        },
      );
}
