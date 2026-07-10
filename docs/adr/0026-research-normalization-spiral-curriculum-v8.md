# ADR-0026 — v8 리서치 정규화와 나선형 커리큘럼

- Status: Accepted
- Date: 2026-06-19

## Context

사용자가 Beginner, Universal Core, 세부 역량, Repertoire Application, 장르별 Advanced Lab, 안전, 평가, 앱 학습 방법론, 자산 제작을 다룬 20개 심층 리서치를 제공했다. 기존 음색 리서치까지 합하면 21개다.

자료의 구조와 실무 가치는 높지만 다음 문제가 있었다.

- 초기 5개 문서는 세션 종속 `turn...` 인용만 남아 재현 가능한 출처 연결이 끊김
- 가요 2개, Vocal Load 2개의 역할 중복
- 임상 음성치료·건강한 가수·일반 운동학습·전문가 합의·제품 가설이 섞임
- 기존 144레슨 Core가 큰 블록의 modulo 반복이라 retention·transfer 설계가 약함
- Repertoire Application이 카드 목록은 있으나 도움 줄이기와 산출물 progression이 약함

## Decision

### 1. 원문 보존과 출처 상태 분리

- 21개 원문을 `docs/research/v8/source-bundle/`에 정규화해 보존한다.
- 원문을 곧바로 verified canonical claim으로 취급하지 않는다.
- 각 문서에 `SOURCE_RECOVERY_REQUIRED` 또는 `SOURCE_LINKED_UNVERIFIED_IN_BULK` 상태를 부여한다.

### 2. 이중 근거 taxonomy

근거 강도 A–D와 직접성 S/C/M/P/D를 분리한다.

- S: 건강한 가수 직접 근거
- C: 임상 음성치료
- M: 일반 운동학습·음악인지
- P: 공식 보컬 페다고지·교육기관 합의
- D: 제품 가설

### 3. Universal Core spiral

144슬롯은 유지하되 36슬롯의 네 spiral pass로 재구성한다.

1. Map / Coordinate
2. Stabilize / Compare
3. Retain / Vary
4. Transfer / Check

각 pass에 호흡/발성, pitch, rhythm, timbre/range, diction/phrase, checkpoint가 재등장한다.

### 4. Repertoire Application progression

72슬롯은 다음 네 단계로 재구성한다.

1. Global Map
2. Local Scaffold
3. Recall / Fade
4. Transfer / Portfolio

이 단계는 노래 제작 기능이 아니라 보컬 기술을 짧은 프레이즈에 적용하는 과정이다.

### 5. 평가

일일 해금은 completion 기반으로 유지한다. 학습 증거는 즉시 수행, delayed retention, near transfer, repertoire transfer, independent artifact로 계층화한다. 단일 가수 점수는 만들지 않는다.

### 6. 장르·안전

장르별 연구는 Advanced Lab에 반영하되 고위험 기술은 근거 문서에 있다는 이유만으로 출시하지 않는다. HITL, runtime cap, fallback, rollout 승인 조건을 유지한다.

## Consequences

### Positive

- 커리큘럼 결정과 근거 상태를 추적할 수 있다.
- 임상 자료의 과잉 일반화를 줄인다.
- 당일 성공이 아니라 유지·전이 중심의 학습 구조가 된다.
- 중급에서 공통 역량이 주기적으로 재등장한다.
- 곡 적용에서 guide dependency를 줄일 수 있다.

### Negative / Cost

- 초기 5개 문서의 임시 인용 복구 작업이 남는다.
- 카드별 실제 자산·variant·feedback copy 제작량이 늘어난다.
- 144/72/40 길이는 아직 사용자 검증 전 제품 가설이다.
- 기존 테스트·문서의 R3/R4 표현을 지속적으로 정리해야 한다.

## Non-decisions

- v8은 Advanced Genre Lab을 출시하지 않는다.
- v8은 정확한 안전 cap을 의학적으로 검증된 값으로 승인하지 않는다.
- v8은 자동 음색·표현·가수급 점수를 도입하지 않는다.
- v8은 임시 인용 01–05를 복구 완료로 간주하지 않는다.
