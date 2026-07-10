/// Stage 0 — A4 IntensityGuard 테스트 (사각지대 문서화 포함).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/intensity_guard.dart';

List<({double? f0Hz, double tSec})> _seq(List<List<double?>> pts) =>
    [for (final p in pts) (f0Hz: p[0], tSec: p[1]!)];

void main() {
  test('S0 상한 이내·짧은 안정음 → withinGuard', () {
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [221, 0.1],
      [220, 0.2],
      [219, 0.3],
    ]));
    expect(r, GuardResult.withinGuard);
  });

  test('S0 음고 상한 초과 grace 지속 → blockedContinuation', () {
    // ceiling 523 초과(600)를 grace(300ms) 넘게 지속.
    final r = evaluateIntensityGuard(_seq([
      [600, 0],
      [600, 0.2],
      [600, 0.4], // 0.4s > 0.3s grace
    ]));
    expect(r, GuardResult.blockedContinuation);
  });

  test('S0 연속 sustain 초과 → blockedContinuation', () {
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [220, 1],
      [220, 2],
      [220, 3.5], // > maxSustain 3s 연속
    ]));
    expect(r, GuardResult.blockedContinuation);
  });

  test('S0 넓은 글라이드 → softWarn', () {
    // 220→440 옥타브(12반음 > 5), 2초에 걸쳐(ramp 6/s < 12) → block 아닌 warn.
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [440, 2],
    ]));
    expect(r, GuardResult.softWarn);
  });

  test('S0 급격 ramp → softWarn', () {
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [440, 0.05], // 12반음/0.05s = 240/s >> 12
    ]));
    expect(r, GuardResult.softWarn);
  });

  test('S0 무성 구간은 연속 run을 끊는다(잘못된 block 방지)', () {
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [220, 2],
      [null, 2.5], // 무성 → 리셋
      [220, 3],
      [220, 4], // 새 run 1s만 → sustain 미초과
    ]));
    expect(r, GuardResult.withinGuard);
  });

  test('S0 사각지대(문서화): 편한 음고 "고강도"는 감지되지 않는다', () {
    // 큰 소리(고강도)를 편한 중음(220Hz)으로 내면 F0는 상한·sustain·글라이드 모두
    // 정상이라 가드가 통과한다. SPL을 못 재므로 이 위험은 본질적으로 감지 불가 —
    // 이 테스트는 그 한계를 명시적으로 단언한다(고강도 영구 잠금의 핵심 이유).
    final r = evaluateIntensityGuard(_seq([
      [220, 0],
      [220, 0.5],
      [220, 1.0], // "loud at mid pitch" — 손상 위험이 있어도
    ]));
    expect(r, GuardResult.withinGuard); // 감지 안 됨(의도된 한계)
  });
}
