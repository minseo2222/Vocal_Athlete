# ADR-0017 — V1 MVP 범위·완료 무결성·안전 Release Gate 고정

## Status

Accepted — 2026-06-16

## Context

프로젝트 검토 결과 다음 리스크가 확인되었다.

1. 초급 V1과 중급 장르 확장 범위가 문서상 섞여 있었다.
2. 앱 실행 경고만으로는 중급 고위험 카드(belt/cover/messa/run 등)를 일반 release하기 어렵다.
3. 듀오링고형 게임화가 streak 수준에 머물고, 보컬 안전에 맞는 XP/미션 금지 기준이 필요했다.
4. LessonScreen에서 진입·워밍업 단계에서 바로 완료할 수 있어 실제 본운동 전 tap-through가 가능했다.

## Decision

1. V1 출시는 초급 48레슨으로 고정한다. 상세 범위는 `docs/app/MVP-SCOPE.md`가 권위다.
2. 일일 학습 루프와 상태 규칙은 `docs/app/PRODUCT-LOOP-SPEC.md`를 따른다.
3. 진입·워밍업 단계에서는 `완료` 버튼을 노출하지 않는다. 최소 본운동 단계 진입 후 완료 가능하다. 단, 시간·품질 점수로 해금을 막지는 않는다.
4. 보컬형 게임화는 `docs/app/GAMIFICATION-SPEC.md`를 따른다. 고음·음량·긴 sustain·belt 반복·리더보드는 보상하지 않는다.
5. 중급 고위험 카드는 `docs/verification/SAFETY-RELEASE-GATE.md` 충족 전 release 금지다. 전문가 사인오프와 앱 hard cap 구현이 모두 필요하다.
6. 3분류 발성 AI와 한국어 모음 식별은 V1 정식 표시가 아니라 숨김 실험/후속 후보로 하향한다.

## Consequences

- V1은 제품 메시지가 더 좁고 안전해진다: “노래 전 초급 루틴 앱”.
- 중급 문서와 카드가 존재하더라도 release toggle은 안전 게이트 전 비활성이다.
- 완료 기반 진행 원칙은 유지하면서, 가장 낮은 수준의 완료 무결성을 확보한다.
- 게임화는 경쟁이 아닌 안전 행동 reinforcement로 제한된다.
- 후속 개발은 hard cap/fallback 카드 스키마 확장과 전문가 사인오프 기록이 우선이다.

