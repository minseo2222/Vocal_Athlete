# 신규 세션 재검증 — 맥락 없이 1커맨드로 진실 재도출 (V)

> 이 대화·이 세션을 전혀 모르는 사람(또는 새 AI 세션)이, 인간 게이트 항목의 현재
> 진실을 *정확히* 재확인하는 절차. 필요한 건 git 체크아웃 + 아래 두 가지뿐이다.

## 30초 요약

```
cd "C:\Users\user\Desktop\new_pro_v\pro v new\app"
C:/src/flutter/bin/flutter.bat test test/verification_harness_test.dart
```

- **PASS** = 단일 소스([`verification-status.json`](verification-status.json))가 라이브
  코드와 정합. 그 JSON/[요약표](VERIFICATION-STATUS.md)를 *그대로 신뢰*하면 된다.
- **FAIL** = 누군가 코드나 JSON 한쪽만 바꿔 드리프트 발생. JSON을 믿지 말고 실패
  메시지가 가리키는 불일치를 사람이 해소해야 한다.

이게 세션 독립의 핵심이다: 진실은 대화 기억이 아니라 *체크인된 산출물 + 통과하는 테스트*다.

## 무엇이 어디서 결정되는가 (진실의 위치)

| 항목 | 진실의 단일 소스(git) | 기본값 | 누가 바꾸나 |
|---|---|---|---|
| 안전 사인오프 | `app/lib/safety/safety_signoff.dart` `kSafetySignoff` | 빈=전 카드 잠금 | 발성 전문가(HITL) |
| 장르 롤아웃 | `app/lib/progression/progression_state.dart` `kReleasedAdvancedGenres`/`kReleasedGenres` | 빈=전 장르 유지 | 롤아웃/안전 결정자 |
| 기기 마이크 | `docs/verification/device-results.md` | UNVERIFIED | 검증자(육안) |
| 고급/periodization | `docs/curriculum/CURRICULUM-REVIEW.md` G4·G5 | OUT_OF_SCOPE | 설계+HITL |

## 전체 재검증(권장)

```
cd "C:\Users\user\Desktop\new_pro_v\pro v new\app"
C:/src/flutter/bin/flutter.bat test     # 전 테스트 green = 게이트/라우팅/정합 전부 일치
C:/src/flutter/bin/flutter.bat analyze  # No issues found!
```

해당 테스트가 강제하는 불변식:
- `safety_signoff_test.dart` — 빈 레코드=전부 잠금, 유효 사인오프 1건=그 카드만 해제, 검토자명 누락=무효.
- `release_config_test.dart` — beginner/fromJson이 config를 권위로 읽음(persisted 무시).
- `verification_harness_test.dart` (W5) — JSON 단일 소스 ↔ 라이브 상수 정합(드리프트 차단).
- `card_library_test.dart` I1.2 — pending 안전 카드 플래그 고정.
- `manifest_safety_invariant_test.dart` — 사용자 대면 트랙(초급·코어·곡적용)에 pending/gated 고위험 카드 유입 차단(방어 심층).
- `card_copy_lint_test.dart` — 카드 사용자 문구에 의료기기 전환 트리거(진단·치료·위험도·의료급 등) 금지(무점수·비진단 포지셔닝).
- `global_lock_invariant_test.dart` — belt/통성/hard-glottal는 어떤 게이트·플래그 상태에서도 unlock 안 됨.

> **남은 작업**(미연결·미검증·확장)의 단일 최신 인덱스: [`../REMAINING-WORK.md`](../REMAINING-WORK.md).
> enforced Stage 0 임상 사인오프 절차·후보값: [`CLINICAL-SIGNOFF-PACKET-2026.md`](CLINICAL-SIGNOFF-PACKET-2026.md).

## 각 항목을 "수행됨"으로 올리는 법 (사람)

[VERIFICATION-STATUS.md](VERIFICATION-STATUS.md) §갱신 규칙 참조. 요점: **코드 상수와
JSON을 함께** 갱신해야 한다. 한쪽만 바꾸면 W5가 실패시켜 거짓 통과를 막는다.

- 안전: `kSafetySignoff`에 사람 검토자+일자+근거 추가 → JSON 동기화. (AI 자가 승인 ❌)
- 롤아웃: `kReleasedAdvancedGenres`에 장르 추가 → JSON 동기화. (AI 자가 롤아웃 ❌)
- 기기: [DEVICE-MIC-VERIFICATION.md](DEVICE-MIC-VERIFICATION.md) 수행 → `device-results.md`
  기록 → JSON `deviceMic.status` 갱신.

## 왜 세션이 바뀌어도 정확한가

1. 모든 결정의 진실이 **git에 박힌 파일**(코드 상수·결과 로그)이다 — 대화·메모리 0 의존.
2. **W5가 단일 소스와 코드의 정합을 강제** → 요약 문서가 코드와 어긋나면 즉시 테스트 실패.
3. 그래서 신규 세션은 *읽고 추측*하지 않고 *돌려서 확인*한다 — `flutter test` 결과가 진실.
