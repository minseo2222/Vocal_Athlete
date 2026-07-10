# PRODUCT-LOOP-SPEC — 일일 학습 루프

> 목적: 듀오링고형 짧은 반복 구조를 보컬 트레이닝에 맞게 구체화한다. 본 문서는 UX·상태머신·이벤트의 단일 제품 흐름 기준이다.

## 1. 핵심 원칙

- 매일 할 일은 하나다: **오늘의 레슨 1개**.
- 품질 점수는 해금을 막지 않는다.
- 사용자가 많이 하도록 부추기지 않는다. 보컬은 과사용 리스크가 있다.
- 실패/공백은 처벌하지 않는다. 복귀 루프가 제품의 일부다.
- “왜” 설명보다 짧은 cue와 변주를 제공한다. 단 안전 cue는 예외적으로 더 명확히 말한다.

## 2. 하루 루프

1. 앱 실행
2. 1탭 안전 경고 확인
3. 홈: TodayHero + JourneyPreview + streak
4. 오늘 레슨 시작
5. 진입·워밍업: 목 상태 micro-check + 가벼운 신체/호흡/SOVT
6. 본운동: cue + 유성 마이크로-윈 + 필요한 경우 확인형 시각 피치 피드백
7. 쿨다운: 권장, 스킵 가능
8. 완료: 오늘 레슨 종료, 당일 재진도 불가
9. 홈 복귀: 완료 상태 + 내일 예고

## 3. 완료 무결성

V1은 시간 강제 게이트를 두지 않는다. 다만 tap-through 방지를 위해 다음 UX는 필수다.

- 진입·워밍업 단계에는 `완료` CTA를 노출하지 않는다.
- 최소 본운동 화면을 본 뒤에만 완료 경로가 열린다.
- 본운동에서는 `쿨다운 건너뛰기`로 완료 가능하다.
- 쿨다운에서는 `완료` CTA를 노출한다.
- 수행 품질·피치 점수·정확도는 해금을 차단하지 않는다.
- 목 상태 micro-check는 진단·문진·해금 게이트가 아니다. 쉰 느낌/피로 선택 시 light-mode를 제안하고 streak는 유지한다.

### 추적 이벤트

- `lesson_started`
- `entry_step_seen`
- `main_step_seen`
- `cooldown_step_seen`
- `lesson_completed`
- `lesson_completed_from_main_skip`
- `lesson_completed_from_cooldown`
- `completed_under_60s`
- `completed_without_pitch_source`

## 4. 복귀 루프

| 공백 | 첫날 경험 | 신규 해금 |
|---|---|---|
| 0–6일 | 오늘 레슨 계속 | 가능 |
| 7–14일 | 복귀 복습 1일 | 복습일에는 신규 해금 없음 |
| 15일+ | 복귀 복습 2일 | 복습 종료 후 신규 해금 |

문구 원칙:

- “실패” 금지.
- “오랜만이에요 — 가볍게 복습부터”처럼 복귀를 정상 루프로 처리.
- streak reset 없음.

## 5. 코스 전이 루프

### 5.1 초급 Foundation 완주 후

1. 축하 화면
2. 현재 코드: 완료 시 `Progression`이 `canStartUniversalCore` 상태를 만들고, 전이 화면 CTA에서 `startUniversalCore()`를 호출
3. 다음 코스 manifest: `buildUniversalCoreManifest()` = 144레슨
4. UI는 축하/다음 단계 안내를 표시

초급 직후에는 장르 선택을 띄우지 않는다. 관심 장르를 기록하더라도 학습 경로는 Universal Core로 간다.

### 5.2 Universal Core 완주 후

1. 축하 화면
2. 현재 코드: 완료 시 `Progression`이 `canStartRepertoireApplication` 상태를 만들고, 전이 화면 CTA에서 `startRepertoireApplication()`를 호출
3. 다음 코스 manifest: `buildRepertoireApplicationManifest()` = 72레슨
4. UI는 축하/다음 단계 안내를 표시

### 5.3 곡 적용 훈련 완주 후

1. 고급 장르 Lab 선택
2. 선택 장르가 출시됨: `buildAdvanced*Manifest()` repeatable cycle 진입
3. 선택 장르가 미출시: 유지 모드 진입 + 의향 기록
4. 출시 시 자동 연결

고급 장르 Lab은 날짜 제한이 없지만, cycle·cap·회복 규칙을 갖는 반복형 구조다.

## 6. 유지 모드 구성

유지 모드는 “새 레슨 없음”이 아니라 초급 핵심 루틴의 얇은 반복이다.

- SOVT day: 빨대/립트릴/허밍
- Self-imitation day: 자기 녹음→재모방
- Visual pitch day: 상대 목표선/시도 후 곡선 관찰
- Listening day: 듣고-상상하고-허밍하기
- Rhythm day: 4박 pulse + 리듬 허밍
- Contour/Korean bridge day: 2–3음 contour 또는 한국어 음절 bridge
- Standard sample light review day: 같은 조건 짧은 기록

유지 모드도 1일 1레슨 cap을 유지한다.

## 7. 알림 원칙

- 죄책감 유발 문구 금지.
- “오늘 안 하면 streak가 깨져요” 금지.
- “오늘은 8분짜리 가벼운 루틴”처럼 낮은 압박 문구 사용.
- 통증/쉰목/피로가 있는 사용자가 streak 때문에 무리하지 않도록 “쉬는 것도 관리” 문구 허용.


