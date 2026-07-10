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

class RecordingPitchSource implements PitchSource {
  RecordingPitchSource({
    AudioRecorder? recorder,
    this.sampleRate = 16000,
    this.frameSize = 2048,
  }) : _rec = recorder ?? AudioRecorder();

  final AudioRecorder _rec;
  final int sampleRate;
  final int frameSize;

  final StreamController<List<double>> _frames =
      StreamController<List<double>>.broadcast();
  late final MicPitchSource _inner =
      MicPitchSource(frames: _frames.stream, sampleRate: sampleRate);
  StreamSubscription<Uint8List>? _byteSub;
  final List<double> _buf = [];

  @override
  Stream<PitchReading> get readings => _inner.readings;

  @override
  Future<bool> start() async {
    if (!await _rec.hasPermission()) return false;
    final byteStream = await _rec.startStream(RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: sampleRate,
      numChannels: 1,
    ));
    _byteSub = byteStream.listen(_onBytes);
    return true;
  }

  void _onBytes(Uint8List bytes) {
    _buf.addAll(pcm16ToSamples(bytes));
    while (_buf.length >= frameSize) {
      _frames.add(_buf.sublist(0, frameSize));
      _buf.removeRange(0, frameSize);
    }
  }

  @override
  Future<void> stop() async {
    await _byteSub?.cancel();
    _byteSub = null;
    if (await _rec.isRecording()) await _rec.stop();
  }

  @override
  void dispose() {
    _byteSub?.cancel();
    _frames.close();
    _rec.dispose();
  }
}
