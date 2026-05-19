# C2 — 콘텐츠 경로 배선

Status: ready-for-agent

## What to build

C1의 13카드·5블록 콘텐츠를 P1 경로 모델에 배선해 플레이스홀더 레슨을 실제 콘텐츠로 교체. ~48레슨 경로가 5블록 순서·비중대로 구성되고, "오늘의 레슨"이 실제 카드 데이터를 반환.

## Acceptance criteria

- [ ] 플레이스홀더 → 실제 13카드/5블록 콘텐츠 교체
- [ ] ~48레슨, 블록 순서·비중(70:30→20:80) 반영
- [ ] 셀렉터가 실제 카드 데이터 반환
- [ ] 경로 구성 단위테스트

## Blocked by

- 16-author-13-cards (C1)
- 04-path-today-selector (P1)
