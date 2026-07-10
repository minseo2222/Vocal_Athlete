# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `12. Advanced Musical Theatre Lab #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `12-advanced-musical-theatre-lab.md`

---

## 1. Executive Summary

**제품 결론:** Advanced Musical Theatre Lab은 “노래를 잘 부르게 하는 앱”이 아니라, 사용자가 **짧은 장면 안에서 텍스트 의도 → 캐릭터 목표 → 말의 충동 → 음악적 프레이즈 → 스타일 선택 → 안전한 반복 수행**을 연결하게 만드는 앱이어야 한다. 뮤지컬 보컬의 핵심은 성악·가요·연기를 병렬로 더하는 것이 아니라, **dramatic action이 소리를 조직하게 만드는 통합 수행 역량**이다. [B]

근거 검토 결과, 전문가 합의가 비교적 강한 지점은 다음이다. 첫째, 뮤지컬 보컬은 말 기반의 명료성, 텍스트 전달, 캐릭터 목표, 다양한 발성 스타일 전환이 핵심이다. NATS 자료는 뮤지컬 노래가 자주 speaking voice에 기반하고, 많은 경우 mix이며, 벨트는 주로 클라이맥스에서 쓰인다고 설명한다. NYU·Berklee·Boston Conservatory 계열 커리큘럼도 노래·연기·텍스트·캐릭터·오디션 레퍼토리의 통합을 반복적으로 강조한다. ([nats.org][1])

둘째, **belt는 앱 단독 훈련의 중심 기술이 아니라 gated high-risk skill**로 설계해야 한다. 연구와 전문 페다고지 문헌은 belt가 단순히 “크게 부르기”가 아니라 성대 접촉, 음압, 공명 전략, 말 같은 음색, 높은 에너지 출력이 결합된 복합 기술임을 보여준다. 여성 Broadway belt 연구도 high belt와 mix-belt의 경계가 명확하지 않으며, 벨트 교육법에는 아직 합의되지 않은 부분이 있음을 보고한다. 

셋째, 앱의 daily lesson은 “무엇을 가르칠까”가 아니라 **사용자가 무엇을 할 수 있게 될까**로 정의해야 한다. 예를 들어 “text intention”은 이론 강의가 아니라, 사용자가 10~15분 안에 **한 문장 목표를 정하고, 말로 수행하고, 리듬에 얹고, 짧게 노래한 뒤, 녹음 A/B에서 목표가 들리는지 판정**하는 기능으로 변환되어야 한다. [B]

**권장 제품 원칙**

| 원칙                         | 제품 해석                                                                      | 근거수준 |
| -------------------------- | -------------------------------------------------------------------------- | ---: |
| Text-first                 | pitch보다 먼저 “누가 누구에게 무엇을 얻으려 하는가”를 확인한다.                                    |    B |
| Speech-to-song             | 말 → heightened speech → rhythm speech → pitch anchor → sung phrase 순서로 간다. |    B |
| Style spectrum             | legit, speech-like, mix, belt-adjacent를 연속체로 다루되 belt는 gate 처리한다.          |  A/B |
| Safety-first belt          | 앱은 belt를 “시도하게” 하기보다 prerequisite, cap, fallback, stop signal을 제공한다.       |  A/B |
| Audition micro-performance | 16-bar cut은 짧은 노래가 아니라 objective가 보이는 압축 장면이다.                             |    B |
| A/B review priority        | pitch 정확도보다 text clarity, objective, vocal ease, phrase action을 먼저 평가한다.   |    B |

---

## 2. Evidence Review

아래 표는 요청하신 우선순위에 따라 NATS, Journal of Singing, Voice Foundation, ASHA, NIH/NIDCD, peer-reviewed 논문, 대학 커리큘럼, conservatory 및 musical theatre audition 자료를 비교·비판·통합한 결과다. YouTube·블로그·개인 코치 의견은 핵심 근거로 사용하지 않았다.

**근거수준 정의:** A = 강한 연구 근거, B = 반복적으로 관찰되는 교육 현장 합의, C = 전문가 의견, D = 제한적 근거.

| 출처군                                                             | 검색·검토된 핵심 내용                                                                                                                                                           | 비교·비판                                                                        | 앱 커리큘럼 변환                                                                  |  근거 |
| --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------------------------- | --: |
| NATS Music Theater Resources                                    | 뮤지컬 노래는 speaking voice 기반인 경우가 많고, 많은 부분이 mix이며, loud mix/belt는 주로 climactic moment에 쓰인다고 제시한다. ([nats.org][1])                                                        | 앱이 “벨트 = 기본 뮤지컬 소리”로 오인시키면 위험하다. 대부분의 phrase는 speech-like/mix 기반으로 설계해야 한다.  | speech-to-song core loop + climactic phrase만 belt-adjacent gate.           |   B |
| Journal of Singing, Roll, *Female Broadway Belt Voice*          | traditional belt와 high belt/mix-belt의 음역·음색·vowel strategy 차이를 보고하며, 고음 belt는 mix-belt 성격이 강하고 교육법에는 불확실성이 남아 있다고 제시한다.                                                | “벨트는 chest voice만”이라는 단순 규칙은 부정확하다. high belt를 앱에서 직접 가르치는 것은 과잉 일반화 위험이 있다. | high belt는 expert gate. 앱은 “belt-adjacent expression”과 fallback만 제공.       | B/C |
| Journal of Singing, Bourne·Garnier·Kenny                        | 뮤지컬 가수는 belt와 legit을 포함한 여러 sound를 유연하게 내야 하며, 안전하고 효율적인 MT 발성에 관한 근거는 아직 부족하다고 정리한다.                                                                                  | 통합 역량은 합의되지만, 특정 훈련법의 안전성은 충분히 검증되지 않았다.                                     | 앱은 스타일 전환 능력을 훈련하되, 고위험 기술은 “교육 + 제한 + 의뢰” 구조.                             | B/D |
| Titze·Worley·Story, source-vocal tract interaction              | theatre belting과 operatic singing은 공명 전략이 다르며, belt는 speech-like quality와 특정 formant/harmonic 전략이 관련된다고 설명한다.                                                          | 벨트는 단순한 볼륨 훈련이 아니다. 사용자가 “더 크게”만 하게 만들면 안전 피드백이 불가능하다.                       | loudness cue 금지. “brighter, clearer, shorter, easier” cue와 stop signal 사용. | A/B |
| Titze, *Belting and a High Larynx*                              | 약간 높은 larynx와 jaw/lip 전략은 acoustic advantage가 있지만, articulatory restriction과 muscular crowding 위험이 있다.                                                                 | “후두를 올려라” 같은 단일 cue는 앱에서 위험하다.                                               | larynx-position instruction 대신 음질·편안함·짧은 duration 기반 feedback.             | A/C |
| Bourne·Garnier·Samson, JASA male MT voice                       | 남성 MT belt는 legit보다 EGG contact quotient, SPL, 고주파 에너지, vocal tract resonance가 높게 관찰되었다.                                                                               | 성별·voice type별 차이가 있어 보편적 pitch cap을 단정하기 어렵다.                               | 사용자별 comfortable range inventory 후 상대적 cap 적용.                             |   A |
| Björkner, *Musical theater and opera singing—why so different?* | MT와 opera singing은 subglottal pressure, source, formant strategy가 다르게 연구되어 왔다. ([PubMed][2])                                                                           | classical technique을 그대로 MT로 전환하는 설계는 불충분하다.                                 | legit module은 필요하지만 MT 전체의 기본값으로 두지 않는다.                                   |   A |
| SOVT 연구군                                                        | SOVT는 음성훈련·치료에서 널리 연구되며 RCT와 리뷰가 있으나, 최근 리뷰는 근거 품질이 낮다고 평가한다. ([PubMed][3])                                                                                            | SOVT를 만능 치료로 포장하면 안 된다.                                                      | 앱 fallback, reset, warm-up/cooldown으로 사용하되 치료 claim 금지.                    | A/D |
| ASHA Voice Disorders                                            | 음성장애는 음질·pitch·loudness가 달라지거나 사용자가 우려할 때 성립하며, vocal fatigue, muscle tension dysphonia 등이 포함된다. ([ASHA][4])                                                           | 앱은 진단하지 말고 위험 신호를 감지해 referral해야 한다.                                         | daily check-in: hoarseness, pain, fatigue, effort, range loss.             |   A |
| ASHA Nodules/Polyps                                             | hoarseness, breathiness, roughness, pitch 변화 어려움, fatigue, neck pain 등은 경고 신호이며 2~3주 이상 hoarseness는 의학적 확인이 필요하다. ([ASHA][5])                                          | “연습하면 풀린다”는 코칭 메시지를 피해야 한다.                                                  | stop signal + ENT/SLP referral language.                                   |   A |
| NIH/NIDCD Voice Care                                            | 전문 음성 사용자는 위험군이며, hoarse/raspy voice, high notes loss, raw/strained throat, effortful talking은 경고 신호다. hydration, vocal naps, rest, avoid extremes를 권장한다. ([NIDCD][6]) | 앱은 “훈련 streak”보다 회복과 중단을 보상해야 한다.                                            | vocal load cap, rest credit, no-penalty skip.                              |   A |
| ASHA Journals Academy review                                    | professional voice users에서 vocal hygiene education과 direct voice therapy가 긍정적 결과를 보인다는 리뷰가 소개된다. ([ASHA Journals Academy][7])                                          | 앱이 therapy를 대체할 수는 없지만 hygiene literacy는 타당하다.                               | vocal hygiene micro-lessons + specialist referral.                         | A/B |
| Voice Foundation                                                | Voice Foundation은 Journal of Voice와 symposium을 통해 음성 과학·치료·훈련을 연결하는 기관이다. ([보이스 재단][8])                                                                                | 최신 초록은 유용하지만 peer-reviewed full paper 전에는 제한적 근거로 취급해야 한다.                   | emerging findings는 “lab note”로만 반영.                                        | C/D |
| Voice Foundation mix/legit/belt abstract                        | MT singers는 belt, mix, legit를 개발해야 하며 mix의 하위 범주가 다양하게 논의된다. ([보이스 재단][9])                                                                                             | mix terminology가 표준화되지 않았다.                                                  | 앱 라벨을 과도하게 세분화하지 말고 청각·기능 outcome 중심.                                      | C/D |
| NYU Tisch New Studio                                            | lyric meaning, intent, objective, character voice, scene into song, healthy sustainable practice를 커리큘럼 핵심으로 둔다. ([tisch.nyu.edu][10])                                  | 대학 교육은 통합 수행을 목표로 하므로 앱도 “음정 훈련만”으로는 부족하다.                                   | phrase = beat/action unit으로 설계.                                            |   B |
| NYU Steinhardt                                                  | voice, acting, dance를 통합하고 song analysis, character analysis, vocal production, text communication을 강조한다. ([NYU Steinhardt][11])                                       | musical theatre는 multi-modal performance discipline이다.                       | text/acting/vocal 통합 lesson template.                                      |   B |
| Berklee MT Performance Minor                                    | vocal/dramatic needs by era/genre, characterization, movement, repertoire identity를 학습성과로 제시한다. ([Berklee College of Music][12])                                       | 레퍼토리·시대·장르 문맥이 빠지면 MT 스타일 훈련이 빈약해진다.                                         | repertoire-tagged skill graph.                                             |   B |
| Boston Conservatory at Berklee MFA MT Vocal Pedagogy            | singing, speech, movement, acting, classical-to-pop styles, vocal health/longevity를 통합한다. ([bostonconservatory.berklee.edu][13])                                       | 교사 양성 커리큘럼도 vocal health와 style range를 함께 본다.                                | safety gate와 style spectrum을 같은 product layer에 배치.                         |   B |
| NYU/Boston Conservatory audition 자료                             | contrasting songs, 32-bar cuts, 60–90 seconds, marked sheet music, text communication, grounded performance를 요구한다. ([bostonconservatory.berklee.edu][14])              | 16-bar 자체는 기관마다 다르지만 “짧은 contrasting cut” 훈련은 실무적으로 타당하다.                    | 16-bar와 32-bar를 모두 export 가능한 audition portfolio.                          |   B |
| University of Utah voice syllabus                               | speak text as poem, speak in rhythm, learn melody, mark dynamics/tempo, record lessons, silent/minimal practice for pacing을 제시한다.                                      | speech-to-song은 현장 교육에서 반복되는 sequence다.                                      | daily lesson의 핵심 단계로 채택.                                                   |   B |
| FAU Musical Theatre Audition syllabus                           | song audition은 acting skills, vocal/breath support, room entry, accompanist, active truth, vocal/physical size를 포함한다.                                                  | audition은 노래 파일이 아니라 room behavior까지 포함한 수행이다.                               | mock audition module: slate, cut, recover, notes.                          |   B |
| NCVS MT vocal hygiene                                           | MT performer는 노래·연기·춤을 결합하며, overuse, noisy environment, 8-show-week, speaking/singing switch 훈련이 중요하다. ([ncvs.org][15])                                               | 앱은 일일 음성 사용량과 공연 부하를 반영해야 한다.                                                | load log, rehearsal day cap, speaking load warning.                        |   B |
| NYU vocal athleticism / vocal dose                              | Broadway는 8회 이상 공연이 흔하고, vocal dose는 시간·pitch·intensity·진동량을 포함하지만 hard-fast rule은 없다고 설명한다. ([NYU Steinhardt][16])                                                    | 안전 threshold를 과학적으로 단정하면 안 된다.                                               | conservative cap을 product rule로 명시하고 개인화.                                  |   D |
| Journal of Voice vocal dose studies                             | MT rehearsal과 performance의 vocal dose를 측정하려는 연구가 있으나 표본과 범위는 제한적이다. ([PubMed][17])                                                                                     | load monitoring은 유망하지만 앱 단독 안전판으로는 부족하다.                                     | self-report + acoustic proxy + rest policy 결합.                             |   D |

---

## 3. Consensus

### 3.1 뮤지컬 보컬을 일반 가요·성악과 구분하는 핵심 역량

**Consensus:** 뮤지컬 보컬은 “아름다운 소리” 자체보다 **장면 속 목적을 가진 말이 음악으로 상승하는 능력**이 중심이다. 사용자는 lyric을 정확히 부르는 것이 아니라, **캐릭터가 지금 이 사람에게 무엇을 얻으려 하는지**를 노래 안에서 수행해야 한다. [B] NYU Tisch는 lyric meaning, intent, objective, character voice, scene into song을 통합해 다루고, Berklee는 시대·장르별 vocal/dramatic needs와 characterization을 학습성과로 둔다. ([tisch.nyu.edu][10])

**앱 outcome:** 사용자는 한 phrase마다 다음을 말하고 수행할 수 있어야 한다.

`I want ___ from ___ because ___, but ___.`
그다음 같은 문장을 **말로, 리듬으로, 노래로, 다른 style option으로** 재현한다.

### 3.2 Speech-to-song은 핵심 훈련 축이다

**Consensus:** speech-to-song은 “말하듯 노래하라”라는 추상 cue가 아니라, spoken text → heightened speech → rhythm speech → sung phrase로 점진화할 수 있다. NATS는 spoken phrases at varying pitch/dynamics 후 노래로 옮기는 방식을 제시하고, Utah syllabus도 text를 말하고, 리듬으로 말하고, melody를 배우는 순서를 포함한다. ([nats.org][1]) [B]

**앱 outcome:** 사용자는 pitch를 붙이기 전에도 phrase의 stress, operative word, beat shift를 들리게 만들 수 있어야 한다.

### 3.3 Legit, mix, belt는 “우열”이 아니라 style spectrum이다

**Consensus:** MT singer는 legit, mix, belt 또는 belt-adjacent sound를 문맥에 따라 전환해야 한다. Journal of Singing 리뷰는 MT singer에게 M1/M2와 blended sound의 유연성이 필요하다고 정리하고, NATS 자료도 대부분의 MT singing이 mix 기반이며 belt는 특정 moments에서 쓰인다고 설명한다.  [B]

**권장 순서:**
**legit phrase 안정화 → speech-like phrase → mix phrase → belt-adjacent phrase → 전문가 gate 이후 belt/belt-mix 확장.**
이 순서는 “classical-first”가 아니라, **음성 효율·range awareness·text clarity·register flexibility**를 확보한 뒤 high-intensity task로 넘어가기 위한 안전 경로다. [B]

### 3.4 Belt는 단순 loud singing이 아니다

**Consensus:** belt는 음향·생리·지각 요소가 결합된 고부하 기술이다. 연구들은 belting이 speech-like quality, formant strategy, 높은 SPL, 더 큰 성대 접촉 또는 고주파 에너지와 관련될 수 있음을 보고한다.  [A/B]

**앱 outcome:** 사용자는 “벨트를 한다”보다 먼저 다음을 할 수 있어야 한다.

1. 본인의 comfortable speaking-mix range를 안다.
2. 큰 소리를 내지 않고도 text climax를 만든다.
3. throat effort, pain, hoarseness, loss of high notes를 stop signal로 인식한다.
4. belt 대신 mix, speech-like, legit intensification으로 fallback한다.

### 3.5 Vocal load management는 커리큘럼의 일부다

**Consensus:** MT performer는 노래·대사·춤·리허설·공연 일정이 결합된 음성 부하를 가진다. NCVS는 MT performer의 overuse, noisy environment, 8-show-week 대비를 강조하고, NIDCD와 ASHA는 hoarseness, throat strain, fatigue, high-note loss 등을 경고 신호로 제시한다. ([ncvs.org][15]) [A/B]

**앱 outcome:** 사용자는 “오늘 얼마나 연습했나”보다 **오늘 음성 조직이 회복 가능한 상태인가**를 판단할 수 있어야 한다.

---

## 4. Controversies

### 4.1 Belt와 belt-mix의 정의

**Controversy:** traditional belt, high belt, mix-belt, chest-dominant mix, head-mix 같은 용어는 문헌과 교육 현장에서 일관되게 쓰이지 않는다. Roll의 Journal of Singing 연구는 high belt가 traditional belt와 다르며 mix-belt 성격을 가진다고 보고하지만, pedagogy가 여전히 정착 중임을 명시한다. Voice Foundation 초록들도 mix의 하위 분류가 다양하게 논의되고 있음을 보여준다.  [C/D]

**제품 판단:** 앱에서 “정답 라벨”을 강하게 부여하지 않는다. 대신 사용자의 outcome을 이렇게 측정한다.

* text가 들리는가
* effort가 낮은가
* phrase climax가 전달되는가
* 다음 take에서 회복 가능한가
* style target과 충분히 가까운가

### 4.2 Belt의 생리·음향 cue

**Controversy:** belt의 acoustic strategy에 대한 연구는 강하지만, 앱이 실시간으로 안전한 벨트 여부를 판정할 만큼의 단일 지표는 없다. Titze 계열 연구는 formant/harmonic strategy와 larynx height의 acoustic advantage를 설명하지만, 동시에 biomechanical disadvantage와 제한을 언급한다.  [A/C]

**제품 판단:** “larynx를 올려라”, “chest를 밀어라”, “목을 열고 세게” 같은 직접 조작 cue는 금지한다. 앱은 감각 cue보다 **stop signal, duration cap, range cap, fallback**을 우선한다.

### 4.3 SOVT의 위치

**Controversy:** SOVT는 음성 훈련·치료에서 널리 사용되고 연구도 많지만, 특정 앱 기반 MT 훈련에서 어떤 프로토콜이 가장 효과적인지는 충분히 검증되지 않았다. 최근 리뷰는 일부 효과를 보고하면서도 근거 품질이 매우 낮다고 평가한다. ([PubMed][3]) [A/D]

**제품 판단:** SOVT는 “치료”가 아니라 **reset, warm-up, cooldown, fallback**으로 제공한다.

### 4.4 Vocal load의 정확한 안전 한계

**Insufficient Evidence:** vocal dose 연구는 유망하지만, “하루 몇 분이면 안전하다” 같은 보편 threshold는 확립되어 있지 않다. NYU vocal dose 자료도 vocal dose가 시간·pitch·intensity·진동량을 포함하지만 hard-fast rule은 없다고 설명한다. ([NYU Steinhardt][16]) [D]

**제품 판단:** 앱 cap은 의학적 안전선이 아니라 **보수적 제품 규칙**으로 표시한다. 개인별 피로·통증·회복 상태가 cap보다 우선한다.

### 4.5 16-bar audition cut의 표준성

**Controversy / Insufficient Evidence:** 대학·conservatory audition 자료는 32-bar, 60–90초, contrasting songs를 자주 요구하지만, 16-bar cut 자체는 기관별 요구가 다르다. ([bostonconservatory.berklee.edu][14]) [B/D]

**제품 판단:** 앱은 16-bar를 “market practice용 압축 장면”으로 훈련하되, 32-bar·60–90초 export도 함께 제공한다.

---

## 5. Curriculum Design Implications

### 5.1 필수 질문 10개에 대한 제품 답변

| 질문                                                                 | 제품팀 결론                                                                                                                                                            |  근거수준 |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----: |
| 1. 뮤지컬 보컬을 일반 가요·성악과 구분하는 핵심 역량은?                                  | **dramatic objective가 vocal phrase를 조직하는 능력.** speech-like intelligibility, character action, style switching, audition compression, vocal load management가 핵심이다. |     B |
| 2. speech-to-song은 앱에서 어떤 단계로?                                     | context brief → plain speech → objective speech → rhythm speech → pitch anchors → sung phrase → A/B review.                                                       |     B |
| 3. text intention과 character objective를 10~15분 daily lesson으로 바꾸면? | active verb 선택, addressee 지정, operative word 표시, 말하기 take, 리듬 말하기 take, 4~8마디 노래 take, A/B 판정.                                                                    |     B |
| 4. legit, mix, belt 순서는?                                           | legit phrase 안정화와 speech-like phrase를 먼저, 그다음 mix, 마지막에 belt-adjacent. 실제 belt/high belt는 expert gate.                                                            |     B |
| 5. belt/belt mix 중 앱 단독으로 위험한 요소는?                                 | high belt, sustained belt, maximal loudness, chest-dominant high mix, 반복 open-vowel belting, throat-driven character belt, rasp/scream/distortion.                |   A/B |
| 6. belt-safe pathway의 cap/fallback/stop signal은?                   | range cap, intensity cap, repetition cap, cumulative time cap, no-pain rule, hoarseness/high-note-loss stop, SOVT or speech-like fallback, referral trigger.      | A/B/D |
| 7. 16-bar audition cut은 어떻게 구성?                                    | “짧은 노래”가 아니라 opening objective, beat shift, climax, recoverable ending이 있는 micro-scene으로 구성한다.                                                                    |     B |
| 8. 녹음 A/B 리뷰에서 pitch보다 중요한 것은?                                     | text intelligibility, objective legibility, phrase action, vocal ease, diction, style authenticity, beat clarity. pitch는 후순위 correction.                          |     B |
| 9. character voice가 과장·압착으로 흐르지 않게 하는 cue는?                        | “목소리를 바꾸지 말고 상황·대상·목적·공명 위치·말 속도·자음 에너지를 바꿔라.” 통증·압박·hoarseness는 즉시 fallback.                                                                                     |     B |
| 10. 고강도 공연 부하를 고려한 vocal load 제한은?                                 | rehearsal/performance/speaking load를 모두 합산하고, high-intensity task는 짧게, 연속일에는 deload, 증상일에는 no-voice 또는 low-voice lesson으로 전환.                                     | A/B/D |

### 5.2 학습목표 → 훈련과제 → 피드백 → 졸업기준

| 역량                         | 학습목표: 사용자가 할 수 있게 될 것                               | 훈련과제                                                   | 앱 피드백                                                     | 졸업기준                                         |    근거 |
| -------------------------- | --------------------------------------------------- | ------------------------------------------------------ | --------------------------------------------------------- | -------------------------------------------- | ----: |
| Text intention             | lyric phrase마다 objective를 말할 수 있다.                  | “I want X from Y because Z” 작성 후 말하기.                  | objective가 행동동사인지, mood label인지 구분.                       | 3회 연속 take에서 objective가 바뀌지 않고 들린다.          |     B |
| Character objective        | 같은 멜로디를 다른 objective로 다르게 수행한다.                     | persuade / accuse / confess 등 active verb swap.        | text stress와 tempo가 objective에 맞는지 비교.                    | 청자가 두 take의 목표 차이를 설명한다.                     |     B |
| Speech-to-song             | 말의 충동을 잃지 않고 melody로 전환한다.                          | plain speech → rhythm speech → sung phrase.            | operative word 유지, rhythm distortion, vocal effort 체크.    | pitch 추가 후에도 말의 stress가 유지된다.                |     B |
| Legit phrase               | legato와 text clarity를 동시에 유지한다.                     | 4마디 legit line, vowel continuity, consonant release.   | breath collapse, over-darkening, text blur 경고.            | text가 흐려지지 않고 phrase end가 안정적이다.             |   A/B |
| Speech-like phrase         | 자연스러운 말투로 musical rhythm을 탄다.                       | short lyric를 speaking range 근처에서 speak-sing.           | 과도한 vibrato, artificial diction, pressed tone 경고.         | 노래처럼 들리되 말의 방향성이 남는다.                        |     B |
| Mix phrase                 | register transition을 드라마틱 climax와 연결한다.             | 3–5음 anchor, resonance shift, dynamic ladder.          | break, squeeze, breathy collapse, vowel distortion 체크.    | 같은 phrase를 2 dynamic level로 무리 없이 수행.        |     B |
| Belt-adjacent phrase       | 고강도 느낌을 낮은 위험으로 표현한다.                               | 짧은 call-like word, moderate intensity, low repetition. | loudness chasing, throat pressure, pain, fatigue 즉시 stop. | 24시간 후 증상 없이 동일 phrase 재현.                   | A/B/D |
| Musical theatre diction    | text가 극장적으로 선명하되 jaw/tongue tension이 낮다.            | consonant energy without jaw clamp.                    | sibilant, plosive, jaw lock, swallowed final consonants.  | backing track 없이도 lyric이 이해된다.               |     B |
| Acting beat & vocal phrase | beat shift가 breath, dynamic, registration 선택에 반영된다. | punctuation/harmony/rest에서 beat map 작성.                | breath가 의미 없이 끊기는지, climax 위치가 일관적인지.                     | beat shift 2개 이상이 청자에게 전달된다.                 |     B |
| 16-bar cut                 | 16마디 안에 objective, shift, climax, ending을 만든다.      | start/end cut 선택, beat map, mock slate.                | late start, no turn, unsafe high note, unclear ending.    | 60초 내 clear story + recoverable vocal state. |     B |
| Vocal load                 | 본인의 음성 부하와 회복 신호를 관리한다.                             | daily load log, symptom check, deload choice.          | risk color, rest recommendation, referral trigger.        | 2주간 증상 악화 없이 계획 조정.                          | A/B/D |
| A/B review                 | pitch보다 storytelling과 ease 중심으로 개선한다.               | 두 take 비교 후 rubric 점수화.                                | objective, intelligibility, ease, phrase action 우선.       | 같은 phrase의 개선 이유를 설명할 수 있다.                  |     B |

### 5.3 Phrase 유형 비교표

| Phrase 유형                  | 선행 조건                                                      | 앱 가능 범위                                                                     | 전문가 gate 필요 여부                                  | 위험 cue                                                          | 안전 fallback                                                           |
| -------------------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------------- |
| Legit phrase               | 기본 호흡 관리, comfortable range, text clarity                  | 4–8마디 legato, vowel continuity, consonant release, repertoire context       | 보통 불필요. 단, 통증·지속 hoarseness·extreme range는 gate | 과도한 dark tone, jaw lock, breath collapse, text가 흐려짐             | speech reset, lighter dynamic, lower key, SOVT cooldown               |
| Speech-like musical phrase | text intention, natural speech stress, rhythm accuracy     | 말 → rhythm speech → melody 전환. MT core phrase로 앱 적합                         | 보통 불필요                                          | “노래하는 척” 과장, pressed speech, swallowed consonants               | plain speech로 돌아가 operative word 재설정                                  |
| Mix phrase                 | legit/speech-like 안정, register break awareness, low effort | short mix phrase, dynamic ladder, vowel comparison, A/B review              | 조건부. 반복 break·압박·고음 확장은 gate                    | squeeze, sudden register flip, breathy collapse, neck tension   | lower pitch, lighter mix, speech-like phrase, SOVT                    |
| Belt-adjacent phrase       | mix 안정, no-pain baseline, load check, stop signal 이해       | 짧은 call-like phrase, moderate intensity, low repetition, comfortable range만 | 강하게 권장. high belt·sustained belt는 필수 gate       | 더 크게 밀기, throat pressure, loss of high notes, hoarseness, pain  | mix climax, speech-like emphasis, key down, no-voice text work        |
| 16-bar audition cut        | text objective, phrase map, safe range, cut literacy       | 16-bar micro-scene, beat shift, slate, A/B review, portfolio tagging        | 고위험 note·벨트 climax·오디션 직전 과사용은 gate             | climax가 top note 의존, breath panic, acting overpush, recovery 실패 | safer key, alternate cut, legit/mix version, spoken acting beat drill |

---

## 6. App Implementation Implications

### 6.1 Daily lesson template: 10~15분

**목표:** 사용자가 하루에 한 phrase를 “더 잘 부르기”가 아니라 **더 분명하게 행동하기**로 개선한다.

| 시간 | 단계                | 사용자 행동                                          | 앱 판정                             |
| -: | ----------------- | ----------------------------------------------- | -------------------------------- |
| 1분 | Safety check      | 오늘 hoarseness, pain, fatigue, high-note loss 체크 | 위험 신호 있으면 no-voice lesson        |
| 2분 | Context card      | who / to whom / objective / obstacle 작성         | objective가 playable verb인지 확인    |
| 2분 | Plain speech      | lyric을 노래 없이 말한다                                | operative word, intelligibility  |
| 2분 | Heightened speech | 더 큰 감정이 아니라 더 분명한 목적을 가진 말                      | neck pressure, overacting cue 경고 |
| 2분 | Rhythm speech     | 음악 리듬으로 말한다                                     | speech stress와 rhythm 충돌 체크      |
| 3분 | Sung phrase       | legit/speech-like/mix 중 하나로 4–8마디               | style target, ease, text clarity |
| 2분 | A/B review        | take A/B 비교                                     | pitch보다 objective/ease 우선        |
| 1분 | Recovery          | SOVT 또는 silent reflection                       | load log 저장                      |

### 6.2 Speech-to-song training model

앱에서 speech-to-song은 다음 8단계로 고정한다.

1. **Scene trigger:** “왜 지금 말로는 부족해서 노래가 시작되는가?”
2. **Plain speech:** lyric을 일상 대사처럼 말한다.
3. **Objective speech:** active verb를 붙여 말한다. 예: persuade, warn, seduce, accuse, confess.
4. **Rhythm speech:** pitch 없이 작곡된 rhythm으로 말한다.
5. **Pitch anchor:** 시작음, climax음, resolution음만 찾는다.
6. **Half-sing:** 일부 operative word에만 pitch를 붙인다.
7. **Full phrase:** style target을 선택한다. legit / speech-like / mix / belt-adjacent.
8. **A/B review:** “노래가 맞았나”보다 “말의 목적이 유지됐나”를 먼저 본다.

이 모델은 NATS의 spoken phrase → sung phrase 접근과 대학 수업 자료의 speak text / rhythm / melody sequence를 제품 구조로 변환한 것이다. ([nats.org][1])

### 6.3 Character voice cue system

캐릭터 보이스 훈련은 “이상한 목소리 만들기”가 아니다. 앱 cue는 다음 순서로 제한한다.

| 허용 cue                   | 금지 또는 위험 cue           |
| ------------------------ | ---------------------- |
| 대상을 바꿔라: 누구에게 말하는가       | 목을 조여라                 |
| 목적을 바꿔라: 무엇을 얻고 싶은가      | 더 거칠게 긁어라              |
| 속도를 바꿔라: 생각이 빠른가 느린가     | 가슴으로 밀어라               |
| 자음 에너지를 바꿔라              | 후두를 강제로 올려라            |
| resonance color를 작게 조절하라 | 원곡 배우의 소리를 복제하라        |
| breath timing을 바꿔라       | 아플 때도 character니까 유지하라 |

**졸업기준:** 같은 lyric을 두 캐릭터 objective로 수행했을 때 청자가 차이를 듣지만, 사용자의 목 피로·통증·hoarseness가 증가하지 않아야 한다. [B]

### 6.4 A/B recording review hierarchy

A/B 리뷰에서 pitch는 마지막 레이어다. 제품의 기본 가중치는 다음과 같다.

| 평가 항목                     | 권장 가중치 | 이유                                    |
| ------------------------- | -----: | ------------------------------------- |
| Text intelligibility      |    20% | lyric이 전달되지 않으면 MT 수행 실패              |
| Objective legibility      |    20% | 캐릭터가 무엇을 하려는지 들려야 함                   |
| Speech-to-song continuity |    15% | 말의 충동이 melody에서도 살아야 함                |
| Vocal ease / safety       |    15% | 반복 가능한 수행이어야 함                        |
| Phrase beat clarity       |    10% | 장면 변화가 phrase에 반영되어야 함                |
| Style appropriateness     |    10% | legit/mix/belt-adjacent 선택이 문맥에 맞아야 함 |
| Rhythm & pitch accuracy   |    10% | 중요하지만 storytelling과 safety 후순위        |

NYU·Berklee·audition 자료가 text, intent, character, vocal/dramatic needs를 반복적으로 요구한다는 점을 제품 rubric으로 변환한 설계다. ([tisch.nyu.edu][10])

### 6.5 Vocal load 제한 설계

앱은 사용자가 “오늘 노래를 몇 분 했는가”만 입력하게 하면 부족하다. MT vocal load는 노래, 대사, 춤, 리허설, 수업, 소음 속 대화, 감기·알레르기·수면까지 합쳐진다. NCVS와 NIDCD는 professional voice user의 과사용, noisy environment, vocal rest, hydration, warning signs를 강조한다. ([ncvs.org][15])

**제품 규칙:** 아래 cap은 의학적 threshold가 아니라 보수적 안전 설계다. [D]

| 상태                                        | 앱 lesson 허용                                     |
| ----------------------------------------- | ----------------------------------------------- |
| 정상, 피로 낮음                                 | 일반 10~15분 lesson                                |
| 말 많이 한 날 / 리허설 후                          | text-only, speech-only, SOVT, low-intensity mix |
| hoarseness / raw throat / high notes loss | no-voice lesson + recovery guidance             |
| 통증, 갑작스러운 음성 변화                           | 훈련 중단 + medical/SLP referral 안내                 |
| 2~3주 이상 hoarseness                        | ASHA 기준에 따라 의학적 확인 권고 ([ASHA][5])               |

---

## 7. Safety Considerations

### 7.1 Belt-safe pathway

앱은 belt를 직접 “획득”시키는 제품이 아니라, **belt prerequisite을 만들고, 위험을 낮춘 표현 대안을 제공하고, 필요한 순간 전문가에게 넘기는 제품**이어야 한다.

| 단계                     | 앱 단독 가능 | cap                                      | fallback                           | stop signal                      | gate |
| ---------------------- | ------- | ---------------------------------------- | ---------------------------------- | -------------------------------- | ---- |
| Belt literacy          | 가능      | 교육 콘텐츠만                                  | mix/legit 예시 비교                    | 없음                               | 불필요  |
| Range inventory        | 가능      | comfortable range만 기록                    | lower key                          | pain/strain                      | 조건부  |
| Speech-like intensity  | 가능      | moderate volume, short phrase            | plain speech                       | throat effort                    | 조건부  |
| Mix stability          | 가능      | 짧은 phrase, low repetition                | lighter mix/SOVT                   | break+squeeze 반복                 | 조건부  |
| Belt-adjacent call     | 제한 가능   | short, no maximal loudness, no high belt | mix climax, key down               | hoarseness, pain, high-note loss | 권장   |
| High belt              | 앱 단독 불가 | 앱에서 drill 금지                             | expert lesson                      | 모든 strain signal                 | 필수   |
| Sustained belt         | 앱 단독 불가 | drill 금지                                 | alternate cut                      | fatigue/recovery failure         | 필수   |
| Belt mix 확장            | 앱 단독 불가 | 고음·장시간 금지                                | speech-like mix                    | pressed throat                   | 필수   |
| Rasp/scream/distortion | 앱 단독 불가 | 금지                                       | acted intention without distortion | pain/roughness                   | 필수   |

### 7.2 앱 단독으로 위험한 belt/belt-mix 요소

다음은 제품에서 **직접 훈련 금지 또는 전문가 gate 필수**로 표시해야 한다.

| 고위험 요소                      | 왜 위험한가                                               | 제품 처리             | 근거  |
| --------------------------- | ---------------------------------------------------- | ----------------- | --- |
| high belt / high belt-mix   | 고음에서 높은 강도와 register strategy가 결합된다. 정의와 교육법도 불안정하다. | gate 필수           | B/C |
| sustained belt              | 높은 부하가 누적된다. vocal dose 안전 기준이 확립되어 있지 않다.           | 앱 drill 금지        | A/D |
| maximal loudness cue        | belt를 volume chasing으로 오인하게 만든다.                     | “더 크게” cue 금지     | A/B |
| chest-dominant high mix     | 사용자가 chest push로 해석하기 쉽다.                            | expert-only       | C/D |
| open-vowel repeated belt    | vowel/formant strategy가 필요하지만 앱 판정이 어렵다.             | 반복 제한·gate        | A/C |
| character compression       | 악역·코미디·분노 표현이 목 조임으로 바뀔 수 있다.                        | intention cue로 대체 | B   |
| sickness/fatigue 상태 belting | 회복 실패와 증상 악화 위험.                                     | no-voice lesson   | A   |

### 7.3 Stop signals

앱이 즉시 훈련을 중단시켜야 하는 신호:

* 목 통증, raw/strained throat
* hoarseness, raspy voice
* 갑작스러운 음성 변화
* 평소 되던 high notes 상실
* 말할 때 effort 증가
* 반복적인 throat clearing
* neck pain, lump sensation
* 한 take 후 회복되지 않는 vocal fatigue
* 2~3주 이상 지속되는 hoarseness

NIDCD와 ASHA는 전문 음성 사용자에게 hoarseness, high-note loss, throat strain, effortful talking, fatigue 등을 경고 신호로 제시하며, 지속 hoarseness는 의학적 확인을 권한다. ([NIDCD][6])

---

## 8. Recommended Framework

### 8.1 Musical Theatre Competency Framework

| 역량                         | 사용자가 할 수 있게 될 것                                               | 레벨          |
| -------------------------- | ------------------------------------------------------------- | ----------- |
| Dramatic premise           | 장면의 who, where, to whom, why now를 30초 안에 말한다.                 | Foundation  |
| Text intention             | lyric phrase마다 active objective를 설정한다.                        | Core        |
| Speech-to-song             | 말의 stress를 잃지 않고 melody로 전환한다.                                | Core        |
| Character voice            | 목을 조이지 않고 objective, rhythm, diction, resonance로 캐릭터 차이를 만든다. | Core        |
| Legit phrase               | legato, vowel line, text clarity를 유지한다.                       | Style       |
| Speech-like phrase         | 자연스러운 말투와 musical rhythm을 결합한다.                               | Style       |
| Mix phrase                 | register transition을 안전하게 처리하고 dramatic climax를 만든다.          | Style       |
| Belt-adjacent expression   | 고강도 인상을 낮은 위험으로 표현하고 stop/fallback을 실행한다.                     | Gated       |
| MT diction                 | text가 빠르거나 높거나 리듬이 복잡해도 이해된다.                                 | Style       |
| Acting beat & vocal phrase | beat shift를 breath, dynamic, registration, tempo에 반영한다.       | Performance |
| 16-bar audition cut        | objective, turn, climax, ending이 있는 압축 장면을 만든다.               | Audition    |
| Recording A/B literacy     | pitch보다 story, objective, ease 중심으로 take를 개선한다.               | Autonomy    |
| Vocal load management      | 연습·리허설·공연·일상 발화를 합산해 훈련 강도를 조절한다.                             | Safety      |

### 8.2 Speech-to-Song Training Model

| 단계                  | 학습목표                           | 훈련과제                               | 피드백                              | 졸업기준              |
| ------------------- | ------------------------------ | ---------------------------------- | -------------------------------- | ----------------- |
| 1. Scene            | 노래가 시작되는 dramatic reason을 말한다. | “말로는 더 이상 부족한 순간” 작성               | reason이 plot/relationship과 연결되는가 | 20초 안에 설명         |
| 2. Plain speech     | lyric을 자연어로 전달한다.              | 노래 없이 말하기                          | text clarity, operative words    | 청자가 핵심 문장 이해      |
| 3. Objective speech | 목적 있는 말로 바꾼다.                  | active verb 3개 비교                  | playable verb vs emotion label   | best verb 선택 가능   |
| 4. Rhythm speech    | 음악 리듬에 말의 충동을 얹는다.             | pitch 없이 rhythm speak              | stress가 rhythm에 눌리지 않는가          | 2회 연속 안정          |
| 5. Pitch anchor     | melody의 구조를 파악한다.              | 시작음, highest point, resolution만 노래 | pitch panic 감소                   | anchor 3개 정확      |
| 6. Half-sing        | operative word에만 pitch를 붙인다.   | speak-sing shuttle                 | 말과 노래의 단절                        | transition smooth |
| 7. Full phrase      | style target으로 4–8마디 수행        | legit/speech-like/mix 선택           | ease, diction, objective         | A/B 개선 확인         |
| 8. Transfer         | cut 안에서 반복 적용                  | 16-bar phrase map                  | turn, climax, recovery           | mock audition 통과  |

### 8.3 Text / Acting / Vocal Integration Framework

**Beat–Breath–Register–Diction Map**

| 레이어    | 질문                 | 앱 입력                                   | 출력               |
| ------ | ------------------ | -------------------------------------- | ---------------- |
| Text   | 핵심 단어는 무엇인가?       | operative words 표시                     | diction priority |
| Acting | 무엇을 얻으려 하는가?       | active verb 선택                         | phrase action    |
| Beat   | 언제 생각이 바뀌는가?       | punctuation, rest, harmony change 표시   | breath point     |
| Vocal  | 어떤 style이 장면에 맞는가? | legit/speech-like/mix/belt-adjacent 선택 | safe phrase plan |
| Safety | 이 선택을 반복할 수 있는가?   | effort, pain, fatigue check            | cap/fallback     |

### 8.4 Advanced Musical Theatre Lab Module Architecture

| 모듈                                 | 목적                              | 핵심 output                   | gate                 |
| ---------------------------------- | ------------------------------- | --------------------------- | -------------------- |
| M0. Voice Safety & Range Inventory | 안전 기준과 comfortable range 설정     | 개인 cap, stop signal profile | 증상 있으면 referral      |
| M1. Text Intention Lab             | lyric을 objective로 변환            | objective card              | 없음                   |
| M2. Speech-to-Song Lab             | 말에서 노래로 전환                      | speak/rhythm/sing A/B       | 없음                   |
| M3. Legit Phrase Lab               | legato와 text clarity            | legit phrase take           | extreme range gate   |
| M4. Speech-like MT Phrase Lab      | spoken quality + musical phrase | speech-like phrase take     | 없음                   |
| M5. Mix Phrase Lab                 | register flexibility            | mix phrase take             | 반복 squeeze gate      |
| M6. Belt-Safe Pathway              | belt prerequisite과 fallback     | belt-adjacent only          | high belt gate       |
| M7. Character Voice Lab            | 안전한 character differentiation   | 2-character A/B             | distortion gate      |
| M8. MT Diction Lab                 | 빠른 text와 선명도                    | diction take                | jaw/tongue pain gate |
| M9. Acting Beat & Phrase Lab       | beat shift를 vocal choice로 변환    | beat map performance        | 없음                   |
| M10. 16-Bar Audition Lab           | audition micro-scene            | 16/32-bar portfolio         | risky climax gate    |
| M11. Load & Recovery Lab           | 공연 부하 관리                        | weekly load plan            | 증상 gate              |

### 8.5 4주 반복 Cycle

| 주차     | 주제                                 | 사용자가 할 수 있게 되는 것            | 산출물                            |
| ------ | ---------------------------------- | --------------------------- | ------------------------------ |
| Week 1 | Text & Speech Baseline             | lyric을 objective speech로 수행 | 3개 objective speech recordings |
| Week 2 | Speech-to-Song & Legit/Speech-like | 말의 stress를 melody에 유지       | 2개 speech-to-song phrase       |
| Week 3 | Mix, Diction, Character            | style과 character를 안전하게 분리   | character A/B + mix phrase     |
| Week 4 | 16-Bar Cut & Load Review           | 압축 장면을 안전하게 반복              | 1개 audition cut + load plan    |

반복 시 매 cycle마다 repertoire difficulty, tempo, range, acting complexity 중 하나만 올린다. belt intensity는 자동 상승시키지 않는다.

### 8.6 6주 반복 Cycle

| 주차     | 주제                       | 제품 focus                                | 졸업기준                             |
| ------ | ------------------------ | --------------------------------------- | -------------------------------- |
| Week 1 | Safety, Range, Text      | baseline recording, stop signal         | 개인 range/load profile            |
| Week 2 | Speech-to-Song           | plain → rhythm → sung                   | phrase 2개 통과                     |
| Week 3 | Legit & Speech-like      | contrast phrase                         | style 차이 청취 가능                   |
| Week 4 | Mix & Character          | mix phrase + character objective        | squeeze 없이 2 take                |
| Week 5 | Belt-Safe / Audition Cut | belt-adjacent 또는 fallback, 16-bar build | high-risk gate 판정                |
| Week 6 | Mock Audition & Deload   | slate, cut, A/B, recovery               | portfolio-ready take + rest plan |

### 8.7 훈련 카드 30개 후보

|  # | 카드명                           | 목표                               | 위험도         |
| -: | ----------------------------- | -------------------------------- | ----------- |
|  1 | Who Am I Singing To?          | addressee 명확화                    | Low         |
|  2 | Objective in One Breath       | objective 1문장화                   | Low         |
|  3 | Active Verb Swap              | 같은 lyric을 다른 행동으로 수행             | Low         |
|  4 | Obstacle Card                 | phrase tension을 목이 아니라 상황에서 만들기  | Low         |
|  5 | Operative Word Ladder         | 핵심 단어 stress 설계                  | Low         |
|  6 | Plain Speech Take             | lyric을 말로 전달                     | Low         |
|  7 | Heightened Speech Take        | 감정 과장이 아닌 목적 강화                  | Low         |
|  8 | Rhythm Speech                 | pitch 없이 리듬 말하기                  | Low         |
|  9 | Pitch Anchor 3 Points         | 시작·climax·resolution 음 찾기        | Low         |
| 10 | Speak–Sing Shuttle            | 말과 노래를 왕복                        | Low         |
| 11 | SOVT Reset Phrase             | low-risk reset                   | Low         |
| 12 | Legit Vowel Line              | legato와 text clarity             | Medium      |
| 13 | Legit Without Blur            | classical color 안에서 lyric 선명도    | Medium      |
| 14 | Speech-like MT Phrase         | 말투 유지한 musical phrase            | Low         |
| 15 | Mix Dynamic Ladder            | 같은 phrase를 2 dynamic으로           | Medium      |
| 16 | Register Break Detective      | flip/squeeze 지점 찾기               | Medium      |
| 17 | Mix Climax Without Push       | high point를 볼륨이 아닌 objective로    | Medium      |
| 18 | Belt Literacy: What Not To Do | belt risk 교육                     | Low         |
| 19 | Belt-Adjacent Call            | 짧은 moderate-intensity call       | High / Gate |
| 20 | Belt Fallback Map             | belt 대신 mix/legit/speech-like 선택 | Low         |
| 21 | Diction Without Jaw           | 자음 선명도와 jaw release              | Low         |
| 22 | Fast Text Clarity             | 빠른 lyric 전달                      | Medium      |
| 23 | Beat-Breath Map               | breath를 acting beat에 연결          | Low         |
| 24 | Phrase Turn Marker            | 생각이 바뀌는 순간 표시                    | Low         |
| 25 | Character Resonance Dial      | 과장 없이 color 조절                   | Medium      |
| 26 | Character Tempo Dial          | 캐릭터 사고 속도 조절                     | Low         |
| 27 | 16-Bar Hook                   | cut 시작점 설계                       | Low         |
| 28 | 16-Bar Turn & Climax          | cut 중간 전환 설계                     | Medium      |
| 29 | Mock Audition Slate           | 입장, slate, cut 시작                | Low         |
| 30 | Load Log & Vocal Nap          | 음성 부하와 회복 계획                     | Low         |

### 8.8 High-risk Skills and Safety Gates

| Skill                               | 앱 단독 처리         | 전문가 gate 조건                               | 안전 fallback                      |
| ----------------------------------- | --------------- | ----------------------------------------- | -------------------------------- |
| High belt                           | 직접 훈련 금지        | 고음 belt, repeated belt, audition top note | lower key, mix climax            |
| Belt mix extension                  | 제한적 교육만         | passaggio 위 chest-dominant mix            | speech-like mix                  |
| Sustained belt                      | 금지              | 길게 유지되는 high-intensity phrase             | shorter cut, alternate phrase    |
| Rasp / scream / distortion          | 금지              | character effect가 필요한 경우                  | text intention, dynamics         |
| Singing while dancing under fatigue | 모니터링만           | breath panic, repeated show conditions    | mark choreography, low-voice run |
| Illness-day singing                 | no-voice lesson | hoarseness, pain, fever, raw throat       | text work, score study           |
| Audition panic repetition           | repetition cap  | 같은 top phrase 반복                          | one-take rule + rest             |
| Imitating cast recording            | 경고              | throat compression, accent/voice copying  | own voice + objective cue        |

### 8.9 16-bar Audition Cut Portfolio Criteria

**16-bar cut은 “잘라낸 16마디”가 아니라 audition room에서 작동하는 micro-scene이다.** 대학 audition 자료는 contrasting songs, 32-bar/60–90초, marked music, grounded text communication을 요구하므로, 앱은 16-bar와 32-bar export를 모두 지원하는 것이 안전하다. ([bostonconservatory.berklee.edu][14])

| 기준                    | Portfolio 통과 기준                                                    |
| --------------------- | ------------------------------------------------------------------ |
| Contrast              | legit / contemporary / comedic / dramatic / tempo 중 최소 2축 contrast |
| Character fit         | 사용자의 age, casting type, vocal identity와 맞음                         |
| Objective             | 첫 2마디 안에 원하는 것이 들림                                                 |
| Turn                  | cut 안에 생각 변화가 최소 1회 있음                                             |
| Climax                | 고위험 top note 하나에만 의존하지 않음                                          |
| Ending                | 끝난 뒤 vocal recovery가 가능함                                           |
| Text clarity          | backing 없이도 lyric 이해 가능                                            |
| Accompanist readiness | cut, tempo, start/end, page turn이 명확히 표시됨                          |
| Duration              | 16-bar 버전과 60–90초/32-bar 버전 모두 준비                                  |
| Safety                | audition 전날 반복해도 증상 악화가 없음                                         |

### 8.10 Recording A/B Review Rubric

| 점수 | Text / Objective              | Vocal Ease              | Style          | Pitch/Rhythm        |
| -: | ----------------------------- | ----------------------- | -------------- | ------------------- |
|  5 | objective가 즉시 들리고 lyric이 명확함  | 노력감 낮고 반복 가능            | style이 장면과 맞음  | 안정적                 |
|  4 | 대부분 명확하나 일부 operative word 약함 | 약간 피로하지만 회복됨            | 대체로 적합         | 작은 오류               |
|  3 | 노래는 되지만 목표가 흐림                | effort가 들림              | style이 일반적     | 오류가 storytelling 방해 |
|  2 | text가 흐리거나 acting이 과장됨        | throat pressure 의심      | style mismatch | 불안정                 |
|  1 | objective 불명확, 모방 느낌          | pain/hoarseness/fatigue | 고위험            | 중단 필요               |

**A/B 리뷰 질문 순서**

1. 어떤 take에서 “누가 누구에게 무엇을 원하는지” 더 잘 들리는가?
2. 어떤 take에서 text가 더 선명한가?
3. 어떤 take가 목에 덜 부담되는가?
4. 어떤 take에서 beat shift가 더 명확한가?
5. 어떤 take가 style target에 더 맞는가?
6. 마지막으로 pitch/rhythm 오류가 storytelling을 방해하는가?

---

## 9. Source Bibliography

1. **NATS, Music Theater Resources.** Speaking voice 기반 MT singing, mix 중심, belt의 climactic use, speech-to-song 접근을 제품 핵심 모델로 반영. ([nats.org][1])
2. **Roll, Christianne. “The Female Broadway Belt Voice: The Singer’s Perspective.” Journal of Singing, 2019.** traditional belt, high belt, mix-belt, singer perspective, pedagogy uncertainty 검토. 
3. **Bourne, Tracy; Garnier, Maëva; Kenny, Dianna. “Music Theater Voice: Production, Physiology and Pedagogy.” Journal of Singing, 2011.** MT voice의 belt/legit versatility와 연구 부족 지점 검토. 
4. **Titze, Ingo; Worley, Albert; Story, Brad. “Source-Vocal Tract Interaction in Female Operatic Singing and Theater Belting.” Journal of Singing, 2011.** belt와 operatic singing의 acoustic strategy 비교. 
5. **Titze, Ingo. “Belting and a High Larynx.” Journal of Singing, 2007.** belt에서 larynx height의 acoustic advantage와 biomechanical disadvantage 검토. 
6. **Bourne, Tracy; Garnier, Maëva; Samson, Adeline. “Physiological and acoustic characteristics of the male music theater voice.” JASA, 2016.** male MT belt와 legit의 acoustic/EGG 차이 검토. 
7. **Björkner, Eva. “Musical theater and opera singing—why so different?” Journal of Voice, 2008.** MT와 opera singing의 pressure/source/formant 차이에 관한 peer-reviewed 연구. ([PubMed][2])
8. **Titze, Ingo. “Voice training and therapy with a semi-occluded vocal tract.” Journal of Speech, Language, and Hearing Research, 2006.** SOVT의 물리적 원리 근거. ([PubMed][3])
9. **Kapsner-Smith et al. “A randomized controlled trial of two semi-occluded vocal tract voice therapy protocols.” Journal of Speech, Language, and Hearing Research, 2015.** SOVT 관련 RCT. ([PMC][18])
10. **2024 J Voice SOVT systematic review.** SOVT 효과 가능성과 낮은 근거 품질을 함께 반영. ([JVoice][19])
11. **ASHA Practice Portal: Voice Disorders.** 음성장애, vocal fatigue, muscle tension, functional/organic disorders 관련 safety 기준. ([ASHA][4])
12. **ASHA: Vocal Cord Nodules and Polyps.** hoarseness, fatigue, pitch change difficulty, neck pain, 2–3주 이상 hoarseness referral 기준. ([ASHA][5])
13. **NIH/NIDCD: Taking Care of Your Voice.** professional voice user risk, warning signs, hydration, vocal naps, rest, avoid extremes. ([NIDCD][6])
14. **ASHA Journals Academy: Vocal Hygiene Review for Professional Voice Users.** vocal hygiene education과 direct voice therapy의 positive outcome 근거. ([ASHA Journals Academy][7])
15. **The Voice Foundation.** 음성 과학·치료·훈련을 연결하는 기관 및 Journal of Voice 출판 맥락. ([보이스 재단][8])
16. **Voice Foundation abstract on mix, legit, belt pedagogy.** mix subcategory와 MT style terminology의 불안정성 판단에 사용. ([보이스 재단][9])
17. **NYU Tisch New Studio on Broadway Curriculum.** lyric intent, objective, character voice, scene into song, sustainable singing actor framework. ([tisch.nyu.edu][10])
18. **NYU Steinhardt Musical Theatre Curriculum.** voice, acting, dance, song analysis, character analysis, vocal production 통합 근거. ([NYU Steinhardt][11])
19. **Berklee Musical Theater Performance Minor.** vocal/dramatic needs by era/genre, characterization, repertoire identity를 제품 skill graph로 변환. ([Berklee College of Music][12])
20. **Boston Conservatory at Berklee MFA Musical Theater Vocal Pedagogy.** singing, speech, movement, acting, classical-to-pop, vocal health/longevity 통합 근거. ([bostonconservatory.berklee.edu][13])
21. **Boston Conservatory at Berklee Audition Requirements.** contrasting songs, 60–90초 audition performance 기준. ([bostonconservatory.berklee.edu][14])
22. **NYU Tisch Artistic Review Requirements.** actors who sing and dance, contrasting 32-bar cuts, marked music, range test 대비. ([tisch.nyu.edu][20])
23. **NYU Steinhardt Audition Guidance.** text communication, contrasting repertoire, sight-singing/music theory 요구. ([NYU Steinhardt][21])
24. **University of Utah Voice Syllabus.** speak text, rhythm speech, melody learning, recording, silent/minimal practice, audition book preparation을 speech-to-song 및 load design에 반영. 
25. **FAU Musical Theatre Audition Syllabus.** acting skills, breath support, room entry, accompanist, active truth를 audition module에 반영. 
26. **NCVS Vocal Hygiene for Musical Theatre Performers.** 노래·연기·춤 결합, overuse, noisy environment, 8-show-week 대비, speaking/singing switch 근거. ([ncvs.org][15])
27. **NYU Vocal Athleticism / Vocal Dose article.** vocal dose의 시간·pitch·intensity·vibration 요소와 hard-fast rule 부재를 load cap 설계에 반영. ([NYU Steinhardt][16])
28. **Journal of Voice vocal dose studies on contemporary musical theatre.** rehearsal/performance vocal dose 측정 연구를 근거 부족 영역으로 반영. ([PubMed][17])

[1]: https://www.nats.org/Music_Theater_-_Resources.html "Music Theater - Resources | National Association of Teachers of Singing"
[2]: https://pubmed.ncbi.nlm.nih.gov/17485197/?utm_source=chatgpt.com "why so different? A study of subglottal pressure, voice ..."
[3]: https://pubmed.ncbi.nlm.nih.gov/16671856/?utm_source=chatgpt.com "Voice training and therapy with a semi-occluded vocal tract"
[4]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOoo5rusrtITCVSaBMuxcun-NQ2NpTqvY7uaPZw-Gt4-NAOgK2OIm "Voice Disorders"
[5]: https://www.asha.org/public/speech/disorders/vocal-cord-nodules-and-polyps/?srsltid=AfmBOooOVA5g1lh9TH4NFPdkZSHiRwwbRMtrEObX-qiX5x9ZXMUwLWWa "Vocal Cord Nodules and Polyps"
[6]: https://www.nidcd.nih.gov/health/taking-care-your-voice "Taking Care of Your Voice | NIDCD"
[7]: https://academy.pubs.asha.org/2023/04/spend-world-voice-day-with-the-asha-journals/ "Spend World Voice Day With the ASHA Journals - ASHA Journals Academy"
[8]: https://voicefoundation.org/ "THE VOICE FOUNDATION"
[9]: https://voicefoundation.org/view/2025-abstracts/entry/2935/?utm_source=chatgpt.com "2025 Abstracts - THE VOICE FOUNDATION"
[10]: https://tisch.nyu.edu/drama/about/studios/new-studio-on-broadway/curriculum "New Studio on Broadway Curriculum"
[11]: https://steinhardt.nyu.edu/degree/mm-vocal-performance-music-theatre "MM, Vocal Performance: Music Theatre | NYU Steinhardt"
[12]: https://college.berklee.edu/minors/musical-theater-performance "Minor in Musical Theater Performance | Berklee College of Music"
[13]: https://bostonconservatory.berklee.edu/vocal-pedagogy/master-fine-arts-musical-theater-vocal-pedagogy "Master of Fine Arts in Musical Theater: Musical Theater Vocal Pedagogy | Boston Conservatory at Berklee"
[14]: https://bostonconservatory.berklee.edu/admissions/theater-audition-requirements "Theater Audition Requirements | Boston Conservatory at Berklee"
[15]: https://ncvs.org/vocal-hygiene-for-musical-theater-performers/ "Vocal Hygiene for Musical Theater Performers - NCVS - National Center for Voice and Speech"
[16]: https://steinhardt.nyu.edu/news/measuring-vocal-athleticism-broadway-stars "Measuring the Vocal Athleticism of Broadway Stars | NYU Steinhardt"
[17]: https://pubmed.ncbi.nlm.nih.gov/34620516/?utm_source=chatgpt.com "Vocal Dose and Vocal Demands in Contemporary Musical ..."
[18]: https://pmc.ncbi.nlm.nih.gov/articles/PMC4610291/?utm_source=chatgpt.com "A Randomized Controlled Trial of Two Semi-Occluded Vocal ..."
[19]: https://www.jvoice.org/article/S0892-1997%2821%2900195-8/abstract?utm_source=chatgpt.com "Effectiveness of Semi-Occluded Vocal Tract Exercises ..."
[20]: https://tisch.nyu.edu/drama/admissions/how-to-apply/artistic-review-guidelines/music-theatre "Drama Musical Theatre Artistic Review"
[21]: https://steinhardt.nyu.edu/degree/bm-vocal-performance-music-theatre/how-audition "How to Audition | BM, Vocal Performance: Music Theatre | NYU Steinhardt"
