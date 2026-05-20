/// C2 — 레슨 카드 모델(ADR-0015 핵심 필드).
///
/// V1 minimal: id + cue(지시문) + voicedMicroWin. anatomy/feedback/antiPatterns
/// /variableAxes/stopCues는 소비자 슬라이스(U3/U4/U5/C3)가 추가(YAGNI).
library;

class Card {
  const Card({
    required this.id,
    required this.cue,
    required this.voicedMicroWin,
    this.anatomyEntry = '',
    this.anatomyMain = '',
    this.anatomyCooldown = '',
    this.variableAxes = const {},
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
}
