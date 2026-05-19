/// F1 SPIKE — naive autocorrelation F0 (throwaway accuracy, real pYIN = A1).
///
/// Pure, no I/O — seeds the swappable pitch-source seam (ADR-0014/0015 U4).
/// The spike measures *pipeline latency*, not pitch accuracy, so a crude
/// autocorrelation estimator is sufficient here.
library;

/// Estimate fundamental frequency (Hz) from a mono PCM frame.
/// Returns null if no clear period (silence / unvoiced).
double? estimateF0(List<double> samples, int sampleRate,
    {double minHz = 70, double maxHz = 1000}) {
  final n = samples.length;
  if (n < 64) return null;

  // DC removal.
  double mean = 0;
  for (final s in samples) {
    mean += s;
  }
  mean /= n;

  // Energy gate (skip silence).
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
