# U6 — 스트릭·진척 노출

Status: done — 헤더에 🔥 streak pill(Key('streak'))·P5와 동기화(완료 시 갱신), idx/total은 U1에 이미 존재, 가혹 연출·정당화 텍스트 없음, TDD 2행동, analyze 클린·테스트 66/66 (2026-05).

## What to build

홈/레슨 헤더에 진척(경로 idx/total)과 관대 스트릭(P5) 노출. 듀오링고형 가시 진척이되 *이유 설명 없음*(무납득). 가혹 스트릭 연출 금지(0 리셋·freeze 없음 정합).

## Acceptance criteria

- [ ] 헤더/홈에 idx/total + 스트릭 표시
- [ ] P5 스트릭 상태와 동기화
- [ ] 가혹 페널티 연출 없음, 정당화 텍스트 없음
- [ ] 렌더 테스트

## Blocked by

- 18-lesson-screen-D (U1)
- 08-lenient-streak (P5)
