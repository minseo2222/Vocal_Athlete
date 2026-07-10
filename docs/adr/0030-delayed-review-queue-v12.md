# ADR-0030 — Delayed Review Queue and Content Revision (v12)

## Status

Accepted — 2026-06-20

## Context

v11은 레슨 완료 시도 수, 자기점검, 녹음 수, best take 여부를 저장했지만, E2/E3에 해당하는 지연 재현과 조건 전이를 실제 일정 기반으로 다시 호출하지 않았다. 또한 콘텐츠 blueprint가 바뀌어도 과거 학습 기록이 어떤 버전에서 생성됐는지 구분하기 어려웠다.

## Decision

v12에서 다음을 추가한다.

1. `ReviewQueueItem`과 local-first `ReviewQueueRepository`.
2. completion 저장 시 `ReviewQueueScheduler`가 D+1 retention, 필요 시 D+3 transfer 과제를 예약한다.
3. `LearningEvidenceRecord`에 `contentRevision`을 추가한다.
4. `LessonPracticeSnapshot`에 `recordedTakeIds`, `bestTakeId`를 추가한다.
5. 설정 화면에서 `복습 큐`를 열 수 있게 한다.

## Non-goals

- 복습 큐를 해금 게이트로 쓰지 않는다.
- 복습 실패를 streak 손상으로 처리하지 않는다.
- E2/E3를 자동 성취 판정하지 않는다.
- 회복 모드 완료 후 유성 복습을 강제하지 않는다.

## Consequences

- 학습 기록은 completion과 retention/transfer 목표를 더 명확히 분리한다.
- 콘텐츠 revision이 남아 향후 blueprint 변경 전후 비교가 가능하다.
- 실제 알림, due task를 오늘 레슨에 삽입하는 UX, 사용자 효과 검증은 v13 이후 과제로 남는다.
