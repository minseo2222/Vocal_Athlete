# P3 — 1일1레슨 캡

Status: ready-for-agent

## What to build

달력일 모델 + `did_today`. 하루에 *해금용 레슨 1개*만 완료 가능(ADR-0003). 같은 날 두 번째 완료 시도는 막힘(메시지는 P4가 정교화). 날짜 진행(다음날) 액션으로 `did_today` 리셋.

## Acceptance criteria

- [ ] 같은 날 2번째 완료 차단
- [ ] 다음날 진행 시 캡 해제
- [ ] 캡은 해금/스트릭 로직과 분리된 순수 규칙
- [ ] 단위테스트(같은날 2회, 다음날 1회)

## Blocked by

- 05-complete-unlock (P2)
