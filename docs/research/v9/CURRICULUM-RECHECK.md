# v9 Curriculum Recheck

## 1. 목적

v8 커리큘럼과 업로드된 리서치 묶음을 코드의 실제 카드 빈도·배치와 다시 대조했다. 이 문서는 연구 결과 자체와 제품 설계 결정을 분리한다.

## 2. 확인된 문제

### 정상 진도에 recovery 카드가 포함됨

`CARD-18`은 목 상태에 따른 대체 루틴인데 v8에서는 일부 정상 manifest에 포함되어 있었다. 회복은 날짜가 아니라 상태에 따라 선택되어야 하므로 v9에서 모든 정상 path에서 제거했다.

### Universal Core의 반복 구조가 거침

v8 path는 각 36일 pass에서 같은 12-card loop를 세 번 반복했고 `UC-17`을 12회 배치했다. 도메인은 재등장했지만 난이도·맥락·retrieval의 구분이 약했다.

v9 결정:

- 12일 microcycle 12개
- 각 microcycle에 pitch, rhythm, phrase, retrieval 포함
- formal checkpoint는 Day 36/72/108/144 네 번
- 나머지는 자기 코칭 retrieval 과제

### Repertoire Application의 전체 재통합이 늦음

v8은 Global/Local/Recall/Transfer를 18일씩 분리했다. 한 프레이즈의 local drill 뒤 전체 phrase로 돌아오는 데 긴 시간이 걸릴 수 있었다.

v9 결정:

- 12일 phrase project 6개
- 프로젝트마다 Global→Local→Global 완결
- 첫날 whole-phrase baseline, 마지막 날 delayed retrieval/transfer

### 장르별 전용 카드 부족

R&B/Soul, Rock/Band, Worship가 다른 장르 카드와 공통 카드의 조합에 의존했다. v9에서 각각 6개의 저위험 전용 카드를 추가했다.

## 3. 근거와 추론

### 유지·전이

보컬 운동학습 문헌은 수업 중 즉시 좋아진 수행과 학습을 구분하고, acquisition·retention·transfer를 별도로 본다. v9의 checkpoint와 delayed take는 이 원칙의 제품 번역이다.

### 피드백 fade와 자기평가

명확한 목표와 점차 줄어드는 피드백은 학습자가 내부 reference-of-correctness를 만드는 데 중요하다는 교육적 제안을 반영했다. 앱은 사용자 자기판단을 먼저 받고, 피드백을 결과형으로 제공한다.

### attempt-first

2025년 NATS pilot은 관찰된 10개 레슨에서 실제 singing time이 평균 25.7%였다고 보고했다. 작은 표본의 관찰 연구이므로 목표 비율로 일반화하지 않는다. v9에서는 이를 “설명보다 사용자의 짧은 시도 기회를 충분히 확보한다”는 제품 가설로만 사용한다.

### 외적 초점

보컬·음악 수행의 attention 연구를 근거로, 신체 부위의 직접 조작보다 소리의 결과·phrase 방향·리듬 목표 같은 외적 cue를 우선한다. 모든 과제와 사용자에게 항상 우월하다고 단정하지 않는다.

### 안전

쉰 목소리·피로 상태에서 노래를 강행하지 않고, 음역 극단과 과사용을 피하는 공공 보건 권고를 recovery 정책의 상위 기준으로 유지한다.

## 4. 제품 가설로 남는 것

다음 수치는 검증된 생물학적 최적값이 아니다.

- 12일 microcycle
- 12일 phrase project
- 144/72/40 전체 길이
- 시도 2–3회 뒤 피드백
- checkpoint Day 36/72/108/144
- 카드별 max take와 rest 기본값

사용자 retention/transfer, 피로, 이탈, 이해도 파일럿으로 조정해야 한다.

## 5. v10 이전 검증 과제

1. Universal microcycle 1의 실제 자산과 5–10명 formative test
2. Repertoire Project 1의 whole/local/whole usability test
3. 장르 전문가의 RB/RK/WC 카드 검수
4. Android 기기별 pitch/timing/recording QA
5. active attempt time과 설명 시간의 관찰
6. checkpoint 루브릭 평가자간 신뢰도
