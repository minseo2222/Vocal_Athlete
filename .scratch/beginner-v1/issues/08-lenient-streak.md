# P5 — 관대 스트릭

Status: done — _streak 활동일 +1(비-캡 분기), advanceDay 불변(0리셋·freeze 없음), 해금/끝과 직교, TDD 5행동, analyze 클린·테스트 25/25 (2026-05)

## What to build

활동일마다 스트릭 +1. **0으로 리셋 없음, streak freeze 없음**(ADR-0010, 커리큘럼 §8.4 정합). 하루 놓쳐도 깨지지 않음 — 공백은 P6 복귀 복습이 처리. 가혹 페널티 일체 없음.

## Acceptance criteria

- [ ] 활동일에 +1
- [ ] 공백(1일~)에 0 리셋 안 됨
- [ ] freeze 개념 없음
- [ ] 단위테스트(연속·공백 후 재개)

## Blocked by

- 06-one-lesson-per-day-cap (P3)
