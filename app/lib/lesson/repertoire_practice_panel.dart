/// v10 — 첫 곡 적용 프로젝트의 프레이즈·호흡표시·훈련음원 패널.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/audio_io.dart';
import '../recording/audio_session_coordinator.dart';
import '../repertoire/repertoire_asset.dart';
import '../theme/app_theme.dart';

String guideStateForRepertoireCard(String cardId) => switch (cardId) {
      'RA-09' => 'full',
      'RA-01' || 'RA-02' || 'CARD-15' => 'click',
      'RA-03' || 'RA-05' => 'hum',
      'RA-07' => 'slow',
      'RA-04' || 'RA-06' || 'CARD-17' || 'RA-08' => 'backing',
      'RA-10' => 'transfer',
      _ => 'none',
    };

class RepertoirePracticePanel extends StatefulWidget {
  const RepertoirePracticePanel({
    required this.assetId,
    required this.guideState,
    this.playbackAdapter,
    this.repository = const RepertoireAssetRepository(),
    this.asset,
    this.initialKey,
    this.onKeyChanged,
    this.onBeforeAudioPlay,
    this.audioSessionCoordinator,
    super.key,
  });

  final String assetId;
  final String guideState;
  final TrainingAudioPlaybackAdapter? playbackAdapter;
  final RepertoireAssetRepository repository;
  final RepertoireAsset? asset;
  final String? initialKey;
  final ValueChanged<String>? onKeyChanged;
  final Future<void> Function()? onBeforeAudioPlay;
  final AudioSessionCoordinator? audioSessionCoordinator;

  @override
  State<RepertoirePracticePanel> createState() =>
      _RepertoirePracticePanelState();
}

class _RepertoirePracticePanelState extends State<RepertoirePracticePanel> {
  late Future<RepertoireAsset> _future;
  late String _selectedKey;
  String? _playingRole;
  String? _error;
  int _lastAudioSessionSequence = 0;

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.initialKey ?? 'mid';
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
      if (mounted && _playingRole != null) {
        setState(() => _playingRole = null);
      }
    }
  }

  @override
  void didUpdateWidget(covariant RepertoirePracticePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioSessionCoordinator != widget.audioSessionCoordinator) {
      _detachAudioSession(oldWidget.audioSessionCoordinator);
      _attachAudioSession(widget.audioSessionCoordinator);
    }
    if (oldWidget.assetId != widget.assetId || oldWidget.asset != widget.asset) {
      _future = _load();
      _selectedKey = widget.initialKey ?? 'mid';
      _playingRole = null;
      _error = null;
    } else if (widget.initialKey != null &&
        oldWidget.initialKey != widget.initialKey) {
      _selectedKey = widget.initialKey!;
    }
  }

  Future<RepertoireAsset> _load() async =>
      widget.asset ?? widget.repository.load(widget.assetId);

  List<String> _rolesForGuideState(String state, String selectedKey) {
    final suffix = selectedKey == 'low' ? 'Low' : 'Mid';
    return switch (state) {
      'full' => ['guideHum$suffix', 'backingTrack$suffix'],
      'click' => ['click'],
      'hum' => ['guideHum$suffix', 'guideMelodyPiano$suffix'],
      'slow' => ['guideMelodySlow$suffix'],
      'backing' || 'transfer' => ['backingTrack$suffix'],
      _ => const [],
    };
  }

  String _labelForRole(String role) => switch (role) {
        'guideHumLow' => '허밍 가이드 · 낮은 키',
        'guideHumMid' => '허밍 가이드 · 중간 키',
        'guideMelodyPianoLow' => '피아노 멜로디 · 낮은 키',
        'guideMelodyPianoMid' => '피아노 멜로디 · 중간 키',
        'guideMelodySlowLow' => '느린 가이드 · 낮은 키',
        'guideMelodySlowMid' => '느린 가이드 · 중간 키',
        'backingTrackLow' => '반주 · 낮은 키',
        'backingTrackMid' => '반주 · 중간 키',
        'click' => '72 BPM 클릭',
        _ => role,
      };

  Future<void> _play(RepertoireAsset asset, String role) async {
    final adapter = widget.playbackAdapter;
    final path = asset.audioPath(role);
    if (adapter == null || path == null) return;
    try {
      await widget.onBeforeAudioPlay?.call();
      await adapter.playAsset(path);
      if (!mounted) return;
      setState(() {
        _playingRole = role;
        _error = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = '훈련 음원을 재생하지 못했습니다.');
    }
  }

  Future<void> _stop() async {
    await widget.playbackAdapter?.stop();
    if (!mounted) return;
    setState(() => _playingRole = null);
  }

  Future<void> _selectKey(String key) async {
    if (_selectedKey == key) return;
    await widget.playbackAdapter?.stop();
    if (!mounted) return;
    setState(() {
      _selectedKey = key;
      _playingRole = null;
      _error = null;
    });
    widget.onKeyChanged?.call(key);
  }

  @override
  void dispose() {
    // 프레이즈 패널 이탈 후 가이드/반주 재생이 남지 않게 한다.
    // ignore: discarded_futures
    _detachAudioSession(widget.audioSessionCoordinator);
    widget.playbackAdapter?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<RepertoireAsset>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
              key: Key('repertoire-asset-error'),
              height: 0,
            );
          }
          final asset = snapshot.data;
          if (asset == null) {
            return const SizedBox(
              key: Key('repertoire-asset-loading'),
              height: 0,
            );
          }
          final effectiveKey = asset.recommendedKeys.contains(_selectedKey)
              ? _selectedKey
              : (asset.recommendedKeys.contains('mid')
                  ? 'mid'
                  : asset.recommendedKeys.first);
          final roles = _rolesForGuideState(widget.guideState, effectiveKey)
              .where((role) => asset.audioPath(role) != null)
              .toList(growable: false);
          return Container(
            key: const Key('repertoire-practice-panel'),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Sun.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Sun.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(asset.title,
                    style: const TextStyle(
                        color: Sun.ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const SizedBox(height: 3),
                Text(
                  '${asset.bars}마디 · ${asset.tempoBpm} BPM · ${asset.countInBeats}박 count-in',
                  style: const TextStyle(
                      color: Sun.inkLow, fontSize: 11, fontFeatures: Sun.tnum),
                ),
                if (asset.recommendedKeys.length > 1) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    key: const Key('repertoire-key-selector'),
                    spacing: 6,
                    runSpacing: 6,
                    children: asset.recommendedKeys
                        .map((key) => ChoiceChip(
                              key: Key('repertoire-key-$key'),
                              selected: effectiveKey == key,
                              onSelected: (_) {
                                HapticFeedback.selectionClick();
                                // ignore: discarded_futures
                                _selectKey(key);
                              },
                              label: Text(key == 'low' ? '낮은 키' : '중간 키'),
                              labelStyle: const TextStyle(fontSize: 11),
                            ))
                        .toList(growable: false),
                  ),
                  const SizedBox(height: 5),
                  const Text('두 예시 중 편한 쪽만 선택합니다. 둘 다 불편하면 듣기만 합니다.',
                      key: Key('comfortable-key-notice'),
                      style: TextStyle(color: Sun.inkLow, fontSize: 10)),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: asset.lyricTiming
                      .map((cue) => Container(
                            key: Key('lyric-bar-${cue.bar}'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 6),
                            decoration: BoxDecoration(
                              color: Sun.surfaceSoft,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('${cue.bar} · ${cue.text}',
                                style: const TextStyle(
                                    color: Sun.ink,
                                    fontSize: 12,
                                    fontFeatures: Sun.tnum)),
                          ))
                      .toList(growable: false),
                ),
                if (asset.breathMarks.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    asset.breathMarks
                        .map((mark) => '${mark.beforeBar}마디 전 · ${mark.cue}')
                        .join('  /  '),
                    key: const Key('repertoire-breath-marks'),
                    style: const TextStyle(
                        color: Sun.coral,
                        fontSize: 11,
                        height: 1.3,
                        fontFeatures: Sun.tnum),
                  ),
                ],
                const SizedBox(height: 9),
                if (widget.guideState == 'transfer') ...[
                  const Text(
                    '보컬 가이드 없이 반주만 사용합니다. 첫 take 뒤 키 조건 하나만 바꿉니다.',
                    key: Key('transfer-guide-notice'),
                    style: TextStyle(color: Sun.inkMid, fontSize: 11),
                  ),
                  const SizedBox(height: 7),
                ],
                if (roles.isEmpty)
                  const Text('오늘은 가이드 없이 먼저 시도합니다.',
                      key: Key('guide-faded-notice'),
                      style: TextStyle(color: Sun.inkMid, fontSize: 12))
                else
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      ...roles.map((role) => OutlinedButton.icon(
                            key: Key('training-audio-$role'),
                            onPressed: widget.playbackAdapter == null
                                ? null
                                : () {
                                    HapticFeedback.lightImpact();
                                    _play(asset, role);
                                  },
                            icon: Icon(
                                _playingRole == role
                                    ? Icons.graphic_eq
                                    : Icons.play_arrow,
                                size: 16),
                            label: Text(_labelForRole(role),
                                style: const TextStyle(fontSize: 11)),
                          )),
                      if (_playingRole != null)
                        TextButton.icon(
                          key: const Key('training-audio-stop'),
                          onPressed: _stop,
                          icon: const Icon(Icons.stop, size: 16),
                          label: const Text('정지',
                              style: TextStyle(fontSize: 11)),
                        ),
                    ],
                  ),
                if (widget.playbackAdapter == null && roles.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  const Text('훈련 음원 재생은 실제 앱 오디오 연결 후 활성화됩니다.',
                      key: Key('training-audio-unavailable'),
                      style: TextStyle(color: Sun.inkLow, fontSize: 10)),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 6),
                  Text(_error!,
                      style: const TextStyle(
                          color: Sun.coral, fontSize: 11)),
                ],
                const SizedBox(height: 6),
                const Text(
                    '볼륨을 편한 수준으로 낮춰 사용 · 프로토타입 합성 가이드 · 출시 전 전문가 제작 음원과 실기기 QA 필요',
                    key: Key('prototype-audio-notice'),
                    style: TextStyle(color: Sun.inkLow, fontSize: 9)),
              ],
            ),
          );
        },
      );
}
