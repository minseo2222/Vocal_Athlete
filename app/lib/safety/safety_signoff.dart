/// W1 — 안전 카드 HITL 사인오프 레코드 (세션-독립 검증 단일 소스).
///
/// belt/트웽/cover/messa/런 등 고위험 카드(card.safetyReview == pending)는
/// 발성 전문가의 사람 검토(HITL-SIGNOFF.md) 없이는 코스에서 영구 잠금된다(I5).
/// 본 레코드는 *그 검토 결과를 git에 박는 단일 소스*다 — 대화·세션이 아니라
/// 체크인된 이 파일이 "어느 카드가 사인오프됐는가"의 진실이다.
///
/// 2026-06-16 업데이트: 이 파일의 사인오프만으로 일반 공개하지 않는다.
/// docs/verification/SAFETY-RELEASE-GATE.md의 강제 cap(음역·횟수·지속·주간·휴식)과
/// fallback/stop-signal 구현이 함께 필요하다.
///
/// ⚠️ AI 자가 승인 금지: AI는 이 맵을 채우지 않는다. 빈 채로 둔다.
///    사람 검토자만 검토자 신원·일자·근거를 적어 게이트를 연다.
library;

/// 한 안전 카드에 대한 사람 검토 사인오프. 세 필드가 모두 채워져야 유효(게이트 해제).
class SafetySignoff {
  const SafetySignoff({
    required this.reviewer,
    required this.date,
    required this.evidence,
  });

  /// 검토자 신원(발성 전문가/SLP 등). 비면 무효.
  final String reviewer;

  /// 사인오프 일자(YYYY-MM-DD). 비면 무효.
  final String date;

  /// 근거(HITL-SIGNOFF 패킷 항목·문서 링크). 비면 무효.
  final String evidence;

  /// 세 필드 모두 비어있지 않아야 유효한 사인오프. 공백만은 무효.
  bool get isValid =>
      reviewer.trim().isNotEmpty &&
      date.trim().isNotEmpty &&
      evidence.trim().isNotEmpty;
}

/// 체크인된 사인오프 레코드 (cardId → SafetySignoff). 기본 = 빈.
///
/// 빈 레코드면 모든 pending 카드가 잠금 유지 = 안전 기본값.
/// 사람이 HITL-SIGNOFF.md 검토 완료 후, 검토한 카드의 항목을 여기에 추가한다:
///
/// ```dart
/// const Map<String, SafetySignoff> kSafetySignoff = {
///   'IM-02': SafetySignoff(
///     reviewer: '홍길동(SLP)', date: '2026-06-04',
///     evidence: 'HITL-SIGNOFF.md#IM-02'),
/// };
/// ```
///
/// ⚠️ AI는 이 맵을 채우지 않는다(자가 승인 금지). 빈 채로 유지.
const Map<String, SafetySignoff> kSafetySignoff = {};
