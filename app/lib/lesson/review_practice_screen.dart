/// v14 — 카드별 cue가 연결된 지연 재현/조건 전이 복습 화면.
///
/// 이 화면은 시험 점수를 만들지 않는다. 오늘 목 상태를 먼저 확인하고, 적은
/// 횟수로 다시 시도한 흔적과 자기점검을 기록한다. 쉰 느낌이면 소리 과제를
/// 강행하지 않고 무성 복습을 기록한 뒤 다음 날로 미룬다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assessment/learning_evidence.dart';
import '../assessment/review_evidence.dart';
import '../assessment/review_instruction.dart';
import '../assessment/review_queue.dart';
import '../curriculum/lesson_blueprint.dart';
import '../recording/audio_io.dart';
import '../recording/audio_session_coordinator.dart';
import '../recording/recording_ab.dart';
import '../theme/app_theme.dart';
import 'recording_ab_panel.dart';
import 'voice_state.dart';

class ReviewPracticeScreen extends StatefulWidget {
  const ReviewPracticeScreen({
    required this.item,
    required this.reviewQueueRepository,
    required this.learningEvidenceRepository,
    required this.reviewEvidenceRepository,
    required this.todayEpochDay,
    required this.onBack,
    required this.onFinished,
    this.blueprintRepository = const LessonBlueprintAssetRepository(),
    this.recordingRepository,
    this.captureAdapter,
    this.playbackAdapter,
    this.pathResolver,
    this.audioSessionCoordinator,
    super.key = const Key('review-practice-screen'),
  });

  final ReviewQueueItem item;
  final ReviewQueueRepository reviewQueueRepository;
  final LearningEvidenceRepository learningEvidenceRepository;
  final ReviewEvidenceRepository reviewEvidenceRepository;
  final LessonBlueprintAssetRepository blueprintRepository;
  final int todayEpochDay;
  final VoidCallback onBack;
  final VoidCallback onFinished;
  final RecordingRepository? recordingRepository;
  final AudioCaptureAdapter? captureAdapter;
  final AudioPlaybackAdapter? playbackAdapter;
  final RecordingFilePathResolver? pathResolver;
  final AudioSessionCoordinator? audioSessionCoordinator;

  @override
  State<ReviewPracticeScreen> createState() => _ReviewPracticeScreenState();
}

class _ReviewContext {
  const _ReviewContext({
    this.sourceEvidence,
    this.currentEntry,
    this.sourceTakes = const <RecordingTake>[],
  });

  final LearningEvidenceRecord? sourceEvidence;
  final LessonBlueprintEntry? currentEntry;
  final List<RecordingTake> sourceTakes;
}

class _ReviewPracticeScreenState extends State<ReviewPracticeScreen> {
  late Future<_ReviewContext> _contextFuture;
  VoiceState? _voiceState;
  int _attempts = 0;
  final Set<int> _selfChecks = <int>{};
  final Set<String> _recordedTakeIds = <String>{};
  final Set<String> _playedSourceTakeIds = <String>{};
  String? _bestTakeId;
  String? _selectedKey;
  bool _saving = false;

  bool get _recovery => _voiceState == VoiceState.hoarse;
  bool get _reduced => _voiceState == VoiceState.tired;
  int get _attemptCap => _reduced ? 1 : 2;
  bool get _hasTrace =>
      _attempts > 0 ||
      _selfChecks.isNotEmpty ||
      _recordedTakeIds.isNotEmpty ||
      _playedSourceTakeIds.isNotEmpty;

  /// 쉰 느낌에서는 이전의 유성 시도/녹음을 완료 근거로 재사용하지 않는다.
  /// 듣기 또는 소리 없는 자기점검을 명시적으로 남겨야 한다.
  bool get _canFinish => _voiceState != null &&
      (_recovery
          ? (_selfChecks.isNotEmpty || _playedSourceTakeIds.isNotEmpty)
          : _hasTrace);

  @override
  void initState() {
    super.initState();
    _contextFuture = _loadContext();
  }

  Future<_ReviewContext> _loadContext() async {
    final source = await widget.learningEvidenceRepository
        .findById(widget.item.sourceEvidenceId);
    LessonBlueprintEntry? current;
    try {
      current = await widget.blueprintRepository.loadLessonEntry(
        track: widget.item.track,
        cycle: widget.item.cycle,
        day: widget.item.day,
      );
    } catch (_) {
      current = null;
    }
    final allTakes = await widget.recordingRepository?.listTakes() ??
        const <RecordingTake>[];
    final sourceTakeIds = source?.snapshot.recordedTakeIds.toSet() ??
        const <String>{};
    final sourceTakes = allTakes
        .where((take) => sourceTakeIds.contains(take.id))
        .toList(growable: false);
    if (mounted && _selectedKey == null) {
      _selectedKey = source?.snapshot.selectedKey ??
          (widget.item.track == 'repertoireApplication' ? 'mid' : null);
    }
    return _ReviewContext(
      sourceEvidence: source,
      currentEntry: current,
      sourceTakes: sourceTakes,
    );
  }

  List<String> _selfCheckLabels() {
    if (_recovery) {
      return const <String>[
        '이전 take 또는 가이드를 낮은 볼륨으로 들었다',
        '리듬·가사·호흡 위치 중 하나를 소리 없이 확인했다',
        '오늘은 발성을 멈추고 내일 다시 하기로 했다',
      ];
    }
    return switch (widget.item.kind) {
      ReviewTaskKind.retention => const <String>[
          '처음에는 가이드 없이 기억에서 시작했다',
          '이전보다 적은 도움으로 핵심 cue를 떠올렸다',
          '목과 턱이 편안한 범위에서 멈췄다',
        ],
      ReviewTaskKind.transfer => const <String>[
          '키·시작음·tempo 중 한 가지 조건만 바꿨다',
          '조건이 바뀌어도 핵심 cue를 유지했다',
          '목과 턱이 편안한 범위에서 멈췄다',
        ],
    };
  }

  String _kindTitle() => switch (widget.item.kind) {
        ReviewTaskKind.retention => '지연 재현 복습',
        ReviewTaskKind.transfer => '조건 전이 복습',
      };

  String _trackLabel() => switch (widget.item.track) {
        'beginnerFoundation' => '초급 기초',
      'universalCore' => '중급 공통 보컬 코어',
        'repertoireApplication' => '곡 적용 훈련',
        _ => widget.item.track,
      };

  Future<void> _prepareCapture() async {
    await widget.playbackAdapter?.stop();
    widget.audioSessionCoordinator?.signal(
      AudioSessionAction.trainingStopped,
      AudioSessionStopReason.recordingStarted,
    );
  }

  Future<void> _preparePlayback() async {
    await widget.captureAdapter?.cancel();
    widget.audioSessionCoordinator?.signal(
      AudioSessionAction.captureCancelled,
      AudioSessionStopReason.recordingPlaybackStarted,
    );
  }

  Future<void> _playSourceTake(RecordingTake take) async {
    if (!take.hasPlayableLocalFile || widget.playbackAdapter == null) return;
    await _preparePlayback();
    await widget.playbackAdapter!.play(take.localPath);
    if (!mounted) return;
    setState(() => _playedSourceTakeIds.add(take.id));
  }

  void _onTakeSaved(RecordingTake take) {
    setState(() => _recordedTakeIds.add(take.id));
  }

  void _onBestTakeSelected(String id) {
    setState(() => _bestTakeId = id);
  }

  Future<void> _finish(_ReviewContext context) async {
    if (_saving || !_canFinish) return;
    setState(() => _saving = true);
    await widget.captureAdapter?.cancel();
    await widget.playbackAdapter?.stop();
    final now = DateTime.now().millisecondsSinceEpoch;
    final currentRevision =
        context.currentEntry?.contentRevision ?? 'unknown';
    final record = ReviewEvidenceRecord(
      id: nextReviewEvidenceId(
        reviewTaskId: widget.item.id,
        completedEpochMs: now,
      ),
      reviewTaskId: widget.item.id,
      sourceEvidenceId: widget.item.sourceEvidenceId,
      track: widget.item.track,
      cycle: widget.item.cycle,
      day: widget.item.day,
      cardId: widget.item.cardId,
      kind: widget.item.kind,
      targetEvidence: widget.item.targetEvidence,
      completedEpochMs: now,
      voiceState: _voiceState!.name,
      adaptationMode: _recovery
          ? 'recovery'
          : (_reduced ? 'reduced' : 'normal'),
      sourceContentRevision: widget.item.contentRevision,
      currentContentRevision: currentRevision,
      snapshot: ReviewPracticeSnapshot(
        attemptsUsed: _attempts,
        selfCheckIndexes: _selfChecks.toList(growable: false)..sort(),
        selectedKey: _selectedKey,
        recordedTakeIds: _recordedTakeIds.toList(growable: false),
        playedSourceTakeIds:
            _playedSourceTakeIds.toList(growable: false),
        bestTakeId: _bestTakeId,
      ),
    );
    await widget.reviewEvidenceRepository.saveRecord(record);
    if (_recovery) {
      await widget.reviewQueueRepository.postponeItem(
        widget.item.id,
        dueEpochDay: widget.todayEpochDay + 1,
        note: 'voice_state_recovery_no_voiced_review',
      );
    } else {
      await widget.reviewQueueRepository.completeItem(
        widget.item.id,
        completedEpochMs: now,
      );
    }
    if (!mounted) return;
    setState(() => _saving = false);
    widget.onFinished();
  }


  @override
  void dispose() {
    // ignore: discarded_futures
    widget.captureAdapter?.cancel();
    // ignore: discarded_futures
    widget.playbackAdapter?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<_ReviewContext>(
        future: _contextFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              backgroundColor: Sun.bg,
              body: SkeletonList(),
            );
          }
          final reviewContext =
              snapshot.data ?? const _ReviewContext();
          final currentRevision =
              reviewContext.currentEntry?.contentRevision ?? 'unknown';
          final revisionMatched = currentRevision != 'unknown' &&
              widget.item.contentRevision == currentRevision;
          final source = reviewContext.sourceEvidence;
          final plan = const ReviewInstructionResolver().resolve(
            item: widget.item,
            currentEntry: reviewContext.currentEntry,
            sourceEvidence: source,
          );
          final checks = _selfCheckLabels();
          return Scaffold(
            backgroundColor: Sun.bg,
            appBar: AppBar(
              backgroundColor: Sun.bg,
              foregroundColor: Sun.ink,
              elevation: 0,
              leading: IconButton(
                key: const Key('review-practice-back'),
                tooltip: '뒤로',
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBack,
              ),
              title: Text(_kindTitle(), style: const TextStyle(fontSize: 18)),
            ),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              children: [
                Text(
                  '${_trackLabel()} · Cycle ${widget.item.cycle} Day ${widget.item.day}',
                  style: const TextStyle(
                    color: Sun.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    fontFeatures: Sun.tnum,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.item.cardId,
                  style: const TextStyle(color: Sun.inkLow, fontSize: 11),
                ),
                const SizedBox(height: 12),
                _InfoBox(
                  key: const Key('review-instruction'),
                  text: plan.displayText,
                ),
                if (!revisionMatched) ...[
                  const SizedBox(height: 8),
                  const _InfoBox(
                    key: Key('review-revision-warning'),
                    text:
                        '처음 배웠을 때와 내용이 달라졌거나 확인되지 않았어요. 전후를 직접 비교하는 점수는 만들지 않고, 가볍게 다시 떠올린 기록으로만 남겨요.',
                    warning: true,
                  ),
                ],
                if (source != null) ...[
                  const SizedBox(height: 8),
                  _InfoBox(
                    key: const Key('review-source-summary'),
                    text:
                        '원래 기록 · 시도 ${source.snapshot.attemptsUsed}회 · 자기점검 ${source.snapshot.selfCheckIndexes.length}개 · 녹음 ${source.snapshot.recordedTakeIds.length}개',
                  ),
                  if (reviewContext.sourceTakes.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text(
                      '이전 take',
                      style: TextStyle(
                          color: Sun.inkMid, fontSize: 12, letterSpacing: 2.0),
                    ),
                    const SizedBox(height: 4),
                    for (final take in reviewContext.sourceTakes.take(2))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: OutlinedButton.icon(
                          key: Key('review-source-play-${take.id}'),
                          onPressed: (_attempts > 0 || _recovery) &&
                                  take.hasPlayableLocalFile &&
                                  widget.playbackAdapter != null
                              ? () {
                                  HapticFeedback.lightImpact();
                                  _playSourceTake(take);
                                }
                              : null,
                          icon: const Icon(Icons.play_arrow, size: 17),
                          label: Text(
                            _attempts > 0 || _recovery
                                ? '이전 take 듣기 · ${take.durationLabel}'
                                : '먼저 가이드 없이 1회 시도하세요',
                          ),
                        ),
                      ),
                  ],
                ],
                const SizedBox(height: 16),
                const Text(
                  '오늘 목 상태',
                  style: TextStyle(
                      color: Sun.inkMid, fontSize: 12, letterSpacing: 2.0),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _voiceChip(VoiceState.ok, '괜찮음'),
                    _voiceChip(VoiceState.tired, '조금 피곤함'),
                    _voiceChip(VoiceState.hoarse, '쉰 느낌'),
                  ],
                ),
                if (_voiceState != null) ...[
                  const SizedBox(height: 12),
                  if (_recovery)
                    const _InfoBox(
                      key: Key('review-recovery-notice'),
                      text:
                          '오늘은 소리를 내지 않습니다. 이전 take 듣기, 리듬 탭, 가사·호흡 위치 확인 중 하나를 하고 기록하면 복습은 내일 다시 제안됩니다.',
                      warning: true,
                    )
                  else ...[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '시도 $_attempts / $_attemptCap',
                            key: const Key('review-attempt-count'),
                            style: const TextStyle(
                              color: Sun.inkMid,
                              fontSize: 12,
                              fontFeatures: Sun.tnum,
                            ),
                          ),
                        ),
                        FilledButton.tonal(
                          key: const Key('review-attempt-add'),
                          onPressed: _attempts >= _attemptCap
                              ? null
                              : () {
                                  HapticFeedback.lightImpact();
                                  setState(() => _attempts += 1);
                                },
                          child: const Text('시도 기록'),
                        ),
                      ],
                    ),
                    if (widget.item.track == 'repertoireApplication') ...[
                      const SizedBox(height: 8),
                      const Text('편안한 키',
                          style: TextStyle(
                              color: Sun.inkMid,
                              fontSize: 11,
                              letterSpacing: 2.0)),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        children: [
                          _keyChip('low', '낮은 키'),
                          _keyChip('mid', '중간 키'),
                        ],
                      ),
                    ],
                    const SizedBox(height: 10),
                    RecordingAbPanel(
                      cardId: 'review-${widget.item.id}',
                      maxTakes: 2,
                      purpose: widget.item.track == 'repertoireApplication'
                          ? RecordingPurpose.repertoirePhrase
                          : RecordingPurpose.toneAB,
                      repository: widget.recordingRepository,
                      captureAdapter: widget.captureAdapter,
                      playbackAdapter: widget.playbackAdapter,
                      pathResolver: widget.pathResolver,
                      onBeforeCapture: _prepareCapture,
                      onBeforePlayback: _preparePlayback,
                      onTakeSaved: _onTakeSaved,
                      onBestTakeSelected: _onBestTakeSelected,
                      audioSessionCoordinator: widget.audioSessionCoordinator,
                    ),
                  ],
                  const SizedBox(height: 14),
                  const Text(
                    '자기점검',
                    style: TextStyle(
                        color: Sun.inkMid, fontSize: 12, letterSpacing: 2.0),
                  ),
                  for (var i = 0; i < checks.length; i++)
                    Material(
                      type: MaterialType.transparency,
                      child: CheckboxListTile(
                        key: Key('review-self-check-${i + 1}'),
                        value: _selfChecks.contains(i),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (selected) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (selected ?? false) {
                              _selfChecks.add(i);
                            } else {
                              _selfChecks.remove(i);
                            }
                          });
                        },
                        title: Text(
                          checks[i],
                          style: const TextStyle(
                            color: Sun.inkMid,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: SunsetCta(
                      buttonKey: const Key('review-finish'),
                      label: _saving
                          ? '기록 저장 중'
                          : (_recovery ? '무성 복습 기록 후 내일 다시 보기' : '복습 기록 완료'),
                      disabled: _saving || !_canFinish,
                      onPressed: () => _finish(reviewContext),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '이 기록은 자동 실력 점수나 정규 진도 해금에 사용되지 않습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Sun.inkLow, fontSize: 10),
                  ),
                ],
              ],
            ),
          );
        },
      );

  Widget _voiceChip(VoiceState state, String label) => ChoiceChip(
        key: Key('review-voice-${state.name}'),
        selected: _voiceState == state,
        onSelected: (_) {
          HapticFeedback.selectionClick();
          setState(() {
            _voiceState = state;
            _attempts = 0;
            _selfChecks.clear();
            if (state == VoiceState.hoarse) {
              _recordedTakeIds.clear();
              _bestTakeId = null;
            }
          });
        },
        label: Text(label),
        labelStyle: TextStyle(
          color: _voiceState == state ? Sun.ink : Sun.inkMid,
          fontSize: 11,
        ),
        selectedColor: Sun.surfaceSoft,
        backgroundColor: Sun.surface,
      );

  Widget _keyChip(String value, String label) => ChoiceChip(
        key: Key('review-key-$value'),
        selected: _selectedKey == value,
        onSelected: (_) {
          HapticFeedback.selectionClick();
          setState(() => _selectedKey = value);
        },
        label: Text(label),
        labelStyle: TextStyle(
          color: _selectedKey == value ? Sun.ink : Sun.inkMid,
          fontSize: 11,
        ),
        selectedColor: Sun.surfaceSoft,
        backgroundColor: Sun.surface,
      );
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    required this.text,
    this.warning = false,
    super.key,
  });

  final String text;
  final bool warning;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Sun.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: warning ? Sun.coral : Sun.hairline),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: warning ? Sun.coral : Sun.inkMid,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      );
}
