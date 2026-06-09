/// C2 — 레슨 카드 모델(ADR-0015 핵심 필드).
///
/// V1 minimal: id + cue(지시문) + voicedMicroWin. anatomy/feedback/antiPatterns
/// /variableAxes/stopCues는 소비자 슬라이스(U3/U4/U5/C3)가 추가(YAGNI).
library;

/// I1 — 안전 검토 상태(HITL-SIGNOFF). pending = 발성 전문가 사인오프 전이라
/// 기본 잠금(belt·트웽·패사지오처리·cover·messa·런). none = 안전 검토 불요.
enum SafetyReview { none, pending }

class Card {
  const Card({
    required this.id,
    required this.cue,
    required this.voicedMicroWin,
    this.anatomyEntry = '',
    this.anatomyMain = '',
    this.anatomyCooldown = '',
    this.variableAxes = const {},
    this.safetyReview = SafetyReview.none,
    this.targetHz,
  });

  final String id;
  final List<String> cue;
  final List<String> voicedMicroWin;
  // U3 — 레슨 해부 (ADR-0015). cards.md anatomy{entry,main,cooldown}.
  final String anatomyEntry;
  final String anatomyMain;
  final String anatomyCooldown;
  // C3 — 변주축(ADR-0015 variableAxes). 키=축, 값=후보 리스트. 비면 변주 없음.
  final Map<String, List<String>> variableAxes;
  // I1 — 안전 게이트(자가 승인 ❌). pending이면 사인오프 전 잠금(I5).
  final SafetyReview safetyReview;
  // 피치 — 카드별 목표음(Hz). null이면 목표 없음(타깃선·넛지 미표시, 점은 절대피치).
  final double? targetHz;
}
