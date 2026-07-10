# 커리큘럼 전체 재점검 — v16

> v9~v15 변경 이력을 함께 보존하며, 현재 판정은 마지막 v16 섹션을 우선한다.
>
> canonical 경로: **Beginner Foundation 48 → Universal Vocal Core 144 → Repertoire Application 72 → Advanced Genre Labs 40-slot 반복 cycle → Portfolio**

## 1. 재점검 결론

v8은 장기 경로와 연구 체계를 만들었지만 실제 path에는 세 가지 문제가 남아 있었다.

1. `CARD-18` 회복 카드가 정상 학습 일정에 섞여 있었다.
2. Universal Core가 36일 패스마다 같은 12카드를 세 번 반복해, 역량 간 간격과 난이도 상승이 거칠었다.
3. Repertoire Application이 Global/Local/Recall/Transfer를 18일 덩어리로 분리해, 하나의 프레이즈를 전체로 재통합하는 주기가 너무 길었다.

추가로 R&B, Rock, Worship이 다른 트랙 카드를 조합하는 수준이라 장르별 학습 내용이 약했다.

## 2. v9 수정

| 문제 | v9 해결 |
|---|---|
| 정상 path의 recovery card | `CARD-18`을 모든 manifest에서 제거하고 런타임 fallback으로만 유지 |
| Beginner 청음 빈도 부족 | `CARD-14`를 최소 세 번 재등장 |
| Core 반복의 단조로움 | 12일 microcycle 12개로 재작성 |
| checkpoint 과다 | `UC-17`을 Day 36/72/108/144 네 번으로 제한 |
| Core 기능 공백 | UC-18~25 신규 카드 추가 |
| pressed 발성 모방 위험 | `UC-04`의 pressed 예시를 listening-only로 변경 |
| Repertoire 재통합 지연 | 12일 phrase project 6개로 변경 |
| 프로젝트 baseline/review 부재 | `RA-09`와 `RA-10` 추가 |
| 장르별 전용 내용 부족 | RB-01~06, RK-01~06, WC-01~06 추가 |
| 최대 발성처럼 보이는 baseline | 표준 모음을 3초, 1 take로 제한 |

## 3. 현재 단계별 준비도

| 단계 | 설계 준비도 | 구현 준비도 | 남은 핵심 문제 |
|---|---:|---:|---|
| Beginner | 높음 | 중간 | 초보자 파일럿, 실제 기기 피치·녹음 QA |
| Universal Core | 중상 | 중상 | Cycle 1은 상세 콘텐츠·짧은 cue 구현. Cycle 2~12 자산과 사용자 검증 필요 |
| Repertoire Application | 중상 | 중간 | Project 1 원본 phrase·guide·backing·권리 기록 구현. Project 2~6 미구현 |
| Advanced Gayo/Musical/Classical | 중간 | 낮음 | 전문가 검수와 고위험 gate |
| Advanced R&B/Rock/Worship | 중간 | 낮음 | v9 전용 카드의 전문가·사용자 검증 |
| Portfolio | 중간 | 낮음 | 루브릭 신뢰도와 review UI |

## 4. 학습 흐름 품질 게이트

### Beginner

- 표준샘플 Day 1/24/48
- 청음·리듬·contour·한국어 bridge 재등장
- 회복은 상태 기반, 일정 기반 아님

### Universal Core

- 모든 12일 microcycle에 pitch, rhythm, phrase, review 포함
- 세 microcycle마다 formal checkpoint
- SOVT는 열린 모음과 가사로 전이
- usable range/key를 maximum range보다 우선

### Repertoire Application

- 각 프로젝트 첫날 whole-phrase baseline
- local practice 뒤 같은 프로젝트 안에서 global return
- 마지막 날 delayed retrieval + 한 조건 transfer
- primary skill 1개, secondary 최대 1개

### Advanced

- 무작위 기술 소비가 아니라 곡/구간 프로젝트
- 고위험 기술은 사인오프·cap·fallback·rollout 승인 전 미출시
- 정상 cycle에 recovery 카드 미배치

## 5. 아직 놓친 것

1. Universal Core Cycle 2~12의 날짜별 blueprint·오디오 exemplar·난이도 variant
2. Repertoire Project 2~6의 자체 제작 프레이즈와 권리 기록
3. pitch/rhythm/timbre 피드백의 Android 실기기 정확도
4. 유저별 tessitura/key 추천의 안전한 초기 calibration
5. 평가자간 루브릭 신뢰도
6. 고급 가요·뮤지컬·성악의 전문가 signoff
7. R&B/Rock/Worship 전용 카드의 장르 전문가 검토
8. 첫 01–05 리서치 문서의 임시 인용 복구
9. 실제 active attempt time과 설명 시간의 사용자 시험
10. 12일 microcycle·project 길이의 유지/전이 효과 검증

## 6. 출시 판단

- Beginner는 콘텐츠·기기·초보자 이해도 QA 후 MVP 후보다.
- Universal Core와 Repertoire Application은 구조는 개선됐지만 자산과 파일럿 전에는 미출시다.
- Advanced Genre Labs는 기본 미출시이며 고위험 기술뿐 아니라 전체 장르 cycle에 전문가 검수가 필요하다.

## 7. 다음 우선순위

1. v10 첫 24일 vertical slice의 Flutter compile·실기기 재생 QA
2. 사용자 5–10명 formative test와 Day 12 지연 재현 확인
3. Universal Core Cycle 2와 Repertoire Project 2 작성
4. 전문가 2인 curriculum/audio/safety review
5. Android 실기기 녹음·F0·timing QA

## 8. v10 추가 판정

- 첫 Universal 12일은 카드 ID만 있는 경로에서 날짜별 목표·단계·시도 상한·피드백·회복 대체가 있는 실행 단위로 승격됐다.
- 첫 Repertoire 12일은 원본 네 마디 프레이즈와 합성 허밍/피아노/반주/클릭으로 end-to-end 흐름을 확인할 수 있다.
- 합성 cue는 출시용 강사 데모가 아니다. 실제 발성 모범을 전달하는 자산은 전문가 제작 master가 필요하다.
- 첫 24일을 구현했다고 전체 144+72일의 콘텐츠 준비도가 완료된 것은 아니다.
- 다음 확장은 새 기능보다 첫 vertical slice의 compile·기기·초보자 사용성 검증이 먼저다.

## 9. v11 학습 증거 재점검

v10까지는 날짜별 `evidence`가 커리큘럼 목표로 존재했지만 앱은 completion 외 수행 흔적을 남기지 않았다. v11은 시도·자기점검·예시 청취·키 선택·녹음·회복 모드를 별도 기록한다.

중요한 경계:

- `목표 E2` 레슨 완료는 E2 달성이 아니다.
- 시도 수와 자기점검 수는 실력 점수가 아니다.
- 회복 모드는 voiced attempt가 없어도 정상 practice trace다.
- 실제 E2/E3는 일정 시간이 지난 재현과 조건 전이 과제로 확인해야 한다.

따라서 v12의 커리큘럼 우선순위는 카드 추가가 아니라 **delayed review queue와 콘텐츠 revision을 포함한 실제 retention/transfer checkpoint**다.

## 10. v15 음색 리서치 재점검과 통합 판정

업로드된 음색 리서치를 기존 경로와 대조한 결과, 독립 12주 코스로 추가하면 호흡·발성·공명·레지스터·딕션·곡 적용과 중복되고 음색을 별도 점수처럼 오해할 위험이 있었다. 따라서 다음처럼 병합했다.

| 단계 | v15 역할 | 구현 |
|---|---|---|
| Beginner | 차이 관찰·자기태그 | Day 1/24/48 snapshot, Day 37 TONE-02, Day 38 TONE-03 |
| Universal Core | 대비·편한 선택·재현·조건 전이 | TONE-02~12 나선형 재등장 |
| Repertoire Application | 동일 프레이즈 tone 전이 | Project 2/4/5/6에 TONE-06/07/11/12 |
| Advanced | 장르 미학 | TONE-13, 단 고위험 효과는 별도 gate |

### 해결한 공백

- 카드별 음색 층, 사용자 tag 선택지, A/B/C 순서가 실제 녹음 UI와 연결됐다.
- `내 음색 팔레트`가 사용자 자기태그·편안함·Best take를 로컬 요약한다.
- take 수, 반복 수, duration, weekly cap/fallback을 TONE 카드에 명시했다.
- 39개 출처를 등록하고 8개 앵커를 v15에서 다시 확인했다.

### 남은 공백

1. 초급 TONE-02/03 및 Core tone day의 최종 강사 음원과 시각 데모
2. tone tag의 사용자 이해도·일관성·재현성 파일럿
3. 마이크 기종·거리·방 조건이 A/B 자기판단에 미치는 영향
4. 31개 imported source의 개별 원문 재검증
5. 고급 장르 tone의 전문가 사인오프
6. 실제 Flutter compile/test와 Android/iOS 녹음 QA

Tone Profile은 학습 보조 기록이며, 사용자의 음색 유형이나 가창 수준을 인증하지 않는다.


## 11. v16 첫 음색 vertical slice 재점검

### 해결한 공백

- Beginner Day 37 `TONE-02`와 Day 38 `TONE-03`에 날짜별 blueprint, 최대 2회 시도, 자기점검, no-voice recovery를 연결했다.
- Universal Core Cycle 1 Day 6의 Hum-to-Vowel도 같은 원칙으로 상세화했다.
- low/mid synthetic prototype 4개와 권리·SHA-256 inventory를 추가했다.
- 같은 날 반복 take가 음색 팔레트를 지배하지 않도록 안정 빈도를 `학습일 × tag`로 계산한다.
- 원본 take 수, 서로 다른 학습일, same-condition 학습일, 날짜 미상 legacy take를 분리해 보여준다.
- 음색 출처 확인 범위를 8개에서 13개로 늘렸고 26개는 pending으로 남겼다.

### 남은 핵심 위험

1. 합성 cue는 최종 강사 master가 아니며 모방 적합성이 검증되지 않았다.
2. Flutter compile·asset bundle·Android/iOS 재생을 실행하지 못했다.
3. 사용자가 `bright/warm/clean/speech-like`를 일관되게 이해하는지 모른다.
4. local day 집계는 timezone 변경과 자정 경계에서 추가 정책이 필요하다.
5. 최대 2회, 최소 3학습일은 제품 가설이다.
6. 음색 과제가 실제 프레이즈와 장기 재현으로 전이되는지 사용자 시험이 필요하다.

### 현재 출시 판정

첫 음색 vertical slice는 **정적 프로토타입 준비 완료 / 런타임·전문가·사용자 검증 미완료**다. 신규 음색 카드 확장보다 실제 Flutter/Android 실행, 강사 master, 소규모 파일럿을 먼저 수행한다.
