# 남은 작업 — 단일 인덱스 (as of 2026-07)

> 흩어진 상태 문서를 한곳에 모은 최신 인덱스. 상세는 각 링크 문서 참조.
> 스냅샷: Flutter 테스트 382 그린 · `analyze --fatal-infos` clean · `build apk --debug` 성공.
> 배선되어 실제 동작: 기능① 음정 허용오차, 기능② vocal dose 피드백(VFI·발성시간·회복 윈도우 배너),
> 기능③ 상대 공명 쿨다운 추세, A2 적신호 스크리닝→비차단 의뢰 배너. 커밋/푸시 미실행.

## A. 만들었지만 미연결 (dormant — 사인오프 대기)
- **Stage 0 집행 6종**(`gate_state.evaluateCardGate`·`safety_feature_flag.isFlagEnabled`·도즈 하드락
  `evaluateDoseHardLock/ForcedRest/WeeklyCap`·`evaluateSymptomLock`·`intensity_guard.evaluateIntensityGuard`)
  — 정의+단위테스트만, 앱 호출 0. **런타임 활성화는 "어떤 카드가 저강도 후보 vs 영구잠금"인가 임상·커리큘럼
  분류가 선행**(사인오프 영역, AI가 정하지 않음). 지금 비활성은 설계상 정답.
- 방어 심층은 확보: `test/manifest_safety_invariant_test.dart`가 사용자 대면 트랙에 pending/gated 카드
  유입을 빌드타임 차단. 상세: `verification/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md §단계 계획`.

## B. 검증 안 거친 것
| 항목 | 상태 | 주체 | 참조 |
|---|---|---|---|
| 실기기/실오디오(F0·공명 밴드에너지 노이즈 내성) | 미검증(전부 주입·합성) — **출시 전 필수** | 사람+기기 | `verification/DEVICE-MIC-VERIFICATION.md`, `VERIFICATION-STATUS.md`(v11, stale) |
| 임상 사인오프 placeholder 확정 | 미확정. 어긋난 3곳: ramp(12→≤1?)·잠금(24→48~72h?)·수술 look-back(6→8~12주?) | 후두과+SLP | `verification/CLINICAL-SIGNOFF-PACKET-2026.md` |
| 규제 카피 lint 범위 | 카드 문구만 자동(card_copy_lint). 화면 인라인 텍스트 미포함(현재 수동 클린) | 코드 가능 | `verification/CLINICAL-SIGNOFF-PACKET-2026.md §3` |
| a11y 소형 탭타깃 | "용어" 칩·pill류 높이 <48dp(레이아웃 조정 결정 필요) | 코드(판단) | — |
| 영속화 마이그레이션 실기기 | 신규 키 폴백만 테스트, 실기기 스키마 버전업 미검증 | 사람+기기 | — |
| 시각 회귀(골든) | 없음(키·문구 단언만) | 코드(선택) | — |
| VERIFICATION-STATUS.md 최신화 | v11(2026-06-20)로 최근 작업 미반영 | 코드/사람 | `verification/VERIFICATION-STATUS.md` |

## C. 확장 필요
1. **Stage 0 런타임 배선**(후보 카드 released 시): 게이트/캡/증상 하드락을 레슨 카드 렌더에 연결 — **사인오프 선행**.
2. **공명 추세 정밀화** — attempt 경계·실오디오 스무딩·clarity(CPPS) 보류분.
3. **발성시간 voiced-F0 실측**(현재 카드 기반 추정).
4. **음역 승격 ↔ 실제 확장 카드 연동.**
5. **가요 C카드(GY-15/16) 근거 업그레이드** — 외부 리서치(시김새 음향 비교·온디바이스 음정분산 정확도) 시.

## D. 주체 구분 (누가 하나)
- **사람/외부(코드 밖)**: 임상 사인오프(B), 실기기·실오디오 검증(B), 법무 카피·MFDS 분류(CLINICAL-SIGNOFF-PACKET §2),
  가요 외부 리서치(C5). → AI가 해결 불가.
- **지금 코드로 가능**(작고 안전한 순): ① 화면 인라인 카피까지 lint 확대 ② 소형 칩 탭타깃 48dp
  ③ VERIFICATION-STATUS 최신화 ④ 보류 확장 중 하나(공명 정밀화 등, 비용 큼).

## 관련 문서 인덱스
- 안전 기능 상태·제약: 메모리 `vocal-safety-system-features`, `gate-release-locked`.
- 게이트 거버넌스: `verification/GENRE-RELEASE-SIGNOFF.md`, `verification/SAFETY-RELEASE-GATE.md`.
- 사인오프 패킷·한국 경로·규제: `verification/CLINICAL-SIGNOFF-PACKET-2026.md`.
- enforced 구현 명세·단계: `verification/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md`(경로: research/) — 실제 위치
  `docs/research/ENFORCED-STAGE-IMPLEMENTATION-SPEC-2026.md`, `docs/research/GENRE-GATE-RELEASE-RESEARCH-2026.md`.
- 안전 집행 백로그(기존): `verification/backlog-safety-enforcement.md`.
- 검증 상태(stale): `verification/VERIFICATION-STATUS.md`, `verification/verification-status.json`.
