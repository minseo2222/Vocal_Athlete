/// A1 — 실 마이크 PitchSource (record 패키지 glue).
///
/// 책임: 권한·캡처 라이프사이클 + PCM 바이트 → 프레임 버퍼링. F0 변환은
/// MicPitchSource에 위임(테스트됨), PCM 디코딩은 pcm16ToSamples(테스트됨).
/// 본 클래스는 device-bound glue라 단위 테스트 대신 analyze + 기기 검증.
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'mic_pitch_source.dart';
import 'pcm.dart';
import 'pitch_source.dart';

abstract class RecordingBackend {
  Future<bool> hasPermission();

  Future<Stream<Uint8List>> startStream({
    required int sampleRate,
    required int numChannels,
  });

  Future<bool> isRecording();

  Future<void> stop();

  Future<void> dispose();
}

class AudioRecorderBackend implements RecordingBackend {
  AudioRecorderBackend([AudioRecorder? recorder])
      : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<Stream<Uint8List>> startStream({
    required int sampleRate,
    required int numChannels,
  }) =>
      _recorder.startStream(RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: sampleRate,
        numChannels: numChannels,
      ));

  @override
  Future<bool> isRecording() => _recorder.isRecording();

  @override
  Future<void> stop() async {
    await _recorder.stop();
  }

  @override
  Future<void> dispose() => _recorder.dispose();
}

class RecordingPitchSource implements PitchSource {
  RecordingPitchSource({
    RecordingBackend? backend,
    AudioRecorder? recorder,
    this.sampleRate = 16000,
    this.frameSize = 2048,
  }) : _backend = backend ?? AudioRecorderBackend(recorder);

  final RecordingBackend _backend;
  final int sampleRate;
  final int frameSize;

  final StreamController<List<double>> _frames =
      StreamController<List<double>>.broadcast();
  late final MicPitchSource _inner =
      MicPitchSource(frames: _frames.stream, sampleRate: sampleRate);
  StreamSubscription<Uint8List>? _byteSub;
  final List<double> _buf = [];
  Future<bool>? _starting;
  Future<void>? _stopping;
  Future<void>? _disposing;
  bool _recording = false;
  bool _closed = false;
  bool _disposed = false;

  @override
  Stream<PitchReading> get readings => _inner.readings;

  @override
  Future<bool> start() async {
    if (_closed) return false;
    if (_recording && _byteSub != null) return true;
    final inFlight = _starting;
    if (inFlight != null) return inFlight;
    final pendingStop = _stopping;
    if (pendingStop != null) await pendingStop;

    final startFuture = _startFresh();
    _starting = startFuture;
    try {
      return await startFuture;
    } finally {
      if (identical(_starting, startFuture)) {
        _starting = null;
      }
    }
  }

  Future<bool> _startFresh() async {
    if (!await _backend.hasPermission()) return false;
    try {
      final byteStream = await _backend.startStream(
        sampleRate: sampleRate,
        numChannels: 1,
      );
      if (_closed) {
        await _stopBackendIfNeeded();
        return false;
      }
      _byteSub = byteStream.listen(_onBytes);
      _recording = true;
      return true;
    } catch (_) {
      await _cleanupAfterFailedStart();
      return false;
    }
  }

  Future<void> _cleanupAfterFailedStart() async {
    final sub = _byteSub;
    _byteSub = null;
    if (sub != null) await sub.cancel();
    _buf.clear();
    await _stopBackendIfNeeded();
    _recording = false;
  }

  void _onBytes(Uint8List bytes) {
    if (_closed || _frames.isClosed) return;
    _buf.addAll(pcm16ToSamples(bytes));
    while (_buf.length >= frameSize) {
      if (_closed || _frames.isClosed) return;
      _frames.add(_buf.sublist(0, frameSize));
      _buf.removeRange(0, frameSize);
    }
  }

  @override
  Future<void> stop() async {
    final inFlight = _stopping;
    if (inFlight != null) return inFlight;
    final stopFuture = _stopInternal();
    _stopping = stopFuture;
    try {
      await stopFuture;
    } finally {
      if (identical(_stopping, stopFuture)) {
        _stopping = null;
      }
    }
  }

  Future<void> _stopInternal() async {
    if (_disposed) return;
    final sub = _byteSub;
    _byteSub = null;
    if (sub != null) await sub.cancel();
    _buf.clear();
    if (_recording || await _backend.isRecording()) {
      await _backend.stop();
    }
    _recording = false;
  }

  Future<void> _stopBackendIfNeeded() async {
    if (_recording || await _backend.isRecording()) {
      await _backend.stop();
    }
  }

  @override
  Future<void> dispose() async {
    final inFlight = _disposing;
    if (inFlight != null) return inFlight;
    final disposeFuture = _disposeInternal();
    _disposing = disposeFuture;
    return disposeFuture;
  }

  Future<void> _disposeInternal() async {
    _closed = true;
    final pendingStart = _starting;
    if (pendingStart != null) {
      await pendingStart;
    }
    await stop();
    if (!_frames.isClosed) {
      await _frames.close();
    }
    await _backend.dispose();
    _disposed = true;
  }
}
