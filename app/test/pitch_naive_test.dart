import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/spike/pitch_naive.dart';

void main() {
  test('estimateF0 recovers a synthetic sine within 5%', () {
    const sr = 16000;
    const f = 220.0; // A3
    final samples = List<double>.generate(
        2048, (i) => sin(2 * pi * f * i / sr));
    final est = estimateF0(samples, sr);
    expect(est, isNotNull);
    expect((est! - f).abs() / f, lessThan(0.05));
  });

  test('estimateF0 returns null on silence', () {
    final est = estimateF0(List<double>.filled(2048, 0), 16000);
    expect(est, isNull);
  });
}
