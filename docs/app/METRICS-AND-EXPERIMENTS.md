# METRICS-AND-EXPERIMENTS — 제품 지표와 실험

> 목적: V1의 성공을 “점수 향상”이 아니라 안전한 반복 학습으로 측정한다.

## 1. North Star

**주간 안전 루틴 완료 사용자 수**

정의: 최근 7일 내 3회 이상 레슨을 완료했고, 중단/통증/저신뢰 피드백을 무시하도록 유도받지 않은 사용자.

## 2. 핵심 퍼널

1. 앱 설치
2. 안전 경고 확인
3. 마이크 권한 안내 도달
4. 첫 레슨 시작
5. 본운동 진입
6. 첫 레슨 완료
7. D1 재방문
8. D7 유지
9. 표준샘플 재기록
10. 청음/리듬/contour/Korean bridge 카드 완료
11. 초급 완주 후 Universal Core 전이
12. Universal Core 완주 후 Repertoire Application 전이
13. 곡 적용 훈련 완주 후 고급 장르 선택/유지

## 3. 이벤트

| 이벤트 | 속성 | 목적 |
|---|---|---|
| `launch_warning_ack` | appVersion | 경고 확인 |
| `lesson_started` | cardId, course, day | 시작률 |
| `entry_step_seen` | cardId | 진입 노출 |
| `main_step_seen` | cardId | 완료 무결성 |
| `cooldown_step_seen` | cardId | 쿨다운 노출 |
| `lesson_completed` | cardId, fromStep, durationSec | 완료율 |
| `stage_transitioned` | fromStage, toStage | 초급→코어→Repertoire Application 전이 |
| `advanced_genre_selected` | genre, released | 고급 장르 선택/미출시 대기 |
| `completed_under_60s` | cardId | tap-through 탐지 |
| `pitch_source_unavailable` | reason | 마이크/권한 문제 |
| `pitch_low_confidence_hidden` | count | 저신뢰 UX 검증 |
| `return_review_started` | gapDays | 복귀 루프 |
| `return_review_completed` | gapDays | 복귀 성공 |
| `standard_sample_recorded` | sampleNo | 성장 체감 |
| `stop_signal_viewed` | signalType | 안전 cue 노출 |
| `stop_signal_confirmed` | signalType | 중단 행동 |
| `voice_state_selected` | state, cardId | 목 상태 light-mode 사용 |
| `light_mode_suggested` | state, suggestedMode | 피로/쉰 느낌 대응 |
| `pitch_feedback_revealed` | cardId, relativeTarget | 확인형 피드백 사용 |
| `relative_target_created` | cardId, seedCount | CARD-12 상대 목표선 생성 |
| `rhythm_card_completed` | pattern, tempo | 리듬 bridge 완료 |
| `contour_card_completed` | contour | 짧은 선율 bridge 완료 |
| `korean_bridge_completed` | syllable | 한국어 bridge 완료 |


## 4. 금지 지표

- 최고음 랭킹
- 음량 랭킹
- sustain 최장 기록 경쟁
- belt 반복 수
- perfect score 비율

내부 품질 검증용으로 sustain·pitch deviation을 볼 수는 있으나 사용자 경쟁 지표로 쓰지 않는다.

## 5. V1 실험 후보

| 실험 | 가설 | 성공 지표 | 주의 |
|---|---|---|---|
| 완료 버튼 진입 단계 숨김 | tap-through 감소 | main_step_seen/complete 비율↑ | 과도한 마찰 금지 |
| 쿨다운 XP | 쿨다운 수행 증가 | cooldown_step_seen↑ | 강제 시간채우기 금지 |
| 복귀 문구 A/B | 죄책감 없는 문구가 재완료↑ | return_review_completed↑ | guilt 카피 금지 |
| 표준샘플 배지 | 성장 체감↑ | sample #2 기록률↑ | 점수화 금지 |
| 저신뢰 null 문구 | 신뢰도↑ | 이탈률↓ | 기술 한계 과설명 금지 |
| 확인형 피치 피드백 | 실시간보다 수행 후 확인이 완주/재시도를 높임 | pitch_feedback_revealed↑, 이탈률↓ | 화면 의존·불안 증가 모니터링 |
| 목 상태 micro-check | 쉰 느낌/피로 사용자가 무리하지 않고 복귀함 | light_mode_suggested 후 completion↑ | 의료 문진처럼 보이지 않게 |
| 리듬/contour bridge | 노래 학습 체감이 증가함 | D7↑, bridge 카드 완료율↑ | tempo/정확도 점수화 금지 |


## 6. MVP 전 최소 계측

- `main_step_seen` 없이 `lesson_completed`가 발생하지 않는지 확인.
- `completed_under_60s` 비율이 높은 카드 식별.
- 마이크 권한 거부 후 완료율 확인.
- 표준샘플이 Day 1/24/48에만 기록되는지 확인.
- `relative_target_created`가 CARD-12에서 생성되는지 확인.
- `pitch_feedback_revealed`가 CARD-12/14/16에서 발생하는지 확인.
- 목 상태 micro-check가 해금 게이트가 아닌지 확인.
- 7일+ 공백 복귀 completion 확인.



## R3 tone events

```text
tone_snapshot_recorded
tone_tag_selected
tone_ab_compared
hum_to_vowel_completed
vowel_color_completed
dynamic_ladder_completed
mic_tone_check_completed
genre_tone_lab_completed
tone_effort_reported
tone_discomfort_reported
enter_universal_core_tapped
advanced_genre_picker_viewed
advanced_genre_selected
```

성공 지표는 tone score가 아니라 A/B 재생률, comfort rating 제출률, tone 재시도 후 중단률, 쉰 느낌 선택 시 recovery 전환률이다.

## v9 학습효과 계측

당일 성공률과 장기 학습을 분리한다.

| 이벤트 | 주요 속성 | 목적 |
|---|---|---|
| `self_judgment_submitted` | cardId, criterion, response | 외부 피드백 전 자기판단 사용률 |
| `feedback_revealed` | cardId, feedbackType, attemptNo | self-controlled feedback 사용 |
| `no_overlay_probe_completed` | cardId, resultAvailable | 화면 도움 없는 수행 기록 |
| `retention_probe_completed` | cardId, delayDays, evidenceLevel | 지연 유지 확인 |
| `transfer_probe_completed` | cardId, changedVariable, evidenceLevel | 다른 조건 전이 확인 |
| `guide_level_used` | phraseId, guideLevel | guide dependency 감소 추적 |
| `repertoire_project_day_completed` | project, day, phraseId | 12일 project 진행 |
| `best_take_selected` | purpose, takeCount | 자기수정·산출물 선택 |
| `recovery_no_voice_completed` | sourceStage, reason | 안전한 no-voice 학습 인정 |
| `checkpoint_artifact_saved` | stage, domain, evidenceLevel | 레벨 산출물 완전성 |
| `universal_microcycle_completed` | cycle, formalCheckpoint | 12일 spiral completion |
| `whole_phrase_baseline_saved` | project, phraseId | RA-09 global baseline |
| `delayed_project_review_saved` | project, changedVariable | RA-10 retention/transfer |
| `active_attempt_seconds` | cardId, voiceState | 설명 대비 실제 시도 시간 연구 |

### v9 지표 해석 원칙

- `lesson_completed` 증가는 곧 실력 향상이 아니다.
- retention은 최소 다음 세션 또는 정의된 지연 후 측정한다.
- transfer는 모음, 시작음, tempo, key, phrase 중 한 변수만 바꿔 확인한다.
- 사용자에게 종합 가수 점수를 표시하지 않는다.
- 실험에서 정확한 delay·반복 수가 바뀌어도 안전 gate는 약화하지 않는다.

### v9 실험 후보

| 실험 | 가설 | 주 지표 | 실패 신호 |
|---|---|---|---|
| 자기판단 선행 vs 즉시 앱 피드백 | 자기 오류탐지가 retention을 높임 | D1 retention probe | 수행 중단·혼란 증가 |
| full guide vs 단계적 fade | fade가 독립 take를 늘림 | backing-only take 비율 | early dropout 증가 |
| 36일 반복 loop vs 12일 microcycle | 짧은 spiral이 영역별 회수를 높임 | 36/72/108/144 retention | 인지부하·완료율 저하 |
| 18일 stage vs 12일 phrase project | 같은 project의 Global→Local→Global이 전이를 높임 | RA-10 revised take | 콘텐츠 혼잡·피로 증가 |
| no-voice recovery lesson | streak 압박 없이 안전한 재방문 유지 | recovery completion, next-day return | voiced task 우회 실패 |
