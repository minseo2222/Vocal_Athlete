# GENRE-RELEASE-SIGNOFF — 고급 장르 Lab 출시 사인오프 절차

> 목적: 고급 장르 Lab(가요·뮤지컬·성악 등)을 사용자에게 공개하기 위한 **사람(HITL) 사인오프 절차**를 정의한다. 본 문서는 절차 스캐폴이며, 코드의 `kReleasedAdvancedGenres`(현재 비어 있음 = 전 장르 유지 모드)를 여는 단일 게이트와 연결된다.
>
> ⚠️ **AI 자가 승인 금지.** AI/에이전트는 `kReleasedAdvancedGenres`를 채우지 않는다. 아래 표는 사람 검토자만 채운다. 빈 채로 두는 것이 안전 기본값이다.

관련: `app/lib/progression/progression_state.dart`(`kReleasedAdvancedGenres`), `app/lib/safety/safety_signoff.dart`(`kSafetySignoff`), `docs/verification/SAFETY-RELEASE-GATE.md`(카드 단위 게이트), `docs/curriculum/HITL-SIGNOFF.md`.

## 1. 두 게이트의 관계

| 게이트 | 코드 | 단위 | 의미 |
|---|---|---|---|
| 카드 사인오프 | `kSafetySignoff` | 카드 | 개별 고위험 카드의 전문가 검토 결과 |
| 장르 출시 | `kReleasedAdvancedGenres` | 장르 | 한 장르 Lab 전체를 사용자에게 공개 |

**장르는 카드 게이트의 상위 게이트다.** 카드들이 사인오프돼도 장르 출시 게이트가 닫혀 있으면 그 장르는 유지 모드로 남는다. 반대로 장르를 열려면 그 장르의 고위험 카드가 **모두** 카드 게이트를 통과해야 한다.

## 2. 장르별 출시 전제 (모두 충족해야 함)

한 장르 `G`를 `kReleasedAdvancedGenres`에 추가하기 전에 다음을 전부 만족해야 한다.

- [ ] **C1. 카드 사인오프 완료** — `G`의 모든 `SafetyReview.pending` 카드가 `kSafetySignoff`에 유효 항목(reviewer·date·evidence)을 가진다.
- [ ] **C2. 강제 캡 구현·테스트** — 해당 카드들의 런타임 캡(maxRange·maxReps·maxSustainSec·maxSessionsPerWeek·minRestHours·stopSignals·fallbackCardId·killSwitchId)이 구현되고 테스트로 검증됨(SAFETY-RELEASE-GATE.md §3·§6).
- [ ] **C3. fallback 경로** — gate 미충족/캡 hit 시 슬롯이 안전 카드로 대체되어 코스 길이가 비정상적으로 짧아지지 않음.
- [ ] **C4. 기기 검증** — DEVICE-MIC-VERIFICATION.md 기준 충족(폰 신뢰 측정 = F0·타이밍·자기보고만 사용; 절대 음향지표 비노출).
- [ ] **C5. canary 관찰** — 제한 롤아웃에서 AE/stop-signal 지표가 임계 이하.
- [ ] **C6. 사람 롤아웃 승인** — 아래 §4 표에 검토자·일자·근거·결정이 기록됨.

하나라도 미충족이면 `G`는 출시하지 않는다(유지 모드 유지).

## 3. 장르별 고위험 카드 (C1 대상)

SAFETY-RELEASE-GATE.md §4와 동기화. 저위험 전용 카드(RB-/RK-/WC-/RA-) 장르는 고위험 카드가 없을 수 있다.

| 장르 | 사인오프 필요 고위험 카드 |
|---|---|
| 가요(Gayo) | GY-04, GY-05, GY-06, GY-09 |
| 뮤지컬(Musical) | IM-02, IM-03, IM-05, IM-12 |
| 성악(Classical) | CL-01, CL-08 |
| R&B/Soul, Rock, CCM, UserSong | (전용 저위험 카드 — 고위험 카드 없음. C2~C6만 적용) |

> 참고: 이번 사이클에 추가된 안전 카드(GY-10, CL-10·11·12, IM-13·14)는 `SafetyReview.none`으로, 사인오프 대상이 아니며 장르 출시 시 자동 노출된다.

## 4. 사인오프 기록 (사람만 작성)

장르를 열 때, 검토자가 아래 표에 한 줄을 채우고 동시에 `kReleasedAdvancedGenres`에 해당 `Genre`를 추가한다. 표가 비어 있으면 코드도 비어 있어야 한다(일치 불변식).

| 장르 | C1 | C2 | C3 | C4 | C5 | 검토자(전문가/SLP) | 일자(YYYY-MM-DD) | 근거 링크 | 결정 |
|---|---|---|---|---|---|---|---|---|---|
| _(예시)_ Gayo | ☐ | ☐ | ☐ | ☐ | ☐ | | | HITL-SIGNOFF.md#gayo | 보류 |

## 5. QA 수용 기준

- `kReleasedAdvancedGenres`가 비면 모든 고급 장르가 유지 모드다(현 상태).
- 표의 "결정=출시"인 장르와 `kReleasedAdvancedGenres`의 내용이 **정확히 일치**한다.
- 어떤 장르도 C1~C6 미충족 상태로 `kReleasedAdvancedGenres`에 들어가지 않는다.
- AI/자동화가 `kReleasedAdvancedGenres`를 수정한 흔적이 없다(사람 커밋만).

## 6. 철회(revoke)

AE/문제 발생 시 검토자는 해당 `Genre`를 `kReleasedAdvancedGenres`에서 제거하고 표의 결정을 "철회"로 바꾼다. 즉시 유지 모드로 복귀한다.

## 7. 연구 기반 해제 기준 (2026 안전 심의)

전체 근거·출처는 `docs/research/GENRE-GATE-RELEASE-RESEARCH-2026.md`. 다학제(후두의학·SLP·발성교육·규제) 심의 결론을 이 게이트에 반영한다.

### 7.1 판정: 조건부 가능, 기본 잠금(locked-by-default)
- 현 사양(F0·타이밍·자가보고만)에선 **기본 잠금 유지가 정답**. 폰은 손상 핵심 인자(SPL·포먼트·충돌응력·부종)를 측정 불가 → 앱은 위험을 **감지**할 수 없고 **노출 제한 + 자가보고 중단 유도**만 가능.
- 싱어 대상 **검증된 안전 보컬 도즈는 부재**(Zuim·Stewart·Titze, J Voice 2021·2023). 'enforced' 도즈 상한은 직접 근거 없는 보수적 외삽 — 해제의 최대 미해결 위험.
- **검증된 안전 기제는 사실상 전문가 핸드오프뿐**(NATS·PAVA·ASHA·VASTA 2024 합의). 비감독 고위험 일반화의 검증 경로 없음.

### 7.2 기법별 해제 가부
| 분류 | 기법 | 처리 |
|---|---|---|
| **사실상 차단(inherently blocked)** | 벨트 고강도, 통성 고강도, 하드 글로탈 온셋 | 무채점·전문가 부재에선 잠금 유지. 폰 측정 불가 + 안전 도즈 부재 |
| **저강도만 signedOff 후보** | 메사 디 보체(크레셴도-only), 트왱(저강도) | A1~A9 전부 충족 시에만 해제 경로 |
| **하드락** | 기존 병변·LPR·출혈위험·2주+ 쉰목소리·연하곤란·경부종괴·각혈·이통 | 사전 스크리닝 100% 차단 + 의료 의뢰(AAO-HNS) |

### 7.3 Go/No-Go 체크리스트(§2의 C1~C6을 구체화 — 측정 임계치·검증 주체)
- **A1 위험 문서화**: 6개 기법 위험·금기·기전 문서 + 후두과·SLP 서명.
- **A2 사전 스크리닝 하드락**: 적신호 1+ 양성 → 100% 차단 + 의료 의뢰.
- **A3 노출 상한**: 고강도 연속시간을 말하기 외삽치(≈17분/520 m)보다 더 보수적(세션당 수 분), 강제 휴식 ≥24h, 주간 빈도 제한.
- **A4 F0·타이밍 집행**: 범위·세션 길이·휴식 자동 제한 테스트.
- **A5 증상 기반 잠금**: VFI/EASE 컷오프 초과·통증·쉰목소리 자가보고 시 자동 잠금.
- **A6 동의·면책**, **A7 비의료기기 포지셔닝(질병/의료급 문구 0)**, **A8 카나리 ≤1% + 부작용 임계 미초과 시만 확대**, **A9 자동 롤백(revoked)**.
- 임계치(특히 A3·A5)는 **AI가 정하지 않는다** — 음성 SLP·후두과가 사인오프에서 설정.

### 7.4 현 코드에 이미 있는 'enforced' 부분 충족(참고)
직전 안전 작업으로 다음이 코드에 존재(완전 충족 아님, 부분 스캐폴드):
- A5 일부: VFI 자가체크(`VocalFatigueSelfCheck.needsEscalation`)·세션 발성시간 상한(`evaluateSessionPhonation`)·회복 윈도우(`recoveryStatusAfterHighLoadDays`)가 레슨 강도를 **낮춤**. 단 고위험 카드 **하드 잠금**은 아직 없음(장르 미출시라 무관) — released 시 하드락으로 강화 필요.
- A3 일부: `kBeginnerSessionPhonationCapSeconds`·`maxSustainSec`/`maxReps` 캡 스키마 존재. 고위험 기법 전용 보수 상한은 미설정(임상 사인오프 대기).
- 미구현: A2 사전 스크리닝, A4 F0 범위 집행, A6 동의·면책 UX, A8 카나리, A9 자동 롤백.

### 7.5 다음 단계는 사람
AI는 `kReleasedAdvancedGenres`·`kSafetySignoff`를 열지 않으며 A3·A5 임계치도 정하지 않는다. 다음 단계는 **후두과 전문의 + 음성 SLP(≥2인) + 스타일 보컬 교육자의 서면 사인오프**로, 그들이 임계치를 정하고 §4 표를 채운 뒤에만 후보 카드를 released 한다. **사인오프 패킷(파라미터 후보값·출처·한국 경로·규제 카피)**: `docs/verification/CLINICAL-SIGNOFF-PACKET-2026.md` — 임상가가 `safety_params.dart` 항목별로 `☐confirm/☐adjust`를 채우는 형태.

### 7.6 enforced 단계 구현 명세 (Stage 0 — 사인오프 불필요)
착수 가능 구현 설계는 `docs/research/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md`. **Stage 0**(임상 수치는 전부 `// SIGN-OFF REQUIRED` placeholder, 전부 잠근 채)에서 기계적 안전 장치를 미리 스캐폴드할 수 있다: GateState 가드, 피처플래그(fail-safe 잠금·≤1% 카나리·킬스위치·revoke), VocalLoadPolicy 도즈 하드락 승격, VocalFatigueSelfCheck 하드락 승격, A2 적신호 스크리닝, A4 F0 가드, 전체 테스트(고강도 belt/통성/하드글로탈은 어떤 상태에서도 unlock 안 됨을 단언). **본질적 한계**: SPL 부재로 "편한 음고 고강도 발성"은 감지 불가 → A4는 약한 F0 프록시뿐, 고강도는 영구 잠금. Stage 1(임상 사인오프)→2(enforced 카나리)→3(auto-revoke 상시)은 그 뒤.
