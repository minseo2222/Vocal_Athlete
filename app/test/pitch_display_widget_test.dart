/// U4 — PitchDisplay widget consumes a PitchSource and renders.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_display.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

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

void main() {
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
}
