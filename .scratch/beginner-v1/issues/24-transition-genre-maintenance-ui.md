# U7 — 졸업/전이/장르/유지 모드 UI

Status: done (장르 변경 진입점은 backlog로 분리)

## What to build

졸업 순간 UI: 축하/전이 화면(P4 메시지) → 비구속 장르 선택 UI(P8) → 중급 미출시 시 유지 모드 루프 UI(P9) / 출시 시 자동 연결(P10). 졸업이 *절벽*이 아니라 *전이*로 보이게(ADR-0010). 장르 변경 진입점 포함.

## Acceptance criteria

- [ ] 졸업 시 전이 화면(에러 아님) + P4 메시지 반영
- [ ] 장르 선택/변경 UI(비구속)
- [ ] 유지 모드 일일 루프 UI(스트릭 유지, 신규 없음)
- [ ] 출시 자동 연결 시 해당 코스로 전이 UI
- [ ] 흐름 테스트(졸업→장르→유지→(스텁)연결)

## Blocked by

- 10-graduation-detect (P7)
- 11-genre-selection (P8)
- 12-maintenance-mode (P9)
- 13-auto-connect-stub (P10)
- 18-lesson-screen-D (U1)
