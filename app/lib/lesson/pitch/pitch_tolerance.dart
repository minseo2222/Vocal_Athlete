/// F1 — 음정 간격·숙련도별 cents 허용오차 순수 모듈 (Flutter import 없음).
///
/// 근거: 도약 폭이 클수록 인토네이션 변동이 자연히 커지므로 허용오차를 넓히고
/// (단, ±50 하드 상한), 숙련 단계(mastery)에서는 더 좁은 허용오차로 정밀도를
/// 요구한다. 이 값은 점수가 아니라 "다시?" 넛지의 트리거 임계값으로만 쓴다
/// (ADR-0002 정합: 정당화 없는 지시 cue/신호만).
library;

enum ToleranceLevel { introductory, mastery }

/// cents 허용오차 하드 상한(±). 어떤 간격·레벨도 이 값을 넘지 않는다.
const double kToleranceHardCapCents = 50;

// 간격(반음) → 허용오차(cents) 앵커. 사이는 단조 선형보간, 앵커 밖은 클램프.
// 3반음≈3도, 7반음=5도, 12반음=옥타브. 도약 폭↑ → 허용↑, mastery → 정밀↑.
const Map<int, double> _introductoryAnchors = {3: 35, 7: 40, 12: 50};
const Map<int, double> _masteryAnchors = {3: 20, 7: 25, 12: 30};

/// intervalSemitones 간격에서의 허용오차(cents, +값). level 앵커를 단조 선형보간.
/// 최소 앵커 미만은 최소값, 최대 앵커 초과는 최대값으로 클램프 후 ±50 상한 적용.
double toleranceCents(int intervalSemitones, ToleranceLevel level) {
  final anchors =
      level == ToleranceLevel.mastery ? _masteryAnchors : _introductoryAnchors;
  final keys = anchors.keys.toList()..sort();
  final lo = keys.first, hi = keys.last;
  double raw;
  if (intervalSemitones <= lo) {
    raw = anchors[lo]!;
  } else if (intervalSemitones >= hi) {
    raw = anchors[hi]!;
  } else {
    var a = lo;
    for (final k in keys) {
      if (k <= intervalSemitones) a = k;
    }
    final b = keys.firstWhere((k) => k > intervalSemitones);
    final t = (intervalSemitones - a) / (b - a);
    raw = anchors[a]! + t * (anchors[b]! - anchors[a]!);
  }
  return raw > kToleranceHardCapCents ? kToleranceHardCapCents : raw;
}
