/// v6 — 실제 녹음/재생 어댑터.
///
/// UI와 도메인 모델은 이 인터페이스에만 의존한다. production에서는
/// `record` + `audioplayers` + `path_provider`를 쓰고, 테스트에서는 fake adapter를 쓴다.
library;

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'recording_ab.dart';

String _safeSegment(String input) => input
    .replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_')
    .replaceAll(RegExp(r'_+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');

class RecordingFilePathResolver {
  const RecordingFilePathResolver(this.rootDirectory);

  final Directory rootDirectory;

  static Future<RecordingFilePathResolver> create() async {
    final support = await getApplicationSupportDirectory();
    final root = Directory('${support.path}/recordings');
    await root.create(recursive: true);
    return RecordingFilePathResolver(root);
  }

  Future<String> nextPath({
    required String cardId,
    required RecordingPurpose purpose,
    required RecordingSlot slot,
    required String takeId,
  }) async {
    final rawCard = _safeSegment(cardId);
    final card = rawCard.isEmpty ? 'card' : rawCard;
    final purposeDir = _safeSegment(purpose.name);
    final dir = Directory('${rootDirectory.path}/$purposeDir/$card');
    await dir.create(recursive: true);
    final rawTake = _safeSegment(takeId);
    final safeTake = rawTake.isEmpty ? 'take' : rawTake;
    final safeSlot = _safeSegment(slot.name);
    return '${dir.path}/${safeSlot}_$safeTake.m4a';
  }

  Future<File> metadataFile() async {
    await rootDirectory.create(recursive: true);
    return File('${rootDirectory.path}/recording_index.json');
  }
}

class CapturedAudioFile {
  const CapturedAudioFile({
    required this.path,
    required this.startedEpochMs,
    required this.stoppedEpochMs,
    required this.durationMs,
    required this.fileSizeBytes,
  });

  final String path;
  final int startedEpochMs;
  final int stoppedEpochMs;
  final int durationMs;
  final int fileSizeBytes;
}

abstract class AudioCaptureAdapter {
  Future<bool> hasPermission();
  Future<bool> start(String outputPath);
  Future<CapturedAudioFile?> stop();
  Future<void> cancel();
  Future<void> dispose();
}

class RecordAudioCaptureAdapter implements AudioCaptureAdapter {
  RecordAudioCaptureAdapter({AudioRecorder? recorder})
      : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;
  String? _path;
  int? _startedEpochMs;

  static final RecordConfig _config = RecordConfig(
    encoder: AudioEncoder.aacLc,
    sampleRate: 44100,
    bitRate: 64000,
    numChannels: 1,
    autoGain: false,
    echoCancel: false,
    noiseSuppress: false,
  );

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<bool> start(String outputPath) async {
    if (!await hasPermission()) return false;
    final f = File(outputPath);
    await f.parent.create(recursive: true);
    _path = outputPath;
    _startedEpochMs = DateTime.now().millisecondsSinceEpoch;
    await _recorder.start(_config, path: outputPath);
    return true;
  }

  @override
  Future<CapturedAudioFile?> stop() async {
    final started = _startedEpochMs;
    final fallbackPath = _path;
    final stoppedPath = await _recorder.stop();
    final now = DateTime.now().millisecondsSinceEpoch;
    final path = stoppedPath ?? fallbackPath;
    _path = null;
    _startedEpochMs = null;
    if (started == null || path == null) return null;
    final f = File(path);
    final size = await f.exists() ? await f.length() : 0;
    return CapturedAudioFile(
      path: path,
      startedEpochMs: started,
      stoppedEpochMs: now,
      durationMs: now - started,
      fileSizeBytes: size,
    );
  }

  @override
  Future<void> cancel() async {
    final path = _path;
    try {
      await _recorder.stop();
    } catch (_) {}
    _path = null;
    _startedEpochMs = null;
    if (path != null) {
      final f = File(path);
      if (await f.exists()) await f.delete();
    }
  }

  @override
  Future<void> dispose() async {
    _recorder.dispose();
  }
}

abstract class AudioPlaybackAdapter {
  Future<void> play(String localPath);
  Future<void> stop();
  Future<void> dispose();
}

class AudioplayersPlaybackAdapter implements AudioPlaybackAdapter {
  AudioplayersPlaybackAdapter({AudioPlayer? player})
      : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  @override
  Future<void> play(String localPath) async {
    await _player.stop();
    await _player.play(DeviceFileSource(localPath));
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() => _player.dispose();
}

/// v10 — 앱 bundle에 포함된 훈련용 guide/backing/click 재생 전용 seam.
/// 사용자 녹음 재생과 별도 player를 사용해 두 목적의 상태를 섞지 않는다.
abstract class TrainingAudioPlaybackAdapter {
  Future<void> playAsset(String assetPath);
  Future<void> stop();
  Future<void> dispose();
}

class AudioplayersTrainingAudioAdapter
    implements TrainingAudioPlaybackAdapter {
  AudioplayersTrainingAudioAdapter({AudioPlayer? player})
      : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  String _assetKey(String path) =>
      path.startsWith('assets/') ? path.substring('assets/'.length) : path;

  @override
  Future<void> playAsset(String assetPath) async {
    await _player.stop();
    await _player.play(AssetSource(_assetKey(assetPath)));
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> dispose() => _player.dispose();
}

/// Widget/unit test용 fake. 실제 마이크 권한이나 platform channel을 쓰지 않는다.
class FakeAudioCaptureAdapter implements AudioCaptureAdapter {
  FakeAudioCaptureAdapter({this.permission = true, this.fakeSizeBytes = 128});

  bool permission;
  int fakeSizeBytes;
  String? startedPath;
  int? startedEpochMs;
  int cancelCalls = 0;
  bool disposed = false;

  @override
  Future<bool> hasPermission() async => permission;

  @override
  Future<bool> start(String outputPath) async {
    if (!permission) return false;
    startedPath = outputPath;
    startedEpochMs = DateTime.now().millisecondsSinceEpoch;
    return true;
  }

  @override
  Future<CapturedAudioFile?> stop() async {
    final path = startedPath;
    final started = startedEpochMs;
    startedPath = null;
    startedEpochMs = null;
    if (path == null || started == null) return null;
    final now = DateTime.now().millisecondsSinceEpoch;
    return CapturedAudioFile(
      path: path,
      startedEpochMs: started,
      stoppedEpochMs: now,
      durationMs: now <= started ? 1 : now - started,
      fileSizeBytes: fakeSizeBytes,
    );
  }

  @override
  Future<void> cancel() async {
    cancelCalls++;
    startedPath = null;
    startedEpochMs = null;
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}

class FakeAudioPlaybackAdapter implements AudioPlaybackAdapter {
  final List<String> played = [];
  int stopCalls = 0;
  bool disposed = false;

  @override
  Future<void> play(String localPath) async {
    played.add(localPath);
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}

class FakeTrainingAudioPlaybackAdapter
    implements TrainingAudioPlaybackAdapter {
  final List<String> playedAssets = [];
  int stopCalls = 0;
  bool disposed = false;

  @override
  Future<void> playAsset(String assetPath) async {
    playedAssets.add(assetPath);
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  @override
  Future<void> dispose() async {
    disposed = true;
  }
}

