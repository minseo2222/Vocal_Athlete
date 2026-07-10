/// Stage 0 — 고위험 게이트 상태 모델과 카드 잠금 가드 (Flutter import 없음).
///
/// 게이트 상태: none→pending→signedOff→enforced→released→revoked.
/// 핵심 안전 불변식:
///  1) 영구 잠금 기법(고강도 belt/통성/hard glottal)은 **어떤 상태에서도 unlock 안 됨**
///     — 폰이 안전 실행을 검증할 수 없어 아예 교습하지 않는다(차단이 아니라 미제공).
///  2) 후보(저강도 트왱·메사)도 enforced/released + 피처플래그 통과 시에만 unlock.
///  3) 기본값은 잠금(locked-by-default). revoked·미지정·미응답은 모두 잠금.
/// 근거: docs/research/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md.
library;

enum GateState { none, pending, signedOff, enforced, released, revoked }

/// 검증 불가라 영구 잠금인 고강도 기법 식별자. Stage 0에선 식별자 집합으로 둔다
/// (실제 카드 매핑은 임상·커리큘럼 사인오프 결정 — 여기서 확정하지 않음).
const Set<String> kPermanentlyLockedTechniques = {
  'belt_high',
  'chest_dominant_high', // 통성 고강도
  'hard_glottal_onset',
};

enum CardLockState { locked, unlocked }

/// 카드 한 장의 잠금 여부. 영구 잠금이 최우선, 그다음 후보 여부, 그다음 게이트/플래그.
/// 신호가 없거나 모호하면 항상 잠금(보수적 기본값).
CardLockState evaluateCardGate({
  required GateState gateState,
  required bool flagEnabled,
  required bool isCandidate,
  required bool isPermanentlyLocked,
}) {
  // (1) 영구 잠금은 무조건 — 어떤 게이트 상태·플래그도 무시.
  if (isPermanentlyLocked) return CardLockState.locked;
  // (2) 후보로 지정되지 않으면 잠금(기본).
  if (!isCandidate) return CardLockState.locked;
  // (3) 후보: enforced 또는 released + 플래그 통과여야 unlock. revoked·그 외는 잠금.
  final stageOk =
      gateState == GateState.enforced || gateState == GateState.released;
  if (stageOk && flagEnabled) return CardLockState.unlocked;
  return CardLockState.locked;
}
