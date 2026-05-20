/// U5b — 편차 분류 순수 모듈 (Flutter import 없음).
///
/// PitchSource readings에서 *지속적 큰 편차*를 감지 → 선택형 "다시?" 넛지
/// 트리거 신호로 사용. ADR-0002 정합: 정당화 없는 *지시 cue*만 노출 책임.
library;

import 'dart:math' as math;

import 'pitch_source.dart';

enum DeviationDirection { flat, sharp, none }

/// 12-TET cents from target. f0Hz·targetHz > 0 전제.
double centsFromTarget(double f0Hz, double targetHz) =>
    1200 * (math.log(f0Hz / targetHz) / math.ln2);

({bool nudge, DeviationDirection direction}) classifyDeviation(
  Iterable<PitchReading> recent, {
  required double targetHz,
  double severeCents = 100,
  int windowN = 5,
  int severeMin = 3,
}) {
  final voiced = recent
      .where((r) => r.f0Hz != null && r.f0Hz! > 0)
      .map((r) => centsFromTarget(r.f0Hz!, targetHz))
      .toList();
  if (voiced.isEmpty) {
    return (nudge: false, direction: DeviationDirection.none);
  }
  final window =
      voiced.length <= windowN ? voiced : voiced.sublist(voiced.length - windowN);
  final severe = window.where((c) => c.abs() > severeCents).toList();
  if (severe.length < severeMin) {
    return (nudge: false, direction: DeviationDirection.none);
  }
  final mean = severe.reduce((a, b) => a + b) / severe.length;
  final dir = mean > 0 ? DeviationDirection.sharp : DeviationDirection.flat;
  return (nudge: true, direction: dir);
}
