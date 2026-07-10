/// F3 — 세션 내·동일 기기 상대 공명 프록시 순수 도메인 (Flutter import 없음).
///
/// 폰의 절대 포먼트/공명 측정은 신뢰도가 낮다(연구: 절대값 D급). 그래서 절대 모음
/// DB를 만들지 않고, "같은 세션·같은 기기" 안에서 시도 간 *상대 변화*만 다룬다.
/// 두 지표(둘 다 외부 DSP에서 raw 주입 — 추출은 이 모듈 범위 밖):
///  - ring index: 2~4kHz 밴드 에너지(또는 spectral tilt) 경향의 상대값.
///  - clarity index: CPPS 경향의 상대값.
/// 어떤 절대값도 점수로 노출하지 않는다. 교차 기기·교차 세션 비교는 금지인데,
/// (1) 고 F0 구간에서 프록시가 불안정하고 (2) 기기 마이크/AGC bias 때문에 절대
/// 비교가 무의미하기 때문이다. 따라서 정규화는 단일 세션만 입력으로 받는다.
library;

import 'dart:math' as math;

/// 고 F0에서 공명 프록시 신뢰가 떨어지는 경계(Hz, 약 C5). 이상이면 불안정 플래그.
const double kHighF0InstabilityHz = 523;

/// 교차 세션/기기 공명 비교 시도를 막는 예외.
class CrossContextResonanceError implements Exception {
  CrossContextResonanceError(this.message);
  final String message;
  @override
  String toString() => 'CrossContextResonanceError: $message';
}

/// 한 시도의 raw 공명 프록시 측정치(외부 주입). 절대값 자체는 노출하지 않는다.
class ResonanceSample {
  const ResonanceSample({
    required this.attemptIndex,
    required this.ringRaw,
    required this.clarityRaw,
    this.f0Hz,
  });

  final int attemptIndex;

  /// 주입된 raw 2~4kHz 밴드 에너지/tilt 프록시.
  final double ringRaw;

  /// 주입된 raw CPPS 프록시.
  final double clarityRaw;

  /// 있으면 고 F0 불안정 플래그 판단에 사용.
  final double? f0Hz;

  Map<String, dynamic> toJson() => {
        'attemptIndex': attemptIndex,
        'ringRaw': ringRaw,
        'clarityRaw': clarityRaw,
        'f0Hz': f0Hz,
      };

  static ResonanceSample fromJson(Map<String, dynamic> j) => ResonanceSample(
        attemptIndex: (j['attemptIndex'] as int?) ?? 0,
        ringRaw: (j['ringRaw'] as num?)?.toDouble() ?? 0,
        clarityRaw: (j['clarityRaw'] as num?)?.toDouble() ?? 0,
        f0Hz: (j['f0Hz'] as num?)?.toDouble(),
      );
}

/// 단일 세션·단일 기기의 공명 샘플 모음(리포지토리). 세션 경계로 컨텍스트를 가둔다.
class ResonanceSession {
  const ResonanceSession({
    required this.sessionId,
    required this.deviceId,
    this.samples = const [],
  });

  final String sessionId;
  final String deviceId;
  final List<ResonanceSample> samples;

  ResonanceSession addSample(ResonanceSample sample) => ResonanceSession(
        sessionId: sessionId,
        deviceId: deviceId,
        samples: [...samples, sample],
      );

  Map<String, dynamic> toJson() => {
        'sessionId': sessionId,
        'deviceId': deviceId,
        'samples': [for (final s in samples) s.toJson()],
      };

  static ResonanceSession fromJson(Map<String, dynamic> j) => ResonanceSession(
        sessionId: (j['sessionId'] as String?) ?? '',
        deviceId: (j['deviceId'] as String?) ?? '',
        samples: [
          for (final s in (j['samples'] as List? ?? const []))
            ResonanceSample.fromJson(Map<String, dynamic>.from(s as Map)),
        ],
      );
}

/// 세션 내부에서만 의미 있는 상대 공명 변화. 절대값 아님, 점수 아님.
class RelativeResonance {
  const RelativeResonance({
    required this.attemptIndex,
    required this.ringDelta,
    required this.clarityDelta,
    required this.ringZ,
    required this.clarityZ,
    required this.f0Unstable,
  });

  final int attemptIndex;

  /// baseline(첫 시도) 대비 변화량.
  final double ringDelta;
  final double clarityDelta;

  /// 세션 평균/표준편차 기준 z-score(표준편차 0이면 0).
  final double ringZ;
  final double clarityZ;

  /// 고 F0 등으로 프록시 신뢰가 낮을 수 있는 시도 표시.
  final bool f0Unstable;
}

/// 교차 세션/기기 비교 시도를 명시적으로 차단한다. sessionId·deviceId가 모두
/// 같아야 하며, 다르면 [CrossContextResonanceError]. 절대 공명의 교차 컨텍스트
/// 비교는 기기 bias·고 F0 불안정으로 무의미하기 때문이다.
void assertSameContext(ResonanceSession a, ResonanceSession b) {
  if (a.sessionId != b.sessionId || a.deviceId != b.deviceId) {
    throw CrossContextResonanceError(
      '교차 세션/기기 공명 비교는 허용되지 않습니다.',
    );
  }
}

/// 단일 세션 내부 상대 정규화(순수). baseline은 첫 시도 델타, z-score는 세션
/// 평균/표준편차 기준. 입력이 단일 세션이라 교차 세션 정규화는 구조적으로 불가.
/// 빈 세션 → 빈 리스트, 단일 샘플 → 델타/z 모두 0.
List<RelativeResonance> normalizeWithinSession(ResonanceSession session) {
  final s = session.samples;
  if (s.isEmpty) return const [];

  final baseRing = s.first.ringRaw;
  final baseClarity = s.first.clarityRaw;
  final ringMean = _mean([for (final x in s) x.ringRaw]);
  final clarityMean = _mean([for (final x in s) x.clarityRaw]);
  final ringStd = _std([for (final x in s) x.ringRaw], ringMean);
  final clarityStd = _std([for (final x in s) x.clarityRaw], clarityMean);

  return [
    for (final x in s)
      RelativeResonance(
        attemptIndex: x.attemptIndex,
        ringDelta: x.ringRaw - baseRing,
        clarityDelta: x.clarityRaw - baseClarity,
        ringZ: ringStd == 0 ? 0 : (x.ringRaw - ringMean) / ringStd,
        clarityZ: clarityStd == 0 ? 0 : (x.clarityRaw - clarityMean) / clarityStd,
        f0Unstable: x.f0Hz != null && x.f0Hz! >= kHighF0InstabilityHz,
      ),
  ];
}

/// 세션 내 상대 ring 추세(정성). 절대값·점수 아님 — 사용자에게는 방향만.
enum ResonanceTrend { insufficient, declining, flat, improving }

/// z-score 기준 데드밴드. 이 이내 변화는 잡음으로 보고 flat 처리(추세 오인 방지).
const double kRingTrendDeadband = 0.5;

/// 세션 내 마지막 [recentWindow] 시도의 ring z-score 평균 부호로 추세를 판정한다.
/// 표본이 부족하면 insufficient. 같은 세션·기기 안에서만 의미가 있다.
ResonanceTrend sessionRingTrend(
  ResonanceSession session, {
  int recentWindow = 3,
}) {
  final rel = normalizeWithinSession(session);
  if (rel.length < recentWindow + 1) return ResonanceTrend.insufficient;
  final recent = rel.sublist(rel.length - recentWindow);
  final meanZ =
      recent.map((r) => r.ringZ).reduce((a, b) => a + b) / recent.length;
  if (meanZ > kRingTrendDeadband) return ResonanceTrend.improving;
  if (meanZ < -kRingTrendDeadband) return ResonanceTrend.declining;
  return ResonanceTrend.flat;
}

double _mean(List<double> xs) =>
    xs.isEmpty ? 0 : xs.reduce((a, b) => a + b) / xs.length;

double _std(List<double> xs, double mean) {
  if (xs.length < 2) return 0;
  final variance =
      xs.map((x) => (x - mean) * (x - mean)).reduce((a, b) => a + b) /
          xs.length;
  return math.sqrt(variance);
}
