/// F3 — 2~4kHz 상대 밴드 에너지 추출 순수 DSP 테스트.
library;

import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/resonance_band.dart';

const _fs = 16000;

List<double> _sine(double hz, {int n = 1024}) =>
    [for (var i = 0; i < n; i++) math.sin(2 * math.pi * hz * i / _fs)];

void main() {
  test('F3 대역 내(3kHz) 비 > 대역 밖(200Hz) 비', () {
    final inBand = relativeBandEnergy(_sine(3000), _fs);
    final outBand = relativeBandEnergy(_sine(200), _fs);
    expect(inBand, greaterThan(outBand));
    expect(inBand, greaterThan(0.5)); // 대역 내는 통과
    expect(outBand, lessThan(0.2)); // 대역 밖은 크게 감쇠
  });

  test('F3 무음/짧은 프레임 → 0', () {
    expect(relativeBandEnergy(List<double>.filled(1024, 0), _fs), 0);
    expect(relativeBandEnergy(const [0.1, 0.2], _fs), 0); // n<8
  });

  test('F3 비는 유한·음수 아님', () {
    final r = relativeBandEnergy(_sine(2828), _fs);
    expect(r.isFinite, isTrue);
    expect(r, greaterThanOrEqualTo(0));
  });
}
