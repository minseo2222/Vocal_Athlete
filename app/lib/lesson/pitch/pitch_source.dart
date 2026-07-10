/// U4 — PitchSource interface (ADR-0014 swappable seam).
///
/// Real F0 detection drops in behind the same interface; V1 uses on-device Dart F0.
/// Pure: no Flutter imports.
library;

class PitchReading {
  const PitchReading({
    required this.f0Hz,
    required this.timestampSec,
    this.ringRaw,
  });

  /// Estimated fundamental in Hz; null = unvoiced / low-confidence.
  /// Honest reporting (ADR-0014): nulls are surfaced, not hidden behind a guess.
  final double? f0Hz;
  final double timestampSec;

  /// 2~4kHz 상대 밴드 에너지(raw). 절대값 아님 — 세션 내 상대 추세 입력으로만.
  /// 실 마이크 소스만 채우고, stub/합성 소스는 null로 둔다.
  final double? ringRaw;
}

abstract class PitchSource {
  Stream<PitchReading> get readings;

  /// 캡처 시작. true=ready, false=권한 거부·장치 점유 등 실패.
  /// 호출자(_AppShell)가 false면 source를 표시 트리에서 빼거나 banner 처리.
  Future<bool> start();

  /// 캡처 중단. dispose 전 multiple stop/restart 허용.
  Future<void> stop();

  /// 리소스 해제. 이후 호출 금지.
  void dispose();
}

/// Synthetic source: deterministic wobble around `targetHz`. For UI iteration
/// and tests before A1 lands.
class StubPitchSource implements PitchSource {
  StubPitchSource({
    this.targetHz = 220.0,
    this.interval = const Duration(milliseconds: 50),
  });

  final double targetHz;
  final Duration interval;

  @override
  Stream<PitchReading> get readings =>
      Stream<PitchReading>.periodic(interval, _generate);

  // Stub은 권한·리소스 없음 — 모든 lifecycle hook은 no-op (success).
  @override
  Future<bool> start() async => true;

  @override
  Future<void> stop() async {}

  @override
  void dispose() {}

  PitchReading _generate(int i) => PitchReading(
        f0Hz: targetHz + ((i % 10) - 5) * 5.0,
        timestampSec: i * interval.inMilliseconds / 1000.0,
      );
}
