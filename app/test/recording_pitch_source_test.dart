import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/recording_pitch_source.dart';

Uint8List _sinePcm16({
  double hz = 220,
  int sampleRate = 16000,
  int samples = 2048,
}) {
  final bytes = ByteData(samples * 2);
  for (var i = 0; i < samples; i++) {
    final sample = (sin(2 * pi * hz * i / sampleRate) * 32767).round();
    bytes.setInt16(i * 2, sample, Endian.little);
  }
  return bytes.buffer.asUint8List();
}

class _ManualByteStream extends Stream<Uint8List> {
  void Function(Uint8List)? _onData;
  int listenCount = 0;
  int cancelCount = 0;

  @override
  StreamSubscription<Uint8List> listen(
    void Function(Uint8List event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    listenCount++;
    _onData = onData;
    return _ManualByteSubscription(this);
  }

  void emit(Uint8List bytes) {
    _onData?.call(bytes);
  }
}

class _ManualByteSubscription implements StreamSubscription<Uint8List> {
  _ManualByteSubscription(this._stream);

  final _ManualByteStream _stream;

  @override
  Future<void> cancel() {
    _stream.cancelCount++;
    return Future<void>.value();
  }

  @override
  void onData(void Function(Uint8List data)? handleData) {}

  @override
  void onError(Function? handleError) {}

  @override
  void onDone(void Function()? handleDone) {}

  @override
  void pause([Future<void>? resumeSignal]) {}

  @override
  void resume() {}

  @override
  bool get isPaused => false;

  @override
  Future<E> asFuture<E>([E? futureValue]) => Future<E>.value(futureValue);
}

class _FakeRecordingBackend implements RecordingBackend {
  _FakeRecordingBackend({this.permission = true, this.throwOnStart = false});

  final _ManualByteStream stream = _ManualByteStream();
  bool permission;
  bool throwOnStart;
  bool recording = false;
  int permissionCalls = 0;
  int startStreamCalls = 0;
  int isRecordingCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;

  @override
  Future<bool> hasPermission() async {
    permissionCalls++;
    return permission;
  }

  @override
  Future<Stream<Uint8List>> startStream({
    required int sampleRate,
    required int numChannels,
  }) async {
    startStreamCalls++;
    recording = true;
    if (throwOnStart) {
      throw StateError('start failed');
    }
    return stream;
  }

  @override
  Future<bool> isRecording() async {
    isRecordingCalls++;
    return recording;
  }

  @override
  Future<void> stop() async {
    stopCalls++;
    recording = false;
  }

  @override
  Future<void> dispose() async {
    disposeCalls++;
    recording = false;
  }
}

void main() {
  test('RPS1 duplicate start does not create duplicate byte subscriptions',
      () async {
    final backend = _FakeRecordingBackend();
    final source = RecordingPitchSource(backend: backend);

    expect(await source.start(), isTrue);
    expect(await source.start(), isTrue);

    expect(backend.startStreamCalls, 1);
    expect(backend.stream.listenCount, 1);

    await source.dispose();
  });

  test('RPS2 stop is idempotent', () async {
    final backend = _FakeRecordingBackend();
    final source = RecordingPitchSource(backend: backend);

    expect(await source.start(), isTrue);
    await source.stop();
    await source.stop();

    expect(backend.stopCalls, 1);

    await source.dispose();
  });

  test('RPS3 dispose ignores late audio chunks after controller close',
      () async {
    final backend = _FakeRecordingBackend();
    final source = RecordingPitchSource(backend: backend);

    expect(await source.start(), isTrue);
    await source.dispose();

    expect(() => backend.stream.emit(_sinePcm16()), returnsNormally);
    await source.dispose();
    expect(backend.disposeCalls, 1);
  });

  test('RPS4 permission denied does not start a byte stream', () async {
    final backend = _FakeRecordingBackend(permission: false);
    final source = RecordingPitchSource(backend: backend);

    expect(await source.start(), isFalse);
    expect(backend.startStreamCalls, 0);

    await source.dispose();
  });

  test('RPS5 startStream failure returns false and cleans partial recorder state',
      () async {
    final backend = _FakeRecordingBackend(throwOnStart: true);
    final source = RecordingPitchSource(backend: backend);

    expect(await source.start(), isFalse);
    expect(backend.stopCalls, 1);

    await source.dispose();
  });
}
