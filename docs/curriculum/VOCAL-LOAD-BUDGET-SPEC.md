# VOCAL-LOAD-BUDGET-SPEC — v8

## 1. 원칙

Vocal Load Budget은 더 많이 노래하게 하는 점수제가 아니라, 오늘 안전하게 허용할 발성량과 강도를 제한하는 보호 레이어다. 정확한 점수·시간·주간 cap은 `[D-D]`이며 전문가 검수와 사용자 데이터로 보정한다.

## 2. 상태 우선 traffic light

| 상태 | 예시 | 허용 | 금지 |
|---|---|---|---|
| Green | 평소 상태, 통증·변화 없음 | 계획된 low/moderate | cap 초과 |
| Yellow | 전신 피로·가벼운 effort 증가, 음질/음역 변화 없음 | no-voice, low, 익숙한 짧은 SOVT | high/gated, full take |
| Orange | 쉰 느낌, raw/strained, 평소 고음 손실, 말하기 effort | no-voice review, 휴식 안내 | voiced lesson |
| Red | 통증, 호흡·삼킴 곤란, 혈액, 갑작스러운 심한 변화 | 즉시 중단·의료 안내 | 모든 training |

## 3. Load classes

| class | 예시 | 정책 |
|---:|---|---|
| 0 | 듣기, tap, 가사·score review | recovery 인정 |
| 1 | 정렬, 무성 호흡, 아주 가벼운 익숙한 SOVT | Yellow 조건부 |
| 2 | 허밍, 낮은 강도 모음 | reduced cap |
| 3 | 짧은 phrase, tone A/B | daily take cap |
| 4 | 장르 section, dynamic/register demand | weekly cap·recovery |
| 5 gated | belt-like, run speed, messa, strong twang | HITL + runtime cap + fallback |

## 4. Runtime fields

`safetyIntensity`, `maxReps`, `maxDurationSec`, `maxTakeCount`, `maxSustainSec`, `weeklyCap`, `requiredRestHours`, `fallbackCardId`, `requiresExpertReview`.

## 5. 제품 동작

- voice state가 card plan보다 우선한다.
- Yellow/Orange에서 voiced lesson을 완료하지 않아도 streak를 동일 인정한다.
- high/gated card는 전날·당일 load ledger와 required rest를 확인한다.
- fallback 없는 gated card는 release blocker다.
- 회복 예상 시간을 확정적으로 표시하지 않는다.

## 6. source

안전 canonical: `18-vocal-load-safety-recovery.md`. `10-vocal-load-operating-model.md`의 점수 체계는 보조 제품 가설로만 사용한다.
