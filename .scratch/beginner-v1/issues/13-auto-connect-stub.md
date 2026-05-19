# P10 — 출시 시 자동 연결 (V1 stub)

Status: ready-for-agent

## What to build

선택한 장르의 중급 코스가 "출시됨"이 되면 유지 모드 → 그 코스로 자동 연결되는 전이 메커니즘(ADR-0010). V1엔 중급 콘텐츠가 없으므로 *출시 플래그는 스텁*이나, 자동 연결 경로 + 전이 메시지(P4)는 실제로 동작해야 함(중급 출시 시 코드 변경 없이 연결되도록).

## Acceptance criteria

- [ ] released 플래그 토글 시 유지 모드→해당 코스 자동 진입
- [ ] 전이 시 `transition_day` 설정 + P4 메시지 경로 동작
- [ ] V1에서 released는 스텁(기본 false)
- [ ] 단위테스트(미출시 유지 / 출시 자동연결)

## Blocked by

- 11-genre-selection (P8)
- 07-transition-messaging (P4)
