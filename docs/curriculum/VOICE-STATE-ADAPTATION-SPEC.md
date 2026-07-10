# VOICE-STATE-ADAPTATION-SPEC.md — R4 목상태 적응 정책

## 목적

목상태 체크는 의료 문진이 아니라 당일 연습 강도 조절 UX다. 선택 결과는 실제 레슨 UI에 반영되어야 한다.

## 상태별 동작

| 상태 | 앱 동작 | Streak |
|---|---|---|
| 괜찮음 | 정상 레슨 | 인정 |
| 조금 피곤함 | light-mode: 반복 절반, 중강도 이상 pitch/강도 피드백 축소 | 인정 |
| 쉰 느낌 | recovery mode: 듣기-only/무성 호흡/가벼운 SOVT 1회, voiced task 생략 가능 | 인정 |

## 금지

- 쉰 느낌 상태에서 고급 장르 Lab, full take, belt-like, run speed, messa, 강한 twang 진행
- 목상태를 의료 진단처럼 표현
- streak 유지를 위해 소리내기를 강제

## 구현 기준

- `LessonScreen`의 voice-state adaptation이 현재 MVP 단일 정책이다. 후속 코드 분리 시 `lesson/voice_state.dart`로 추출한다.
- `LessonScreen`은 `VoiceState.hoarse`에서 pitch display를 숨긴다.
- `VoiceState.tired`는 moderate/gated 카드에서 pitch display를 숨기고 light-mode copy를 표시한다.
