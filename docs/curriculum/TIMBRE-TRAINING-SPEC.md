# TIMBRE-TRAINING-SPEC — v16 음색 조절·재현 훈련

> 음색은 별도 코스나 타고난 유형 판정이 아니다. 초급–공통 코어–곡 적용–고급 장르 전 구간에서 **한 변수를 바꾸고, 편안함을 고르고, 시간이 지난 뒤 다시 재현하는 능력**으로 다룬다.

## 1. 제품용 정의

목표는 특정 가수를 복제하거나 “좋은 목소리”를 점수화하는 것이 아니다. 사용자가 작은 강도와 편안한 음역에서 다음을 할 수 있게 하는 것이다.

1. 같은 음높이·음량에서 모음이나 연결 방식 하나만 바꾼다.
2. 들리는 차이와 노력감을 자기 언어로 기록한다.
3. 더 편한 조건을 선택한다.
4. 같은 날 반복 take가 아니라 다른 학습일에도 그 선택을 재현한다.
5. 짧은 프레이즈와 장르 맥락으로 옮긴다.

음색은 네 층으로 다룬다.

| 층 | 학습 내용 | 앱 역할 |
|---|---|---|
| Source 결과 | 시작음, 숨 섞임 느낌, 또렷함, 노력감 | 직접 생리 판정 없이 자기청취·A/B |
| Filter 선택 | 모음, 혀·입 모양, 밝기/따뜻함/둥글기 | 모음 contrast와 짧은 프레이즈 |
| Transfer | 레지스터·딕션·다이내믹·마이크 조건 | 한 변수씩 바꿔 재현 |
| Style | 장르 미학과 레퍼토리 | 고급 장르 Lab에서만 적용 |

## 2. 단계별 배치

### Beginner Foundation

- Day 1/24/48 `CARD-13`: 짧은 표준샘플, 사용자 tone/comfort tag.
- Day 37 `TONE-02`: Hum-to-Vowel 첫 vertical slice.
- Day 38 `TONE-03`: 같은 편한 음에서 모음 색채 관찰.
- 목표: 음색을 만들기보다 **차이를 듣고 편안함을 기록하는 능력**.
- 코드/자산 권위: `beginner_timbre_slice_v16.json`, `assets/training/timbre_v16/`.

### Universal Vocal Core

| 구간 | 주된 음색 목표 | 핵심 카드 |
|---|---|---|
| Cycle 1–3 | 허밍→모음, 모음 차이, 편한 시작 | TONE-02/03/04/06 |
| Cycle 4–6 | gentle onset, bright/warm 선택, 같은 조건 A/B | TONE-05/07/04/06 |
| Cycle 7–9 | 작은 다이내믹, 전환 구간 tone continuity, 한국어 명료도 | TONE-08/09/10/07 |
| Cycle 10–12 | 프레이즈 tone 선택·지연 재현 | TONE-12/06/12 |

공통 나선:

```text
관찰 → 대비 → 편한 선택 → 다른 날 재현 → 조건 하나 변경 → 프레이즈 전이
```

### Repertoire Application

- Project 2: 모음 색채의 프레이즈 전이.
- Project 4: 동일 프레이즈 Bright/Warm A/B.
- Project 5: 마이크 위치·clipping/noise 조건 A/B.
- Project 6: Clean/Warm/Speech-like A/B/C와 best take.
- 한 레슨의 주 평가 기준은 하나, 보조 기준은 최대 하나다.

### Advanced Genre Labs

- 공통 Tone Palette를 장르 목표에 적용한다.
- 원곡자 복제, 유명 가수 유사도, 장르별 정답 tone은 제공하지 않는다.
- belt·강한 twang·rasp·growl·scream은 일반 음색 카드가 아니라 별도 전문가 게이트다.

## 3. v16 첫 vertical slice

### Beginner Day 37 — Hum-to-Vowel

```text
낮은/중간 prototype cue 중 편한 흐름 하나만 듣기 — 절대 음높이는 복제하지 않기
→ 내 편한 한 음에서 /m/ 2초
→ 같은 높이·크기로 /ma/ 1회
→ 최대 2회 안에서 더 편한 take와 tag 선택
```

확인 기준은 “더 밝게/크게”가 아니라 **모음으로 열 때 목·턱 힘과 음량을 늘리지 않았는가**다.

### Beginner Day 38 — Vowel Color

```text
같은 편한 음과 작은 음량 유지
→ /i-e-a-o-u/
→ 높이·음량을 그대로 두고 1회 재현
→ 편한 모음과 달라진 느낌의 tag 선택
```

### Universal Core Cycle 1 Day 6

초급 과제를 그대로 반복하지 않는다. 같은 Hum-to-Vowel 과제를 공통 코어의 `음색 전이 + 편안함` 체크로 다시 호출하며, 첫 시도 후에만 비교·피드백을 본다.

### prototype audio 경계

v16 합성 cue는 다음 용도에만 쓴다.

- 앱 asset·재생·revision·권리 inventory 검증
- 낮은/중간 기준 선택 UX 검증
- 레슨 순서와 회복 대체 UX 검증

다음을 의미하지 않는다.

- 최종 강사 가이드 master
- 건강한/잘못된 후두 설정 예시
- 사용자가 반드시 복제해야 할 정답 음색
- 임상·안전 승인

## 4. 사용자 태그

```text
clean, bright, warm, clear, soft, speech-like, round,
mic-friendly, comfortable, airy-feeling, effortful-feeling, tired
```

`airy-feeling`, `effortful-feeling`, `tired`는 사용자 자기보고다. 앱이 음성에서 자동 판정하지 않는다.

## 5. 수행·안전 규칙

- 첫 시도는 가능한 범위에서 시각 피드백 없이 수행한다.
- A/B는 최대 2 take, A/B/C는 최대 3 take.
- pitch·volume·vowel·tempo 중 한 번에 하나만 바꾼다.
- `TONE-08/09/13`은 moderate load로 취급한다.
- 통증, 쉰 느낌, 말하기 어려움, 갑작스러운 음역 손실이 있으면 음색 실험을 중단한다.
- 쉰 상태에서는 예시 듣기, 이전 take 비교, 가사·호흡 계획만 허용한다.
- whisper는 회복 대체가 아니다.

## 6. 피드백

허용:

- 사용자가 선택한 tag와 편안함 1–5
- 동일 조건 확인
- A/B/C 재생과 best take
- clipping/noise, 녹음 위치 조정 안내
- F0·phrase duration 같은 비진단 보조 정보

금지:

- 종합 음색 점수
- 성대 접촉률·폐쇄율·질환 판정
- 비성/과압착 자동 정체성 라벨
- 가수·아이돌 매칭률
- jitter/shimmer/HNR/CPPS/formant 사용자 건강 점수

## 7. Tone Profile v16

Tone Profile은 저장된 take의 사용자 선택 데이터만 집계한다.

- 원본 tagged take 수는 투명하게 표시한다.
- 안정 팔레트 빈도는 **학습일 × tag** 단위로 계산한다.
- 같은 날 같은 tag를 여러 번 녹음해도 1회만 기여한다.
- 같은 날 같은 tag에 편안함 4–5와 1–2가 함께 있으면 낮은 편안함 신호를 우선 보존한다.
- 최소 3개의 서로 다른 학습일이 있어야 “기록이 쌓임”으로 표시한다.
- 생성 시각이 없는 legacy take는 reference로 남길 수 있지만 안정 빈도에서는 제외한다.
- 녹음 삭제 후 남은 take로 즉시 재계산한다.

이는 성향 진단이나 자동 추천 엔진이 아니다.

## 8. 근거와 경계

- 공통 보컬 기능의 통합 구조는 NATS 계열 페다고지 자료를 외부 앵커로 사용한다.
- 임상 resonant voice/SOVT hierarchy는 과제 단계화 아이디어로만 사용하며 건강한 가수의 장기 효과로 직접 일반화하지 않는다.
- v16 재검증 상태는 `docs/research/v16/`을 따른다.
- 제품 수치(2 take, 3일, 음원 peak, 날짜 위치)는 `D` 제품 가설이며 사용자·전문가·기기 검증으로 조정한다.
