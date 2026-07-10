# Universal Vocal Core — v16 중급 공통 보컬 코어

> 코드 권위: `buildUniversalCoreManifest()` = **12일 microcycle × 12 = 144 slots**. 세 microcycle이 하나의 macro phase를 이룬다.

## 1. 목적

모든 장르에 공통으로 필요한 보컬 엔진을 만든다. 사용자는 특정 스타일을 흉내 내기 전에 다음 능력을 반복해서 꺼내고 다른 조건으로 옮기는 법을 배운다.

- phrase에 맞는 호흡과 짧은 갱신 호흡
- 안전한 onset과 phonation contrast
- SOVT에서 모음·음절·가사로의 전이
- pitch memory, relative pitch, 시작음 전이
- pulse, subdivision, 쉼표, 자음 timing
- 모음 연속성과 tone palette
- usable range와 편한 key 선택
- 한국어 딕션
- phrase arc, intention, self-coaching

## 2. v16 나선형 설계 원칙

매 12일마다 주요 능력을 다시 호출하는 나선형 구조를 유지한다. v16에서는 음색도 독립 미학 점수가 아니라 모음·발성 시작·레지스터·딕션·프레이즈 전이를 잇는 공통 역량으로 명시한다.

```text
호흡/발성
→ SOVT 전이
→ Pitch & Ear
→ Rhythm & Time
→ Timbre/Vowel
→ Range/Key
→ Diction
→ Phrase Integration
→ Retrieval/Review
```

정식 `UC-17` 표준 체크포인트는 Day 36/72/108/144 네 번만 사용한다. 나머지 microcycle 말미에는 `UC-25` 자기 코칭 재현 과제를 사용한다.

## 3. 네 macro phase

| Phase | microcycle | slots | 역할 | 피드백 상태 |
|---|---:|---:|---|---|
| 1. Map & Coordinate | 1–3 | 1–36 | 과제 차이와 편한 coordination 찾기 | 모델·cue 충분 |
| 2. Stabilize & Compare | 4–6 | 37–72 | 한 변수씩 바꾸며 안정화 | A/B·deferred feedback |
| 3. Retain & Vary | 7–9 | 73–108 | 지연 재현과 조건 변형 | 묶음 피드백·모델 감소 |
| 4. Transfer & Check | 10–12 | 109–144 | phrase 통합과 독립 자기수정 | 요청형 피드백·산출물 중심 |

36/72/108/144라는 위치는 제품 설계값이며 생물학적 최적값으로 주장하지 않는다.

## 4. 역량별 학습 내용

| 영역 | 핵심 카드 | 학습 목표 | 고급으로 미룰 것 |
|---|---|---|---|
| Breath/Phonation | UC-01~04, UC-18 | 4–8박 phrase, 갱신 호흡, 편한 onset | 고강도 projection, 극단 장구절 |
| SOVT Transfer | UC-05, UC-24 | SOVT→contour→모음→가사 | 고저항·고강도 dose |
| Pitch & Ear | CARD-12/14, UC-06/07/19 | 듣기·기억·시작음 전이 | 절대음감 평가, 고음 랭킹 |
| Rhythm & Time | CARD-15, UC-08/09/20 | pulse·subdivision·쉼표·음절 timing | 장르 groove 미학 |
| Timbre/Vowel | TONE-02~08, UC-10/21 | 모음 연속성, clean/warm/bright 조절 | rasp/growl/scream, 가수 매칭 |
| Registration/Key | UC-13/14/22, TONE-09 | usable range, 변화 지점, 편한 key | forced mix, belt, passaggio handling |
| Diction/Phrase | CARD-17, UC-15/16/23 | 자음 timing, phrase arc, intention | 장르별 언어 미학 |
| Retrieval | UC-25/17 | 모델 없는 시도, 자기 cue, 지연 비교 | 총점·정체성 라벨 |

## 5. v9 보강 카드

- `UC-18 Breath Renewal & Phrase Landing`
- `UC-19 Pitch Memory & Transposition`
- `UC-20 Subdivision & Duration`
- `UC-21 Vowel Continuity`
- `UC-22 Key Fit Choice`
- `UC-23 Phrase Arc & Intention`
- `UC-24 SOVT Transfer Probe`
- `UC-25 Self-Coaching Retrieval`

`UC-04`는 사용자가 pressed phonation을 일부러 만들게 하지 않는다. 가벼운 숨 섞임과 편한 균형만 짧게 비교하며, 눌린 예시는 듣기-only로 제한한다.


## 6. v16 음색 나선형 모듈

음색은 12주 독립 코스로 분리하지 않는다. 같은 기초 기능을 더 적은 도움과 새로운 조건에서 다시 사용한다.

| Microcycle | 목표 | 대표 카드 | 확인 방식 |
|---|---|---|---|
| 1–3 | 허밍→모음, 모음 차이, 편한 시작 관찰 | TONE-02/03/04/06 | 자기태그·편안함·2 take 이하 |
| 4–6 | gentle onset, bright/warm 선택, 같은 조건 A/B | TONE-05/07/04/06 | 첫 시도 후 A/B, 더 편한 take 선택 |
| 7–9 | 작은 다이내믹, 전환 구간 tone continuity, 한국어 명료도 | TONE-08/09/10/07 | 부하 상한·지연 피드백·낮은 강도 |
| 10–12 | 프레이즈 tone 선택과 재현 | TONE-12/06/12 | clean/warm/speech-like A/B/C, best take |

공통 수행 순서는 다음과 같다.

```text
관찰 → 대비 → 편한 선택 → 같은 조건 재현 → 조건 하나 변경 → 프레이즈 전이
```

- 한 번에 pitch·volume·vowel·tempo 중 하나만 바꾼다.
- A/B는 최대 2 take, A/B/C는 최대 3 take다.
- `TONE-08/09`는 moderate load이며 피곤함에는 축소, 쉰 느낌에는 no-voice 대체한다.
- 앱은 source/filter 결과를 생리 상태나 발성 유형으로 역추정하지 않는다.
- Tone Profile은 사용자가 고른 tag·편안함·Best take만 사용하고, 안정 빈도는 같은 날 반복 take가 아닌 `학습일 × tag`로 집계한다.
- Cycle 1 Day 6은 `universal_core_cycle_01.json` v16 blueprint와 timbre_v16 prototype cue를 사용한다.

## 7. 12일 microcycle 품질 게이트

각 microcycle에는 반드시 다음이 하나 이상 들어간다.

1. Pitch/Ear
2. Rhythm/Time
3. Phrase transfer
4. Retrieval 또는 formal checkpoint

또한 다음 규칙을 지킨다.

- primary learning criterion 1개
- secondary criterion 최대 1개
- 고음역과 고음량 변수를 같은 날 함께 올리지 않음
- 정상 path에는 recovery 카드 미배치
- 첫 시도는 가능한 범위에서 화면·모델 없이 수행
- 안전 문제가 없으면 2–3회의 짧은 시도 후 묶음 피드백

## 8. 체크포인트와 졸업 증거

정식 checkpoint는 Day 36/72/108/144에만 기록한다.

- 4–8박 phrase와 갱신 호흡
- safe onset A/B
- SOVT→가사 전이
- 3–5음 pitch memory와 새 시작음
- subdivision/rest-entry rhythm
- vowel/tone A/B 및 선택한 tone의 지연 재현
- usable range와 key fit
- 한국어 neutral phrase
- 모델 없는 자기 코칭 재시도

일일 해금은 completion 기반이다. Core 졸업 산출물은 E2 retention과 E3 transfer를 포함해야 하지만, 미검증 숫자 컷으로 사용자 진도를 차단하지 않는다.
