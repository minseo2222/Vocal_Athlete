# ADR-0021 — Repertoire Application / 곡 적용 훈련 명칭 정리

## Status
Accepted — 2026-06-16

## Context
`Song Builder`라는 이름은 작곡·편곡·노래 제작 기능으로 오해될 수 있다. 본 프로젝트는 보컬 트레이닝 앱이며, 해당 단계의 목적은 노래를 만드는 것이 아니라 Universal Vocal Core에서 배운 호흡·발성·음정·리듬·음색·딕션을 짧은 프레이즈와 곡 구간에 적용하는 것이다.

## Decision
- 사용자-facing 명칭은 `Repertoire Application / 곡 적용 훈련`으로 한다.
- 코드의 canonical stage는 `LearningStage.repertoireApplication`이다.
- canonical manifest 함수는 `buildRepertoireApplicationManifest()`이고 길이는 `repertoireApplicationLength = 72`다.
- 기존 R3 저장 데이터와 일부 도구 호환을 위해 `songBuilder` stage, `buildSongBuilderManifest()`, `songBuilderLength`, `startSongBuilder()`는 migration alias로만 유지한다.
- 카드 prefix는 `RA-01~08`을 사용한다.

## Consequences
- 앱은 노래 제작 앱처럼 보이지 않는다.
- 초급/중급에서 배운 기술을 실제 노래 구간으로 전이하는 목적이 명확해진다.
- 과거 R3 데이터는 migration alias로 계속 읽을 수 있다.
