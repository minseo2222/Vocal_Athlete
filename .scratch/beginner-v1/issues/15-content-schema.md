# C0 — 레슨/카드 스키마 + 변주 5축 표현 확정

Status: done — 결정: **정규화(Card+PathManifest→LessonInstance 도출)** (ADR-0015)

## Decision

정규화 스키마 확정 — Card 템플릿 + PathManifest, 레슨은 `resolve(Card,PathSlot,day)`로 런타임 도출. 변주 5축 = 카드 `variableAxes` + `PathSlot.variationLevel`(blocked→variable). 무납득 = rationale 필드 부재로 구조 강제. 유성 마이크로윈 타입 필수. 전체 골격·근거 = `docs/adr/0015-content-schema-normalized.md`.

---


## What to build

레슨/카드가 담는 데이터 모델과 변주 5축의 파라미터화를 *확정*한다(스키마 결정 = 아키텍처, 다운스트림 전체에 영향). 카드 필드(예: 카드ID, 운동 지시 cue 텍스트[무납득 — "왜" 없음], 유성 마이크로윈 요소, 안티패턴, 레슨 해부 구간, 인-레슨 피드백 종류). 변주 5축(음역·모음·글라이드·멜로디·세션위치)을 *표면 변주*로 표현하는 방식 + 경로 따라 blocked→variable 내부 상승 표현. ADR로 기록.

## Acceptance criteria

- [ ] 레슨/카드 스키마 확정(필드·타입) + ADR
- [ ] 변주 5축 파라미터 표현 확정
- [ ] blocked→variable 내부 상승 표현 방식 확정
- [ ] 무납득 원칙 반영(정당화 필드 없음, 지시 cue만)

## Blocked by

- 04-path-today-selector (P1)
