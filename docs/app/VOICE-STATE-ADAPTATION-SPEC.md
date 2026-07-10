# VOICE-STATE-ADAPTATION-SPEC — 목 상태 기반 light-mode

R4 canonical.

## 목적

목 상태 micro-check는 의료 문진이 아니라, 그날의 보컬 부하를 낮추기 위한 비진단 UX다. 사용자가 streak 때문에 쉰 목소리 상태에서 소리내기를 계속하지 않도록 한다.

## 상태별 동작

| 상태 | 앱 동작 |
|---|---|
| 괜찮음 | 정상 레슨 |
| 조금 피곤함 | 반복 수 절반, 불편하면 쿨다운 이동, high/gated 성격 피드백 숨김 |
| 쉰 느낌 | 소리내기 과제 대신 듣기·무음 호흡·쿨다운 recovery cue, pitch 표시 숨김, streak 인정 |

## 금지

- 진단명 부여 금지
- 성대 상태 판정 금지
- 쉰 느낌 상태에서 고음·belt·run·full take 권유 금지
- streak 유지를 위해 발성을 강제하지 않음

## 근거

NIDCD는 목소리가 쉬었거나 피곤할 때 말하거나 노래하는 것을 피하고, 극단적 음역 사용을 피하라고 안내한다. 따라서 voice-state check는 실제 레슨 강도 전환으로 이어져야 한다.
