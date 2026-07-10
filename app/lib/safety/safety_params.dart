/// Stage 0 — 안전 집행 파라미터 단일 출처 (Flutter import 없음).
///
/// ⚠️ "SIGN-OFF REQUIRED" 표시 값은 **임상(SLP/후두과) 사인오프 전 확정값이 아니다** —
///    코드가 컴파일·테스트되도록 둔 보수적 placeholder일 뿐이다. AI/엔지니어가 임상
///    임계치를 확정하지 않는다. 실제 enforced 출시는 이 값들이 사인오프된 뒤에만.
///    근거·구분은 docs/research/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md (§E 파라미터 표).
///    후보값·출처·확정칸(☐confirm/☐adjust)은 docs/verification/CLINICAL-SIGNOFF-PACKET-2026.md.
///    ⚠️ 사인오프 시 우선 조정 후보(현 placeholder가 리서치 보수 방향과 어긋남):
///       kGuardMaxRampSemitonesPerSec(12 → ≤1?), kSymptomLockoutHours(24 → 48~72?),
///       kScreenSurgeryLookbackWeeks(6 → 8~12?). (전부 잠긴 상태라 현재 사용자 영향 0.)
///
/// VFI 컷오프(F1≥24/F2≥7/F3≤7)는 vocal_recovery.dart의 kVfiFactor*Cutoff 참조(중복 정의 금지) —
/// 이 또한 출판 참조값(Nanjundeswaran 2015)으로 한국 인구 검증 전까지 SIGN-OFF REQUIRED.
library;

// ── A2 사전 스크리닝 ───────────────────────────────────────────────────────
const int kScreenSurgeryLookbackWeeks = 6; // SIGN-OFF REQUIRED
const int kScreenRescreenDays = 30; // SIGN-OFF REQUIRED (engineer-proposable)
const int kScreenHoarsenessPersistDays = 14; // SIGN-OFF REQUIRED (보수적 2주)

// ── A3 도즈 ────────────────────────────────────────────────────────────────
const int kDoseMinRestSec = 10; // SIGN-OFF REQUIRED (rep 간 최소 휴식)
const double kDoseHighF0Hz = 440; // SIGN-OFF REQUIRED (고음 경계 — 음성타입별 재설정)

// ── A4 강도/F0 가드 ────────────────────────────────────────────────────────
const double kGuardF0CeilingHz = 523; // SIGN-OFF REQUIRED (음성타입별 ~C5)
const int kGuardMaxSustainSec = 3; // SIGN-OFF REQUIRED
const double kGuardMaxGlideSemitones = 5; // SIGN-OFF REQUIRED
const double kGuardMaxRampSemitonesPerSec = 12; // SIGN-OFF REQUIRED
const int kGuardF0GraceMs = 300; // SIGN-OFF REQUIRED

// ── A5 증상 잠금 ───────────────────────────────────────────────────────────
const int kSymptomVfcSoft = 5; // SIGN-OFF REQUIRED (경량 자가체크 0~10)
const int kSymptomVfcHard = 8; // SIGN-OFF REQUIRED
const int kSymptomHoarseDays = 3; // SIGN-OFF REQUIRED
const int kSymptomLockoutHours = 24; // SIGN-OFF REQUIRED (반복 시 72h)
const int kSymptomReferralCount = 3; // SIGN-OFF REQUIRED

// ── A8 카나리 (구조는 엔지니어/제품, "심각 부작용"·halt율은 SIGN-OFF) ──────
const double kCanaryStartRolloutPercent = 0.01; // 엔지니어 결정(≤1% 시작)
const int kCanaryObservationDays = 14; // 제품 제안
const double kCanaryAdverseHaltRate = 0.05; // SIGN-OFF REQUIRED (임상 동의)
