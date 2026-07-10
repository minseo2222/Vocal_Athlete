# 피드백 반영 업데이트 기록 — 2026-06-16

> 목적: 외부 검토 피드백을 실제 문서·코드 체계에 반영한 내역을 남긴다.  
> 범위: 제품 루프, MVP 범위, 게임화, 안전 게이트, AI 분석, 개인정보, 지표, 문서 정합성, 최소 코드 반영.

## 1. 새로 추가한 문서

| 문서 | 추가 이유 |
|---|---|
| `docs/app/MVP-SCOPE.md` | 초급 V1 포함/제외 범위 고정 |
| `docs/app/PRODUCT-LOOP-SPEC.md` | 앱 실행→오늘 레슨→완료→복귀까지 실제 루프 정의 |
| `docs/app/GAMIFICATION-SPEC.md` | XP/streak/mission/badge를 보컬 안전형으로 변형 |
| `docs/verification/SAFETY-RELEASE-GATE.md` | HITL 사인오프와 강제 cap 구현을 canonical 출시 게이트로 연결 |
| `docs/app/SAFETY-RELEASE-GATE.md` | 기존/제품 문서 위치 호환용 포인터 |
| `docs/curriculum/SAFETY-RELEASE-GATE.md` | 커리큘럼 폴더용 포인터 |
| `docs/app/DATA-PRIVACY-SPEC.md` | 오디오/피치/표준샘플/analytics 데이터 처리 기준 정의 |
| `docs/app/METRICS-AND-EXPERIMENTS.md` | MVP 성공 지표와 실험 후보 정의 |
| `docs/research/EXTERNAL-RESEARCH-GAPS-2026-06-16.md` | 추가 외부 리서치 필요 영역 분리 |
| `docs/adr/0017-mvp-product-loop-safety-gate.md` | V1 범위·완료 무결성·안전 release gate 결정 고정 |
| `docs/UPDATE-VALIDATION-2026-06-16.md` | 업데이트 후 수행한 확인과 Flutter/Dart 미실행 제한 기록 |

## 2. 수정한 기존 문서

| 문서 | 수정 내용 |
|---|---|
| `CONTEXT-MAP.md` | 성악/가요 중급을 “미생성”에서 실제 문서 링크로 수정, 신규 product spec 연결 |
| `docs/app/APP-SPEC.md` | 초급 V1 안전 경고와 중급 고위험 출시 게이트를 분리, micro-onboarding 허용, 신규 사양 문서 연결 |
| `docs/app/AI-ANALYSIS.md` | V1 F0 기술을 ADR-0014/코드 기준으로 정정, 3분류/한국어 모음 AI는 정식 표시에서 실험 후보로 낮춤 |
| `docs/curriculum/CURRICULUM-REVIEW.md` | 중급 카드/레슨 수와 구현 상태 표현 정리, 과거 갭 기록을 현재 갭과 분리 |
| `docs/curriculum/HITL-SIGNOFF.md` | canonical safety gate 연결, 전문가 승인만으로 출시 불가함을 명시 |
| `docs/adr/0015-content-schema-normalized.md` | 피치 피드백 설명을 pYIN V1에서 현재 자기상관+신뢰 게이트 기준으로 정정 |
| `docs/adr/0016-trust-based-completion-no-time-gate.md` | “시간 게이트 없음”과 “entry 완료 버튼 숨김 가능”의 관계 명확화 |
| `docs/verification/verification-status.json` | safety prerequisite를 전문가+강제 cap+rollout 기준으로 갱신 |
| `app/lib/lesson/card_library.dart` | 상단 주석을 13카드 고정 표현에서 초급+중급 통합 라이브러리 표현으로 정정 |
| `app/lib/safety/safety_signoff.dart` | 사인오프만으로 일반 공개하지 않으며 hard cap/fallback 구현이 필요하다는 주석 추가 |

## 3. 반영된 핵심 의사결정

1. MVP는 초급 48레슨으로 고정한다.
2. 중급 장르 트랙은 코드/문서가 있어도 release flag와 safety gate 전까지 일반 공개하지 않는다.
3. 3분류 발성 AI와 한국어 모음 식별은 V1 정식 사용자 표시에서 제외하고 opt-in 실험 후보로 둔다.
4. 게임화는 고음·음량·sustain 경쟁이 아니라 안전 완료·쿨다운·복귀·표준샘플 기록을 보상한다.
5. 온보딩 없음은 긴 설문 없음이지, 첫 레슨의 30초 마이크/환경 안내 금지가 아니다.
6. 완료 기반 원칙은 유지하되, entry 단계에서 바로 완료하는 tap-through는 제품 루프상 줄인다.
7. 개인정보 기본값은 원음 오디오 서버 업로드 없음, 온디바이스 분석 우선이다.

## 4. 코드에 반영한 항목

| 항목 | 파일 | 상태 |
|---|---|---|
| entry 단계 완료 CTA 숨김 | `app/lib/lesson/lesson_screen.dart` | 반영됨 |
| CTA 문구를 단계별로 명확화 | `app/lib/lesson/lesson_screen.dart` | `본운동으로 가기` / `쿨다운으로 가기` |
| completion integrity 테스트 기대값 갱신 | `app/test/lesson_screen_widget_test.dart` | 반영됨 |
| 캘린더/저장 통합 테스트의 완료 흐름 수정 | `app/test/calendar_integration_test.dart`, `app/test/persistence_integration_test.dart` | 반영됨 |
| 안전 사인오프 주석 갱신 | `app/lib/safety/safety_signoff.dart` | 반영됨 |

## 5. 아직 구현이 필요한 항목

| 항목 | 문서 위치 | 구현 상태 |
|---|---|---|
| analytics 이벤트 | `METRICS-AND-EXPERIMENTS.md` | 구현 필요 |
| safety cap schema/runtime enforcement | `docs/verification/SAFETY-RELEASE-GATE.md` | 설계 추가, 코드 미구현 |
| pending 카드 fallback slot 치환 | `docs/verification/SAFETY-RELEASE-GATE.md` | 설계 필요 |
| 표준 샘플 저장/삭제 UI | `DATA-PRIVACY-SPEC.md` | 확인 필요 |
| Play Data Safety 준비 | `DATA-PRIVACY-SPEC.md` | 출시 전 필요 |
| 실기기 마이크 검증 | `docs/verification/DEVICE-MIC-VERIFICATION.md` | 사람 검증 필요 |

## 6. 다음 작업 순서

1. `METRICS-AND-EXPERIMENTS.md` 이벤트 중 MVP 필수 이벤트를 구현한다.
2. `DATA-PRIVACY-SPEC.md` 기준으로 표준 샘플 저장/삭제 정책을 UI에 반영한다.
3. `DEVICE-MIC-VERIFICATION.md`를 실제 Android 기기 3종 이상에서 수행한다.
4. 중급을 다룰 때는 `docs/verification/SAFETY-RELEASE-GATE.md`의 release state와 cap enforcement를 먼저 구현한다.
5. pending 카드 제외 시 코스 길이가 깨지지 않도록 fallback path를 설계한다.

