# SAFETY-RUNTIME-CAPS — 고위험 카드 런타임 제한

> R4 canonical. 이 문서는 `HITL-SIGNOFF.md`, `SAFETY-RELEASE-GATE.md`, `app/lib/lesson/card.dart`, `app/lib/progression/progression_state.dart`를 연결한다.

## 1. 원칙

고급 장르 Lab은 반복 가능하지만 무제한 반복이 아니다. 고위험 카드는 다음 네 조건을 모두 충족해야 사용자에게 공개할 수 있다.

1. 발성 전문가/HITL 사인오프
2. 카드별 runtime cap
3. 안전 fallback 카드
4. rollout config 승인

NIDCD는 쉰 목소리나 피곤한 목소리 상태에서 말하거나 노래하지 말고, 음역의 극단과 과사용을 피하라고 권고한다. 따라서 앱의 안전 정책은 “경고 문구”가 아니라 실제 연습량 제한으로 구현되어야 한다.

## 2. Card runtime safety fields

`Card` 모델에는 R4부터 다음 필드가 있다.

```text
safetyIntensity: low / moderate / high / gated
maxReps
maxDurationSec
maxTakeCount
maxSustainSec
weeklyCap
requiredRestHours
fallbackCardId
```

`SafetyReview.pending` 카드가 사인오프되지 않았으면 `fallbackCardId`로 대체한다. fallback이 없거나 fallback도 잠겨 있으면 해당 slot은 숨긴다.

## 3. 1차 fallback mapping

| Pending card | 위험 유형 | Fallback |
|---|---|---|
| IM-02 | strong oral twang | TONE-07 |
| IM-03 | passaggio handling | UC-10 |
| IM-05 | belt entry | GY-08 |
| IM-12 | belt-like phrase | IM-07 |
| CL-01 | cover | CL-02 |
| CL-08 | messa di voce | TONE-08 |
| GY-04 | strong twang | TONE-07 |
| GY-05 | light belt entry | GY-08 |
| GY-06 | run/agility speed | CARD-16 |
| GY-09 | light belt phrase | GY-01 |

## 4. 후속 구현 backlog

현재 R4는 cap/fallback schema와 manifest 대체를 구현했다. 아직 실제 주간 cap 카운팅과 `requiredRestHours` 강제는 후속 구현이다.

필수 후속 코드:

- `VocalLoadBudget`
- `WeeklySafetyLedger`
- `maxTakeCount` UI 제한
- `hoarse/tired override`
- `full-take count cap`

