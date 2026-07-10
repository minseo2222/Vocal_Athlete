# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `9. Advanced Gayo - K-Pop #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `09-advanced-gayo-background.md`

---

## 1. Executive Summary

**Advanced Gayo / K-Pop Lab은 “고음을 잘 내는 앱”이 아니라, 사용자가 현대 상업음악 환경에서 녹음·마이크·가사·프레이징·감정·음색·앙상블 역할을 수행할 수 있게 만드는 역량 기반 커리큘럼이어야 합니다.** K-Pop과 한국 가요는 성악의 “좋은 소리” 기준으로 평가하면 핵심을 놓칩니다. NATS와 Journal of Singing 계열 자료는 K-Pop 보컬을 contemporary pop, R&B, hip-hop, dance-pop의 CCM 문맥에서 보며, speech-like delivery, casual diction, phrasing, registration choice, tone color, audio technology를 중요한 요소로 다룹니다. [B | Consensus] ([NATS][1])

제품팀 관점의 최종 결론은 다음입니다.

| 결론                                                                                                                                                                            | 제품 판단                                                                                               | 근거 수준 |                                       |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | ----- | ------------------------------------- |
| K-Pop / 가요 보컬은 성악식 공명·비브라토·발성 균질성보다 **CCM 스타일 수행능력**으로 평가해야 한다.                                                                                                               | 앱의 기본 루브릭에서 “클래식처럼 둥글고 풍성한 소리”를 정답으로 두면 안 된다.                                                       | **B   | Consensus**                           |
| 핵심 역량은 고음이 아니라 **speech-like tone, lyric delivery, microphone technique, recording performance, phrasing, emotional communication, tone variation, ensemble compatibility**다. | 단일 점수 대신 8개 역량별 진행도를 제공해야 한다.                                                                       | **B   | Consensus** ([NATS][1])               |
| K-Pop은 “원곡 가수처럼 복제”가 아니라 **스타일 문법을 이해한 뒤 자기 음색으로 적용**하는 방향이 안전하다.                                                                                                             | “원곡과 다르면 감점” 피드백을 금지하고, “스타일 기능을 유지하면서 다른 선택도 허용”해야 한다.                                             | **B/C | Consensus + Controversy** ([NATS][1]) |
| 마이크와 녹음은 보컬 외부 장비가 아니라 CCM 보컬 수행의 일부다.                                                                                                                                        | 앱은 피치·리듬만 보지 말고 clipping, plosive, distance, level consistency, doubling, stack alignment를 평가해야 한다. | **B   | Consensus**                           |
| breathy tone과 clean tone은 둘 다 스타일 자원이다. 그러나 피로·쉰 목소리·통증 상태에서 breathy/whisper 계열을 반복 훈련시키면 안전 리스크가 있다.                                                                         | 앱은 “breathy=나쁨”도, “breathy=섹시하니 많이”도 피해야 한다.                                                        | **B/D | Controversy** ([NATS][1])             |
| 보컬 건강은 앱이 진단할 수 없다. 쉰 목소리, 고음 상실, 말하기 노력 증가, 목 통증, 반복적 목청 가다듬기는 안전 게이트로 처리해야 한다.                                                                                              | 앱은 의학적 진단 대신 중단·휴식·전문가 상담 권고를 제공해야 한다.                                                              | **A   | Consensus** ([ASHA][2])               |

---

## 2. Evidence Review

### 2.1 검색 범위

핵심 근거로 **25개 이상**의 자료를 검토했습니다. 우선순위는 NATS / Journal of Singing, Voice Foundation, ASHA, NIH/NIDCD, peer-reviewed 논문, 대학·컨서버토리 커리큘럼, Berklee, NYU, conservatory 자료 순으로 두었습니다. 유튜브, 블로그, 개인 코치 의견은 핵심 근거로 사용하지 않았습니다.

검토 자료는 다섯 그룹으로 나뉩니다.

| 그룹                                              | 주요 자료                                                                                                   | 제품 설계에서 쓰는 방식                                                                              |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| NATS / Journal of Singing                       | K-Pop pedagogy, CCM pedagogy, audio technology, commercial music glossary                               | K-Pop을 CCM으로 정의하고, speech-like delivery, casual diction, mic/recording, style features를 도출 |
| Voice Foundation / AATS                         | CCM pedagogy 프레임, 스타일별 안전한 테크닉 필요성                                                                      | “한 가지 발성법으로 모든 장르를 가르치지 않는다”는 제품 원칙                                                        |
| ASHA / NIDCD / Voice health 연구                  | 음성장애 정의, 고위험 사용자, red flags, 가수 dysphonia prevalence                                                    | Safety Gates와 앱 금지 피드백 설계                                                                  |
| Peer-reviewed K-Pop / Korean pop / recording 연구 | K-pop audio features, Korean ballad, lyric-emotion, KVT vocal tags, live vocal/backing-track 연구         | K-Pop vs 가요 차이, hook/chorus energy, lyric delivery, AI 피드백 한계                              |
| Berklee / NYU / conservatory curricula          | contemporary voice, vocal production, popular singing styles, digital media performance, K-pop ensemble | 앱 커리큘럼을 studio, performance, ensemble, portfolio 중심으로 변환                                   |

### 2.2 비교: 성악식 보컬 교육 vs CCM / K-Pop 보컬 교육

CCM 보컬 교육 자료들은 classical technique을 모든 장르의 기본값으로 적용하는 접근을 비판합니다. Journal of Singing의 CCM pedagogy 논의는 CCM이 voice quality, tone, registration, speech quality phonation, vocal effects 면에서 classical singing과 다른 요구를 가진다고 설명합니다. AATS 또한 한 가지 테크닉이 모든 스타일의 performing needs를 충족하지 않는다고 정리합니다. [B | Consensus] 

K-Pop 관련 NATS / Journal of Singing 자료는 K-Pop vocal delivery가 contemporary pop, R&B, hip-hop 스타일에 뿌리를 두며, registration, ornament, dynamic shift, articulation, phrasing, riffs, groove, vibe, audio technology를 함께 분석해야 한다고 봅니다. 특히 K-Pop의 diction은 speech-driven, casual, percussive, syllabic 특성을 가질 수 있고, clean onset/offset이 기본이지만 breathy, glottal, fry도 스타일적으로 사용될 수 있다고 설명합니다. [B/C | Consensus] ([NATS][1])

### 2.3 비교: 한국 가요 / 발라드 vs K-Pop

한국 가요, 특히 발라드는 느리거나 중간 템포, 넓은 선율선, 섬세한 감정 표현, 가사 중심의 사랑·이별 정서가 중요한 장르로 설명됩니다. 한국대중음악 연구에서도 발라드는 한국 대중음악의 중요한 양식으로 다루어져 왔습니다. [B | Consensus] ([KCI][3])

반면 K-Pop은 한국 대중음악 전체와 동일하지 않습니다. 최근 대중음악 연구는 K-Pop을 pop, hip-hop, R&B, electronic, dance-pop 요소가 혼합된 글로벌 상업음악 양식으로 분석하며, danceability, energy, speechiness 같은 오디오 특징을 비교 대상으로 삼습니다. [A/B | Consensus] ([Cambridge University Press & Assessment][4])

제품 설계상 가요 Lab과 K-Pop Lab의 차이는 다음처럼 정리됩니다.

| 항목    | Advanced Gayo                                          | Advanced K-Pop                                                        |
| ----- | ------------------------------------------------------ | --------------------------------------------------------------------- |
| 핵심 수행 | 긴 감정선 유지, 가사 전달, 호흡·프레이징, ballad arc                   | 짧은 파트 완성도, hook energy, tone switching, group role                    |
| 보컬 위치 | solo narrator                                          | lead / sub-vocal / harmony / ad-lib / chorus layer 중 하나               |
| 음색    | clean, intimate, restrained vibrato, emotional release | bright / speech-like / breathy / clean / shouty accent / stacked tone |
| 리듬    | rubato-like phrasing 가능                                | click, groove, choreography, syllabic precision 중요                    |
| 앱 평가  | 감정선·가사·프레이징 중심                                         | recording, mic, ensemble, hook, tone variation 중심                     |

### 2.4 비판: 현재 근거의 한계

K-Pop 보컬에 대한 직접적인 임상·생리학 연구는 아직 충분하지 않습니다. NATS의 K-Pop pedagogy 자료는 매우 유용하지만, 많은 부분이 전문가 청취·교육 현장 분석에 기반합니다. 따라서 “K-Pop 보컬의 유일한 정답 발성”으로 해석하면 안 됩니다. [C/D | Insufficient Evidence] ([NATS][1])

K-Pop vocal tagging 연구와 KVT dataset은 K-Pop 녹음에서 vocal timbre와 expression tag를 다루기 때문에 앱 AI 설계에 유용합니다. 그러나 해당 데이터는 pedagogical correctness나 vocal health를 판정하는 데이터가 아니라, 10초 단위 segment와 semantic tag 중심의 연구입니다. 따라서 앱이 “이 소리는 건강하다 / 틀렸다 / 정통 K-Pop이다”라고 판정하는 근거로 쓰기에는 부족합니다. [D | Insufficient Evidence] 

라이브 K-Pop 보컬도 단순히 fancam이나 방송 음원으로 “실력”을 판정하기 어렵습니다. 최근 연구는 K-Pop live performance에서 prerecorded backing tracks와 in-ear monitor 환경이 보컬을 더 풍성하게 만들 수 있다고 설명합니다. 이는 제품팀이 “라이브처럼 들림 = 실제 생목소리 능력”으로 단순화하면 안 된다는 뜻입니다. [D | Controversy] ([arXiv][5])

### 2.5 통합: 앱 커리큘럼으로 바꿀 때의 핵심 원칙

Advanced Gayo / K-Pop Lab은 “무엇을 가르칠까”가 아니라 “사용자가 무엇을 할 수 있게 될까”로 설계해야 합니다. Berklee와 NYU의 contemporary voice, vocal production, popular singing styles, digital media performance 관련 커리큘럼도 voice technique만이 아니라 performance, style, recording, band/group work, repertoire, critique, portfolio를 함께 다룹니다. [B | Consensus] ([버클리 음악 대학][6])

따라서 앱의 기본 루프는 다음이어야 합니다.

**듣기 → 스타일 표식 찾기 → 짧게 녹음 → 마이크/테이크 확인 → 감정·가사·프레이징 비교 → 자기 음색으로 재녹음 → 포트폴리오 제출**

---

## 3. Consensus

### 3.1 전문가 합의: 제품팀이 신뢰해도 되는 내용

| 합의 주장                                                                  | 앱 설계 의미                                                                                           | 근거 수준 |                                                                |
| ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ----- | -------------------------------------------------------------- |
| K-Pop / 가요는 CCM 범주에서 다뤄야 하며, classical default로 평가하면 안 된다.             | 앱 점수 체계에서 classical resonance, uniform vibrato, operatic vowel을 기본 정답으로 두지 않는다.                   | **B   | Consensus**                                                    |
| K-Pop 보컬은 speech-like, casual, rhythmic, percussive diction을 포함할 수 있다. | “말하듯이 → 리듬화 → 노래화” 훈련을 핵심 카드로 둔다.                                                                 | **B/C | Consensus** ([NATS][1])                                        |
| 가사 전달과 감정 전달은 한국 가요·발라드에서 핵심 역량이다.                                     | 앱은 pitch accuracy만이 아니라 lyric keyword, emotional intent, listener recognition을 평가해야 한다.           | **A/B | Consensus** ([KCI][7])                                         |
| 마이크와 녹음 기술은 CCM 보컬 수행의 일부다.                                            | 앱은 dry vocal, guide mix, mic distance, clipping, plosive, stack alignment를 리뷰해야 한다.               | **B   | Consensus**                                                    |
| K-Pop은 hook, chorus energy, production layer, group role을 포함한다.        | 앱은 solo singing만이 아니라 lead, double, harmony, ad-lib, chorus blend 과제를 제공해야 한다.                    | **B/D | Consensus with Limited Evidence** ([Korea Journal Central][8]) |
| tone variation은 결함이 아니라 스타일 자원이다.                                      | clean, breathy, straight tone, vibrato release, falsetto, speech-like, fry accent를 “색깔 카드”로 제공한다. | **B/C | Consensus** ([NATS][1])                                        |
| 보컬 건강 red flag는 앱에서 최우선 게이트로 처리해야 한다.                                  | 통증, 쉰 소리, 고음 상실, 말하기 노력 증가, 목청 가다듬기를 감지하거나 자가보고하면 강도 높은 과제를 잠근다.                                  | **A   | Consensus** ([ASHA][2])                                        |
| advanced learner에게는 “정답 음색”보다 self-directed recording review가 중요하다.    | 앱은 imitation score보다 take selection, self-review, portfolio evidence를 강화한다.                       | **B/C | Consensus** ([ResearchSpace][9])                               |

---

## 4. Controversies

### 4.1 전문가 논쟁

| 논쟁 지점                                       | 왜 논쟁인가                                                                  | 제품팀 결정                                                                                     |
| ------------------------------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| **mix / belt / chest / head / register 용어** | CCM 현장과 음성 과학, 코치마다 용어가 다르다. 같은 소리를 다른 용어로 설명할 수 있다.                    | 앱은 “당신은 chest를 잘못 쓴다”처럼 단정하지 말고, “밝기, 압력감, 음량, 피로도, 피치 안정성” 같은 관찰 가능한 피드백을 준다. **[B/C]**   |
| **breathy tone의 가치**                        | K-Pop과 발라드에서 breathy tone은 표현 자원이나, 피로·쉰 목 상태에서 반복되면 위험할 수 있다.          | breathy를 금지하지 말되, duration, effort, recovery, hoarseness gate를 둔다. **[B/D]** ([NATS][1])   |
| **원곡 모방 vs 자기 음색**                          | K-Pop 학습자는 reference imitation이 필요하지만, 원곡 복제는 정체성·안전·저작권·편집 환경 문제를 만든다. | “원곡의 기능을 분석하되, 사용자 버전으로 재구성”하는 과제를 둔다. **[B/C]** ([NATS][1])                               |
| **라이브 실력 판정**                               | K-Pop 라이브에는 backing track, in-ear, broadcast mix가 개입될 수 있다.             | 앱은 방송·fancam 비교를 실력 판정 근거로 쓰지 않는다. 사용자의 dry take와 guide mix를 분리 평가한다. **[D]** ([arXiv][5]) |
| **AI가 K-Pop tone을 자동 판정할 수 있는가**            | KVT 같은 데이터는 semantic tag 연구에는 유용하지만, 보컬 건강·정답성 판정 데이터가 아니다.             | AI는 “가능한 tone tag 후보”만 제시하고, 확정 진단·정답 판정은 피한다. **[D]**                                     |

### 4.2 근거 부족

| 근거 부족 주장                                          | 처리 방식                                                                                                |
| ------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| “K-Pop 보컬은 반드시 특정 후두 위치 / 특정 공명 / 특정 mix로 해야 한다.” | **Insufficient Evidence [D]**. 앱에서 생리학적 단정을 금지한다.                                                    |
| “고음 점수가 높으면 K-Pop 보컬 역량이 높다.”                     | **Insufficient Evidence [D]**. 고음은 일부 역량일 뿐, 본 Lab의 핵심 8역량과 분리한다.                                    |
| “breathy tone 비율을 수치로 맞추면 K-Pop답다.”               | **Insufficient Evidence [D]**. 문맥·가사·마이크·피로도 기반으로 판단한다.                                              |
| “휴대폰 마이크만으로 성대 건강을 진단할 수 있다.”                     | **Insufficient Evidence / Safety Risk [D]**. ASHA와 NIDCD 기준상 전문 평가가 필요한 영역은 앱이 진단하지 않는다. ([ASHA][2]) |
| “원곡 가수와 spectral similarity가 높을수록 좋은 훈련이다.”       | **Insufficient Evidence [D]**. 앱은 style function similarity와 user identity를 분리한다.                    |

---

## 5. Curriculum Design Implications

### 5.1 가요 보컬 핵심 역량

Advanced Gayo의 목표는 사용자가 **한국어 가사와 감정선을 중심으로, 긴 프레이즈를 설득력 있게 전달하는 녹음 가능한 보컬**이 되는 것입니다. 한국 발라드 자료는 느리거나 중간 템포, 선율적 폭, 섬세한 감정 표현을 강조하며, 한국어 가사·정서 전달 연구도 lyric concentration과 emotional delivery의 교육적 가치를 보여줍니다. [B | Consensus] ([KCI][7])

| Gayo 역량             | 사용자가 할 수 있게 되는 것                                      | 근거 수준   |
| ------------------- | ----------------------------------------------------- | ------- |
| Lyric narrative     | 한 절 안에서 화자, 대상, 감정 전환을 구분해 부른다.                       | **B**   |
| Emotional arc       | verse의 절제와 chorus의 감정 상승을 과장 없이 만든다.                  | **B**   |
| Phrasing            | 한국어 조사·어미·핵심어를 살리며 breath point를 설계한다.                | **B/C** |
| Clean intimate tone | 마이크 가까이에서도 과압 없이 선명한 tone을 유지한다.                      | **B**   |
| Controlled release  | chorus에서 음량만 키우지 않고 vowel, onset, dynamics로 에너지를 만든다. | **B/C** |

### 5.2 K-Pop 보컬 핵심 역량

Advanced K-Pop의 목표는 사용자가 **짧은 파트 안에서 캐릭터, groove, mic tone, hook energy, ensemble fit을 빠르게 구현하는 녹음 가능한 보컬**이 되는 것입니다. NATS의 K-Pop pedagogy 자료는 articulation, phrasing, riffs, groove, vibe, registration, audio technology를 함께 다루며, Berklee의 K-Pop ensemble 자료도 K-Pop이 R&B, hip-hop, funk, indie, rock 요소와 한국어 수행을 포함한다고 설명합니다. [B | Consensus] ([NATS][1])

| K-Pop 역량               | 사용자가 할 수 있게 되는 것                                                          | 근거 수준   |
| ---------------------- | ------------------------------------------------------------------------- | ------- |
| Speech-like verse      | 말하듯 시작해 pitch와 groove 안으로 넣는다.                                            | **B/C** |
| Hook energy            | 후렴에서 음량만이 아니라 timing, vowel, articulation, mic distance로 에너지를 만든다.        | **B/D** |
| Tone switching         | clean, breathy, bright, straight, vibrato release, falsetto 계열을 문맥별로 바꾼다. | **B/C** |
| Recording role         | lead, double, harmony, ad-lib, backing layer를 구분해 녹음한다.                   | **B**   |
| Ensemble compatibility | 다른 보컬과 timing, vowel, level, character가 충돌하지 않게 맞춘다.                      | **B/C** |

### 5.3 공통점과 차이점

| 구분       | 공통점                                                                                 | 차이점                                                                                   |
| -------- | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| 공통 핵심    | lyric delivery, mic tone, emotional intent, phrasing, clean recording, vocal safety |                                                                                       |
| Gayo 중심  |                                                                                     | 긴 감정선, 서사, ballad phrasing, solo identity                                             |
| K-Pop 중심 |                                                                                     | hook, short-part impact, group role, production stack, choreography-friendly delivery |
| 앱 설계     | 두 Lab 모두 dry recording과 self-review 필요                                              | Gayo는 narrative arc rubric, K-Pop은 role / hook / ensemble rubric 강화                   |

### 5.4 연구 결과의 커리큘럼 변환

아래 표는 “무엇을 가르칠까”가 아니라 “사용자가 무엇을 할 수 있게 될까” 기준으로 구성한 핵심 8역량입니다.

| 역량                      | 학습목표                                                                   | 훈련과제                                                                  | 피드백                                                                            | 졸업기준                                                        | 근거                                             |
| ----------------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------- | ---------------------------------------------- |
| Speech-like Tone        | 사용자가 verse를 말하듯 자연스럽게 시작해 pitch 안에 넣을 수 있다.                            | ① 가사 말하기 ② rhythm chant ③ 70% 음량 singing ④ 원곡 없이 재녹음                  | syllable clarity, 과도한 vibrato, forced brightness, timing drift, effort rating  | 같은 4마디를 spoken → sung으로 전환해도 가사 이해도와 pitch 안정성이 유지된다.       | **B/C** ([NATS][1])                            |
| Lyric Delivery          | 사용자가 핵심어, 감정 전환, 문장 방향을 들리게 만든다.                                       | lyric map, keyword underline, emotion take 3종                         | listener keyword recall, diction clarity, phrase ending, emotional consistency | 블라인드 청취자가 핵심어와 감정을 70% 이상 맞힌다.                              | **A/B** ([KCI][7])                             |
| Microphone Technique    | 사용자가 mic distance와 angle로 tone과 level을 조절한다.                           | 10cm / 20cm / 30cm take, plosive test, chorus pull-back               | clipping, plosive, sibilance, level consistency, proximity effect              | chorus에서도 clipping 없이 level variation을 ±3dB 안팎으로 관리한다.      | **B**                                          |
| Recording Performance   | 사용자가 한 곡 파트를 studio-ready take로 만든다.                                   | 3-take recording, comp selection, double, harmony stack               | take consistency, noise, timing, edit readiness, headphone bleed               | lead + double + harmony/ad-lib 3-layer 제출 가능                | **B** ([University of Miami Scholarships][10]) |
| Phrasing                | 사용자가 groove를 유지하면서 앞당김·늦춤·breath point를 설계한다.                          | metronome grid, push/pull phrase, breath mark                         | onset timing, phrase arc, rushed ending, breath noise                          | guide track 없이도 phrase intent가 유지된다.                        | **B/C** ([NATS][1])                            |
| Emotional Communication | 사용자가 같은 문장을 다른 정서로 구분해 전달한다.                                           | same-line 3 emotions, camera/mic intimacy take                        | listener emotion recognition, dynamics, consonant weight, overacting flag      | 3개 감정 take가 청자에게 구분된다.                                      | **A/B** ([PubMed][11])                         |
| Tone Variation          | 사용자가 clean, breathy, bright, straight, vibrato release 등을 목적에 맞게 선택한다. | tone card A/B, clean vs breathy contrast, straight-to-vibrato release | tone label confidence, onset type, fatigue, consistency                        | 4개 tone card를 1문장 안에서 안전하게 구분한다.                            | **B/D** ([NATS][1])                            |
| Ensemble Compatibility  | 사용자가 group context에서 blend, contrast, role clarity를 만든다.               | unison blend, harmony, call-response, chorus stack                    | timing with guide, vowel match, level balance, masking                         | lead를 방해하지 않는 backing take와 자기 파트가 드러나는 lead take를 모두 제출한다. | **B/C** ([버클리 음악 대학][12])                      |

---

## 6. App Implementation Implications

### 6.1 앱의 핵심 제품 구조

Advanced Gayo / K-Pop Lab은 다음 4개 모드로 구성하는 것이 가장 적합합니다.

| 모드                        | 목적                                              | 주요 출력물                            |
| ------------------------- | ----------------------------------------------- | --------------------------------- |
| **Ballad Narrative Mode** | 가요·발라드의 감정선, 가사, 프레이징 강화                        | verse + chorus emotional arc take |
| **K-Pop Part Mode**       | 짧은 파트의 캐릭터, speech-like tone, hook energy 강화    | 15–30초 role-based take            |
| **Studio Stack Mode**     | lead, double, harmony, ad-lib, backing layer 녹음 | 3–5 track vocal stack             |
| **Ensemble Fit Mode**     | 다른 보컬과 timing, vowel, level, tone이 맞는지 확인       | group mix-compatible take         |

이 구조는 Berklee의 vocal production, popular singing styles, group singing, contemporary commercial performance 교육과 NYU의 digital media performance, critique, repertoire portfolio 방식과도 잘 맞습니다. [B | Consensus] ([Berklee Online][13])

### 6.2 앱 피드백 레이어

앱 피드백은 한 번에 “잘함/못함”을 말하지 말고, 다음 순서로 제공해야 합니다.

| 레이어                  | 앱이 먼저 확인할 것                                           | 이유                              |
| -------------------- | ----------------------------------------------------- | ------------------------------- |
| 1. Safety Gate       | 통증, 쉰 목, 피로, clipping, 과도한 음량 요구                      | 건강 리스크가 있으면 스타일 피드백보다 중단·완화가 우선 |
| 2. Audio Gate        | mic distance, clipping, noise, plosive, guide balance | 녹음 품질이 나쁘면 보컬 피드백이 왜곡됨          |
| 3. Competency Rubric | 8역량별 0–4 레벨                                           | 단일 총점보다 학습 경로 추천에 유리            |
| 4. Style Function    | 이 선택이 lyric, groove, emotion, role에 맞는가               | 원곡 모방보다 기능 중심                   |
| 5. Next Best Task    | 다음 1개 과제만 추천                                          | advanced user도 과제 과부하를 피해야 함    |

### 6.3 앱에서 제공하면 안 되는 피드백

| 금지 피드백                        | 왜 금지해야 하는가                              | 대체 피드백                                                                            |
| ----------------------------- | --------------------------------------- | --------------------------------------------------------------------------------- |
| “원곡 가수와 다르니 틀렸습니다.”           | 모방 강박과 unsafe imitation을 유발한다.          | “원곡의 기능은 breathy intimacy입니다. 당신 버전에서는 clean intimacy로도 유지됩니다.”                   |
| “고음이 약하므로 K-Pop 보컬 점수가 낮습니다.” | K-Pop 역량을 고음으로 축소한다.                    | “hook energy는 pitch, timing, diction, mic distance, ensemble level로 나눠 봅니다.”      |
| “더 세게 밀어주세요.”                 | 과압, 피로, clipping을 유발할 수 있다.             | “mic에서 5cm 물러나고 vowel을 밝게 하며 음량은 유지하세요.”                                          |
| “목을 열어라 / 배로 밀어라.”            | 관찰 불가능하고 장르별로 오해가 크다.                   | “현재 take는 phrase end에서 pitch가 20 cents 낮아지고 effort가 높습니다. 70% intensity로 재녹음하세요.” |
| “breathy는 나쁜 소리입니다.”          | K-Pop·발라드의 표현 자원을 제거한다.                 | “breathy는 1–2단어 강조에 사용하고, phrase 전체에서는 clean tone으로 회복하세요.”                       |
| “AI가 성대결절 가능성을 감지했습니다.”       | 앱이 의학적 진단을 해서는 안 된다.                    | “쉰 목소리·통증·말하기 노력 증가가 있으면 훈련을 중단하고 전문가 상담을 고려하세요.”                                 |
| “클래식처럼 더 둥글게, 비브라토를 더 크게.”    | CCM/K-Pop 스타일과 충돌할 수 있다.                | “이 phrase는 straight tone 유지 후 마지막 음절에서 짧게 release해보세요.”                           |
| “라이브 영상처럼 들리지 않으니 실력이 부족합니다.” | K-Pop live mix와 backing track 환경을 무시한다. | “당신의 dry vocal 기준으로 timing, level, tone을 따로 봅니다.”                                 |

---

## 7. Safety Considerations

ASHA는 voice disorder를 vocal quality, pitch, loudness가 개인의 필요와 맞지 않거나 본인이 우려할 때 발생하는 문제로 설명하며, singers는 음성 사용 요구가 높은 집단입니다. NIDCD는 쉰 목소리, 고음 상실, 갑자기 낮아진 음성, 목의 raw/strained 느낌, 말하기 노력 증가, 반복적 목청 가다듬기 등을 주의 신호로 제시합니다. [A | Consensus] ([ASHA][2])

### 7.1 Safety Gates

| Gate                | 사용자 입력 / 앱 감지                                           | 앱 조치                                                        | 근거 수준                            |
| ------------------- | ------------------------------------------------------- | ----------------------------------------------------------- | -------------------------------- |
| Pre-Session Gate    | 오늘 쉰 목소리, 감기, 목 통증, 말하기 피로, 수면 부족                       | high-intensity, belting, shouty hook, long breathy 과제 잠금    | **A/B** ([청각 및 의사소통 장애 연구소][14]) |
| During-Session Gate | 통증, effort 4/10 이상, pitch collapse, 반복적 throat clearing | 즉시 stop, low-intensity reset, hydration/rest 안내             | **A/C** ([ASHA][2])              |
| Audio Safety Gate   | clipping, 과도한 SPL 추정, mic에 너무 가까운 shout                 | “더 크게” 대신 mic pull-back, gain reduction, 70% intensity take | **B/C**                          |
| Breathy Gate        | breathy phrase 반복 후 건조감, 피로, 쉰 소리                       | breathy duration 제한, clean recovery take 요구                 | **B/D** ([NATS][1])              |
| Referral Gate       | 2주 이상 지속되는 쉰 목소리, 고음 상실, 통증, 말하기 어려움                    | 앱 훈련 중단 권고, ENT / SLP 상담 안내                                 | **A** ([ASHA][2])                |

### 7.2 안전 설계 원칙

보컬 hygiene 교육은 가수에게 긍정적 결과가 보고되지만, 단독 hygiene 교육만으로 충분하다고 보기에는 한계가 있습니다. 따라서 앱은 hydration, vocal rest, noisy environment 회피 같은 일반 안전 안내를 제공하되, 실제 기술 훈련과 red flag referral을 함께 설계해야 합니다. [A/B | Consensus with Limits] ([PubMed][15])

---

## 8. Recommended Framework

# K-Pop Competency Framework

### 8.1 8대 역량 모델

| 역량                      | Level 1             | Level 2          | Level 3                         | Level 4                     |
| ----------------------- | ------------------- | ---------------- | ------------------------------- | --------------------------- |
| Speech-like Tone        | 말과 노래가 분리됨          | 말하듯 시작 가능        | groove 안에서 자연스럽게 유지             | 감정·파트별로 speech density 조절   |
| Lyric Delivery          | 가사 발음은 되지만 의미 전달 약함 | 핵심어 강조 가능        | 감정 전환 전달 가능                     | listener가 화자·감정·핵심어를 인식     |
| Mic Technique           | 거리·gain 관리 불안정      | clipping 방지 가능   | tone과 level을 거리로 조절             | phrase별 mic choreography 가능 |
| Recording Performance   | 한 take만 제출          | 3 take 비교 가능     | lead/double/harmony 가능          | comp-ready portfolio 제출     |
| Phrasing                | 박자에 맞춰 부름           | breath point 설계  | push/pull 가능                    | groove를 유지하며 개성 있는 phrase   |
| Emotional Communication | 감정 설명은 가능           | 한 감정 표현 가능       | 대비 감정 2–3개 표현                   | 청자가 감정 차이를 식별               |
| Tone Variation          | 한 가지 음색             | clean/breathy 구분 | bright/soft/straight/vibrato 선택 | 곡 기능에 맞춰 tone palette 설계    |
| Ensemble Compatibility  | solo만 가능            | guide와 timing 맞춤 | harmony/blend 가능                | group mix 안에서 역할 명확         |

---

# Advanced Lab Architecture

### 8.2 제품 아키텍처

| Layer            | 기능                                                      | 사용자 산출물                         |
| ---------------- | ------------------------------------------------------- | ------------------------------- |
| Diagnostic Layer | baseline 녹음 3종: spoken verse, ballad chorus, K-Pop hook | 8역량 radar                       |
| Listening Layer  | reference의 tone, lyric, mic, phrase, role 분석            | Style Map                       |
| Skill Layer      | Training Cards 수행                                       | 짧은 과제 take                      |
| Recording Layer  | dry vocal, guide mix, double, harmony, ad-lib           | Studio-ready files              |
| Review Layer     | AI + self-review + optional peer/human review           | Rubric report                   |
| Portfolio Layer  | 6주 capstone 제출                                          | Advanced Gayo / K-Pop Portfolio |

---

# 6 Week Cycle

### Week 1 — Diagnostic & Style Literacy

| 학습목표                             | 훈련과제                                                                 | 피드백                                        | 졸업기준                    |
| -------------------------------- | -------------------------------------------------------------------- | ------------------------------------------ | ----------------------- |
| 사용자가 K-Pop / 가요 스타일 표식을 들을 수 있다. | reference 3곡에서 speech-like, lyric stress, mic tone, chorus energy 표시 | style tag accuracy, over-imitation warning | 8개 역량 중 자기 강점·약점 2개씩 설명 |

### Week 2 — Speech-like Tone & Lyric Delivery

| 학습목표                    | 훈련과제                                    | 피드백                                   | 졸업기준                                   |
| ----------------------- | --------------------------------------- | ------------------------------------- | -------------------------------------- |
| 사용자가 말하듯이 시작해 노래로 연결한다. | talk → chant → sing ladder, keyword map | diction, syllable groove, forced tone | 4마디 verse를 자연스러운 speech-like tone으로 녹음 |

### Week 3 — Microphone Technique & Recording Discipline

| 학습목표                           | 훈련과제                                            | 피드백                      | 졸업기준                        |
| ------------------------------ | ----------------------------------------------- | ------------------------ | --------------------------- |
| 사용자가 mic distance와 gain을 조절한다. | 10/20/30cm take, plosive test, chorus pull-back | clipping, plosive, level | clipping 없는 lead take 3개 제출 |

### Week 4 — Phrasing & Emotional Arc

| 학습목표                      | 훈련과제                                        | 피드백                                | 졸업기준          |
| ------------------------- | ------------------------------------------- | ---------------------------------- | ------------- |
| 사용자가 가사 감정선을 phrase로 만든다. | ballad verse/chorus arc, emotion wheel take | phrase ending, listener emotion ID | 청자가 감정 전환을 식별 |

### Week 5 — Tone Variation & Chorus Energy

| 학습목표                                           | 훈련과제                                     | 피드백                                     | 졸업기준                           |
| ---------------------------------------------- | ---------------------------------------- | --------------------------------------- | ------------------------------ |
| 사용자가 clean/breathy/bright/straight tone을 선택한다. | tone card A/B, hook energy without shout | effort, tone consistency, mic pull-back | 후렴 energy가 올라가도 통증·clipping 없음 |

### Week 6 — Ensemble, Studio Stack & Portfolio

| 학습목표                                                  | 훈련과제                                               | 피드백                                 | 졸업기준            |
| ----------------------------------------------------- | -------------------------------------------------- | ----------------------------------- | --------------- |
| 사용자가 K-Pop group context와 gayo solo context를 모두 수행한다. | lead + double + harmony + ad-lib, ballad arc final | blend, role clarity, take selection | portfolio 6종 제출 |

---

# Training Cards

### Card 1. Talk-to-Sing Line

| 항목   | 내용                                                         |
| ---- | ---------------------------------------------------------- |
| 학습목표 | 사용자가 말하듯 자연스러운 verse tone을 만든다.                            |
| 훈련과제 | 가사 1문장 말하기 → 박자에 맞춰 말하기 → 70% 음량으로 노래하기                    |
| 피드백  | speech rhythm, vowel over-shaping, pitch stability, effort |
| 졸업기준 | spoken version과 sung version의 가사 인식률이 모두 높다.               |
| 근거   | **B/C** ([NATS][1])                                        |

### Card 2. Korean Lyric Keyword Map

| 항목   | 내용                                                  |
| ---- | --------------------------------------------------- |
| 학습목표 | 사용자가 한국어 핵심어와 감정 전환을 들리게 한다.                        |
| 훈련과제 | 핵심어 3개 표시, 조사·어미 약화/강화 선택, emotion note 작성          |
| 피드백  | keyword recall, consonant clarity, phrase direction |
| 졸업기준 | 청자가 핵심어 3개 중 2개 이상을 기억한다.                           |
| 근거   | **B** ([KCI][7])                                    |

### Card 3. Mic Distance Ladder

| 항목   | 내용                                             |
| ---- | ---------------------------------------------- |
| 학습목표 | 사용자가 mic distance로 level과 tone을 조절한다.          |
| 훈련과제 | 같은 phrase를 10cm, 20cm, 30cm에서 녹음               |
| 피드백  | clipping, proximity warmth, plosive, sibilance |
| 졸업기준 | 가장 적절한 거리 선택 이유를 설명하고 재현한다.                    |
| 근거   | **B**                                          |

### Card 4. Chorus Energy Without Shout

| 항목   | 내용                                                                     |
| ---- | ---------------------------------------------------------------------- |
| 학습목표 | 사용자가 후렴 에너지를 소리 지르지 않고 만든다.                                            |
| 훈련과제 | 70% intensity take → articulation 강화 → mic pull-back → 85% energy take |
| 피드백  | strain report, clipping, vowel spread, timing drive                    |
| 졸업기준 | energy 상승이 들리지만 통증·clipping이 없다.                                       |
| 근거   | **B/D** ([NATS][1])                                                    |

### Card 5. Clean vs Breathy A/B

| 항목   | 내용                                             |
| ---- | ---------------------------------------------- |
| 학습목표 | 사용자가 clean tone과 breathy tone을 표현 목적에 따라 선택한다. |
| 훈련과제 | 같은 가사를 clean, breathy, hybrid로 녹음              |
| 피드백  | lyric intimacy, audibility, fatigue, air noise |
| 졸업기준 | breathy를 짧은 표현 장치로 쓰고 clean recovery가 가능하다.    |
| 근거   | **B/D** ([NATS][1])                            |

### Card 6. Straight Tone to Vibrato Release

| 항목   | 내용                                                   |
| ---- | ---------------------------------------------------- |
| 학습목표 | 사용자가 straight tone과 짧은 vibrato release를 구분한다.        |
| 훈련과제 | sustained note를 straight로 유지한 뒤 마지막 20–30%에서 release |
| 피드백  | wobble, delayed release, pitch center                |
| 졸업기준 | verse에서는 straight, ballad climax에서는 release를 선택 가능   |
| 근거   | **B/C** ([NATS][1])                                  |

### Card 7. Three-Take Studio Comp

| 항목   | 내용                                             |
| ---- | ---------------------------------------------- |
| 학습목표 | 사용자가 좋은 take를 스스로 고른다.                         |
| 훈련과제 | 같은 20초 구간을 3번 녹음하고 best phrase를 선택             |
| 피드백  | pitch, timing, emotion, noise, consistency     |
| 졸업기준 | 선택한 take의 이유를 3가지 근거로 설명                       |
| 근거   | **B** ([University of Miami Scholarships][10]) |

### Card 8. Double & Stack Alignment

| 항목   | 내용                                                  |
| ---- | --------------------------------------------------- |
| 학습목표 | 사용자가 lead와 double을 tight하게 맞춘다.                     |
| 훈련과제 | lead 녹음 후 double, harmony, whisper/backing layer 추가 |
| 피드백  | consonant alignment, timing smear, level masking    |
| 졸업기준 | double이 lead를 흐리지 않고 두께를 만든다.                       |
| 근거   | **B/C**                                             |

### Card 9. Hook Role Fit

| 항목   | 내용                                                |
| ---- | ------------------------------------------------- |
| 학습목표 | 사용자가 K-Pop hook에서 자기 역할을 분명히 한다.                  |
| 훈련과제 | lead hook, sub hook, backing chant 3버전 녹음         |
| 피드백  | role clarity, brightness, level, ensemble masking |
| 졸업기준 | 세 버전이 서로 다른 mix role로 들린다.                        |
| 근거   | **B/C** ([버클리 음악 대학][12])                         |

### Card 10. Anti-Imitation Rewrite

| 항목   | 내용                                                                          |
| ---- | --------------------------------------------------------------------------- |
| 학습목표 | 사용자가 원곡 기능을 유지하면서 자기 버전으로 바꾼다.                                              |
| 훈련과제 | 원곡에서 기능 3개만 추출: breathy intimacy, delayed phrase, bright hook 등 → 음색은 자기 선택 |
| 피드백  | function retained, clone risk, identity clarity                             |
| 졸업기준 | 원곡의 역할은 유지되지만 원곡 가수 복제가 아니다.                                                |
| 근거   | **B/C** ([NATS][1])                                                         |

---

# Safety Gates

| Gate            | 잠금되는 과제                                               | 허용되는 대체 과제                                             |
| --------------- | ----------------------------------------------------- | ------------------------------------------------------ |
| Hoarseness Gate | high-intensity chorus, long breathy, belt-like phrase | lyric reading, listening map, low-intensity clean tone |
| Pain Gate       | 모든 발성 과제                                              | 휴식, hydration 안내, 전문가 상담 권고                            |
| Fatigue Gate    | 반복 녹음, stack recording                                | 1-take review, self-analysis                           |
| Clipping Gate   | loud chorus challenge                                 | gain setup, mic distance ladder                        |
| Imitation Gate  | 원곡 따라 하기 반복                                           | function analysis, anti-imitation rewrite              |

---

# Recording Review System

### 8.3 리뷰 입력

| 입력                     | 설명                         |
| ---------------------- | -------------------------- |
| Dry vocal              | 반주 없는 사용자 목소리              |
| Guide mix              | 반주와 함께 들리는 실제 수행           |
| Mic setup note         | 거리, 기기, gain, 방 환경         |
| Effort self-rating     | 0–10 effort, pain, fatigue |
| Lyric map              | 핵심어, 감정, breath point      |
| Reference function map | 원곡의 기능만 추출한 지도             |

### 8.4 리뷰 출력

| 출력                  | 앱이 말해야 하는 것                                         |
| ------------------- | --------------------------------------------------- |
| Safety result       | “오늘은 high-energy hook 대신 clean lyric task 권장”       |
| Audio result        | “0:12에서 clipping. mic를 10cm 뒤로 이동”                  |
| Competency score    | Speech-like 3, Lyric 2, Mic 3, Recording 2처럼 역량별 표시 |
| Style function      | “breathy tone이 intimacy에는 맞지만 phrase 끝 가사 명료도가 낮음”  |
| Next task           | “Clean vs Breathy A/B를 1회 더 수행”                     |
| Portfolio readiness | “Studio Stack Mode 졸업 기준 4개 중 3개 충족”                |

---

# Portfolio Requirements

Advanced Gayo / K-Pop Lab 졸업 포트폴리오는 다음을 요구합니다.

| 제출물                           | 졸업기준                                                        |
| ----------------------------- | ----------------------------------------------------------- |
| 1. Gayo Ballad Narrative Take | verse + chorus에서 감정선과 핵심어가 들림                               |
| 2. K-Pop Part Take            | 15–30초 파트에서 speech-like tone, groove, role이 명확함             |
| 3. Mic Technique A/B          | 거리·gain·tone 선택 이유를 설명                                      |
| 4. Studio Stack               | lead + double + harmony/ad-lib 제출                           |
| 5. Tone Palette Demo          | clean, breathy, bright, straight/vibrato release 중 4개 이상 구분 |
| 6. Ensemble Compatibility Mix | lead를 방해하지 않는 backing 또는 harmony 가능                         |
| 7. Self-Review Report         | 원곡 모방이 아니라 기능 분석과 자기 선택을 설명                                 |
| 8. Safety Log                 | 통증·쉰 목·피로 gate 기록과 조치 포함                                    |

---

## 9. Source Bibliography

1. **NATS / Journal of Singing — “The Korean Wave: Cross-Cultural and Pedagogical Perspectives in K-Pop.”** K-Pop 보컬의 speech-like delivery, articulation, phrasing, registration, tone color, clean/breathy onset, audio technology를 핵심 근거로 사용. ([NATS][1])

2. **NATS / Journal of Singing — “Audio Technology: A Tool for Teachers and Singers.”** CCM에서 live sound와 studio recording technology가 보컬 수행과 분리되지 않는다는 근거로 사용. 

3. **NATS / Journal of Singing — “An Investigation of Contemporary Commercial Music Voice Pedagogy: A Class of its Own?”** CCM이 classical singing과 다른 voice quality, tone, registration, style-related technique을 가진다는 근거로 사용. 

4. **NATS Commercial Music Resources / Glossary.** close miking, cardioid, clipping, blend, click 등 앱 녹음 피드백 용어 설계에 사용. 

5. **Voice Foundation — CCM vocal pedagogy 관련 자료.** CCM pedagogy framework 부재와 style-related effects를 안전하게 다룰 필요성의 근거로 사용. ([음성재단][16])

6. **AATS — Contemporary Commercial Music 자료.** 모든 장르에 단일 vocal technique을 적용할 수 없다는 제품 원칙의 근거로 사용. ([American Academy of Teachers of Singing][17])

7. **ASHA — Voice Disorders Practice Portal.** voice disorder 정의, signs, singers의 high-demand voice use, referral 필요성의 핵심 안전 근거. ([ASHA][2])

8. **NIH / NIDCD — Taking Care of Your Voice.** hoarseness, lost high notes, raw/strained throat, effort to talk, throat clearing 등 safety gate 근거. ([청각 및 의사소통 장애 연구소][14])

9. **Pestana et al. — Systematic review/meta-analysis on dysphonia in singers.** 가수 집단의 self-reported dysphonia prevalence 근거. ([PubMed][18])

10. **Vocal hygiene systematic review 자료들.** hygiene education의 효과와 한계, direct therapy와 병행 필요성 판단에 사용. ([PubMed][15])

11. **Kim et al. — Semantic Tagging of Singing Voices in Popular Music Recordings / KVT dataset.** K-Pop 녹음에서 vocal timbre와 expression tag를 앱 AI 후보 태그로 참고하되, 정답 판정 근거로는 제한. 

12. **Yamamoto et al. — KVT 관련 vocal technique tagging 연구.** whisper, quiet, vibrato, shouty, falsetto, speech-like 등 태그가 가능하지만 pedagogical diagnosis가 아니라는 한계 판단에 사용. ([ISMIR Archives][19])

13. **GTSinger dataset 연구.** mixed voice, falsetto, breathy, vibrato 등 singing technique annotation이 가능하다는 보조 근거로 사용하되, K-Pop 앱 직접 판정에는 제한적으로 해석. ([NeurIPS Proceedings][20])

14. **Miroudot — “What’s behind the K?” Popular Music / Cambridge.** K-Pop을 Korean popular music 전체와 구분하고, danceability, energy, speechiness 같은 오디오 특징으로 비교하는 근거로 사용. ([Cambridge University Press & Assessment][4])

15. **Korean Popular Music 연구 — lyric-emotion analysis.** 한국 대중음악 보컬에서 lyric concentration과 emotional delivery를 훈련 과제로 변환하는 근거. ([KCI][7])

16. **Howard & Yang — “Exploding Ballads: The Transformation of Korean Pop Music.”** 한국 발라드가 한국 대중음악에서 중요한 장르임을 설명하는 근거. ([KCI][3])

17. **Encyclopedia of Korean Culture — Korean Ballad.** 한국 발라드의 느린/중간 템포, 감정 표현, 선율적 특성을 정리하는 근거. ([한국민족문화대백과사전][21])

18. **Hook song 관련 KCI 연구.** K-Pop hook과 chorus emphasis를 제품 과제의 “후렴 에너지”로 변환하는 보조 근거. ([Korea Journal Central][8])

19. **K-Pop live vocal / backing track 연구.** 라이브 K-Pop 평가에서 prerecorded backing track과 mix 환경을 고려해야 한다는 제한 근거. ([arXiv][5])

20. **Berklee — Studying Voice / Performance Voice / Popular Singing Styles.** style, vocal technique, pop/rock/R&B, breath management, tone shaping, performance 중심 커리큘럼 근거. ([버클리 음악 대학][6])

21. **Berklee — Commercial Vocal Production.** contemporary, commercially viable vocal-focused recording과 technology-processed voice의 근거. ([Berklee Online][13])

22. **Berklee — K-Pop Ensemble.** K-Pop을 R&B, hip-hop, funk, indie, rock 등과 연결하고 한국어 수행을 요구하는 ensemble 설계 근거. ([버클리 음악 대학][12])

23. **NYU — BM Contemporary Voice / Contemporary Voice Workshop.** contemporary genres, stylistic integrity, performance adaptability, vocal health, guided listening, peer critique, repertoire book 근거. ([NYU Steinhardt][22])

24. **Shenandoah Conservatory — CCM Voice Pedagogy.** CCM voice pedagogy를 독립 전문영역으로 다루는 conservatory 근거. ([Shenandoah University][23])

25. **Boston Conservatory / Berklee vocal pedagogy 자료.** classical, musical theatre, contemporary voice, vocal anatomy, healthy practice/performance를 결합하는 교육 모델 근거. ([Boston Conservatory][24])

26. **University of Miami — Vocal Recording Techniques for Modern Digital Studio.** microphone choice, setup, proximity, positioning, producer decision, recording session technique을 앱 Recording Review System에 반영. ([University of Miami Scholarships][10])

27. **Research on agency in vocal recording of contemporary vocalists.** original performance, agency, recording pedagogy, mimicry 감소를 Anti-Imitation Rewrite 카드에 반영. ([ResearchSpace][9])

28. **Hakanpää et al. / Journal of Voice — Emotion expression in CCM and classical singing.** 감정 표현을 acoustic cue와 performance task로 다룰 수 있다는 근거. ([PubMed][11])

29. **Emotion expression in singing 연구.** 숙련 보컬이 감정 전달을 위해 음향적 cue를 사용한다는 근거로 listener emotion recognition 과제에 반영. ([AIP Publishing][25])

30. **Indiana University — Korean diction for singers.** 한국어 발음 교육의 참고 자료로 사용하되, classical/art song 중심이므로 K-Pop casual diction에는 제한적으로 적용. ([IUScholarWorks][26])

[1]: https://www.nats.org/_Library/JOS_On_Point/JOS-082-3-2026-357.pdf "Journal of Singing Volume 82, Number 3"
[2]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOoqtwzr_OyHnpBeF0NGarfMHUgpbhRAa-wdvWxhqYGrL-wwhc8Sx "Voice Disorders"
[3]: https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART002188895 "발라드 전성시대: 한국 대중음악의 변신"
[4]: https://www.cambridge.org/core/journals/popular-music/article/whats-behind-the-k-common-audio-features-of-korean-popular-music-before-and-after-the-rise-of-kpop/E0A20BDA5FD01DD9FB6F65BC7A6EE172 "What's behind the ‘K’? Common audio features of Korean popular music before and after the rise of K-POP | Popular Music | Cambridge Core"
[5]: https://arxiv.org/html/2508.20273?utm_source=chatgpt.com "Live Vocal Extraction from K-pop Performances"
[6]: https://college.berklee.edu/voice/studying-voice-berklee?utm_source=chatgpt.com "Studying Voice at Berklee"
[7]: https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART002900522 "노래 가사 감정 분석법이 보컬 표현력 향상에 미치는 효과 - ‘감정의 바퀴’를 활용하여 -"
[8]: https://journal.kci.go.kr/djnar/archive/articleView?artiId=ART001670107&utm_source=chatgpt.com "Hook Songs and Popular Music in Korea"
[9]: https://researchspace.bathspa.ac.uk/16514/1/16514.pdf?utm_source=chatgpt.com "facilitating agency in the vocal recording of - ResearchSPAce"
[10]: https://scholarship.miami.edu/esploro/outputs/doctoral/Vocal-Recording-Techniques-for-the-Modern/991031447873002976?utm_source=chatgpt.com "Vocal Recording Techniques for the Modern Digital Studio"
[11]: https://pubmed.ncbi.nlm.nih.gov/31708368/?utm_source=chatgpt.com "Comparing Contemporary Commercial and Classical Styles"
[12]: https://college.berklee.edu/courses/engb-230?utm_source=chatgpt.com "Berklee K-Pop Ensemble"
[13]: https://online.berklee.edu/courses/commercial-vocal-production?utm_source=chatgpt.com "Commercial Vocal Production Course - Berklee Online"
[14]: https://www.nidcd.nih.gov/health/taking-care-your-voice "Taking Care of Your Voice | NIDCD"
[15]: https://pubmed.ncbi.nlm.nih.gov/38052688/?utm_source=chatgpt.com "The Vocal Hygiene Treatment Programs for Singers"
[16]: https://voicefoundation.org/virtual-voice/15504-2/?utm_source=chatgpt.com "Acoustic Characteristics of Vocal Sounds"
[17]: https://www.americanacademyofteachersofsinging.org/vocal-pedagogy/in-support-of-contemporary-commercial-music-nonclassical-voice-pedagogy/ "In Support of Contemporary Commercial Music (Nonclassical) Voice Pedagogy – American Academy of Teachers of Singing"
[18]: https://pubmed.ncbi.nlm.nih.gov/28342677/?utm_source=chatgpt.com "Prevalence of Voice Disorders in Singers"
[19]: https://archives.ismir.net/ismir2022/paper/000046.pdf?utm_source=chatgpt.com "ANALYSIS AND DETECTION OF SINGING TECHNIQUES ..."
[20]: https://proceedings.neurips.cc/paper_files/paper/2024/file/023d2c1a17cf35b11a0cbb43a0677c91-Paper-Datasets_and_Benchmarks_Track.pdf?utm_source=chatgpt.com "GTSinger: A Global Multi-Technique Singing Corpus with ..."
[21]: https://encykorea.aks.ac.kr/Article/E0072198 "한국의 발라드 - 한국민족문화대백과사전"
[22]: https://steinhardt.nyu.edu/degree/bm-vocal-performance-contemporary-voice/curriculum?utm_source=chatgpt.com "Curriculum | BM, Vocal Performance: Contemporary Voice"
[23]: https://www.su.edu/conservatory/areas-of-study/pedagogy-voice/master-of-music-in-pedagogy-ccm-voice/?utm_source=chatgpt.com "Master of Music | Contemporary Commercial Music (CCM)"
[24]: https://bostonconservatory.berklee.edu/vocal-pedagogy/mm-vocal-pedagogy?utm_source=chatgpt.com "Master of Music in Vocal Pedagogy"
[25]: https://pubs.aip.org/asa/jasa/article/142/4/1805/852940/The-expression-of-emotion-in-the-singing-voice?utm_source=chatgpt.com "The expression of emotion in the singing voice - AIP Publishing"
[26]: https://scholarworks.iu.edu/dspace/items/70e9fa16-a5fa-4c5f-98ea-169a28496cc7?utm_source=chatgpt.com "Korean diction for singers - IU ScholarWorks"
