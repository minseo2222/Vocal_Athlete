# ADR-0031 — Today 선택 복습, 복습 증거, 콘텐츠 해시 (v13)

- Status: Accepted
- Date: 2026-06-20

## Context

v12는 D+1/D+3 복습 task를 만들었지만 설정 화면에서만 접근할 수 있었고, task 완료 상태와 실제 수행 흔적이 분리되지 않았다. 또한 content revision은 사람이 읽는 문자열이라 cue/asset 변경을 안정적으로 식별하기 어려웠다.

## Decision

1. due 복습을 Today 화면에 선택 카드로 표시한다.
2. 복습은 정규 진도와 streak에 영향을 주지 않는다.
3. task 완료 전 `ReviewPracticeScreen`을 거친다.
4. 목 상태, 시도, 자기점검, 녹음, 이전 take 재생을 `ReviewEvidenceRecord`로 저장한다.
5. 쉰 느낌은 무성 복습 행동을 명시적으로 기록하고 다음 날로 재예약한다.
6. 첫 vertical slice JSON/rights 파일을 SHA-256 manifest로 고정한다.
7. revision이 다르면 과거·현재 수행을 직접 자동 점수 비교하지 않는다.
8. `SharedPreferencesAsync`는 새 ReviewEvidence 저장소에 사용하며, 기존 저장소 전체 이전은 별도 migration으로 다룬다.

## Consequences

- 복습 발견성이 높아지지만 daily loop에 강제 부담을 추가하지 않는다.
- E2/E3 목표와 실제 달성을 계속 분리한다.
- 콘텐츠 개정 전후 데이터 혼합 위험이 줄어든다.
- Flutter 실행 검증과 실기기 QA는 여전히 release blocker다.
