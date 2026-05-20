# U1 — 레슨 화면 D 셸 + 완료 배선

Status: done — LessonScreen D 셸(헤더·3단 스테퍼·cue·하단 시트·완료) + _AppShell이 Progression 보유·완료 배선 → P2 전진, 디버그 허브 제거(역할 종료), TDD 4행동, analyze 클린·테스트 58/58 (2026-05). cue/유성/피치/쿨다운chip/넛지=후속 슬라이스.

## What to build

채택안 D 레이아웃(프로토 검증, `prototypes/lesson-ui/NOTES.md`)을 실제 화면으로: 헤더(레슨·idx/total + 유성 pill) → 얇은 3단 스테퍼(진입✓·본운동●·쿨다운) → cue 중앙 → 하단 시트(피치 영역 자리·완료 버튼). "오늘의 레슨"(P1) 바인딩, 완료 버튼 → P2 완료 액션 디스패치. 워크스루: 실행경고 → D 레슨 → 완료 → 다음 해금.

## Acceptance criteria

- [ ] D 구조 렌더(헤더·스테퍼·cue·하단시트), 세로 모바일
- [ ] 현재 레슨 데이터 바인딩
- [ ] 완료 → P2 액션 → 다음 레슨
- [ ] 실행경고→레슨→완료 end-to-end 데모
- [ ] 컴포넌트/배선 테스트

## Blocked by

- 05-complete-unlock (P2)
- 03-launch-warning (F2)
