# VOCAL-LOAD-BUDGET-SPEC — v8 app policy

## 구현 상태

코드에는 `VocalLoadIntensity`, `VocalLoadLedger`, `VocalLoadPolicy`, `VocalLoadDecision`이 존재한다. v8 리서치는 **상태 우선 traffic-light policy**를 canonical로 채택한다.

## 현재 기본값

일일 8 points, high 1개, gated 0개, full take 2개는 출시 안전값이 아니라 `[D-D]` 개발 기본값이다. UI에서 과학적 권장량처럼 설명하지 않는다.

## 다음 구현 요구

1. ledger를 날짜별 persistence에 연결
2. weekly cap과 required rest 강제
3. Green/Yellow/Orange/Red voice state 저장
4. Orange에서 no-voice lesson으로 실제 교체
5. advanced release 전에 fallback·HITL 확인
6. user report와 다음 날 변화 기록

상세 정책: `docs/curriculum/VOCAL-LOAD-BUDGET-SPEC.md`.
