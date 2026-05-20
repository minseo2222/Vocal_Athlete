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
}

void main() {
  testWidgets('P5 unvoiced reading (f0Hz=null) → no current dot painted',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(source: _UnvoicedOnlySource()),
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
        home: Scaffold(body: PitchDisplay(source: null)),
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
}
