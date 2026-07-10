# ADR-0019 — 초급 후 장르 분기 폐지, Universal Core 후 고급 장르 Lab

Date: 2026-06-16
Status: Accepted

## Context

기존 구조는 초급 48일 이후 중급 장르(성악/뮤지컬/가요)로 분기했다. 장기 목표가 “준가수형 성장 플랫폼”으로 확장되면서 초급 직후 장르 선택은 너무 빠르다는 문제가 생겼다.

## Decision

라우팅을 다음으로 바꾼다. 전이는 completion 후 전이 화면 CTA로 수행한다.

```text
Beginner Foundation 48
→ Universal Vocal Core 144
→ Repertoire Application 72
→ Advanced Genre Labs repeatable
```

- 초급 완주 후 장르 선택을 열지 않는다.
- 초급 완주 후 `GraduationScreen`에서 `startUniversalCore()` CTA를 제공한다.
- Universal Core 완주 후 `startRepertoireApplication()` CTA를 제공한다.
- 곡 적용 훈련 완주 후에만 고급 장르 Lab 선택을 연다.
- 고급 장르 Lab은 40-slot 반복 cycle이며 날짜 제한은 없지만, safety cap/fallback/HITL gate 전까지 공개하지 않는다.
- 미출시 고급 장르는 maintenance wait로 보낸다.

## Consequences

- `buildCoreManifest()`는 하위 호환 alias로 남기되 `buildUniversalCoreManifest()`를 반환한다.
- 기존 `intermediate-*` 자산은 삭제하지 않고 고급 장르 Lab 초안/연구 자산으로 재분류한다.
- 고급 장르 Lab rollout은 `kReleasedAdvancedGenres = {}` 기본값으로 유지한다. `kReleasedGenres`는 하위 호환 alias다.
- UX 카피는 “초급 완주 → 장르 선택”이 아니라 “초급 완주 → 중급 공통 코어 시작”으로 바뀐다.

## Supersedes

- ADR-0011의 “초급 후 공유 코어 + 중급 장르 분기” 구조.
- ADR-0012의 중급 코어/분기 범위 구분. 카드 자산은 유지하되 라우팅 계층을 변경한다.
