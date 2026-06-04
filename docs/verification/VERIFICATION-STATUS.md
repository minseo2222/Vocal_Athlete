# 인간 게이트 검증 상태 — 단일 소스 (W4)

> "사람이 결정·조치할 항목"의 현재 검증 상태를 한 곳에 모은 **사람용 요약**.
> 기계용 단일 소스는 [`verification-status.json`](verification-status.json).
> 두 파일과 라이브 코드의 정합은 **W5 하네스(`flutter test`)가 강제**한다 — 어느
> 세션·어느 사람이든 `flutter test`만 돌리면 이 표가 코드와 일치하는지 즉시 검증된다.

## 현재 상태 (2026-06-04)

| 항목 | 결정 주체 | 상태 | 단일 소스 | 해제 방법 |
|---|---|---|---|---|
| 안전 사인오프 | 발성 전문가(HITL) | 🔒 UNVERIFIED | `kSafetySignoff` (빈) | `safety_signoff.dart` 레코드에 검토자+일자+근거 추가 |
| 장르 롤아웃 | 롤아웃/안전 | 🔒 UNVERIFIED | `kReleasedGenres` (빈) | `progression_state.dart` config에 장르 추가 |
| 기기 마이크 검증 | 검증자(육안) | 🔒 UNVERIFIED | `device-results.md` | [체크리스트](DEVICE-MIC-VERIFICATION.md) 수행 후 결과 기록 |
| 고급/periodization | 설계+HITL | ⬜ OUT_OF_SCOPE | CURRICULUM-REVIEW G4·G5 | 의도적 범위 밖(별도 안전 설계 필요) |

기본은 전부 잠금/미검증 = **안전 기본값**. AI는 어느 것도 자가 결정하지 않는다.

## 세션-독립성이 보장되는 방식

1. **진실의 위치 = git에 박힌 산출물**: 사인오프=`kSafetySignoff`, 롤아웃=`kReleasedGenres`,
   기기=`device-results.md` + `verification-status.json`. 대화·메모리가 아니다.
2. **드리프트 차단**: W5가 이 JSON의 `signedOffCardIds`/`releasedGenres`를 라이브
   코드 상수와 대조 → JSON만 올리고 코드가 안 따르면(또는 반대) **테스트 실패**.
3. **재도출 1커맨드**: 신규 세션은 맥락 없이 `flutter test`로 현재 진실을 재확인.

## 갱신 규칙 (사람)

상태를 바꾸려면 **코드 산출물과 JSON을 함께** 갱신하고 커밋해야 한다(둘 중 하나만
바꾸면 W5 실패):

- **안전 카드 사인오프**: ① `kSafetySignoff`에 항목 추가(검토자/일자/근거)
  → ② JSON `safetySignoff.signedOffCardIds`에 같은 cardId 추가 + `stillGatedCardIds`에서 제거
  → ③ 전 카드 사인오프 시 `status: VERIFIED`.
- **장르 출시**: ① `kReleasedGenres`에 장르 추가 → ② JSON `releasedGenres`에 같은 이름 추가
  → ③ `status: VERIFIED`.
- **기기 검증**: ① `device-results.md`에 런 결과 append → ② JSON `deviceMic.status`를
  종합 결과(VERIFIED/FAIL→UNVERIFIED/BLOCKED)로 갱신.
- **고급/periodization**: 범위 진입 시 별도 안전 설계 ADR + HITL 후 본 표 갱신.

> ⚠️ AI는 위 ①(코드 상수)·기기 결과를 채우지 않는다. 사람만 채운다(자가 결정 금지).
> AI가 도울 수 있는 건 *채워진 사실을 JSON에 반영*하는 동기화뿐이며, 그조차 사람이
> 코드를 먼저 채운 뒤다.
