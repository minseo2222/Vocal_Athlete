# 초급 V1 — 슬라이스 인덱스

듀오링고형 일일 보컬 트레이닝 앱, 초급 커리큘럼 V1. 트레이서불릿 수직 슬라이스.
근거: `CONTEXT-MAP.md`, `CONTEXT.md`, `docs/adr/0001-0012`, `docs/curriculum/beginner/CURRICULUM.md`,
프로토 검증(`prototypes/progression/NOTES.md`, `prototypes/lesson-ui/NOTES.md`).

HITL = 사람 결정/검토 필요. 그 외 AFK.

| # | 슬라이스 | 타입 | Blocked by |
|---|---|---|---|
| 01 | F0 스택·스캐폴드 결정 ✅ Flutter(ADR-0013) | HITL | — |
| 02 | F1 스캐폴드 부팅 🟡 비대화형 done, 실기기 지연측정 남음 | AFK | 01 |
| 03 | F2 앱 실행 경고 화면 | AFK | 02 |
| 04 | P1 선형 경로 + 오늘 레슨 셀렉터 ✅ | AFK | 02 |
| 05 | P2 완료 액션 → 완료 기반 해금 ✅ | AFK | 04 |
| 06 | P3 1일1레슨 캡 ✅ | AFK | 05 |
| 07 | P4 졸업/전이 메시지(transition_day) ✅ | AFK | 06 |
| 08 | P5 관대 스트릭 | AFK | 06 |
| 09 | P6 복귀 복습 | AFK | 06, 08 |
| 10 | P7 졸업 감지 | AFK | 05 |
| 11 | P8 비구속 장르 선택 | AFK | 10 |
| 12 | P9 유지 모드 | AFK | 11, 08 |
| 13 | P10 출시 자동 연결(V1 stub) | AFK | 11, 07 |
| 14 | A0 피치 검출 방식 결정 ✅ pYIN V1(ADR-0014) | HITL | 01 |
| 15 | C0 레슨/카드 스키마 + 변주 5축 ✅ 정규화(ADR-0015) | HITL | 04 |
| 16 | C1 13 IN 카드 콘텐츠 작성 ✅ cards.md(사인오프) | HITL | 15 |
| 17 | C2 콘텐츠 경로 배선 | AFK | 16, 04 |
| 18 | U1 레슨 화면 D 셸 + 완료 배선 | AFK | 05, 03 |
| 19 | U2 유성 마이크로윈 + cue 렌더 | AFK | 18, 17 |
| 20 | U3 레슨 해부(쿨다운 스킵) | AFK | 18 |
| 21 | U4 시각 피치 피드백(stub) | AFK | 18 |
| 22 | U5 선택형 "다시?" 넛지 | AFK | 21 |
| 23 | U6 스트릭·진척 노출 | AFK | 18, 08 |
| 24 | U7 졸업/전이/장르/유지 UI | AFK | 10,11,12,13,18 |
| 25 | A1 실제 F0 검출 → U4 교체 | AFK | 14, 21 |
| 26 | C3 변주 엔진 | AFK | 17 |
