/// U1 — 레슨 화면 D 셸(채택안 D, 프로토 검증).
///
/// U3 — 단계 머신(진입/본운동/쿨다운) 도입. 시각 피치 = U4, "다시?" 넛지 = U5.
/// R4 — 목 상태에 따라 normal/light/recovery 모드로 cue·피치 표시를 조정한다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assessment/learning_evidence.dart';
import '../assessment/review_queue.dart';
import '../curriculum/lesson_blueprint.dart';
import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import '../safety/vocal_load_budget.dart';
import '../safety/vocal_recovery.dart';
import '../recording/audio_io.dart';
import '../recording/audio_session_coordinator.dart';
import '../recording/recording_ab.dart';
import 'glossary_screen.dart';
import 'lesson_instance.dart';
import 'lesson_blueprint_panel.dart';
import 'repertoire_practice_panel.dart';
import 'pitch/pitch_display.dart';
import 'pitch/pitch_source.dart';
import 'pitch/pitch_tolerance.dart';
import '../timbre/resonance_proxy.dart';
import 'recording_ab_panel.dart';
import 'voice_state.dart';

/// U3 — 레슨 단계 머신(진입→본운동→쿨다운).
enum LessonStep { entry, main, cooldown }

class LessonScreen extends StatefulWidget {
  const LessonScreen(
      {this.progression,
      this.onComplete,
      this.pitchSource,
      this.recordingRepository,
      this.recordingCaptureAdapter,
      this.recordingPlaybackAdapter,
      this.trainingAudioPlaybackAdapter,
      this.recordingPathResolver,
      this.evidenceRepository,
      this.reviewQueueRepository,
      this.audioSessionCoordinator,
      this.ledger = const VocalLoadLedger(),
      this.fatigueEscalation = false,
      this.screeningReferral = false,
      super.key = const Key('lesson-screen')});

  final Progression? progression;
  final VoidCallback? onComplete;
  /// 누적·영속화된 보컬 부하 ledger. 부모(_AppShell)가 일자 리셋·저장을 관리한다.
  final VocalLoadLedger ledger;
  /// 최근(오늘) VFI 자가점검이 escalation이면 true — 오늘 레슨 강도를 낮춘다.
  final bool fatigueEscalation;
  /// 최근 적신호 스크리닝이 상담 권고(hardBlock·유효)면 true — 비차단 의료 의뢰 배너.
  final bool screeningReferral;
  final PitchSource? pitchSource;
  final RecordingRepository? recordingRepository;
  final AudioCaptureAdapter? recordingCaptureAdapter;
  final AudioPlaybackAdapter? recordingPlaybackAdapter;
  final TrainingAudioPlaybackAdapter? trainingAudioPlaybackAdapter;
  final RecordingFilePathResolver? recordingPathResolver;
  final LearningEvidenceRepository? evidenceRepository;
  final ReviewQueueRepository? reviewQueueRepository;
  final AudioSessionCoordinator? audioSessionCoordinator;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

int _lessonEpochDay() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}

class _LessonScreenState extends State<LessonScreen> {
  LessonStep _step = LessonStep.entry;
  VoiceState? _voiceState;
  // _p가 변이형이라 widget.progression 참조 비교가 무용 — 카드ID 자체를 추적.
  String? _lastCardId;
  LessonPracticeSnapshot _practiceSnapshot = const LessonPracticeSnapshot();
  bool _savingEvidence = false;
  bool _celebrating = false;
  // 현재 카드 메인 단계의 voiced 공명 raw 샘플(쿨다운에서 세션 내 추세 산출).
  final List<ResonanceSample> _ringSamples = [];

  _StepState _stepStateFor(LessonStep s) {
    if (s.index < _step.index) return _StepState.done;
    if (s.index == _step.index) return _StepState.now;
    return _StepState.next;
  }

  /// 쿨다운에서 이번 카드 메인 단계의 세션 내 상대 공명 추세를 정성적으로만 안내.
  /// 절대값·점수 없음. 표본 부족하면 아무것도 표시하지 않는다(stub 소스 포함).
  Widget _resonanceTrendNotice(dynamic card) {
    final session = ResonanceSession(
      sessionId: (card?.id as String?) ?? 'card',
      deviceId: 'device',
      samples: _ringSamples,
    );
    final text = switch (sessionRingTrend(session)) {
      ResonanceTrend.improving =>
        '🔆 이번 연습에서 소리가 점점 또렷해지는 추세였어요. (상대·세션 내 참고용)',
      ResonanceTrend.declining =>
        '이번 연습 후반엔 소리가 다소 흐려지는 추세였어요. 피로 신호일 수 있으니 무리하지 마세요. (상대·세션 내 참고용)',
      ResonanceTrend.flat => '소리는 대체로 일정했어요. (상대·세션 내 참고용)',
      ResonanceTrend.insufficient => '',
    };
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        key: const Key('resonance-trend'),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text,
            style: const TextStyle(color: Sun.inkMid, fontSize: 12)),
      ),
    );
  }

  String _cueTextFor(dynamic card, LessonAdaptation adaptation) {
    if (_step == LessonStep.entry) return '워밍업: ${card.anatomyEntry}';
    if (_step == LessonStep.cooldown) {
      if (adaptation.recoveryMode) {
        return '쿨다운: 소리내지 않고 느린 호흡 3회. 목을 쉬게 합니다.';
      }
      return '쿨다운: ${card.anatomyCooldown}';
    }
    return adaptation.mainCue;
  }

  Future<void> _stopInteractiveMedia({
    bool cancelCapture = false,
    AudioSessionStopReason reason = AudioSessionStopReason.lessonStepChanged,
  }) async {
    await widget.trainingAudioPlaybackAdapter?.stop();
    await widget.recordingPlaybackAdapter?.stop();
    if (cancelCapture) await widget.recordingCaptureAdapter?.cancel();
    widget.audioSessionCoordinator?.signal(
      AudioSessionAction.allStopped,
      reason,
    );
  }

  Future<void> _prepareTrainingAudio() async {
    // 다른 guide/click, 저장 take 재생, 마이크 캡처를 모두 정리한 뒤
    // 새 훈련 음원을 시작한다. 패널 UI도 같은 event로 초기화된다.
    await widget.trainingAudioPlaybackAdapter?.stop();
    await widget.recordingPlaybackAdapter?.stop();
    await widget.recordingCaptureAdapter?.cancel();
    widget.audioSessionCoordinator?.signal(
      AudioSessionAction.allStopped,
      AudioSessionStopReason.trainingAudioStarted,
    );
  }

  Future<void> _prepareRecording() async {
    await widget.trainingAudioPlaybackAdapter?.stop();
    await widget.recordingPlaybackAdapter?.stop();
    widget.audioSessionCoordinator?.signal(
      AudioSessionAction.trainingStopped,
      AudioSessionStopReason.recordingStarted,
    );
  }

  void _updatePracticeSnapshot(LessonPracticeSnapshot snapshot) {
    if (!mounted) return;
    setState(() => _practiceSnapshot = snapshot);
  }

  List<ToneTag> _toneTagsFromNames(List<String> names) {
    final result = <ToneTag>[];
    for (final name in names) {
      final tag = toneTagFromName(name);
      if (tag != null && !result.contains(tag)) result.add(tag);
    }
    return result;
  }

  void _onTakeSaved(RecordingTake take) {
    final takeIds = <String>{..._practiceSnapshot.recordedTakeIds, take.id}
        .toList(growable: false);
    _updatePracticeSnapshot(_practiceSnapshot.copyWith(
      recordedTakeCount: takeIds.length,
      recordedTakeIds: takeIds,
    ));
  }

  void _onBestTakeSelected(String id) {
    _updatePracticeSnapshot(_practiceSnapshot.copyWith(
      bestTakeSelected: true,
      bestTakeId: id,
    ));
  }

  String _adaptationMode(LessonAdaptation? adaptation) {
    if (adaptation?.recoveryMode ?? false) return 'recovery';
    if (adaptation?.reducedMode ?? false) return 'reduced';
    return 'normal';
  }

  Future<void> _saveLearningEvidence({
    required String track,
    required int cycle,
    required int day,
    required String cardId,
    required LessonAdaptation? adaptation,
  }) async {
    final repository = widget.evidenceRepository;
    if (repository == null) return;
    LessonBlueprintEntry? entry;
    try {
      entry = await const LessonBlueprintAssetRepository().loadLessonEntry(
        track: track,
        cycle: cycle,
        day: day,
      );
    } catch (_) {
      entry = null;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final record = LearningEvidenceRecord(
      id: nextLearningEvidenceId(
        track: track,
        cycle: cycle,
        day: day,
        cardId: cardId,
        completedEpochMs: now,
      ),
      track: track,
      cycle: cycle,
      day: day,
      cardId: cardId,
      targetEvidence:
          evidenceLevelFromLabel(entry?.blueprint.evidence ?? 'e0'),
      completedEpochMs: now,
      voiceState: _voiceState?.name ?? 'unreported',
      adaptationMode: _adaptationMode(adaptation),
      snapshot: _practiceSnapshot,
      contentRevision: entry?.contentRevision ??
          '$track:$cycle:unknown:day_$day:$cardId',
    );
    await repository.saveRecord(record);
    final reviewQueue = widget.reviewQueueRepository;
    if (reviewQueue != null) {
      final dueItems = const ReviewQueueScheduler().itemsForEvidence(
        record: record,
        todayEpochDay: _lessonEpochDay(),
      );
      await reviewQueue.saveItems(dueItems);
    }
  }

  Future<void> _advanceLessonStep() async {
    if (_step == LessonStep.main) {
      await _stopInteractiveMedia(
        cancelCapture: true,
        reason: AudioSessionStopReason.lessonStepChanged,
      );
    }
    if (!mounted) return;
    setState(() {
      _step = _step == LessonStep.entry
          ? LessonStep.main
          : LessonStep.cooldown;
    });
  }

  Future<void> _completeCurrentLesson({
    required Progression? progression,
    required String? track,
    required int cycle,
    required int day,
    required String? cardId,
    required LessonAdaptation? adaptation,
  }) async {
    if (_savingEvidence) return;
    setState(() => _savingEvidence = true);
    await _stopInteractiveMedia(
      cancelCapture: true,
      reason: AudioSessionStopReason.lessonCompleted,
    );
    if (progression != null && track != null && cardId != null) {
      try {
        await _saveLearningEvidence(
          track: track,
          cycle: cycle,
          day: day,
          cardId: cardId,
          adaptation: adaptation,
        );
      } catch (_) {
        // 메타데이터 저장 실패가 일일 completion을 막지는 않는다.
      }
    }
    if (!mounted) return;
    setState(() {
      _savingEvidence = false;
      _celebrating = true;
    });
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    if (_celebrating) {
      return LessonCelebration(onDone: () => widget.onComplete?.call());
    }
    final p = widget.progression;
    final instance =
        p == null ? null : resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance?.card;
    // (c) 최근 고부하 후 회복 윈도우 — lastHighEpochDay 기준 다일 경과로 판정.
    //     완전 회복(≥72h) 전이면 '회복 중'으로 보고 오늘 강도를 낮추도록 권고.
    final lastHigh = widget.ledger.lastHighEpochDay;
    final withinRecoveryWindow = lastHigh != null &&
        recoveryStatusAfterHighLoadDays(_lessonEpochDay() - lastHigh) !=
            RecoveryStatus.recovered;
    // (a)+(c) 피로 자가점검 escalation 또는 회복 윈도우면 'ok/미보고' 날을 tired로
    //     격상해 적응·부하 평가에만 합류(절대 강등 ❌, 명시적 tired/hoarse는 그대로).
    //     표시·기록은 원본 _voiceState 유지.
    final shouldEase = widget.fatigueEscalation || withinRecoveryWindow;
    final effectiveVoiceState = (shouldEase &&
            (_voiceState == null || _voiceState == VoiceState.ok))
        ? VoiceState.tired
        : _voiceState;
    final adaptation = card == null
        ? null
        : adaptLessonForVoiceState(card, effectiveVoiceState);
    final loadDecision = card == null
        ? null
        : const VocalLoadPolicy().evaluate(
            card: card,
            ledger: widget.ledger,
            voiceState: effectiveVoiceState,
          );
    // (b) 세션 누적 발성 시간 상한 권고(초과 시 reduced).
    final sessionLoad = card == null
        ? null
        : const VocalLoadPolicy().evaluateSessionPhonation(ledger: widget.ledger);
    final blueprintTrack = switch (p?.stage) {
      LearningStage.beginnerFoundation => 'beginnerFoundation',
      LearningStage.universalCore => 'universalCore',
      LearningStage.repertoireApplication => 'repertoireApplication',
      _ => null,
    };
    final absoluteDay = p == null ? 0 : p.currentIndex + 1;
    final cycleDay = p == null ? 0 : (p.todaysLesson.index % 12) + 1;
    final cycleNumber = p == null ? 0 : (p.todaysLesson.index ~/ 12) + 1;
    final blueprintCycle = p?.stage == LearningStage.beginnerFoundation
        ? 1
        : cycleNumber;
    final blueprintDay = p?.stage == LearningStage.beginnerFoundation
        ? absoluteDay
        : cycleDay;
    final hasDetailedBlueprint = p?.stage == LearningStage.beginnerFoundation
        ? blueprintDay == 37 || blueprintDay == 38
        : instance?.slot.cycle == 1;
    final id = card?.id;
    final standardSampleSlot = id == 'CARD-13' &&
            p?.stage == LearningStage.beginnerFoundation
        ? standardSampleSlotForBeginnerIndex(p!.currentIndex)
        : null;
    if (id != null &&
        _lastCardId == null &&
        p?.stage == LearningStage.repertoireApplication &&
        _practiceSnapshot.selectedKey == null) {
      _practiceSnapshot =
          _practiceSnapshot.copyWith(selectedKey: 'mid');
    }
    if (id != null && _lastCardId != null && id != _lastCardId) {
      _step = LessonStep.entry;
      _voiceState = null;
      _ringSamples.clear(); // 새 카드 → 공명 추세 샘플 리셋
      _practiceSnapshot = LessonPracticeSnapshot(
        selectedKey: p?.stage == LearningStage.repertoireApplication
            ? 'mid'
            : null,
      );
    }
    _lastCardId = id;
    return Scaffold(
      backgroundColor: Sun.bg,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: Sun.bgWash),
        child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p == null
                        ? ''
                        : '${p.todaysLesson.cardId} · ${p.currentIndex + 1}/${p.total}',
                    style: const TextStyle(
                        color: Sun.inkLow,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        const _HelpButton(),
                        if (p != null)
                          _Pill(
                              key: const Key('streak'),
                              text: '🔥 ${p.streak}'),
                        if (p != null && p.maintenance)
                          const _Pill(
                              key: Key('maintenance-badge'), text: '유지 모드'),
                        if (instance != null && instance.hasVoicedMicroWin)
                          const _Pill(text: '● 유성'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Row(
                children: [
                  _Step(label: '진입·워밍업', state: _stepStateFor(LessonStep.entry)),
                  const SizedBox(width: 8),
                  _Step(label: '본운동 7–11분', state: _stepStateFor(LessonStep.main)),
                  const SizedBox(width: 8),
                  _Step(label: '쿨다운', state: _stepStateFor(LessonStep.cooldown)),
                ],
              ),
            ),
            Expanded(
              child: Center(
                key: const Key('lesson-cue'),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  child: KeyedSubtree(
                    key: ValueKey(_step),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: card == null || adaptation == null
                          ? const SizedBox.shrink()
                          : SingleChildScrollView(
                              child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _cueTextFor(card, adaptation),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _step == LessonStep.entry
                                        ? Sun.inkMid
                                        : Sun.ink,
                                    fontSize:
                                        _step == LessonStep.entry ? 20 : 25,
                                    fontWeight: FontWeight.w800,
                                    height: 1.45,
                                  ),
                                ),
                                if (_step != LessonStep.main) ...[
                                  const SizedBox(height: 14),
                                  Text(
                                    _step == LessonStep.entry
                                        ? '목과 호흡을 가볍게 깨우는 단계예요. 무리하지 말고 편하게 따라 해요.'
                                        : '오늘 쓴 목을 부드럽게 정리하는 단계예요.',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Sun.inkLow,
                                      fontSize: 13,
                                      height: 1.4,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              key: const Key('lesson-sheet'),
              decoration: BoxDecoration(
                color: Sun.surface,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.card)),
                boxShadow: Sun.softShadow(
                    color: Sun.coral, opacity: 0.12, blur: 28, dy: -6),
              ),
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.68,
              ),
              child: SingleChildScrollView(
                key: const Key('lesson-sheet-scroll'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Sun.line,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          switch (_step) {
                            LessonStep.entry => '진입 · 워밍업',
                            LessonStep.main => '본운동 · 7–11분',
                            LessonStep.cooldown => '쿨다운 · 마무리',
                          },
                          style: const TextStyle(
                              color: Sun.inkMid,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                      if (_step == LessonStep.main &&
                          adaptation != null &&
                          !adaptation.recoveryMode &&
                          !adaptation.reducedMode)
                        Semantics(
                          button: true,
                          child: InkWell(
                            key: const Key('skip-cooldown'),
                            onTap: _savingEvidence
                                ? null
                                : () => _completeCurrentLesson(
                                      progression: p,
                                      track: blueprintTrack,
                                      cycle: blueprintCycle,
                                      day: blueprintDay,
                                      cardId: card?.id,
                                      adaptation: adaptation,
                                    ),
                            borderRadius: BorderRadius.circular(AppRadii.pill),
                            child: const _Pill(text: '쿨다운 건너뛰고 완료'),
                          ),
                        ),
                    ],
                  ),
                  if (_step == LessonStep.entry) ...[
                    const SizedBox(height: 8),
                    _VoiceCheckPanel(
                      selected: _voiceState,
                      onSelected: (state) =>
                          setState(() => _voiceState = state),
                    ),
                  ],
                  if (adaptation?.notice != null) ...[
                    const SizedBox(height: 8),
                    _VoiceAdaptationNotice(adaptation: adaptation!),
                    if (_step == LessonStep.entry && adaptation.recoveryMode)
                      const SizedBox(
                        key: Key('recovery-mode-notice'),
                        height: 0,
                      ),
                  ],
                  if (loadDecision != null &&
                      loadDecision.mode != VocalLoadMode.normal) ...[
                    const SizedBox(height: 8),
                    _VocalLoadNotice(decision: loadDecision),
                  ],
                  if (sessionLoad != null &&
                      sessionLoad.mode != VocalLoadMode.normal) ...[
                    const SizedBox(height: 8),
                    _VocalLoadNotice(
                      key: const Key('session-phonation-notice'),
                      decision: sessionLoad,
                    ),
                  ],
                  if (widget.screeningReferral) ...[
                    const SizedBox(height: 8),
                    Container(
                      key: const Key('screening-referral-notice'),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Sun.surfaceSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Sun.hairline),
                      ),
                      child: const Text(
                        '⚠️ 최근 점검에 전문가 상담이 필요한 항목이 있었어요. 무리하지 말고, 가능하면 의사·이비인후과 상담을 권합니다.',
                        style: TextStyle(
                            color: Sun.danger,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  if (widget.fatigueEscalation) ...[
                    const SizedBox(height: 8),
                    Container(
                      key: const Key('fatigue-escalation-notice'),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Sun.mintSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Sun.hairline),
                      ),
                      child: const Text(
                        '🌿 최근 자가점검에서 피로 신호가 있어 오늘은 강도를 낮춰 진행해요.',
                        style: TextStyle(
                            color: Sun.mint,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  if (withinRecoveryWindow) ...[
                    const SizedBox(height: 8),
                    Container(
                      key: const Key('recovery-window-notice'),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Sun.mintSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Sun.hairline),
                      ),
                      child: const Text(
                        '🌿 최근 고강도 연습 후 회복 중이에요. 오늘은 강도를 낮추는 게 좋아요.',
                        style: TextStyle(
                            color: Sun.mint,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                  if (adaptation != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '● ${adaptation.microWin}',
                      key: const Key('voice-adapted-micro-win'),
                      style: const TextStyle(
                          color: Sun.mint,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                  if (_step == LessonStep.main &&
                      instance != null &&
                      instance.variation.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '오늘: ${instance.variationLabel}',
                        key: const Key('today-variation'),
                        style: const TextStyle(
                            color: Sun.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  if (_step == LessonStep.main &&
                      instance != null &&
                      blueprintTrack != null &&
                      hasDetailedBlueprint) ...[
                    const SizedBox(height: 10),
                    LessonBlueprintPanel(
                      track: blueprintTrack,
                      cycle: blueprintCycle,
                      day: blueprintDay,
                      recoveryMode: adaptation?.recoveryMode ?? false,
                      playbackAdapter: widget.trainingAudioPlaybackAdapter,
                      initialSnapshot: _practiceSnapshot,
                      onSnapshotChanged: _updatePracticeSnapshot,
                      onBeforeAudioPlay: _prepareTrainingAudio,
                      audioSessionCoordinator: widget.audioSessionCoordinator,
                    ),
                  ],
                  if (_step == LessonStep.main &&
                      p?.stage == LearningStage.repertoireApplication &&
                      instance != null &&
                      instance.slot.cycle == 1 &&
                      card != null &&
                      !(adaptation?.recoveryMode ?? false)) ...[
                    const SizedBox(height: 10),
                    RepertoirePracticePanel(
                      assetId: 'neutral_001',
                      guideState: guideStateForRepertoireCard(card.id),
                      playbackAdapter: widget.trainingAudioPlaybackAdapter,
                      initialKey: _practiceSnapshot.selectedKey,
                      onKeyChanged: (key) => _updatePracticeSnapshot(
                        _practiceSnapshot.copyWith(selectedKey: key),
                      ),
                      onBeforeAudioPlay: _prepareTrainingAudio,
                      audioSessionCoordinator: widget.audioSessionCoordinator,
                    ),
                  ],
                  const SizedBox(height: 12),
                  if (_step == LessonStep.main &&
                      adaptation != null &&
                      !adaptation.showPitch)
                    Container(
                      key: const Key('recovery-mode-notice'),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Sun.mintSoft,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '🌿 목 상태 우선 — 오늘은 피치 표시 없이 회복/듣기 루틴',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Sun.mint,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  else if (_step == LessonStep.main) ...[
                    if (widget.pitchSource == null)
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Sun.surfaceSoft,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '🎤\n마이크 꺼짐 — 피치 표시 안 됨',
                          key: Key('mic-off-notice'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Sun.inkLow, fontSize: 13),
                        ),
                      )
                    else
                      PitchDisplay(
                        source: widget.pitchSource,
                        targetHz: card?.targetHz,
                        relativeTargetMode: card?.relativePitchTarget ?? false,
                        deferredFeedback: card?.deferredVisualFeedback ?? false,
                        toleranceIntervalSemitones:
                            card?.toleranceIntervalSemitones,
                        // 초급 단계는 introductory, 그 이후 단계는 mastery(더 좁은 허용오차).
                        toleranceLevel:
                            p?.stage == LearningStage.beginnerFoundation
                                ? ToleranceLevel.introductory
                                : ToleranceLevel.mastery,
                        onRingSample: (ring, f0) => _ringSamples.add(
                          ResonanceSample(
                            attemptIndex: _ringSamples.length,
                            ringRaw: ring,
                            clarityRaw: 0,
                            f0Hz: f0,
                          ),
                        ),
                      ),
                  ] else
                    const SizedBox(height: 110),
                  if (_step == LessonStep.main &&
                      card != null &&
                      adaptation != null &&
                      !adaptation.recoveryMode &&
                      (card.allowsToneAB || card.requiresSameRecordingCondition)) ...[
                    const SizedBox(height: 12),
                    RecordingAbPanel(
                      cardId: card.id,
                      maxTakes: card.maxTakeCount ?? 2,
                      purpose: card.id == 'CARD-13'
                          ? RecordingPurpose.standardSample
                          : (card.id.startsWith('RA-')
                              ? RecordingPurpose.repertoirePhrase
                              : RecordingPurpose.toneAB),
                      fixedSlot: standardSampleSlot,
                      repository: widget.recordingRepository,
                      captureAdapter: widget.recordingCaptureAdapter,
                      playbackAdapter: widget.recordingPlaybackAdapter,
                      pathResolver: widget.recordingPathResolver,
                      onBeforeCapture: _prepareRecording,
                      audioSessionCoordinator: widget.audioSessionCoordinator,
                      onBeforePlayback: () async {
                        await widget.trainingAudioPlaybackAdapter?.stop();
                        widget.audioSessionCoordinator?.signal(
                          AudioSessionAction.trainingStopped,
                          AudioSessionStopReason.recordingPlaybackStarted,
                        );
                      },
                      availableToneTags:
                          _toneTagsFromNames(card.toneTagOptions),
                      takeToneSequence:
                          _toneTagsFromNames(card.toneSequence),
                      onTakeSaved: _onTakeSaved,
                      onBestTakeSelected: _onBestTakeSelected,
                    ),
                  ],
                  const SizedBox(height: 12),
                  if (_step != LessonStep.cooldown) ...[
                    SunsetCta(
                      buttonKey: const Key('next-button'),
                      onPressed: _advanceLessonStep,
                      label: _step == LessonStep.entry
                          ? ((adaptation?.recoveryMode ?? false)
                              ? '회복 루틴으로 가기'
                              : ((adaptation?.reducedMode ?? false)
                                  ? '라이트 모드로 가기'
                                  : '본운동으로 가기'))
                          : (adaptation?.nextLabel ?? '쿨다운으로 가기'),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (_step == LessonStep.cooldown) _resonanceTrendNotice(card),
                  if (_step == LessonStep.cooldown)
                    SunsetCta(
                      buttonKey: const Key('complete-button'),
                      disabled: _savingEvidence,
                      onPressed: _savingEvidence
                          ? null
                          : () => _completeCurrentLesson(
                                progression: p,
                                track: blueprintTrack,
                                cycle: blueprintCycle,
                                day: blueprintDay,
                                cardId: card?.id,
                                adaptation: adaptation,
                              ),
                      label: _savingEvidence ? '기록 저장 중' : '완료',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

enum _StepState { done, now, next }

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.state});
  final String label;
  final _StepState state;
  @override
  Widget build(BuildContext context) {
    final now = state == _StepState.now;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: switch (state) {
                _StepState.done => Sun.mint,
                _StepState.now => null,
                _StepState.next => Sun.line,
              },
              gradient: now ? Sun.gradient : null,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 7),
          Text(label,
              style: TextStyle(
                  color: now
                      ? Sun.coral
                      : (state == _StepState.done ? Sun.mint : Sun.inkLow),
                  fontSize: 11,
                  fontWeight: now ? FontWeight.w700 : FontWeight.w600)),
        ],
      ),
    );
  }
}


class _VocalLoadNotice extends StatelessWidget {
  const _VocalLoadNotice({required this.decision, super.key});

  final VocalLoadDecision decision;

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('vocal-load-notice'),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Sun.amberSoft,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          decision.reason,
          style: const TextStyle(color: Sun.amber, fontSize: 12, height: 1.4, fontWeight: FontWeight.w600),
        ),
      );
}

class _VoiceAdaptationNotice extends StatelessWidget {
  const _VoiceAdaptationNotice({required this.adaptation});

  final LessonAdaptation adaptation;

  @override
  Widget build(BuildContext context) => Container(
        key: Key(adaptation.recoveryMode
            ? 'recovery-adaptation-notice'
            : 'light-mode-notice'),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: adaptation.recoveryMode ? Sun.mintSoft : Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          adaptation.notice ?? '',
          style: TextStyle(
              color: adaptation.recoveryMode ? Sun.mint : Sun.orange,
              fontSize: 12,
              height: 1.4,
              fontWeight: FontWeight.w600),
        ),
      );
}

class _VoiceCheckPanel extends StatelessWidget {
  const _VoiceCheckPanel({required this.selected, required this.onSelected});

  final VoiceState? selected;
  final ValueChanged<VoiceState> onSelected;

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('voice-state-check'),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('오늘 목 상태',
                style: TextStyle(
                    color: Sun.inkMid,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('상태에 맞춰 오늘 훈련 강도를 자동으로 조정해요. 안 고르면 "괜찮음"으로 진행돼요.',
                style: TextStyle(
                    color: Sun.inkLow, fontSize: 11, height: 1.3)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _stateChip(VoiceState.ok, '괜찮음'),
                _stateChip(VoiceState.tired, '조금 피곤함'),
                _stateChip(VoiceState.hoarse, '쉰 느낌'),
              ],
            ),
          ],
        ),
      );

  Widget _stateChip(VoiceState state, String label) => ChoiceChip(
        key: Key('voice-state-${state.name}'),
        selected: selected == state,
        onSelected: (_) {
          HapticFeedback.selectionClick();
          onSelected(state);
        },
        label: Text(label),
        labelStyle: TextStyle(
          color: selected == state ? Colors.white : Sun.inkMid,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        showCheckmark: false,
        selectedColor: Sun.coral,
        backgroundColor: Sun.surface,
        side: BorderSide(color: selected == state ? Sun.coral : Sun.line),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
      );
}

/// 레슨 중 용어가 헷갈릴 때 여는 도움말 진입점. 셸을 거치지 않고 라우트로 띄운다.
class _HelpButton extends StatelessWidget {
  const _HelpButton();

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: '용어 도움말',
        excludeSemantics: true,
        child: InkWell(
        key: const Key('lesson-help'),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GlossaryScreen(
              onBack: () => Navigator.of(context).pop(),
            ),
          ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: Sun.surfaceSoft,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(color: Sun.hairline),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline_rounded, color: Sun.inkMid, size: 13),
              SizedBox(width: 4),
              Text('용어',
                  style: TextStyle(
                      color: Sun.inkMid,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ),
      );
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(text,
            style: const TextStyle(
                color: Sun.orange, fontSize: 12, fontWeight: FontWeight.w700)),
      );
}
