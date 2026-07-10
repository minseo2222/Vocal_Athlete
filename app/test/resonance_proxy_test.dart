/// F3 — 세션 내·동일 기기 상대 공명 프록시 순수 도메인 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/timbre/resonance_proxy.dart';

ResonanceSession _session(List<ResonanceSample> samples) => ResonanceSession(
      sessionId: 's1',
      deviceId: 'dev-A',
      samples: samples,
    );

ResonanceSample _s(int i, double ring, double clarity, {double? f0}) =>
    ResonanceSample(
      attemptIndex: i,
      ringRaw: ring,
      clarityRaw: clarity,
      f0Hz: f0,
    );

void main() {
  group('normalizeWithinSession', () {
    test('F3.1 빈 세션 → 빈 리스트', () {
      expect(normalizeWithinSession(_session(const [])), isEmpty);
    });

    test('F3.2 단일 샘플 → 델타/z 모두 0', () {
      final out = normalizeWithinSession(_session([_s(0, 5, 10)]));
      expect(out, hasLength(1));
      expect(out.first.ringDelta, 0);
      expect(out.first.clarityDelta, 0);
      expect(out.first.ringZ, 0);
      expect(out.first.clarityZ, 0);
    });

    test('F3.3 baseline(첫 시도) 대비 상대 델타', () {
      final out = normalizeWithinSession(_session([
        _s(0, 10, 4),
        _s(1, 13, 4),
        _s(2, 7, 4),
      ]));
      expect(out[0].ringDelta, 0);
      expect(out[1].ringDelta, 3); // 13-10
      expect(out[2].ringDelta, -3); // 7-10
    });

    test('F3.4 z-score는 세션 평균/표준편차 기준, 표준편차 0이면 0', () {
      final out = normalizeWithinSession(_session([
        _s(0, 5, 9),
        _s(1, 5, 9),
        _s(2, 5, 9),
      ]));
      // 모두 동일 → std 0 → z 0
      for (final r in out) {
        expect(r.ringZ, 0);
        expect(r.clarityZ, 0);
      }
    });

    test('F3.5 고 F0(≥C5) 시도는 불안정 플래그', () {
      final out = normalizeWithinSession(_session([
        _s(0, 5, 9, f0: 220),
        _s(1, 6, 9, f0: 600), // ≥523 → 불안정
      ]));
      expect(out[0].f0Unstable, isFalse);
      expect(out[1].f0Unstable, isTrue);
    });
  });

  group('교차 컨텍스트 차단', () {
    test('F3.6 동일 세션·기기는 통과', () {
      final a = _session(const []);
      final b = _session(const []);
      expect(() => assertSameContext(a, b), returnsNormally);
    });

    test('F3.7 다른 세션이면 CrossContextResonanceError', () {
      final a = _session(const []);
      const b = ResonanceSession(sessionId: 's2', deviceId: 'dev-A');
      expect(
        () => assertSameContext(a, b),
        throwsA(isA<CrossContextResonanceError>()),
      );
    });

    test('F3.8 다른 기기면 CrossContextResonanceError', () {
      final a = _session(const []);
      const b = ResonanceSession(sessionId: 's1', deviceId: 'dev-B');
      expect(
        () => assertSameContext(a, b),
        throwsA(isA<CrossContextResonanceError>()),
      );
    });
  });

  group('sessionRingTrend', () {
    ResonanceSession trend(List<double> rings) => ResonanceSession(
          sessionId: 's1',
          deviceId: 'dev-A',
          samples: [
            for (var i = 0; i < rings.length; i++)
              ResonanceSample(attemptIndex: i, ringRaw: rings[i], clarityRaw: 0),
          ],
        );

    test('F3.10 표본 부족 → insufficient', () {
      expect(sessionRingTrend(trend([1, 2])), ResonanceTrend.insufficient);
    });

    test('F3.11 상승 추세 → improving', () {
      expect(
        sessionRingTrend(trend([1, 2, 3, 4, 5])),
        ResonanceTrend.improving,
      );
    });

    test('F3.12 하강 추세 → declining', () {
      expect(
        sessionRingTrend(trend([5, 4, 3, 2, 1])),
        ResonanceTrend.declining,
      );
    });

    test('F3.13 변화 미미 → flat(데드밴드)', () {
      expect(
        sessionRingTrend(trend([2, 2, 2, 2, 2])),
        ResonanceTrend.flat,
      );
    });
  });

  group('직렬화', () {
    test('F3.9 세션 json round-trip', () {
      final session = _session(const [])
          .addSample(_s(0, 10, 4, f0: 220))
          .addSample(_s(1, 13, 5));
      final back = ResonanceSession.fromJson(session.toJson());
      expect(back.sessionId, 's1');
      expect(back.deviceId, 'dev-A');
      expect(back.samples, hasLength(2));
      expect(back.samples[0].ringRaw, 10);
      expect(back.samples[0].f0Hz, 220);
      expect(back.samples[1].clarityRaw, 5);
      expect(back.samples[1].f0Hz, isNull);
      // 복원본 정규화도 동일하게 동작.
      final out = normalizeWithinSession(back);
      expect(out[1].ringDelta, 3);
    });
  });
}
