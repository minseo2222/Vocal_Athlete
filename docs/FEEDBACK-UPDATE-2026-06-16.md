# 피드백 반영 업데이트 로그 — 2026-06-16

> 입력: 프로젝트 전체 리뷰 피드백.  
> 목표: 문서 불일치 수정, MVP 범위 고정, 안전 게이트와 게임화/데이터 정책을 실행 가능한 사양으로 보강.  
> 상세 변경 기록: `docs/app/FEEDBACK-UPDATE-2026-06-16.md`.

## 1. 추가된 핵심 사양

| 문서 | 목적 |
|---|---|
| `docs/app/MVP-SCOPE.md` | V1 초급 MVP 포함/제외 범위 고정 |
| `docs/app/PRODUCT-LOOP-SPEC.md` | 앱 실행부터 다음날 복귀까지 학습 루프 정의 |
| `docs/app/GAMIFICATION-SPEC.md` | 보컬 안전형 XP/streak/mission/badge/nudge 설계 |
| `docs/verification/SAFETY-RELEASE-GATE.md` | HITL + 강제 cap + release flag 출시 조건 정의 |
| `docs/app/DATA-PRIVACY-SPEC.md` | 음성 녹음·피치·학습 데이터 저장/삭제/업로드 정책 |
| `docs/app/METRICS-AND-EXPERIMENTS.md` | retention, completion integrity, mic/pitch, safety 지표 정의 |
| `docs/research/EXTERNAL-RESEARCH-GAPS-2026-06-16.md` | 추가 외부 리서치 필요 영역과 우선순위 정리 |
| `docs/UPDATE-VALIDATION-2026-06-16.md` | 업데이트 후 수행한 확인/미수행 검증 기록 |

## 2. 수정된 핵심 문서

| 문서 | 수정 내용 |
|---|---|
| `CONTEXT-MAP.md` | 성악/가요 중급을 실제 문서 링크로 수정 |
| `docs/app/APP-SPEC.md` | 초급 V1 경고와 중급 고위험 출시 게이트 분리, micro-onboarding 허용 범위 명시 |
| `docs/app/AI-ANALYSIS.md` | V1 기술을 ADR-0014 기준으로 정정, 3분류/한국어 모음 AI는 실험 후보로 하향 |
| `docs/curriculum/CURRICULUM-REVIEW.md` | 중급 구현 상태와 과거 갭 기록을 분리, 다음 우선순위 갱신 |
| `docs/curriculum/HITL-SIGNOFF.md` | canonical safety gate 연결 및 stop signal 확장 후보 추가 |
| `docs/adr/0016-trust-based-completion-no-time-gate.md` | 시간 게이트 없음과 entry 완료 버튼 숨김 가능성의 관계 명확화 |
| `app/lib/lesson/card_library.dart` | 상단 주석을 실제 초급+중급 통합 카드 라이브러리 기준으로 수정 |

## 3. 이번 업데이트의 제품 판단

- V1은 초급 48레슨 중심으로 출시 범위를 좁힌다.
- 중급 문서와 구현은 존재해도, `pending` 고위험 카드는 release gate 전 일반 공개 대상이 아니다.
- 게임화는 경쟁형이 아니라 안전 완료·복귀·쿨다운·표준 샘플 기록을 보상한다.
- 음성 데이터는 local-first, 원음 서버 업로드 없음, 클라우드/모델 학습은 별도 opt-in 후 V2+로 둔다.
- 완료 기반 원칙은 유지하되, 본운동 cue를 보기 전 즉시 완료하는 tap-through는 제품 루프상 줄이며 코드에 entry 완료 CTA 숨김을 반영했다.

## 4. 다음 구현 이슈 제안

1. `analytics`: `main_step_entered`, `completed_under_60s`, `cooldown_entered` 이벤트 추가.
2. `card.dart` 또는 별도 policy map: `SafetyPolicy/SafetyCaps` 후보 스키마 추가, 수치는 전문가 확정 전 비워둠.
3. `path.dart`: pending 카드 제외 시 fallback slot 치환 로직 설계.
4. `settings`: 저장된 녹음/표준 샘플 삭제 UX 추가.
5. `tests`: safety gate + fallback + runtime cap enforcement 테스트 추가.
6. `device-results.md`: 실제 Android 기기 검증 결과 기록.
