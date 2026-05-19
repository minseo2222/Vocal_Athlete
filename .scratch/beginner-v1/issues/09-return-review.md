# P6 — 복귀 복습

Status: ready-for-agent

## What to build

7일 이상 공백 후 복귀 시 *벌점·강등이 아니라* 복습 트레이닝 제공(ADR-0010). 복귀 첫 세션 = 복습 레슨이 *그날의 1레슨*(신규 해금은 다음날). 공백 길이별: 7–14일 → 복습 1일, >14일 → 복습 2일. 졸업일은 징벌 없이 자연 지연만. 스트릭은 0 리셋 안 됨(P5).

## Acceptance criteria

- [ ] gap≥7 → 복습 owed 계산(7–14→1, >14→2)
- [ ] 복귀일 do_lesson = 복습 소비(신규 해금 아님)
- [ ] 복습 소진 후 다음날부터 신규 정상 진행
- [ ] 스트릭 유지(0 리셋 없음)
- [ ] 단위테스트(3일·8일·20일 공백)

## Blocked by

- 06-one-lesson-per-day-cap (P3)
- 08-lenient-streak (P5)
