/// Stage 0 — A4 강도/F0 가드 (순수, Flutter import 없음).
///
/// **본질적 한계(정직):** SPL/EGG/CPPS 없어 강도·내전력·충돌응력을 측정할 수 없다.
/// 따라서 "편한 음고로 세게 벨팅"하는 고강도 시도는 **감지 불가** — 이 가드는 F0·타이밍으로
/// 가능한 약한 프록시(음고 상한·연속 sustain·글라이드 폭·ramp)만 본다. 마이크 게인을
/// SPL 대용으로 쓰지 않는다(무보정·거리·기기 의존). 임계치는 safety_params placeholder.
/// 근거: ENFORCED-...SPEC §A4.
library;

import 'dart:math' as math;

import 'safety_params.dart';

enum GuardResult { withinGuard, softWarn, blockedContinuation }

class IntensityGuard {
  const IntensityGuard({
    this.f0CeilingHz = kGuardF0CeilingHz,
    this.maxSustainSec = kGuardMaxSustainSec,
    this.maxGlideSemitones = kGuardMaxGlideSemitones,
    this.maxRampSemitonesPerSec = kGuardMaxRampSemitonesPerSec,
    this.f0GraceMs = kGuardF0GraceMs,
  });

  final double f0CeilingHz;
  final int maxSustainSec;
  final double maxGlideSemitones;
  final double maxRampSemitonesPerSec;
  final int f0GraceMs;
}

double _semitones(double a, double b) => 12 * (math.log(b / a) / math.ln2);

/// F0 시퀀스(무성=f0Hz null)에서 가장 심각한 가드 위반을 반환.
/// 음고 상한 grace 초과·연속 sustain 초과 → blockedContinuation;
/// 글라이드 폭·ramp 초과 → softWarn; 그 외 → withinGuard.
GuardResult evaluateIntensityGuard(
  List<({double? f0Hz, double tSec})> samples, {
  IntensityGuard guard = const IntensityGuard(),
}) {
  final graceSec = guard.f0GraceMs / 1000.0;
  var aboveCeilStart = -1.0;
  var voicedStart = -1.0;
  double? voicedMin, voicedMax;
  var prevF0 = -1.0, prevT = -1.0;
  var block = false, warn = false;

  for (final s in samples) {
    final f0 = s.f0Hz;
    final t = s.tSec;
    if (f0 == null || f0 <= 0) {
      // 무성 → 모든 연속 run 리셋.
      aboveCeilStart = -1;
      voicedStart = -1;
      voicedMin = null;
      voicedMax = null;
      prevF0 = -1;
      prevT = -1;
      continue;
    }
    if (voicedStart < 0) {
      voicedStart = t;
      voicedMin = f0;
      voicedMax = f0;
    } else {
      if (f0 < voicedMin!) voicedMin = f0;
      if (f0 > voicedMax!) voicedMax = f0;
    }
    // 연속 sustain 초과.
    if (t - voicedStart > guard.maxSustainSec) block = true;
    // 음고 상한 + grace.
    if (f0 > guard.f0CeilingHz) {
      if (aboveCeilStart < 0) aboveCeilStart = t;
      if (t - aboveCeilStart > graceSec) block = true;
    } else {
      aboveCeilStart = -1;
    }
    // 글라이드 폭(run 내 max/min).
    if (_semitones(voicedMin, voicedMax) > guard.maxGlideSemitones) {
      warn = true;
    }
    // ramp(연속 샘플 간 변화율).
    if (prevF0 > 0 && t > prevT) {
      final rate = _semitones(prevF0, f0).abs() / (t - prevT);
      if (rate > guard.maxRampSemitonesPerSec) warn = true;
    }
    prevF0 = f0;
    prevT = t;
  }
  if (block) return GuardResult.blockedContinuation;
  if (warn) return GuardResult.softWarn;
  return GuardResult.withinGuard;
}
