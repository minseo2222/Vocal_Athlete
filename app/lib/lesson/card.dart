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
    this.relativePitchTarget = false,
    this.toleranceIntervalSemitones,
    this.deferredVisualFeedback = false,
    this.timbreTags = const [],
    this.timbreLayer = 'none',
    this.toneTagOptions = const [],
    this.toneSequence = const [],
    this.toneGoal = '',
    this.allowsToneAB = false,
    this.requiresSameRecordingCondition = false,
    this.acousticFeedbackLevel = 'basic',
    this.safetyIntensity = 'low',
    this.maxReps,
    this.maxDurationSec,
    this.maxTakeCount,
    this.maxSustainSec,
    this.weeklyCap,
    this.requiredRestHours,
    this.fallbackCardId,
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
  // 피치 — 카드별 절대 목표음(Hz). null이면 절대 목표 없음.
  final double? targetHz;
  // 피치 — true면 세션 초반 안정 voiced F0를 오늘의 상대 기준선으로 잡는다.
  final bool relativePitchTarget;
  // 피치 — 이 카드가 훈련하는 음정 간격(반음). null이면 음정별 허용오차를 쓰지
  // 않고 기존 기본 임계값을 유지한다(pitch_tolerance.toleranceCents 참조).
  final int? toleranceIntervalSemitones;
  // 피드백 — true면 수행 중 그래프 노출을 줄이고, 시도 후 사용자가 열어본다.
  final bool deferredVisualFeedback;
  // 음색 — AI 판정 라벨이 아니라 사용자 자기 태그/카드 목표를 표현하는 안전 메타데이터.
  final List<String> timbreTags;
  // v15 — source / filter / style / learningSafety 중 어디를 훈련하는지 표시.
  // 사용자에게 해부학적 진단처럼 노출하지 않고 커리큘럼·검수 메타데이터로 사용한다.
  final String timbreLayer;
  // 사용자가 직접 선택할 수 있는 안전한 tone tag 후보.
  final List<String> toneTagOptions;
  // A/B/C 카드가 요구하는 순서. 예: bright→warm, clean→warm→speechLike.
  // 녹음 패널은 각 take의 기본 태그로 사용하며 정답 점수로 해석하지 않는다.
  final List<String> toneSequence;
  final String toneGoal;
  final bool allowsToneAB;
  final bool requiresSameRecordingCondition;
  // 음색 측정 노출 수준: basic=자기태그/기본 안내, ab=A/B 재생, internalOnly=연구 지표 숨김.
  final String acousticFeedbackLevel;
  // 안전 강도: low / moderate / high / gated. high 이상은 런타임 cap·HITL 필요.
  final String safetyIntensity;
  // 안전 cap — UI 문구뿐 아니라 runtime enforcement/backlog의 단일 스키마.
  final int? maxReps;
  final int? maxDurationSec;
  final int? maxTakeCount;
  final int? maxSustainSec;
  final int? weeklyCap;
  final int? requiredRestHours;
  // 사인오프 전 고위험 카드를 제거하지 않고 안전 대체 카드로 바꾸기 위한 ID.
  final String? fallbackCardId;
}


// R4 runtime safety-cap metadata.
extension CardRuntimeSafety on Card {
  bool get blocksWhenHoarse => safetyIntensity == 'moderate' || safetyIntensity == 'high' || safetyIntensity == 'gated';
}
