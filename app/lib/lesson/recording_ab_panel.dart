/// v6 — 레슨 안의 녹음 A/B 패널.
///
/// 실제 녹음/재생 어댑터가 주입되면 native capture/playback을 사용한다.
/// 어댑터가 없으면 widget test와 UI 프로토타입을 위해 preview take만 기록한다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/audio_io.dart';
import '../recording/audio_session_coordinator.dart';
import '../recording/recording_ab.dart';
import '../theme/app_theme.dart';

enum _CaptureUiState { idle, recording, saving }

class RecordingAbPanel extends StatefulWidget {
  const RecordingAbPanel({
    required this.cardId,
    this.maxTakes = 2,
    this.purpose = RecordingPurpose.toneAB,
    this.fixedSlot,
    this.repository,
    this.captureAdapter,
    this.playbackAdapter,
    this.pathResolver,
    this.onBeforeCapture,
    this.onBeforePlayback,
    this.onTakeSaved,
    this.onBestTakeSelected,
    this.availableToneTags = const [],
    this.takeToneSequence = const [],
    this.audioSessionCoordinator,
    super.key,
  });

  final String cardId;
  final int maxTakes;
  final RecordingPurpose purpose;

  /// 표준샘플처럼 milestone별로 독립 세션을 만들 때 슬롯을 고정한다.
  final RecordingSlot? fixedSlot;
  final RecordingRepository? repository;
  final AudioCaptureAdapter? captureAdapter;
  final AudioPlaybackAdapter? playbackAdapter;
  final RecordingFilePathResolver? pathResolver;
  final Future<void> Function()? onBeforeCapture;
  final Future<void> Function()? onBeforePlayback;
  final ValueChanged<RecordingTake>? onTakeSaved;
  final ValueChanged<String>? onBestTakeSelected;
  final List<ToneTag> availableToneTags;
  final List<ToneTag> takeToneSequence;
  final AudioSessionCoordinator? audioSessionCoordinator;

  @override
  State<RecordingAbPanel> createState() => _RecordingAbPanelState();
}

class _RecordingAbPanelState extends State<RecordingAbPanel> {
  late RecordingAbSession _session;
  late RecordingRepository _repository;
  ToneTag _tag = ToneTag.comfortable;
  int _comfort = 3;
  bool _sameCondition = true;
  _CaptureUiState _captureState = _CaptureUiState.idle;
  String? _error;
  String? _activeTakeId;
  RecordingSlot? _activeSlot;
  int _lastAudioSessionSequence = 0;

  bool get _hasNativeCapture =>
      widget.captureAdapter != null && widget.pathResolver != null;


  List<ToneTag> get _tagOptions {
    final configured = widget.availableToneTags;
    if (configured.isNotEmpty) return configured;
    return const [
      ToneTag.comfortable,
      ToneTag.clear,
      ToneTag.clean,
      ToneTag.warm,
      ToneTag.bright,
      ToneTag.speechLike,
    ];
  }

  ToneTag _tagForIndex(int index) {
    if (index >= 0 && index < widget.takeToneSequence.length) {
      return widget.takeToneSequence[index];
    }
    if (_tagOptions.contains(ToneTag.comfortable)) {
      return ToneTag.comfortable;
    }
    return _tagOptions.first;
  }

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? InMemoryRecordingRepository();
    _session = RecordingAbSession(
      cardId: widget.cardId,
      purpose: widget.purpose,
      maxTakes: widget.maxTakes,
    );
    _tag = _tagForIndex(0);
    _loadSession();
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
    if ((action == AudioSessionAction.captureCancelled ||
            action == AudioSessionAction.allStopped) &&
        _captureState != _CaptureUiState.idle) {
      if (!mounted) return;
      setState(() {
        _captureState = _CaptureUiState.idle;
        _activeTakeId = null;
        _activeSlot = null;
        _error = coordinator.event.reason == AudioSessionStopReason.appLifecycle
            ? '앱 상태가 바뀌어 녹음을 취소했습니다.'
            : '다른 오디오를 시작해 녹음을 취소했습니다.';
      });
    }
  }

  @override
  void didUpdateWidget(covariant RecordingAbPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioSessionCoordinator != widget.audioSessionCoordinator) {
      _detachAudioSession(oldWidget.audioSessionCoordinator);
      _attachAudioSession(widget.audioSessionCoordinator);
    }
    if (oldWidget.cardId != widget.cardId ||
        oldWidget.maxTakes != widget.maxTakes ||
        oldWidget.purpose != widget.purpose ||
        oldWidget.fixedSlot != widget.fixedSlot ||
        oldWidget.repository != widget.repository ||
        oldWidget.availableToneTags != widget.availableToneTags ||
        oldWidget.takeToneSequence != widget.takeToneSequence) {
      _repository = widget.repository ?? InMemoryRecordingRepository();
      _session = RecordingAbSession(
        cardId: widget.cardId,
        purpose: widget.purpose,
        maxTakes: widget.maxTakes,
      );
      _tag = _tagForIndex(0);
      _loadSession();
    }
  }

  Future<void> _loadSession() async {
    final takes = await _repository.listTakes(
      cardId: widget.cardId,
      purpose: widget.purpose,
    );
    if (!mounted) return;
    final scoped = widget.fixedSlot == null
        ? takes
        : takes.where((take) => take.slot == widget.fixedSlot).toList();
    final limited = scoped.take(widget.maxTakes).toList(growable: false);
    String? bestTakeId;
    for (final take in limited) {
      if (take.isBest) {
        bestTakeId = take.id;
        break;
      }
    }
    setState(() {
      _session = RecordingAbSession(
        cardId: widget.cardId,
        purpose: widget.purpose,
        maxTakes: widget.maxTakes,
        takes: limited,
        bestTakeId: bestTakeId,
      );
      _tag = _tagForIndex(limited.length);
    });
  }

  RecordingSlot _slotForIndex(int index) {
    final fixed = widget.fixedSlot;
    if (fixed != null) return fixed;
    return switch (index) {
      0 when widget.purpose == RecordingPurpose.standardSample =>
        RecordingSlot.baseline,
      1 when widget.purpose == RecordingPurpose.standardSample =>
        RecordingSlot.midpoint,
      2 when widget.purpose == RecordingPurpose.standardSample =>
        RecordingSlot.graduation,
      0 => RecordingSlot.a,
      1 => RecordingSlot.b,
      _ => RecordingSlot.c,
    };
  }

  Future<void> _saveTake(RecordingTake take) async {
    await _repository.saveTake(take);
    widget.onTakeSaved?.call(take);
    if (!mounted) return;
    setState(() {
      _session = _session.addTake(take);
      _tag = _tagForIndex(_session.takes.length);
    });
  }

  Future<void> _addPreviewTake() async {
    if (!_session.canAddTake) return;
    final index = _session.takes.length;
    final slot = _slotForIndex(index);
    final createdEpochMs = DateTime.now().millisecondsSinceEpoch;
    final take = RecordingTake(
      id: nextTakeId(widget.cardId, index + 1, slot: widget.fixedSlot),
      cardId: widget.cardId,
      purpose: widget.purpose,
      slot: slot,
      localPath: 'local://preview/${widget.cardId}/${index + 1}',
      createdEpochMs: createdEpochMs,
      createdLocalDateKey: localDateKeyForEpochMs(createdEpochMs),
      toneTags: [_tag],
      comfortRating: _comfort,
      sameConditionConfirmed: _sameCondition,
      memo: _hasNativeCapture ? '' : 'preview-only',
    );
    await _saveTake(take);
  }

  Future<void> _startNativeRecording() async {
    if (!_session.canAddTake) return;
    final capture = widget.captureAdapter;
    final resolver = widget.pathResolver;
    if (capture == null || resolver == null) {
      await _addPreviewTake();
      return;
    }
    await widget.onBeforeCapture?.call();
    final index = _session.takes.length;
    final takeId = nextTakeId(widget.cardId, index + 1, slot: widget.fixedSlot);
    final slot = _slotForIndex(index);
    final path = await resolver.nextPath(
      cardId: widget.cardId,
      purpose: widget.purpose,
      slot: slot,
      takeId: takeId,
    );
    final ok = await capture.start(path);
    if (!mounted) return;
    if (!ok) {
      setState(() => _error =
          '마이크 권한이 없어 녹음을 시작하지 못했습니다. 기기 설정 > 앱 > 권한에서 마이크를 켜고 다시 시도해 주세요.');
      return;
    }
    setState(() {
      _activeTakeId = takeId;
      _activeSlot = slot;
      _captureState = _CaptureUiState.recording;
      _error = null;
    });
  }

  Future<void> _stopNativeRecording() async {
    final capture = widget.captureAdapter;
    final id = _activeTakeId;
    final slot = _activeSlot;
    if (capture == null || id == null || slot == null) return;
    setState(() => _captureState = _CaptureUiState.saving);
    final captured = await capture.stop();
    if (!mounted) return;
    if (captured == null) {
      setState(() {
        _captureState = _CaptureUiState.idle;
        _activeTakeId = null;
        _activeSlot = null;
        _error = '녹음 파일을 저장하지 못했습니다.';
      });
      return;
    }
    final take = RecordingTake(
      id: id,
      cardId: widget.cardId,
      purpose: widget.purpose,
      slot: slot,
      localPath: captured.path,
      createdEpochMs: captured.stoppedEpochMs,
      createdLocalDateKey:
          localDateKeyForEpochMs(captured.stoppedEpochMs),
      toneTags: [_tag],
      comfortRating: _comfort,
      sameConditionConfirmed: _sameCondition,
      durationMs: captured.durationMs,
      fileSizeBytes: captured.fileSizeBytes,
    );
    await _saveTake(take);
    if (!mounted) return;
    setState(() {
      _captureState = _CaptureUiState.idle;
      _activeTakeId = null;
      _activeSlot = null;
      _error = null;
    });
  }

  Future<void> _onRecordPressed() async {
    if (_captureState == _CaptureUiState.saving) return;
    if (_captureState == _CaptureUiState.recording) {
      await _stopNativeRecording();
      return;
    }
    if (_hasNativeCapture) {
      await _startNativeRecording();
    } else {
      await _addPreviewTake();
    }
  }

  Future<void> _deleteTake(String id) async {
    await _repository.deleteTake(id);
    if (!mounted) return;
    setState(() {
      _session = _session.deleteTake(id);
      _tag = _tagForIndex(_session.takes.length);
    });
  }

  Future<void> _markBestTake(String id) async {
    final updated = <RecordingTake>[
      for (final take in _session.takes)
        take.copyWith(isBest: take.id == id),
    ];
    for (final take in updated) {
      await _repository.saveTake(take);
    }
    if (!mounted) return;
    setState(() {
      _session = RecordingAbSession(
        cardId: _session.cardId,
        purpose: _session.purpose,
        maxTakes: _session.maxTakes,
        takes: updated,
        bestTakeId: id,
      );
    });
    widget.onBestTakeSelected?.call(id);
  }

  Future<void> _playTake(RecordingTake take) async {
    final playback = widget.playbackAdapter;
    if (playback == null || !take.hasPlayableLocalFile) return;
    await widget.onBeforePlayback?.call();
    await playback.play(take.localPath);
  }

  @override
  void dispose() {
    // 패널이 사라질 때 진행 중인 캡처/재생을 남기지 않는다. 어댑터 소유권은
    // AppShell에 있으므로 dispose하지 않고 세션만 중단한다.
    // ignore: discarded_futures
    _detachAudioSession(widget.audioSessionCoordinator);
    widget.captureAdapter?.cancel();
    // ignore: discarded_futures
    widget.playbackAdapter?.stop();
    super.dispose();
  }

  String get _buttonText {
    if (_captureState == _CaptureUiState.recording) return '녹음 종료';
    if (_captureState == _CaptureUiState.saving) return '저장 중';
    if (!_session.canAddTake) return '오늘 take 제한';
    return _hasNativeCapture ? '녹음 시작' : 'Take 기록';
  }

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('recording-ab-panel'),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('녹음 A/B',
                      style: TextStyle(color: Sun.ink, fontSize: 12)),
                ),
                if (_hasNativeCapture)
                  const Text('실제 녹음',
                      key: Key('native-capture-ready'),
                      style: TextStyle(color: Sun.mint, fontSize: 11))
                else
                  const Text('미리보기',
                      key: Key('preview-capture-mode'),
                      style: TextStyle(color: Sun.inkLow, fontSize: 11)),
              ],
            ),
            if (!_hasNativeCapture) ...[
              const SizedBox(height: 8),
              Container(
                key: const Key('preview-mode-banner'),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Sun.surfaceSoft,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Sun.hairline),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: Sun.coral, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '이 기기에서는 실제 녹음을 쓸 수 없어 미리보기로만 동작해요. '
                        '마이크 권한을 허용했는지 확인해 주세요. 지금 남기는 기록은 다시 들을 수 없습니다.',
                        style: TextStyle(
                            color: Sun.inkMid, fontSize: 11.5, height: 1.35),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              widget.maxTakes == 1
                  ? '이 시점에는 take 1개만 남깁니다. 점수 대신 tone tag와 편안함을 기록합니다.'
                  : '같은 조건에서 최대 ${widget.maxTakes}개 take만 비교합니다. 점수 대신 tone tag와 편안함을 남깁니다.',
              style: const TextStyle(
                  color: Sun.inkLow, fontSize: 11, height: 1.3),
            ),
            const SizedBox(height: 8),
            if (_session.canAddTake && widget.takeToneSequence.isNotEmpty) ...[
              Text(
                '이번 take 목표: ${_tag.label}',
                key: const Key('tone-take-target'),
                style: const TextStyle(
                    color: Sun.mint, fontSize: 11),
              ),
              const SizedBox(height: 6),
            ],
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final tag in _tagOptions)
                  ChoiceChip(
                    key: Key('tone-tag-${tag.name}'),
                    selected: _tag == tag,
                    onSelected: (_) {
                      HapticFeedback.selectionClick();
                      setState(() => _tag = tag);
                    },
                    label: Text(tag.label),
                    labelStyle: TextStyle(
                      color: _tag == tag ? Colors.white : Sun.inkMid,
                      fontSize: 11,
                    ),
                    selectedColor: Sun.coral,
                    backgroundColor: Sun.surface,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Material(
              type: MaterialType.transparency,
              child: CheckboxListTile(
                key: const Key('same-condition-check'),
                value: _sameCondition,
                dense: true,
                contentPadding: EdgeInsets.zero,
                onChanged: (v) {
                  HapticFeedback.selectionClick();
                  setState(() => _sameCondition = v ?? false);
                },
                title: const Text('같은 거리·같은 자세·같은 볼륨 느낌',
                    style: TextStyle(color: Sun.inkMid, fontSize: 11)),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Row(
              children: [
                const Text('편안함',
                    style: TextStyle(color: Sun.inkMid, fontSize: 11)),
                Expanded(
                  child: Slider(
                    value: _comfort.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: '$_comfort',
                    onChanged: (v) => setState(() => _comfort = v.round()),
                  ),
                ),
                Text('$_comfort/5',
                    style: const TextStyle(color: Sun.inkMid, fontSize: 11)),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    key: const Key('add-ab-take-button'),
                    onPressed: _session.canAddTake ||
                            _captureState == _CaptureUiState.recording
                        ? () {
                            HapticFeedback.lightImpact();
                            _onRecordPressed();
                          }
                        : null,
                    child: Text(_buttonText),
                  ),
                ),
                const SizedBox(width: 8),
                _SmallCounter(text: '${_session.takes.length}/${_session.maxTakes}'),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 6),
              Text(_error!,
                  key: const Key('recording-error'),
                  style: const TextStyle(color: Sun.amber, fontSize: 11)),
            ],
            if (_session.takes.isNotEmpty) ...[
              const SizedBox(height: 8),
              for (final take in _session.takes)
                _TakeRow(
                  take: take,
                  isBest: _session.bestTakeId == take.id,
                  canPlay: widget.playbackAdapter != null && take.hasPlayableLocalFile,
                  onBest: () {
                    HapticFeedback.lightImpact();
                    _markBestTake(take.id);
                  },
                  onDelete: () {
                    HapticFeedback.lightImpact();
                    _deleteTake(take.id);
                  },
                  onPlay: () {
                    HapticFeedback.lightImpact();
                    _playTake(take);
                  },
                ),
            ],
          ],
        ),
      );
}

class _TakeRow extends StatelessWidget {
  const _TakeRow({
    required this.take,
    required this.isBest,
    required this.canPlay,
    required this.onBest,
    required this.onDelete,
    required this.onPlay,
  });

  final RecordingTake take;
  final bool isBest;
  final bool canPlay;
  final VoidCallback onBest;
  final VoidCallback onDelete;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${take.slot.name.toUpperCase()} · ${take.toneTags.isEmpty ? '태그 없음' : take.toneTags.map((tag) => tag.label).join(' · ')} · 편안함 ${take.comfortRating}/5 · ${take.durationLabel}',
                key: Key('take-row-${take.id}'),
                style: const TextStyle(color: Sun.inkMid, fontSize: 11),
              ),
            ),
            TextButton(
              key: Key('play-take-${take.id}'),
              onPressed: canPlay ? onPlay : null,
              child: const Text('재생'),
            ),
            TextButton(
              key: Key('mark-best-${take.id}'),
              onPressed: onBest,
              child: Text(isBest ? 'Best' : 'Best로'),
            ),
            IconButton(
              key: Key('delete-take-${take.id}'),
              tooltip: '삭제',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Sun.inkLow, size: 18),
            ),
          ],
        ),
      );
}

class _SmallCounter extends StatelessWidget {
  const _SmallCounter({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(text, style: const TextStyle(color: Sun.inkMid, fontSize: 11)),
      );
}
