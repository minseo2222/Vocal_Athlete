# v9 피드백 반영 업데이트 — 2026-06-19

## 1. 목표

v8의 리서치 정규화 결과를 실제 학습 경로와 다시 대조해 다음을 해결한다.

1. 정상 진도와 상태 기반 회복을 분리한다.
2. Universal Vocal Core의 단순 반복을 학습 의도가 있는 microcycle로 바꾼다.
3. Repertoire Application에서 한 프레이즈의 Global→Local→Global 재통합을 빠르게 만든다.
4. 장르 이름만 있고 전용 훈련이 약했던 R&B/Soul, Rock/Band, Worship를 보강한다.
5. 당일 수행이 아니라 지연 재현과 전이를 학습 증거로 다루도록 평가·방법론을 정리한다.

## 2. Beginner Foundation 재점검

- 총 48레슨 유지
- 표준샘플 Day 1/24/48 유지
- `CARD-18` 회복 카드를 정상 path에서 제거하고 런타임 fallback으로만 유지
- `CARD-14` 듣고-상상-허밍을 세 번 이상 재등장
- `CARD-13` 모음 샘플을 각 3초, 1 take로 제한
- `UC-04`의 pressed 예시는 사용자가 만들지 않고 듣기-only 비교로 변경

## 3. Universal Vocal Core 재설계

기존 36일 pass 안의 동일 12카드 반복을 제거하고 다음처럼 변경했다.

```text
12일 microcycle × 12 = 144레슨
```

각 microcycle은 다음을 다시 호출한다.

- 호흡·발성
- SOVT 전이
- Pitch & Ear
- Rhythm & Time
- Timbre/Resonance
- Registration/usable range
- 한국어 딕션
- 프레이즈 적용
- 자기평가·retrieval

공식 `UC-17` checkpoint는 Day 36/72/108/144 네 번만 둔다. 나머지 cycle은 `UC-25` 자기 코칭 retrieval로 부담을 낮춘다.

신규 카드:

- `UC-18` Breath Renewal & Phrase Landing
- `UC-19` Pitch Memory & Transposition
- `UC-20` Subdivision & Duration
- `UC-21` Vowel Continuity
- `UC-22` Key Fit Choice
- `UC-23` Phrase Arc & Intention
- `UC-24` SOVT Transfer Probe
- `UC-25` Self-Coaching Retrieval

## 4. Repertoire Application 재설계

72레슨은 유지하되, 18일짜리 기능 덩어리 대신 다음처럼 바꿨다.

```text
12일 phrase project × 6 = 72레슨
```

각 프로젝트는 다음 순서다.

```text
whole-phrase baseline
→ 가사·리듬·허밍·모음·호흡의 local scaffold
→ guide 축소
→ 전체 프레이즈 복귀
→ delayed retrieval / 한 조건 transfer
```

신규 카드:

- `RA-09` Global Phrase Baseline
- `RA-10` Delayed Retrieval & Project Review

각 프로젝트는 `RA-09`로 시작해 `RA-10`으로 끝난다. 이 단계는 작곡·제작 기능이 아니라 보컬 기술의 실제 프레이즈 적용이다.

## 5. 장르 트랙 보강

다른 장르 카드 재활용에 의존하던 세 트랙에 저위험 전용 카드를 추가했다.

- R&B/Soul: `RB-01~06`
- Rock/Band: `RK-01~06`
- Worship/Christian CCM: `WC-01~06`

Rock의 rasp/growl/scream, 강한 belt, 고강도 projection은 추가하지 않았다. 모든 Advanced Lab은 여전히 미출시 기본값이며 전문가 검수·cap·fallback·device QA가 필요하다.

## 6. 학습 방법론·평가 변경

추가/갱신:

- `LEARNING-METHODOLOGY-SPEC.md`
- `CURRICULUM-QUALITY-GATES.md`
- `ASSESSMENT-RUBRIC.md`
- `CURRICULUM-REVIEW.md`
- `docs/research/v9/CURRICULUM-RECHECK.md`
- `docs/research/v9/VERIFIED-SOURCES.md`

핵심 원칙:

- 짧은 attempt를 먼저 확보하고 설명·피드백을 과도하게 겹치지 않는다.
- 한 세트의 primary criterion은 하나다.
- 사용자가 먼저 자기평가한 뒤 결과형 피드백을 본다.
- 피드백은 모델+cue → 선택형 cue → 결과 요약 → 독립 take로 줄인다.
- 일일 해금은 completion 기반을 유지한다.
- 학습 증거는 retention·transfer·독립 녹음으로 분리한다.
- 12일 cycle, 시도 횟수, checkpoint 간격은 제품 가설이며 파일럿으로 조정한다.

## 7. 코드·테스트 변경

주요 코드:

- `app/lib/progression/path.dart`
- `app/lib/lesson/card_library.dart`

테스트:

- `app/test/path_test.dart`
- `app/test/card_library_test.dart`

정적 검증 스크립트:

- `tools/validate_v9.py`

## 8. 남은 블로커

1. 첫 Universal 12일 microcycle의 실제 음원·화면·피드백 완성
2. 첫 Repertoire 12일 project의 자체 프레이즈·guide·backing·권리 기록
3. Android/iOS 실제 기기 F0·timing·녹음 QA
4. 초보자 formative test와 delayed retention/transfer 측정
5. 장르 전문가의 RB/RK/WC 카드 검수
6. 고급 트랙 전체의 HITL·runtime cap·rollout 승인
7. 평가 루브릭 평가자간 신뢰도

## 9. 출시 판단

- Beginner: 콘텐츠·기기·초보자 이해도 QA 후 MVP 후보
- Universal Core: 구조 개선 완료, 실제 자산·사용자 검증 전 미출시
- Repertoire Application: 구조 개선 완료, 실제 프레이즈 자산 전 미출시
- Advanced Genre Labs: 전부 미출시
