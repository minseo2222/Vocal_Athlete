/// U5b — 편차 분류 순수 함수 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/deviation.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

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

  test('N1 centsFromTarget — 같은 음 0, 한 옥타브 1200', () {
    expect(centsFromTarget(220, 220), 0);
    expect(centsFromTarget(440, 220), closeTo(1200, 0.01));
  });
}
