/// Task 5(A1) — MicPitchSource: PCM 프레임 → PitchReading 변환 골격.
library;

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/mic_pitch_source.dart';

List<double> _sine(double hz, int sr, int n) =>
    List<double>.generate(n, (i) => sin(2 * pi * hz * i / sr));

void main() {
  test('A1.1 voiced frame → reading with detected f0', () async {
    final src = MicPitchSource(
      frames: Stream.value(_sine(220, 16000, 2048)),
      sampleRate: 16000,
    );
    final r = await src.readings.first;
    expect(r.f0Hz, isNotNull);
    expect((r.f0Hz! - 220).abs() / 220, lessThan(0.05));
  });

  test('A1.2 silent frame → reading with null f0 (honest)', () async {
    final src = MicPitchSource(
      frames: Stream.value(List<double>.filled(2048, 0)),
      sampleRate: 16000,
    );
    final r = await src.readings.first;
    expect(r.f0Hz, isNull);
  });

  test('A1.3 lifecycle start/stop/dispose', () async {
    final src = MicPitchSource(
      frames: const Stream.empty(),
      sampleRate: 16000,
    );
    expect(await src.start(), isTrue);
    await src.stop();
    src.dispose();
  });
}
