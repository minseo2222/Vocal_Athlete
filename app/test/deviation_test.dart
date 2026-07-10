/// U5b — 편차 분류 순수 함수 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/deviation.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_tolerance.dart';

PitchReading _r(double? hz) =>
    PitchReading(f0Hz: hz, timestampSec: 0);

void main() {
  test('N3 classifyDeviation — direction sharp/flat by severe mean sign', () {
    final sharp = _r(440); // +1200
    final flat = _r(110); // -1200
    expect(
      classifyDeviation(List.filled(3, sharp), targetHz: 220).direction,
      DeviationDirection.sharp,
    );
    expect(
      classifyDeviation(List.filled(3, flat), targetHz: 220).direction,
      DeviationDirection.flat,
    );
  });

  test('N2 classifyDeviation — 3/5 severe → nudge:true, 2/5 → false', () {
    final severe = _r(440); // +1200 cents at target=220
    final ok = _r(220); // 0 cents
    expect(
      classifyDeviation(
        [severe, severe, severe, ok, ok],
        targetHz: 220,
      ).nudge,
      isTrue,
    );
    expect(
      classifyDeviation(
        [severe, severe, ok, ok, ok],
        targetHz: 220,
      ).nudge,
      isFalse,
    );
    expect(classifyDeviation([], targetHz: 220).nudge, isFalse);
    expect(
      classifyDeviation([_r(null), _r(null), _r(null)], targetHz: 220).nudge,
      isFalse,
    );
  });

  test('F1.8 tolerance 컨텍스트가 severe 임계값을 좁힌다', () {
    final mild = _r(227.77); // 220 기준 ≈ +60 cents
    // 컨텍스트 없음 → 기본 100: +60은 severe 아님 → 넛지 없음(하위호환).
    expect(
      classifyDeviation(List.filled(3, mild), targetHz: 220).nudge,
      isFalse,
    );
    // mastery 5도(7반음) 허용오차 ±25: +60은 severe → 넛지.
    expect(
      classifyDeviation(
        List.filled(3, mild),
        targetHz: 220,
        tolerance: (intervalSemitones: 7, level: ToleranceLevel.mastery),
      ).nudge,
      isTrue,
    );
  });

  test('N1 centsFromTarget — 같은 음 0, 한 옥타브 1200', () {
    expect(centsFromTarget(220, 220), 0);
    expect(centsFromTarget(440, 220), closeTo(1200, 0.01));
  });
}
