# U2 — 유성 마이크로윈 + 운동 지시 cue 렌더

Status: done — 헤더 ● 유성 pill 데이터 조건부(card.voicedMicroWin.isNotEmpty), 시트에 voicedMicroWin 본문 노출, 무납득 데이터 가드(cue에 정당화 토큰 미포함), TDD 2행동+리팩터+가드, analyze 클린·테스트 64/64 (2026-05).

## What to build

레슨 화면에 유성 마이크로윈 표시(매 레슨 ≥1 소리 요소, "● 유성" 표지)와 운동 지시 cue 렌더링. **무납득**: cue는 과제 정의 지시문만("이로 물지 마세요", "밝게, 크게 아님") — *왜* 설명·정당화·동기 텍스트 없음(ADR-0002+개정). C2 콘텐츠의 cue/voiced 필드를 화면에 연결.

## Acceptance criteria

- [ ] 모든 레슨에 유성 마이크로윈 표지 노출(무성 레슨 0)
- [ ] cue = 지시문만, 정당화/동기 문구 없음
- [ ] C2 콘텐츠 필드 바인딩
- [ ] 렌더 테스트

## Blocked by

- 18-lesson-screen-D (U1)
- 17-wire-content-path (C2)
