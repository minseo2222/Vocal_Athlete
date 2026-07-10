/// F3 — 2~4kHz 상대 밴드 에너지 추출(순수 DSP, no I/O). f0.dart와 같은 seam.
///
/// 절대 공명/포먼트는 폰에서 신뢰도가 낮으므로(연구 D급) 절대값·점수로 쓰지
/// 않는다. 같은 세션·같은 기기 안에서 시도 간 *상대 변화*의 raw 입력으로만 쓴다.
/// 2~4kHz 대역통과 RMS / 전체 RMS 비(보통 0~1). 값은 기기 마이크/AGC 응답에
/// 의존하므로 교차 기기·교차 세션 비교는 무의미(resonance_proxy가 구조적으로 차단).
library;

import 'dart:math' as math;

/// 모노 PCM 프레임의 2~4kHz 상대 밴드 에너지(대역통과 RMS / 전체 RMS).
/// RBJ 2차 대역통과(중심=√(low·high), Q=중심/대역폭)로 필터링 후 RMS 비를 낸다.
/// 무음·짧은 프레임은 0.
double relativeBandEnergy(
  List<double> samples,
  int sampleRate, {
  double lowHz = 2000,
  double highHz = 4000,
}) {
  final n = samples.length;
  if (n < 8) return 0;

  double mean = 0;
  for (final s in samples) {
    mean += s;
  }
  mean /= n;

  final centerHz = math.sqrt(lowHz * highHz);
  final bandwidthHz = highHz - lowHz;
  final q = centerHz / bandwidthHz;
  final w0 = 2 * math.pi * centerHz / sampleRate;
  final cosw = math.cos(w0);
  final alpha = math.sin(w0) / (2 * q);
  final a0 = 1 + alpha;
  // RBJ band-pass (constant 0 dB peak gain): b1=0.
  final b0 = alpha / a0;
  final b2 = -alpha / a0;
  final a1 = -2 * cosw / a0;
  final a2 = (1 - alpha) / a0;

  double x1 = 0, x2 = 0, y1 = 0, y2 = 0;
  double inEnergy = 0, bandEnergy = 0;
  for (var i = 0; i < n; i++) {
    final x = samples[i] - mean;
    final y = b0 * x + b2 * x2 - a1 * y1 - a2 * y2;
    x2 = x1;
    x1 = x;
    y2 = y1;
    y1 = y;
    inEnergy += x * x;
    bandEnergy += y * y;
  }
  if (inEnergy <= 0) return 0;
  final ratio = math.sqrt(bandEnergy / inEnergy);
  return ratio.isFinite ? ratio.clamp(0.0, 4.0) : 0;
}
