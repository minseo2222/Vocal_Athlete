/// PitchSource interface + StubPitchSource — ADR-0014 swappable seam.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

void main() {
  test('P2 StubPitchSource hovers within ±25Hz of targetHz', () async {
    final s = StubPitchSource(targetHz: 220.0,
        interval: const Duration(milliseconds: 1));
    final batch = await s.readings.take(20).toList();
    for (final r in batch) {
      expect(r.f0Hz, isNotNull);
      expect((r.f0Hz! - 220.0).abs(), lessThanOrEqualTo(25.0),
          reason: 'reading $r out of ±25Hz band');
    }
  });

  test('L1 PitchSource lifecycle — start/stop/dispose on stub', () async {
    final s = StubPitchSource();
    expect(await s.start(), isTrue); // stub: 항상 grant
    final r = await s.readings.first;
    expect(r.f0Hz, isNotNull);
    await s.stop();
    s.dispose();
  });

  test('P1 StubPitchSource emits at least one non-null reading', () async {
    final s = StubPitchSource();
    final first = await s.readings.first;
    expect(first.f0Hz, isNotNull);
  });
}
