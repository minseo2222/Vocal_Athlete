# P7 — 졸업 감지

Status: ready-for-agent

## What to build

경로 마지막 레슨 완료 → `graduated` 상태 진입. 졸업은 *시험이 아니라 경로 완주*(완주가 곧 4스킬 연습의 증명, ADR-0004). 졸업 후에는 신규 레슨 진행이 멈추고 전이(P8~P10)로 넘어간다.

## Acceptance criteria

- [ ] 마지막 레슨 완료 시 graduated=true
- [ ] 졸업 후 일반 do_lesson은 신규 전진 안 함
- [ ] 졸업 = 경로 완주로만 트리거(점수/시험 무관)
- [ ] 단위테스트

## Blocked by

- 05-complete-unlock (P2)
