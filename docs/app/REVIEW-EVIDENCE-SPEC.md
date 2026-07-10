# REVIEW EVIDENCE SPEC — v14

## 목적

복습 task의 `완료` 상태와 실제 수행 흔적을 분리한다. 이 기록은 노래 품질 점수나 자격 인증이 아니라, 사용자가 어떤 조건에서 어떤 복습 행동을 했는지 나타내는 local-first 메타데이터다.

## 데이터

`ReviewEvidenceRecord`

- `reviewTaskId`
- `sourceEvidenceId`
- track / cycle / day / card ID
- retention / transfer
- 목표 evidence E2 / E3
- 완료 시각
- 목 상태
- normal / reduced / recovery
- 원 학습의 content revision
- 현재 content revision

`ReviewPracticeSnapshot`

- 시도 횟수
- 자기점검 인덱스
- 선택 키
- 새로 저장한 take ID
- 재생한 원 학습 take ID
- best take ID

## 해석 제한

다음 해석은 금지한다.

- 복습 기록이 있으므로 E2/E3를 달성했다.
- 시도 수가 적으므로 실력이 높다.
- 녹음이 있으므로 음정이나 음색이 좋아졌다.
- revision이 같으므로 두 take를 자동 종합점수로 비교할 수 있다.

## revision 정책

- 원 학습 revision과 현재 blueprint revision이 같으면 `revisionMatched=true`로 기록한다.
- 다르거나 확인되지 않으면 직접 전후 점수 비교를 하지 않는다.
- revision mismatch 상태에서도 일반 복습 수행 기록은 남길 수 있다.

## 회복 기록

쉰 느낌에서는 무성 복습 항목을 최소 하나 선택해야 한다.

- 이전 take/가이드 낮은 볼륨 청취
- 리듬·가사·호흡 위치 확인
- 발성을 멈추고 다음 날로 재예약

회복 기록은 정상 가창 복습 달성으로 해석하지 않는다.

## 보존/삭제

- 기본 저장: 로컬 `AppMetadataStore` key-value 메타데이터 (`SharedPreferencesAsync` primary)
- 원음 경로는 ReviewEvidence에 저장하지 않음
- 설정 → 복습 기록에서 전체 삭제 가능
- 서버, 모델 학습, 공개 공유 없음


## v14 card-specific cue

- 복습 화면은 현재 blueprint의 objective를 핵심 cue로 표시한다.
- retention은 이전 take/가이드 없이 먼저 재현한다.
- transfer는 한 번에 조건 하나만 바꾼다.
- key 관련 전이는 같은/낮은 편안한 키와 guide 감소를 우선하며 높은 키를 처방하지 않는다.
