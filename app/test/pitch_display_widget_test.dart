/// U4 — PitchDisplay widget consumes a PitchSource and renders.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_display.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_tolerance.dart';

class _UnvoicedOnlySource implements PitchSource {
  @override
  Stream<PitchReading> get readings =>
      Stream<PitchReading>.value(const PitchReading(f0Hz: null, timestampSec: 0));
  @override
  Future<bool> start() async => true;
  @override
  Future<void> stop() async {}
  @override
  void dispose() {}
}

/// 일정한 f0를 주기적으로 내보내는 소스 — 통제된 편차 테스트용.
class _ConstantSource implements PitchSource {
  _ConstantSource(this.hz);
  final double hz;
  static const _interval = Duration(milliseconds: 5);
  @override
  Stream<PitchReading> get readings => Stream<PitchReading>.periodic(
        _interval,
        (i) => PitchReading(
          f0Hz: hz,
          timestampSec: i * _interval.inMilliseconds / 1000.0,
        ),
      );
  @override
  Future<bool> start() async => true;
  @override
  Future<void> stop() async {}
  @override
  void dispose() {}
}

/// f0 + ringRaw를 주기적으로 내보내는 소스 — onRingSample 배선 테스트용.
class _RingSource implements PitchSource {
  _RingSource(this.ring);
  final double ring;
  static const _interval = Duration(milliseconds: 5);
  @override
  Stream<PitchReading> get readings => Stream<PitchReading>.periodic(
        _interval,
        (i) => PitchReading(f0Hz: 220, timestampSec: i * 0.005, ringRaw: ring),
      );
  @override
  Future<bool> start() async => true;
  @override
  Future<void> stop() async {}
  @override
  void dispose() {}
}

void main() {
  testWidgets('F3 ringRaw가 있는 voiced 프레임 → onRingSample 보고', (tester) async {
    final rings = <double>[];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PitchDisplay(
          targetHz: 220,
          source: _RingSource(0.7),
          onRingSample: (ring, _) => rings.add(ring),
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 40));
    expect(rings, isNotEmpty);
    expect(rings.first, 0.7);
  });

  testWidgets('F3 ringRaw 없는 stub 소스 → onRingSample 미호출', (tester) async {
    var called = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PitchDisplay(
          targetHz: 220,
          source: StubPitchSource(interval: const Duration(milliseconds: 5)),
          onRingSample: (_, _) => called = true,
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 40));
    expect(called, isFalse);
  });

  testWidgets('N5 dismiss → nudge disappears and stays gone for instance',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              targetHz: 440,
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nudge-dismiss')));
    await tester.pump();
    expect(find.byKey(const Key('retry-nudge')), findsNothing);
    // 추가 reading 흘러도 재노출 ❌
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsNothing);
  });

  testWidgets('N4 sustained severe deviation → retry-nudge appears',
      (tester) async {
    // PitchDisplay target=220, stub target=440 → 모든 reading +1200 cents.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              targetHz: 440,
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60)); // ~10 readings
    expect(find.byKey(const Key('retry-nudge')), findsOneWidget);
  });

  testWidgets('P5 unvoiced reading (f0Hz=null) → no current dot painted',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(targetHz: 220, source: _UnvoicedOnlySource()),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
    expect(find.byKey(const Key('pitch-curve')), findsNothing); // 무성-only → 곡선 없음
  });

  testWidgets('P4 PitchDisplay with null source → target only, no current',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PitchDisplay(targetHz: 220, source: null)),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
  });

  testWidgets('P3 PitchDisplay with stub source → target + current rendered',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              interval: const Duration(milliseconds: 10),
            ),
          ),
        ),
      ),
    );
    // Allow the periodic stream to emit at least one reading.
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsOneWidget);
  });

  testWidgets('P7 targetHz null → 타깃선 미표시, 점은 절대피치로 표시',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: null, // 카드 목표음 없음
            source: StubPitchSource(
              interval: const Duration(milliseconds: 10),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsNothing);
    expect(find.byKey(const Key('pitch-current')), findsOneWidget);
  });

  testWidgets('PC1 voiced readings 누적 → pitch-curve + pitch-current 표시',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60)); // ≥2 voiced readings
    expect(find.byKey(const Key('pitch-curve')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsOneWidget);
  });

  testWidgets('R2 deferred feedback hides curve until user reveals',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            deferredFeedback: true,
            source: StubPitchSource(
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('reveal-pitch-feedback')), findsOneWidget);
    expect(find.byKey(const Key('pitch-target')), findsNothing);
    await tester.tap(find.byKey(const Key('reveal-pitch-feedback')));
    await tester.pump();
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
  });

  testWidgets(
      'F1 음정별 허용오차: 컨텍스트 없으면 +60 cents 무넛지, 있으면 넛지',
      (tester) async {
    // 220 기준 +60 cents 일정 입력(기본 임계 100 미만, introductory ±35 초과).
    Widget build({int? interval, ToleranceLevel? level}) => MaterialApp(
          home: Scaffold(
            body: PitchDisplay(
              targetHz: 220,
              source: _ConstantSource(227.76),
              toleranceIntervalSemitones: interval,
              toleranceLevel: level,
            ),
          ),
        );

    // 컨텍스트 없음 → 기본 100 → +60은 넛지 없음(하위호환).
    await tester.pumpWidget(build());
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsNothing);

    // introductory 3반음 허용오차 ±35 → +60은 severe → 넛지.
    await tester.pumpWidget(
      build(interval: 3, level: ToleranceLevel.introductory),
    );
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsOneWidget);
  });

  test('F1 음정 매칭 카드는 toleranceIntervalSemitones를 갖는다', () {
    expect(kCardLibrary['CARD-12']!.toleranceIntervalSemitones, 3);
    expect(kCardLibrary['CARD-26']!.toleranceIntervalSemitones, 3);
  });

  testWidgets('R2 relative target mode creates a session target line',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: null,
            relativeTargetMode: true,
            source: StubPitchSource(
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
  });

}
