# 곡 적용 훈련 자산 사양 — v8

## 1. 목적

Repertoire Application의 프레이즈 자산은 작곡 기능이나 감상용 노래가 아니다. 호흡·발성·음정·리듬·음색·딕션을 실제 노래 구간과 비슷한 조건으로 전이하는 **통제된 보컬 훈련 과제**다.

## 2. 콘텐츠 설계 원칙

- 한 프레이즈의 **주 학습목표는 1개**, 보조목표는 최대 1개다.
- 첫 노출은 전체를 듣고 지도화한 뒤, 어려운 1–2마디를 국소 연습하고 다시 전체로 돌아간다.
- 모음·자음·호흡·리듬·음역 난이도를 동시에 올리지 않는다.
- 사용자의 maximum range가 아니라 usable range 안에서 key variant를 제공한다.
- guide vocal은 영구 정답이 아니라 초기 scaffold이며 단계적으로 줄인다.
- “4마디 이하”는 저작권 안전 기준이 아니다. 자체 제작 또는 명시적 라이선스를 사용한다.

## 3. 난이도 차원

정확한 가중치 점수는 제품 가설이며, 다음 차원을 각각 기록한다.

| 차원 | 낮음 | 중간 | 높음 |
|---|---|---|---|
| Range | 좁은 3–5음 | 6도 안팎 | 옥타브 근접/이상 |
| Tessitura | 편한 중심부 | 상·하단 체류 일부 | 경계 부근 체류 |
| Melodic contour | 반복·순차 | 작은 도약 | 큰 도약·복합 contour |
| Rhythm | 균등 박 | 쉼표·pickup | syncopation·빠른 자음 |
| Phrase length | 1–2마디 | 4마디 | 8마디 이상 |
| Vowel load | 한두 모음 | 다양한 모음 | 높은 음에서 어려운 모음 전환 |
| Consonant load | 열린 음절 | 받침 일부 | 빠른 군집·연속 받침 |
| Breath demand | 명확한 짧은 호흡 | 한 번의 긴 phrase | 긴 phrase 반복 |
| Tone demand | clean/neutral | warm/bright 선택 | 장르 고유 고강도 tone |
| Guide dependence | full guide | 부분 guide | guide 없음 |

출시 manifest는 각 차원을 개별 필드로 저장하고 단일 합산 점수만으로 난이도를 숨기지 않는다.

## 4. 자산 패키지

```text
assets/repertoire/<phrase_id>/
  manifest.json
  guide_vocal_low.m4a
  guide_vocal_mid.m4a
  guide_vocal_high.m4a        # 필요한 경우만
  guide_melody_piano.m4a
  backing_track.m4a
  click_track.m4a
  lyrics.json
  lyric_timing.json
  breath_marks.json
  rights.json
  qa.json
```

초급·중급에서 high key variant는 필수가 아니다. 사용자 usable range와 transpose policy에 맞춰 제공한다.

## 5. manifest 최소 필드

```json
{
  "id": "neutral_001",
  "version": 1,
  "title": "Neutral Phrase 001",
  "language": "ko",
  "bars": 4,
  "meter": "4/4",
  "tempoBpm": 72,
  "primarySkill": "phrase_breath",
  "secondarySkill": "diction_timing",
  "difficulty": {
    "rangeSemitones": 5,
    "tessituraBand": "comfortable_mid",
    "rhythm": "low",
    "vowelLoad": "low",
    "consonantLoad": "medium",
    "breathDemand": "low"
  },
  "keyVariants": ["low", "mid"],
  "trainingSequence": [
    "listen_global",
    "speak_text",
    "tap_rhythm",
    "hum_contour",
    "sing_vowel",
    "sing_lyric",
    "record_review"
  ],
  "guideFade": ["full", "melody_only", "backing_only"],
  "rightsId": "original-work-001",
  "safetyIntensity": "moderate"
}
```

## 6. guide fade 상태

| 상태 | 제공물 | 사용 목적 |
|---|---|---|
| Map | guide vocal + 가사 + 박 표시 | 전체 구조 인식 |
| Coordinate | piano guide + 시각 cue | 음정·리듬 연결 |
| Recall | backing + 선택적 시작음 | 기억에서 재현 |
| Transfer | 다른 key/tempo 또는 backing only | 조건 변화 대응 |
| Portfolio | 최소 cue, one-take | 독립 산출물 |

피드백을 줄이는 속도는 사용자 정확도 점수 하나가 아니라 반복 경험, self-confidence, 안전 상태를 함께 고려한다.

## 7. 프레이즈 유형 로드맵

### Neutral Core

- 짧은 breath phrase
- 단순 pulse/쉼표 phrase
- 3–5음 contour phrase
- 모음 일관성 phrase
- 한국어 자음 timing phrase
- clean/warm/speech-like tone A/B phrase

### Advanced Genre

- Gayo/K-pop: 한국어 hook·ballad phrase·mic tone
- Musical: speech-to-song·text intention·16-bar segment
- Classical: legato·vowel alignment·언어 diction excerpt
- R&B/Soul: groove·slow melisma·tone variation
- Rock/Band: clean energy·band-context diction·mic distance
- CCM/Worship: 긴 phrase·반복 후렴·가사 전달

고위험 tone은 일반 자산에 섞지 않고 별도 release gate를 둔다.

## 8. 자산 QA

출시 전 각 자산에 다음을 기록한다.

- 가이드 음정·리듬 오류 없음
- key별 실제 음역·tessitura
- 가사와 lyric timing 일치
- breath mark가 유일한 정답처럼 보이지 않음
- guide vocal이 과도한 장르 모방을 강요하지 않음
- clipping·noise·음량 정규화 확인
- 저작권/실연자/음원 권리 기록
- 보컬 교사 콘텐츠 검수
- high-risk cue와 카드 연결 여부
- Android/iOS 재생 QA

## 9. 현재 v8 상태

현재 scaffold:

- `neutral_001`
- `neutral_002`
- `korean_001`

manifest 구조만 존재하며 실제 가이드·반주·권리·기기 QA가 끝난 출시 자산으로 간주하지 않는다. 다음 콘텐츠 작업은 세 프레이즈를 실제 제작해 Map→Transfer 전 과정을 통과시키는 vertical slice다.

## v10 구현 상태

`neutral_001`만 prototype audio-ready다. 4마디 72 BPM 원본 프레이즈, 4박 count-in, 낮은/중간 허밍·피아노·느린 guide·backing, 공통 click, 낮은 prototype peak, rights checksum을 포함한다.

`neutral_002`와 `korean_001`은 manifest placeholder 상태이며 path의 Project 2~6에 자동 연결하지 않는다.

Flutter는 중첩 asset 디렉터리를 별도 등록해야 하므로 `pubspec.yaml`에 각 repertoire 디렉터리를 명시한다.
