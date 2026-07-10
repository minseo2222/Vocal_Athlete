/// 위젯 테스트 공용 헬퍼.
///
/// 실제 audioplayers/record/path_provider 플러그인은 위젯 테스트에서 응답하지
/// 않아 레슨 완료·단계 전이 흐름을 멈추게 한다. 흐름을 끝까지 검증하는 테스트는
/// fake 어댑터와 in-memory 저장소를 모두 주입해 `_initRecordingStack`이
/// path_provider를 호출하지 않게 하고, 오디오 정지/녹음 정리가 즉시 끝나게 한다.
library;

import 'dart:io';

import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

DebugApp flowApp({
  Progression? initialProgression,
  ProgressionStore? store,
  int? todayEpochDay,
  bool startInLesson = false,
  PitchSource? pitchSource,
}) =>
    DebugApp(
      initialProgression: initialProgression,
      store: store,
      todayEpochDay: todayEpochDay,
      startInLesson: startInLesson,
      pitchSource: pitchSource,
      trainingAudioPlaybackAdapter: FakeTrainingAudioPlaybackAdapter(),
      recordingCaptureAdapter: FakeAudioCaptureAdapter(),
      recordingPlaybackAdapter: FakeAudioPlaybackAdapter(),
      recordingRepository: InMemoryRecordingRepository(),
      recordingPathResolver: RecordingFilePathResolver(Directory.systemTemp),
      evidenceRepository: InMemoryLearningEvidenceRepository(),
      reviewQueueRepository: InMemoryReviewQueueRepository(),
    );
