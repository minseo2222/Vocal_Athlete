/// F0(기본 주파수) 검출 — 자기상관 기반(ADR-0014 pYIN 자리 V1).
///
/// 순수, no I/O. PitchSource 구현체(MicPitchSource)가 프레임마다 호출.
/// 비차단 피드백(ADR-0002)이라 완벽 정확도가 V1 게이트 아님 — 정직하게
/// 명확한 주기가 없으면 null(무음/무성).
library;

/// 신뢰 임계(NSDF clarity). 이 미만이면 명확한 주기 없음 → null(틀린 점 ❌).
/// 순수 사인 ≈ 1.0, 백색잡음·언보이스드 ≪ 0.5. (ADR-0014 개정: 저신뢰 미표시)
const double kClarityThreshold = 0.5;

/// 모노 PCM 프레임에서 F0(Hz) 추정. 명확한 주기 없으면 null.
///
/// 정규화 자기상관(NSDF, McLeod): n(τ)=2·Σx_i·x_{i+τ} / Σ(x_i²+x_{i+τ}²).
/// 최대 NSDF가 [kClarityThreshold] 미만이면 저신뢰로 보고 null.
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

  // NSDF[lag] 산출. (NSDF는 τ0·2τ0·3τ0 모두에서 ≈1이라 전역최대는 옥타브-다운 위험)
  final lags = maxLag - minLag + 1;
  final nsdf = List<double>.filled(lags, 0);
  for (var lag = minLag; lag <= maxLag; lag++) {
    double acf = 0, e1 = 0, e2 = 0;
    for (var i = 0; i + lag < n; i++) {
      final a = samples[i] - mean;
      final b = samples[i + lag] - mean;
      acf += a * b;
      e1 += a * a;
      e2 += b * b;
    }
    final m = e1 + e2;
    nsdf[lag - minLag] = m <= 0 ? 0.0 : 2 * acf / m;
  }

  // 신뢰 게이트: 최대 clarity가 임계 미만이면(잡음·언보이스드) null.
  double peakMax = 0;
  for (final v in nsdf) {
    if (v > peakMax) peakMax = v;
  }
  if (peakMax < kClarityThreshold) return null;

  // McLeod 키-최대(MPM): peakMax의 90% 이상인 *첫* 로컬 최대 = 진짜 주기(옥타브-다운 방지).
  final thr = 0.9 * peakMax;
  int chosen = -1;
  for (var i = 1; i < lags - 1; i++) {
    if (nsdf[i] >= nsdf[i - 1] && nsdf[i] > nsdf[i + 1] && nsdf[i] >= thr) {
      chosen = i;
      break;
    }
  }
  if (chosen < 0) {
    for (var i = 0; i < lags; i++) {
      if (nsdf[i] > nsdf[chosen < 0 ? 0 : chosen]) chosen = i;
    }
    if (chosen < 0) chosen = 0;
  }
  return sampleRate / (minLag + chosen);
}
