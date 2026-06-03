/// F0(기본 주파수) 검출 — 자기상관 기반(ADR-0014 pYIN 자리 V1).
///
/// 순수, no I/O. PitchSource 구현체(MicPitchSource)가 프레임마다 호출.
/// 비차단 피드백(ADR-0002)이라 완벽 정확도가 V1 게이트 아님 — 정직하게
/// 명확한 주기가 없으면 null(무음/무성).
library;

/// 모노 PCM 프레임에서 F0(Hz) 추정. 명확한 주기 없으면 null.
double? estimateF0(List<double> samples, int sampleRate,
    {double minHz = 70, double maxHz = 1000}) {
  final n = samples.length;
  if (n < 64) return null;

  // DC 제거.
  double mean = 0;
  for (final s in samples) {
    mean += s;
  }
  mean /= n;

  // 에너지 게이트(무음 skip).
  double energy = 0;
  for (final s in samples) {
    final v = s - mean;
    energy += v * v;
  }
  if (energy / n < 1e-6) return null;

  final maxLag = (sampleRate / minHz).floor().clamp(1, n - 1);
  final minLag = (sampleRate / maxHz).floor().clamp(1, maxLag);

  double bestCorr = 0;
  int bestLag = 0;
  for (var lag = minLag; lag <= maxLag; lag++) {
    double corr = 0;
    for (var i = 0; i + lag < n; i++) {
      corr += (samples[i] - mean) * (samples[i + lag] - mean);
    }
    if (corr > bestCorr) {
      bestCorr = corr;
      bestLag = lag;
    }
  }
  if (bestLag == 0 || bestCorr <= 0) return null;
  return sampleRate / bestLag;
}
