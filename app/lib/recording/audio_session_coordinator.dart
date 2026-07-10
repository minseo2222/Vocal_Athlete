/// v11 — 훈련 음원·저장 take 재생·마이크 캡처 사이의 중단 신호.
///
/// 실제 adapter stop/cancel은 상위 셸이 수행하고, 이 coordinator는 하위 패널이
/// 외부 중단을 UI 상태에 반영하도록 알린다.
library;

import 'package:flutter/foundation.dart';

enum AudioSessionAction { captureCancelled, trainingStopped, allStopped }

enum AudioSessionStopReason {
  trainingAudioStarted,
  recordingStarted,
  recordingPlaybackStarted,
  lessonStepChanged,
  lessonCompleted,
  appLifecycle,
}

class AudioSessionEvent {
  const AudioSessionEvent({
    required this.sequence,
    required this.action,
    required this.reason,
  });

  final int sequence;
  final AudioSessionAction action;
  final AudioSessionStopReason reason;
}

class AudioSessionCoordinator extends ChangeNotifier {
  AudioSessionEvent _event = const AudioSessionEvent(
    sequence: 0,
    action: AudioSessionAction.allStopped,
    reason: AudioSessionStopReason.lessonStepChanged,
  );

  AudioSessionEvent get event => _event;

  void signal(
    AudioSessionAction action,
    AudioSessionStopReason reason,
  ) {
    _event = AudioSessionEvent(
      sequence: _event.sequence + 1,
      action: action,
      reason: reason,
    );
    notifyListeners();
  }
}
