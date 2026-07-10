/// F1 — 음정 간격·숙련도별 cents 허용오차 순수 모듈 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_tolerance.dart';

void main() {
  group('toleranceCents', () {
    test('F1.1 introductory 앵커: 3→35, 7→40, 12→50', () {
      expect(toleranceCents(3, ToleranceLevel.introductory), 35);
      expect(toleranceCents(7, ToleranceLevel.introductory), 40);
      expect(toleranceCents(12, ToleranceLevel.introductory), 50);
    });

    test('F1.2 mastery 앵커: 3→20, 7→25, 12→30', () {
      expect(toleranceCents(3, ToleranceLevel.mastery), 20);
      expect(toleranceCents(7, ToleranceLevel.mastery), 25);
      expect(toleranceCents(12, ToleranceLevel.mastery), 30);
    });

    test('F1.3 같은 간격에서 mastery는 항상 introductory보다 좁다', () {
      for (var s = 3; s <= 12; s++) {
        expect(
          toleranceCents(s, ToleranceLevel.mastery),
          lessThan(toleranceCents(s, ToleranceLevel.introductory)),
        );
      }
    });

    test('F1.4 간격이 커지면 허용오차는 단조 비감소', () {
      for (final lvl in ToleranceLevel.values) {
        for (var s = 3; s < 12; s++) {
          expect(
            toleranceCents(s + 1, lvl),
            greaterThanOrEqualTo(toleranceCents(s, lvl)),
          );
        }
      }
    });

    test('F1.5 앵커 사이 선형보간(introductory 5반음 → 37.5)', () {
      expect(toleranceCents(5, ToleranceLevel.introductory), closeTo(37.5, 1e-9));
      // mastery 5반음: 20 + (5-3)/(7-3)*(25-20) = 22.5
      expect(toleranceCents(5, ToleranceLevel.mastery), closeTo(22.5, 1e-9));
    });

    test('F1.6 최소 앵커 미만은 최소값으로 클램프', () {
      expect(toleranceCents(0, ToleranceLevel.introductory), 35);
      expect(toleranceCents(1, ToleranceLevel.mastery), 20);
    });

    test('F1.7 최대 앵커 초과는 ±50 하드 상한 이내', () {
      expect(toleranceCents(24, ToleranceLevel.introductory), 50);
      expect(toleranceCents(24, ToleranceLevel.mastery), 30);
      expect(
        toleranceCents(100, ToleranceLevel.introductory),
        lessThanOrEqualTo(kToleranceHardCapCents),
      );
    });
  });
}
