# C2 — 콘텐츠 경로 배선

Status: done — Card 모델(ADR-0015 minimal) + kCardLibrary 13카드(cards.md 직역) + resolveCard, LessonScreen cue 영역이 실제 카드 cue 렌더, TDD 4행동 + 전수 가드, analyze 클린·테스트 62/62 (2026-05). anatomy/feedback/antiPatterns/variableAxes는 소비자 슬라이스에서 추가(YAGNI).

## What to build

ADR-0015대로 **PathManifest 작성 + `resolve(Card,PathSlot,day)` 리졸버 구현**. C1의 13카드를 manifest 슬롯(블록·bodyVoicedRatio·variationLevel)에 배치해 ~48레슨 경로 구성, "오늘의 레슨" = 리졸버가 도출한 LessonInstance. 플레이스홀더 교체.

## Acceptance criteria

- [ ] 플레이스홀더 → 실제 13카드/5블록 콘텐츠 교체
- [ ] ~48레슨, 블록 순서·비중(70:30→20:80) 반영
- [ ] 셀렉터가 실제 카드 데이터 반환
- [ ] 경로 구성 단위테스트

## Blocked by

- 16-author-13-cards (C1)
- 04-path-today-selector (P1)
