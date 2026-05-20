# C3 — 변주 엔진

Status: done

## What to build

ADR-0015 스키마 기반 변주 엔진: 리졸버 안에서 Card `variableAxes` + `PathSlot.variationLevel`을 소비해 같은 레슨 타입 안 표면(음역·모음·글라이드·멜로디·세션위치 5축)을 일자별로 변경. 경로 따라 blocked→variable 비중 *내부 상승*(§13.5, 내부 설계 전용). 사용자에겐 *그냥 매일 조금 다른 운동*으로만 체감 — 이유 설명 없음(무납득). 경로는 변주로 갈리지 않음(단일 고정 선형).

## Acceptance criteria

- [ ] 레슨 타입 내 표면 변주(5축) 적용
- [ ] 경로 진행에 따른 blocked→variable 내부 상승
- [ ] 사용자向 변주 근거 설명 없음
- [ ] 경로 분기 아님(고정 선형 유지) 확인
- [ ] 변주 선택 로직 테스트

## Blocked by

- 17-wire-content-path (C2)
