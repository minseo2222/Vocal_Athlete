/// D1 — f0 특성화(현 자기상관 V1의 정량 거동). 합성 신호로 정확도·옥타브·null 측정.
///
/// 이 파일은 *현 상태를 문서화*하는 측정 하네스다(개선 목표가 아니라 reality 고정).
/// 출력 표는 docs/superpowers/specs의 결정 패킷으로 전사된다. 측정값 날조 ❌ — 전부 실측.
library;

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/f0.dart';

const _sr = 16000; // RecordingPitchSource sampleRate
const _n = 2048; // RecordingPitchSource frameSize

List<double> _sine(double f0, {int n = _n, int sr = _sr, double amp = 1.0}) =>
    [for (var i = 0; i < n; i++) amp * sin(2 * pi * f0 * i / sr)];

/// 배음 많은 신호(f0 + 2f0 + 3f0 + 4f0), 톱니파 비슷.
List<double> _harmonics(double f0, {int n = _n, int sr = _sr}) => [
      for (var i = 0; i < n; i++)
        sin(2 * pi * f0 * i / sr) +
            0.6 * sin(2 * pi * 2 * f0 * i / sr) +
            0.4 * sin(2 * pi * 3 * f0 * i / sr) +
            0.3 * sin(2 * pi * 4 * f0 * i / sr)
    ];

/// 잃어버린 기음(2f0·3f0만 강함, f0 성분 없음) — 옥타브 함정.
List<double> _missingFundamental(double f0, {int n = _n, int sr = _sr}) => [
      for (var i = 0; i < n; i++)
        sin(2 * pi * 2 * f0 * i / sr) + 0.8 * sin(2 * pi * 3 * f0 * i / sr)
    ];

/// SOVT 버즈 근사(립트릴/빨대): 피치 + 강배음 + 느린 진폭변조(~30Hz).
List<double> _sovtBuzz(double f0, {int n = _n, int sr = _sr}) => [
      for (var i = 0; i < n; i++)
        (1 + 0.5 * sin(2 * pi * 30 * i / sr)) *
            (sin(2 * pi * f0 * i / sr) + 0.5 * sin(2 * pi * 2 * f0 * i / sr))
    ];

List<double> _noise(int seed, {int n = _n}) {
  final r = Random(seed);
  return [for (var i = 0; i < n; i++) (r.nextDouble() * 2 - 1)];
}

double _cents(double est, double ref) => 1200 * (log(est / ref) / log(2));

void main() {
  // 측정 대상 f0(저~고음). C3=131, A3=220, A4=440, C5=523, A5=880.
  const fs = [110.0, 131.0, 165.0, 220.0, 330.0, 440.0, 523.0, 659.0, 880.0];

  test('CHAR1 깨끗한 사인 — f0별 cents 오차(정수 lag 양자화)', () {
    final rows = <String>[];
    var maxAbs = 0.0;
    for (final f in fs) {
      final est = estimateF0(_sine(f), _sr);
      final c = est == null ? double.nan : _cents(est, f);
      if (est != null && c.abs() > maxAbs) maxAbs = c.abs();
      rows.add('  sine ${f.toStringAsFixed(0)}Hz → '
          '${est?.toStringAsFixed(1) ?? "null"}Hz '
          '(${c.isNaN ? "null" : "${c >= 0 ? "+" : ""}${c.toStringAsFixed(0)}c"})');
    }
    // ignore: avoid_print
    print('[CHAR1 깨끗한 사인]\n${rows.join("\n")}\n  최대 |오차| ≈ ${maxAbs.toStringAsFixed(0)}c');
    // 개선 강제(I2): 모두 검출 + 포물선 보간 후 전 음역 |오차| < 10c.
    for (final f in fs) {
      expect(estimateF0(_sine(f), _sr), isNotNull, reason: '$f sine null');
    }
    expect(maxAbs, lessThan(10), reason: '보간 후 고음도 10c 이내여야');
  });

  test('CHAR2 배음많은/잃은기음/SOVT — 옥타브·검출 거동', () {
    String tag(double f, double? est) {
      if (est == null) return 'null';
      final r = est / f;
      if ((r - 0.5).abs() < 0.06) return '↓옥타브(½)';
      if ((r - 2).abs() < 0.12) return '↑옥타브(2×)';
      if ((r - 3).abs() < 0.18) return '3×';
      if ((r - 1).abs() < 0.06) return '정확';
      return 'x${r.toStringAsFixed(2)}';
    }

    final rows = <String>[];
    for (final f in [131.0, 220.0, 440.0]) {
      rows.add('  harmonics ${f.toStringAsFixed(0)} → ${tag(f, estimateF0(_harmonics(f), _sr))}');
      rows.add('  missingF0 ${f.toStringAsFixed(0)} → ${tag(f, estimateF0(_missingFundamental(f), _sr))}');
      rows.add('  sovtBuzz  ${f.toStringAsFixed(0)} → ${tag(f, estimateF0(_sovtBuzz(f), _sr))}');
    }
    // ignore: avoid_print
    print('[CHAR2 배음/잃은기음/SOVT]\n${rows.join("\n")}');
    // 배음많은 신호도 무언가는 반환(검출 시도) — 정확/옥타브는 표로 문서화.
    expect(estimateF0(_harmonics(220), _sr), isNotNull);
  });

  test('CHAR3 잡음·무음 — 신뢰 게이트(잡음 spurious 제거)', () {
    final noiseResults = [for (var s = 1; s <= 5; s++) estimateF0(_noise(s), _sr)];
    final nonNull = noiseResults.where((e) => e != null).length;
    // ignore: avoid_print
    print('[CHAR3 잡음/무음]\n  백색잡음 5프레임 → 검출(null아님) $nonNull/5: '
        '${noiseResults.map((e) => e?.toStringAsFixed(0) ?? "null").join(", ")}\n'
        '  무음 → ${estimateF0(List.filled(_n, 0), _sr) ?? "null"}');
    // 개선 강제(I1): NSDF clarity 신뢰 게이트 → 백색잡음은 전부 null(틀린 점 ❌).
    expect(nonNull, 0, reason: '신뢰 게이트로 잡음 spurious f0 제거');
    expect(estimateF0(List.filled(_n, 0), _sr), isNull); // 무음 null 유지.
  });
}
