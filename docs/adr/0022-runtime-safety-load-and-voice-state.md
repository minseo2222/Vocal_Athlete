# ADR-0022 — Runtime safety cap, fallback, and voice-state adaptation

## Status
Accepted — 2026-06-16

## Context
고급 장르 Lab의 pending 카드는 belt, twang, cover, messa, run 등 앱 단독 지도에 위험이 있는 과제를 포함한다. 단순 삭제는 경로를 빈약하게 만들고, 단순 경고는 보컬 부하를 충분히 제어하지 못한다. 또한 목상태 체크가 실제 레슨 강도 조절로 이어지지 않으면 streak가 과사용을 유도할 수 있다.

## Decision
1. pending safety card에는 `fallbackCardId`를 지정한다.
2. `safetyApproved=false`이면 pending card를 fallback card로 대체한다. fallback이 없으면 해당 슬롯을 숨긴다.
3. `Card` 모델에 runtime cap 필드를 추가한다: `maxReps`, `maxDurationSec`, `maxTakeCount`, `maxSustainSec`, `weeklyCap`, `requiredRestHours`.
4. `VoiceState.hoarse`는 recovery mode cue, pitch display 숨김, voiced task 비강제로 연결한다.
5. `VoiceState.tired`는 reduced/light mode cue와 반복 절반, 중강도 이상 pitch feedback 축소로 연결한다.
6. full cap enforcement는 후속 `VocalLoadBudget` 저장/카운터 slice에서 구현한다.

## Consequences
- 고급 Lab은 사인오프 전에도 학습 흐름을 안전하게 degrade할 수 있다.
- 쉰 느낌 상태에서도 streak는 유지할 수 있으나 소리내기는 강제하지 않는다.
- fallback/cap 없는 고위험 카드는 release blocker다.
