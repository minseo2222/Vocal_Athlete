# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `13. Advanced Classical Lab #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `13-advanced-classical-lab.md`

---

# 1. Executive Summary

**제품 결론:** Advanced Classical Lab은 “성악을 앱으로 완성시키는 트랙”이 아니라, **전문 레슨 사이의 반복 연습·녹음·자기평가·전문가 리뷰를 구조화하는 보조 훈련 시스템**으로 설계해야 한다. 성악 고급 역량은 호흡·발성·공명·언어·레퍼토리·청각 판단·건강 판단이 결합된 복합 기술이며, NATS 계열 자료도 음성 교사가 해부·생리·음향·딕션·레퍼토리·테크놀로지를 통합적으로 다뤄야 한다고 본다. 특히 잘못된 과사용은 손상 가능성이 있으므로 앱은 “진단자”가 아니라 “안전한 반복 과제와 기록 시스템”이어야 한다. [B] ([가창교사협회][1])

| 필수 질문                             | 제품팀용 결론                                                                                                                                                                                                           | 근거 수준 |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| 1. 성악 트랙 핵심 역량                    | 사용자가 **건강 신호를 감지하고, 중간 음역에서 안정적 호흡 조정·legato·vowel/diction·기초 레퍼토리 수행·녹음 A/B 비교**를 할 수 있게 하는 것이 핵심이다.                                                                                                             | [A/B] |
| 2. 앱 단독 vs 전문가 리뷰                 | 앱 단독은 짧고 편안한 음역의 반복 과제, IPA/diction, 녹음 비교, 자기평가까지다. **passaggio handling, messa di voce, aria, acoustic projection, voice type/fach 판단, 병적 음성 의심**은 전문가 리뷰가 필요하다.                                                | [A/B] |
| 3. appoggio·legato 앱 과제화          | “support/push”가 아니라 **breath management**로 표현하고, 10–30초 과제: 편안한 흡기 → 짧은 모음/문장 → 상대적 음량 안정 → 무긴장 자기체크로 만든다. NATS 용어집은 appoggio를 현대적으로 breath management/coordination 관점에서 설명한다. ([가창교사협회][2])                      | [B]   |
| 4. 모음 정렬·diction 순서               | **IPA 기초 → cardinal vowel map → Italian pure vowel/legato → English stress·diphthong → German front rounded vowel·final devoicing·consonant cluster** 순서가 앱 안전성과 난이도 면에서 적합하다.                                    | [B/C] |
| 5. Italian/German/English 깊이      | Italian은 legato와 모음 안정의 기본 언어, English는 텍스트 명료도·diphthong timing, German은 고급 diction·Lieder 준비로 다룬다. 대학 diction 수업은 IPA와 주요 singing languages를 반복적으로 다룬다. ([rpublic.rollins.edu][3])                              | [B]   |
| 6. passaggio·messa di voce unlock | passaggio는 먼저 “인식·기록”만 열고, handling은 전문가 gate. messa di voce는 **중간 음역·낮은 강도·짧은 pre-MdV**만 앱에서 열며, 고음·큰 음량·aria 문맥은 전문가 gate다. passaggio와 MdV 모두 연구상 개인차와 복잡성이 크다. ([PLOS][4])                                     | [A/D] |
| 7. art song/aria 난이도              | art song excerpt는 앱 자산으로 가능하되 range, tessitura, language, phrase length, dynamics, text age/context를 제한한다. aria excerpt는 원조·역할·tessitura·투사 요구 때문에 기본적으로 전문가 승인 자산이다. ([rcmusic-kentico-cdn.s3.amazonaws.com][5]) | [B]   |
| 8. acoustic projection vs 스마트폰    | 스마트폰은 pitch, rhythm, duration, 같은 조건의 A/B 상대 비교에는 유용하지만, **절대 SPL, 객석 투사, singer’s formant score, 성악적 공명 품질 판정**에는 한계가 있다. 기기·마이크 거리·소음·주파수 응답이 음향 측정에 영향을 준다. ([Frontiers][6])                                   | [A]   |
| 9. singer’s formant 직접 피드백 위험     | singer’s formant는 훈련된 클래식/오페라 음성에서 관찰되는 3kHz 부근 spectral peak지만, vowel·loudness·voice classification에 따라 달라진다. 이를 초중급자에게 “점수”로 주면 과압·목 조작·과도한 어둡게 만들기 같은 오동작을 유발할 수 있다. ([PubMed][7])                             | [A/D] |
| 10. 고급 포트폴리오                      | 고급 산출물은 “멋진 고음”이 아니라 **안전 로그, IPA/translation, diction clips, appoggio/legato A/B, art song excerpt, 전문가 승인 aria/MdV clip, 자기평가 리포트**다.                                                                           | [B]   |

---

# 2. Evidence Review

아래 표는 검색 자료를 **비교 → 비판 → 통합 → 커리큘럼 변환** 관점으로 정리한 evidence review다. “근거 수준”은 앱 설계 주장에 적용한다.

|  # | 출처 우선순위                                | 핵심 근거                                                                                                                                                                         | 비판적 해석                                                    | 앱 커리큘럼 변환                                                     | 수준    |
| -: | -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------- | ----- |
|  1 | NATS / Science-informed terminology    | breath management는 호흡 압력·유량을 phonation·resonance와 조정하는 개념이며, appoggio/breath support는 역사적 용어로 breath management로 대체되는 경향이 있다. ([가창교사협회][2])                                   | “복식호흡을 하라” 같은 단일 지시는 부정확하다.                               | 앱 문구는 **support**보다 “조정, pacing, no pushing”으로 설계한다.          | [B]   |
|  2 | NATS / AATS fact-based pedagogy        | 과도한 흡기와 과압은 최적 발성보다 높은 압력을 만들 수 있고, “support” 언어는 조임·과압을 유발할 수 있다. ([americanacademyofteachersofsinging.org][8])                                                              | appoggio를 앱이 자동 교정하는 것은 위험하다.                             | “더 밀어라” 금지. breath task는 짧고 편안한 음역으로 제한.                      | [B/A] |
|  3 | Journal of Singing / NATS CVPF         | 현대 voice teacher는 과학·전통·예술을 통합하고, 건강 보존·repertoire·diction·technology 이해가 필요하다. ([가창교사협회][1])                                                                                 | 앱은 교사를 대체할 수 없고, teacher-informed practice layer가 되어야 한다. | 전문가 리뷰, 레슨 노트, 포트폴리오 export 기능 필요.                            | [B]   |
|  4 | Journal of Singing / diction pedagogy  | IPA는 lyric diction 교육에서 표준화된 도구로 자리 잡았다. ([가창교사협회][9])                                                                                                                        | 발음 모사만으로는 language diction progression이 약하다.              | 모든 diction mini-module은 **IPA → spoken text → sung text** 구조. | [B]   |
|  5 | Rollins Singing Diction syllabus       | Italian, German, French, English lyric diction과 IPA, sung diction, 자기·타인 발음 인식 훈련을 명시한다. ([rpublic.rollins.edu][3])                                                           | 대학 수업은 앱보다 피드백 밀도가 높다.                                    | 앱은 IPA drill과 녹음 비교는 제공하되, stylistic diction은 리뷰 gate.        | [B]   |
|  6 | Diction curriculum dissertation        | 여러 프로그램이 English/Italian을 먼저, German/French를 후속으로 배열한다. ([OhioLINK ETD Center][10])                                                                                           | 논문·설문 기반이라 보편 규칙은 아니다.                                    | 앱 기본 순서는 IPA+Italian → English → German, 기관별 custom 가능.       | [C/D] |
|  7 | UNT vocal studies curriculum           | graduate vocal diction은 advanced Italian/French/German phonetics and pronunciation, vocal pedagogy는 respiration·phonation·resonation·articulation을 다룬다. ([music.unt.edu][11]) | 고급 diction은 별도 학습 단위다.                                    | diction은 technique module의 부속이 아니라 독립 competency.             | [B]   |
|  8 | Conservatoire de Paris                 | Italian lyric diction은 phonetics뿐 아니라 characteristic legato와 technical vocal requirements와 연결된다. ([conservatoiredeparis.fr][12])                                              | Italian diction은 단순 발음이 아니라 legato 설계와 결합된다.              | Italian module을 legato/vowel alignment의 gateway로 사용.          | [B]   |
|  9 | ASHA Voice Disorders                   | voice disorder는 구조적·신경학적·기능적 원인이 있고, severity는 청각 인상만으로 결정할 수 없으며 instrumental assessment가 필요할 수 있다. ([ASHA][13])                                                             | 앱이 병적 음성 여부를 판단하면 안 된다.                                   | red flag 발생 시 “진단”이 아니라 ENT/SLP referral.                     | [A]   |
| 10 | NIDCD Taking Care of Your Voice        | hoarseness, 고음 상실, 낮아진 음색, raw/strained throat, effortful talking 등이 문제 신호이며 ENT/SLP 상담이 권고된다. ([NIDCD][14])                                                                  | 성악 앱은 wellness gate를 필수로 가져야 한다.                          | 매 세션 시작/종료 voice health check.                                | [A]   |
| 11 | ASHA nodules/polyps                    | 2–3주 이상 hoarseness가 지속되면 의사 진료와 laryngoscopy/stroboscopy가 필요할 수 있다. ([ASHA][15])                                                                                              | 앱이 장기 쉰소리 사용자를 계속 훈련시키면 위험하다.                             | 14일 이상 증상 로그 → 훈련 잠금 + 의료 안내.                                 | [A]   |
| 12 | Voice Foundation / Journal of Voice    | Journal of Voice는 peer-reviewed voice medicine and research journal이며 voice science, medicine, SLP, pedagogy를 다룬다. ([보이스 재단][16])                                             | 성악 앱의 안전 정책은 voice medicine 자료와 연결해야 한다.                  | 임상 경계선은 ASHA/NIDCD/Voice Foundation 계열 근거 우선.                 | [A/B] |
| 13 | Real-time visual feedback review       | objective·positive·task-oriented KR은 self-regulation과 motor learning을 도울 수 있으나, subglottal pressure 과도화는 충돌·장애 위험과 연결된다. ([MDPI][17])                                         | 피드백은 유용하지만 잘못 설계하면 위험 동작을 강화한다.                           | feedback은 “더 크게”보다 “편안한 반복, 일정성, 자기감각” 중심.                    | [A/B] |
| 14 | Sundberg singer’s formant              | singer’s formant는 3kHz 부근 peak이며 F3–F5 cluster와 관련되고 vowel, loudness, voice classification에 따라 level·center frequency가 달라진다. ([PubMed][7])                                    | 단일 목표 주파수 점수화는 부정확하다.                                     | singer’s formant는 교육 설명/고급 리뷰용, 자동 점수 금지.                     | [A/D] |
| 15 | Ritzerfeld & Miller passaggio          | male passaggio에서 H2/F1, F2, singer’s formant cluster 상호작용이 관찰된다. ([PubMed][18])                                                                                               | passaggio는 pitch-only 문제가 아니다.                            | 앱은 “break marker”까지만, vowel/formant prescription은 전문가 gate.   | [A/D] |
| 16 | Echternach et al. soprano passaggio    | trained sopranos에서도 passaggi에 다양한 패턴이 있고, laryngeal biomechanics와 vocal tract resonance 효과가 모두 논의된다. ([PLOS][4])                                                              | passaggio handling의 단일 알고리즘화가 어렵다.                        | voice type별 자동 처방 금지.                                         | [A/D] |
| 17 | Köberlein et al. messa di voce         | MdV는 stable pitch 위에서 SPL 변조를 하는 어려운 고전 성악 기술이며, 여러 생리 구성요소가 관여한다. ([PLOS][19])                                                                                               | full MdV는 고급 전문 기술이다.                                     | 앱은 pre-MdV awareness만, full MdV는 전문가 리뷰.                      | [A/D] |
| 18 | RCM Voice Syllabus                     | 레퍼토리는 levels와 lists로 나뉘며, 상위 단계에서 opera/oratorio arias가 등장하고 언어 다양성이 요구된다. ([rcmusic-kentico-cdn.s3.amazonaws.com][5])                                                        | 레퍼토리 난이도는 곡명만으로 결정되지 않는다.                                 | range·tessitura·언어·style·dynamic load로 asset metadata화.       | [B]   |
| 19 | ABRSM Singing                          | 모든 곡이 모든 학생에게 적합하지 않으며 range, content, context를 고려해야 한다. ([abrsm.org][20])                                                                                                    | “유명 aria” 추천은 위험하다.                                       | app recommendation에 suitability warning 필수.                   | [B]   |
| 20 | LCM Classical Singing list             | classical singing repertoire는 art song, sacred, opera, oratorio 등이며, singer에게 vocally suitable하고 character·words·music을 project할 수 있어야 한다. ([lcme.uwl.ac.uk][21])             | 난이도에는 음악·언어·극적 요구가 포함된다.                                  | excerpt rubric에 vocal/musical/text/dramatic demand 포함.        | [B]   |
| 21 | NATS Student Auditions rules           | classical category는 art song/aria를 구분하고, arias는 원어·원조/표준키 요구가 있다. ([가창교사협회][22])                                                                                              | aria는 단순 song excerpt가 아니다.                               | aria excerpt는 expert-approved asset로 분리.                      | [B]   |
| 22 | Smartphone acoustics research          | sentence-level voice acoustic measures는 recording method, mic type, distance, noise에 영향을 받으며, smartphone/tablet 조건 간 차이가 있다. ([Frontiers][6])                                 | 스마트폰 녹음은 절대 음향 판단에 부적합할 수 있다.                             | same-device, same-distance A/B review만 신뢰.                    | [A]   |
| 23 | Acoustics Today smartphone measurement | professional sound-level meter 기준을 완전히 충족한 smartphone-based sound level solution은 없고, calibration이 중요하다. ([Acoustics Today][23])                                              | “projection score”는 과학적으로 취약하다.                           | absolute SPL/projection feedback 금지.                          | [A]   |

---

# 3. Consensus

**Consensus 1 — 성악 고급 역량은 단일 테크닉이 아니라 통합 조정 능력이다. [A/B]**
호흡, 발성, 공명, articulation, diction, repertoire, 청각 판단, 건강 판단이 동시에 작동한다. NATS 계열 CVPF는 음성 교사의 역량에 anatomy/physiology, acoustics, diction, repertoire, diagnostic listening, technology를 포함한다. 따라서 앱 커리큘럼도 “호흡 챕터 → 공명 챕터” 식 단절형보다 **짧은 과제 반복 → 녹음 → 자기평가 → 레퍼토리 적용 → 전문가 리뷰** 루프가 더 타당하다. ([가창교사협회][1])

**Consensus 2 — appoggio는 앱에서 “밀기”가 아니라 breath management로 번역해야 한다. [B]**
NATS terminology 자료는 breath management를 호흡 압력·유량이 phonation·resonance와 조정되는 것으로 정의하고, appoggio/breath support를 역사적 용어로 설명한다. AATS/NATS 자료는 “support”가 조임·과압으로 오해될 수 있음을 지적한다. 따라서 앱 과제는 “더 강하게 지탱하라”가 아니라 **편안한 흡기, 일정한 phrase pacing, 무긴장, 적정 음량**을 목표로 해야 한다. ([가창교사협회][2])

**Consensus 3 — diction은 IPA, 언어 규칙, sung diction, repertoire context가 함께 가야 한다. [B]**
Journal of Singing diction 자료와 대학 diction syllabus들은 IPA를 공통 도구로 사용하고, Italian/German/French/English 같은 주요 singing languages에서 spoken pronunciation과 sung diction을 구분한다. 앱은 단어 발음 채점만 제공하면 부족하며, **IPA → stress → vowel/diphthong/consonant → text rhythm → sung phrase** 순서로 설계해야 한다. ([가창교사협회][9])

**Consensus 4 — passaggio는 존재하지만, handling은 개인화가 필요하다. [A/B]**
Journal of Singing은 classical singing에서 register transition이 미숙하게 드러나면 abrupt timbral/pitch changes가 나타날 수 있다고 설명하고, soprano passaggio 연구와 male passaggio 연구는 laryngeal·resonance·harmonic/formant 상호작용이 복합적임을 보여준다. 앱은 passaggio를 “인식하고 기록하는 능력”까지는 도울 수 있지만, vowel modification이나 register strategy를 자동 처방해서는 안 된다. ([가창교사협회][24])

**Consensus 5 — messa di voce는 고급 기술이며 앱 단독 목표가 아니다. [A/D]**
messa di voce는 안정된 pitch 위에서 crescendo–decrescendo를 조정하는 어려운 classical skill이고, 연구는 professional singers를 대상으로 해도 복합 생리 조정이 관여한다고 본다. 앱은 “full MdV” 대신 **중간 음역의 짧은 dynamic awareness precursor**만 제공하고, 실제 MdV 수행 평가는 전문가 gate로 넘겨야 한다. ([PLOS][19])

**Consensus 6 — vocal health red flag는 앱 훈련보다 우선한다. [A]**
NIDCD는 쉰소리, 고음 상실, 목의 raw/strained 느낌, 말하기 노력 증가 등을 문제 신호로 제시하고, ASHA는 음성장애 severity를 청각 인상만으로 판단할 수 없다고 설명한다. 2–3주 이상 hoarseness가 지속되면 의학적 평가가 필요할 수 있다. 앱은 이러한 상태에서 “계속 연습”을 권장하면 안 된다. ([ASHA][13])

**Consensus 7 — repertoire는 곡명이 아니라 vocal load와 context로 난이도화해야 한다. [B]**
RCM, ABRSM, LCM, NATS audition rules 모두 레퍼토리 적합성을 range, language, style, original key, aria/art song distinction, text/content/context 등과 연결한다. 따라서 앱의 art song/aria asset은 “인기곡”이 아니라 **range, tessitura, phrase length, dynamics, language, dramatic demand, expert-gate status**로 태깅해야 한다. ([rcmusic-kentico-cdn.s3.amazonaws.com][5])

---

# 4. Controversies

## 4.1 전문가 논쟁 Controversy

| 논쟁 영역                            | 서로 갈리는 지점                                                                                               | 제품 판단                                                                             | 수준    |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ----- |
| appoggio 용어                      | 전통적 “support/appoggio” 언어를 유지할지, breath management/coordination으로 바꿀지 의견 차이가 있다.                        | 앱 UX에서는 전통 용어를 설명하되, 피드백 문장은 **push/support**보다 “조정, release, pacing”으로 쓴다.       | [B/C] |
| passaggio 원인                     | register event를 laryngeal biomechanics 중심으로 볼지, vowel/formant/resonance interaction 중심으로 볼지 단일 합의가 약하다. | 앱은 passaggio “처방”을 하지 않고, **break/timbre shift logging**만 제공한다. ([PLOS][4])       | [A/D] |
| vowel alignment / formant tuning | 일부 pedagogical tradition은 vowel modification을 적극 사용하지만, 개인 voice type·pitch·language·room에 따라 다르다.      | 자동 “이 모음을 이렇게 바꾸라” 금지. 대신 user가 IPA target과 녹음 A/B를 비교하게 한다.                      | [B/D] |
| singer’s formant 교육              | 고급 classical projection의 핵심 설명으로 유용하지만, 초중급자에게 직접 목표로 줄 수 있는지는 논쟁적이다.                                   | “3kHz 점수” 금지. 고급 설명 콘텐츠와 전문가 리뷰용 spectrogram only. ([PubMed][7])                  | [A/D] |
| messa di voce unlock 시점          | 일부 전통에서는 기본 훈련으로 쓰지만, 현대 연구·안전 관점에서는 복합 고급 조정으로 본다.                                                     | 앱은 pre-MdV만 허용하고 full MdV는 expert-gated. ([PLOS][19])                             | [A/D] |
| 스마트폰 음향 피드백                      | 일부 acoustic measures는 강한 상관을 보이나, sentence-level·spectral/cepstral measures는 기기·거리·소음 영향이 크다.           | same-device A/B만 신뢰. absolute projection, SPL, formant score 금지. ([Frontiers][6]) | [A]   |

## 4.2 근거 부족 Insufficient Evidence

| 근거 부족 영역                         | 왜 부족한가                                                                               | 앱 정책                                            |
| -------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------- |
| 개인별 passaggio 자동 탐지 후 교정         | 성별·voice type·훈련 수준·vowel·pitch에 따른 패턴이 다양하고, 연구도 주로 소규모 전문 singer 대상이다.             | “인식·기록”만 앱 가능, handling은 전문가.                   |
| 스마트폰 기반 singer’s formant scoring | singer’s formant 자체는 연구 근거가 있으나, 스마트폰 mic로 사용자별 성악 공명 품질을 정확히 점수화하는 근거는 약하다.         | 점수화 금지, 교육용 시각화만.                               |
| 앱 단독 messa di voce 완성            | MdV 연구는 전문 singer 중심이며, 안전한 일반 사용자 progression 기준은 충분하지 않다.                          | pre-MdV gate + expert review.                   |
| aria excerpt 자동 난이도 판정           | aria는 원조, role, orchestration, dramatic context, fach, tessitura가 복합적이다.             | asset metadata + expert approval 없이는 unlock 금지. |
| “좋은 classical resonance” 자동 판정   | 공명은 vowel, pitch, loudness, room, mic, singer morphology, repertoire style의 영향을 받는다. | acoustic proxy를 “정답”으로 표시하지 않음.                 |

---

# 5. Curriculum Design Implications

Advanced Classical Lab은 “무엇을 가르칠까”가 아니라 **사용자가 무엇을 할 수 있게 될까**로 설계해야 한다. 권장 반복 루프는 다음과 같다.

**Readiness check → 10–30초 micro-task → 녹음 → 자기감각 체크 → 앱 피드백 → A/B 비교 → safety gate → repertoire excerpt 적용 → 전문가 리뷰.**

| 모듈                                | 학습목표: 사용자가 할 수 있게 되는 것                                            | 훈련과제                                                              | 앱 피드백                                                               | 졸업기준                                                             | 범위                      |
| --------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------------- |
| M0. Vocal Health Readiness        | 오늘 훈련 가능한 상태인지 판단한다.                                              | hoarseness, pain, fatigue, high-note loss, speaking effort check. | stop / reduce / proceed.                                            | 7일 이상 red flag 없이 기록.                                            | 앱 단독                    |
| M1. Recording Protocol            | 같은 조건으로 A/B 비교 가능한 녹음을 만든다.                                       | mic distance, room noise, same device, 10초 calibration phrase.    | clipping, noise, distance reminder.                                 | 3회 연속 비교 가능한 recording quality.                                  | 앱 단독                    |
| M2. Appoggio as Breath Management | 편안한 중간 음역에서 phrase를 밀지 않고 유지한다.                                   | 4초 조용한 흡기 → 6–8초 모음/짧은 문장.                                        | duration, onset stability, relative loudness drift, RPE self-check. | pain 0, strain ≤2/10, 3세션 안정.                                    | 앱 + 자기평가                |
| M3. Legato Line                   | 모음·음절 사이 끊김 없이 짧은 선율을 연결한다.                                       | vowel skeleton → syllables → text on 3–5 notes.                   | pitch continuity, gap detection, rhythm, consonant timing.          | 80% 이상 no-gap phrase, text intelligibility self-pass.            | 앱 + 자기평가                |
| M4. Vowel Alignment               | IPA target vowel을 인식하고, pitch가 바뀌어도 과도하게 왜곡하지 않는다.                | [i e ɛ a ɔ o u] spoken→sung mapping.                              | target reminder, recording A/B, self-label.                         | 3개 vowel family에서 안정된 A/B improvement.                           | 앱 + 자기평가                |
| M5. Diction Mini-modules          | Italian/German/English short text를 IPA·stress·sung timing으로 수행한다. | IPA → speak → chant → sing.                                       | phoneme checklist, stress placement, diphthong/consonant timing.    | 각 언어 2개 clip + self-correction note.                             | 앱 + 자기평가; style 리뷰는 전문가 |
| M6. Passaggio Recognition         | 자신의 break/timbre shift 위치를 무리 없이 기록한다.                            | 낮은 강도 siren/scale in comfortable range.                           | “변화 지점 표시”만, 교정 지시 없음.                                              | 3회 recording에서 변화 지점 self-marking.                               | 앱 + 전문가 리뷰 필요           |
| M7. Pre-Messa di Voce             | 중간 음역에서 작은 dynamic swell을 무리 없이 시도한다.                             | 5–6초 gentle swell, mp 중심.                                         | clipping, duration, relative amplitude contour, red-flag check.     | strain ≤2/10, no hoarseness next day, expert approval 전까지 확장 금지. | 전문가 gate                |
| M8. Art Song Excerpt              | 적합한 난이도의 art song 20–40초를 준비한다.                                   | text/IPA/translation → vowel skeleton → phrase recording.         | pitch/rhythm/text checklist, A/B rubric.                            | 2개 art song excerpt portfolio.                                   | 앱 + 자기평가                |
| M9. Aria Excerpt                  | 승인된 aria excerpt를 안전하게 준비한다.                                      | expert-approved excerpt only.                                     | recording logistics, checklist, no technical prescription.          | 전문가 리뷰 통과 clip.                                                  | 앱 + 전문가 리뷰              |
| M10. Portfolio                    | 자신의 고급 성악 학습 근거를 제출 가능하게 정리한다.                                    | clips, IPA, translation, self-assessment, review notes.           | completeness score, safety status.                                  | portfolio rubric 80% 이상 + no unresolved red flags.               | 앱 + 전문가 리뷰              |

---

# 6. App Implementation Implications

## 6.1 앱 단독 가능 / 자기평가 가능 / 전문가 필요 / 금지

| 분류                | 앱이 제공할 수 있는 것                                                                                                                                                                                   | 조건                                     |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| **앱 단독 가능**       | IPA 기초, cardinal vowel recognition, rhythm/pitch practice, recording protocol, noise/clipping check, short spoken diction, 레퍼토리 metadata 학습, vocal health checklist.                            | 발성 강도 낮음, comfortable range, 진단·처방 없음. |
| **앱 + 자기평가 가능**   | appoggio precursor, legato short phrase, vowel alignment A/B, Italian/English/German mini-diction, art song excerpt preparation.                                                                | RPE, 통증, hoarseness, 다음날 피로 로그 필수.     |
| **앱 + 전문가 리뷰 필요** | passaggio handling, vowel modification above/below passaggio, messa di voce, aria excerpt, acoustic projection, resonance strategy, repertoire difficulty override, voice type/fach discussion. | 전문가 승인 전까지 확장 잠금.                      |
| **앱에서 금지**        | 병명 진단, nodules/polyps 의심 판정, voice type 확정, “고음을 밀어라,” “복압을 더 줘라,” singer’s formant 점수화, absolute SPL/projection 점수, 고음·forte 반복 endurance challenge, 통증 무시 지시.                                 | 항상 금지.                                 |

## 6.2 피드백 신호 설계

| 피드백 항목    | 허용 방식                                                 | 금지/주의                       |
| --------- | ----------------------------------------------------- | --------------------------- |
| Pitch     | 음정 중심, 안정성, 과제 내 drift.                               | passaggio 교정 처방으로 연결 금지.    |
| Rhythm    | text rhythm, phrase timing, onset/offset.             | “늦으니 더 세게 발음” 같은 물리 지시 금지.  |
| Loudness  | 같은 기기·같은 거리에서 relative contour만.                      | 절대 dB, projection score 금지. |
| Vowel     | IPA target reminder, user self-label, A/B comparison. | formant target을 정답처럼 표시 금지. |
| Legato    | gap, abrupt cutoff, consonant delay proxy.            | “목을 열어라/후두를 내려라” 자동 처방 금지.  |
| Resonance | 교육 콘텐츠, listening example, reflection prompt.         | “당신의 공명은 부족하다” 자동 판정 금지.    |
| Health    | red flag check, rest recommendation, referral.        | 병명 추정, 치료 지시 금지.            |

스마트폰 녹음은 녹음 방법·마이크 거리·소음·기기 특성에 따라 acoustic measures가 달라지므로, 제품은 **동일 조건 A/B review**에 집중해야 한다. absolute SPL, 객석 projection, singer’s formant, formant tuning score는 스마트폰 기반 자동 피드백으로 부적합하다. [A] ([Frontiers][6])

---

# 7. Safety Considerations

## 7.1 공통 safety gate

모든 발성 세션 시작 전 앱은 다음을 확인해야 한다: 오늘 쉰소리, 목 통증, raw/strained sensation, 말하기 노력 증가, 고음 상실, 감기·reflux flare, 전날 과사용, 수면 부족. NIDCD와 ASHA 자료는 이러한 증상이 음성 문제의 신호일 수 있으며, 지속적 hoarseness는 의학적 평가가 필요할 수 있음을 제시한다. [A] ([NIDCD][14])

| 상태                       | 앱 조치                                   |
| ------------------------ | -------------------------------------- |
| 통증, 날카로운 불편감, 갑작스런 음역 상실 | 즉시 세션 중단.                              |
| hoarseness 48시간 이상       | 발성 과제 잠금, 비발성 diction/score study만 허용. |
| hoarseness 2–3주 지속       | ENT/SLP 상담 안내, 훈련 잠금.                  |
| 녹음에서 clipping·과도한 소음     | acoustic feedback 비활성화.                |
| RPE 5/10 이상              | 강도 감소 또는 중단.                           |
| 다음날 목 피로 악화              | progression rollback.                  |

## 7.2 Passaggio safety gate

**앱에서 열 수 있는 단계:** passaggio recognition only.
사용자는 짧은 glide 또는 scale에서 “어디서 음색·저항·전환감이 느껴지는지” 표시한다. 앱은 이를 “정답 위치”로 확정하지 않고, 다음 레슨/리뷰에 가져갈 observation으로 저장한다. passaggio 연구는 성부·성별·개인 전략에 따라 다양한 패턴을 보여주므로 자동 교정은 부적합하다. [A/D] ([PLOS][4])

**unlock 조건:** red flag 없음, 중간 음역 legato 과제 통과, 녹음 protocol 안정, 사용자 strain ≤2/10, expert profile에서 음역 제한 설정.

**잠금 조건:** 고음 반복, forte, “break를 없애기 위해 밀기,” 특정 vowel modification 자동 처방.

## 7.3 Messa di voce safety gate

**앱에서 허용:** pre-MdV, 즉 중간 음역에서 작은 dynamic swell을 짧게 시도하는 awareness 과제.
**전문가 gate:** full messa di voce, 고음 MdV, 넓은 dynamic range, aria 문맥 MdV. MdV는 stable pitch와 intensity modulation을 동시에 요구하는 고급 기술이며, 연구도 전문 singer 중심으로 진행되어 일반 사용자에게 안전한 자동 progression 근거가 충분하지 않다. [A/D] ([PLOS][19])

## 7.4 Acoustic projection safety gate

“더 멀리 보내라”는 제품 문구는 사용자를 더 크게 부르게 만들 위험이 있다. 앱은 projection을 **청각 이미지·text clarity·consistent resonance reflection** 수준에서만 다루고, 실제 hall projection은 전문가·피아니스트·공간 리허설·고품질 녹음 조건에서 리뷰해야 한다. 스마트폰은 professional sound-level meter 기준을 충족하지 않을 수 있고, recording method가 acoustic results에 영향을 준다. [A] ([Frontiers][6])

---

# 8. Recommended Framework

## 8.1 Classical Vocal Competency Framework

| 역량                           | 사용자가 할 수 있게 되는 것                                                  | 앱 범위                 | 근거    |
| ---------------------------- | ----------------------------------------------------------------- | -------------------- | ----- |
| Vocal Health Literacy        | 훈련 가능/중단/의뢰 상태를 구분한다.                                             | 앱 단독 + referral      | [A]   |
| Breath Management / Appoggio | 편안한 음역에서 phrase를 밀지 않고 유지한다.                                      | 앱 + 자기평가             | [B]   |
| Legato Coordination          | vowel skeleton에서 text phrase까지 연결한다.                              | 앱 + 자기평가             | [B]   |
| Vowel Alignment              | IPA vowel을 인식하고 과도한 왜곡 없이 녹음 비교한다.                                | 앱 + 자기평가             | [B/D] |
| Classical Resonance Literacy | 공명 개념을 이해하되, 자동 점수에 의존하지 않는다.                                     | 교육 콘텐츠 + 전문가 리뷰      | [A/D] |
| Passaggio Recognition        | 전환감을 안전하게 기록하고 리뷰에 제출한다.                                          | 앱 + 전문가 리뷰           | [A/D] |
| Lyric Diction                | Italian/German/English short text를 IPA·stress·sung timing으로 수행한다. | 앱 + 자기평가; style은 전문가 | [B]   |
| Repertoire Calibration       | art song/aria excerpt의 난이도와 위험 요소를 판단한다.                          | 앱 + 전문가 리뷰           | [B]   |
| Recording A/B Review         | 동일 조건 녹음으로 개선 여부를 설명한다.                                           | 앱 단독                 | [A/B] |
| Portfolio Integration        | clips, IPA, translation, self-review, expert notes를 제출한다.         | 앱 + 전문가 리뷰           | [B]   |

## 8.2 App-safe Classical Training Scope

| 안전한 앱 훈련                | 구체 과제                                                               | 졸업기준                                  |
| ----------------------- | ------------------------------------------------------------------- | ------------------------------------- |
| Recording setup         | 같은 방, 같은 거리, same-device 10초 test phrase.                           | clipping 없음, noise acceptable, 3회 일관. |
| IPA vowel map           | [i e ɛ a ɔ o u] 듣기·말하기·짧게 노래하기.                                     | self-label 80% 이상.                    |
| Italian starter diction | pure vowels, stress, double consonants, open/closed e/o.            | 2개 short phrase 녹음 + checklist.       |
| English diction         | stress, schwa awareness, diphthong timing, final consonant clarity. | 2개 text phrase A/B.                   |
| German starter diction  | front rounded vowels, final devoicing, ich/ach, consonant cluster.  | spoken→chanted→sung clip.             |
| Appoggio precursor      | 6–8초 comfortable phrase, no push, no pain.                          | 3세션 안정.                               |
| Legato phrase           | vowel skeleton → syllables → text.                                  | no-gap phrase 80% 이상.                 |
| Art song excerpt prep   | IPA/translation/vowel skeleton/short recording.                     | 20–40초 excerpt 2개.                    |

## 8.3 Expert-gated Skills Table

| 기술                  | 왜 gate가 필요한가                                                                   | 전문가 리뷰 기준                           |
| ------------------- | ------------------------------------------------------------------------------ | ----------------------------------- |
| Passaggio handling  | register, laryngeal, harmonic/formant interaction이 개인별로 다르다.                   | 음역·성부·vowel strategy·긴장 여부 검토.      |
| Messa di voce       | pitch 안정과 dynamic modulation의 복합 고급 기술이다.                                      | 중간 음역 안정, strain 없음, 다음날 피로 없음.     |
| Aria excerpt        | role, original key, tessitura, orchestral projection, dramatic context가 복합적이다. | 곡 선택·key·cut·tempo·text context 승인. |
| Acoustic projection | hall projection은 스마트폰 mic로 판정 불가.                                              | 대면/고품질 녹음/공간 리허설 리뷰.                |
| Singer’s formant    | vowel·loudness·voice classification 의존성이 크다.                                   | spectrogram은 설명용, 점수화 금지.           |
| Fach/voice type     | 성숙도·range·tessitura·timbre·레퍼토리 history가 필요하다.                                 | 장기 관찰 기반 전문가 판단.                    |
| 지속적 hoarseness      | 병적 원인 가능성.                                                                     | ENT/SLP referral.                   |

## 8.4 Advanced Classical Lab Module Architecture

| Lab                           | 사용자 산출물                        | 반복 주기    | Review     |
| ----------------------------- | ------------------------------ | -------- | ---------- |
| Lab 0. Safety & Baseline      | baseline recording, health log | 매 세션     | 앱          |
| Lab 1. Vowel Map              | 7 vowel clips                  | 주 2–3회   | 앱 + 자기평가   |
| Lab 2. Italian Legato Gateway | Italian phrase 2개              | 주 2–3회   | 앱 + 자기평가   |
| Lab 3. Appoggio Micro-phrases | breath-managed phrase A/B      | 주 2회     | 앱 + 자기평가   |
| Lab 4. Legato Text Line       | vowel skeleton→text clip       | 주 2회     | 앱 + 자기평가   |
| Lab 5. English Diction        | English art-song phrase        | 주 1–2회   | 앱 + 자기평가   |
| Lab 6. German Diction         | German Lied phrase             | 주 1–2회   | 앱 + 전문가 옵션 |
| Lab 7. Passaggio Recognition  | passaggio observation log      | 격주       | 전문가        |
| Lab 8. Pre-MdV                | gentle swell clip              | 전문가 승인 후 | 전문가        |
| Lab 9. Art Song Studio        | art song excerpt 2개            | 월 1개     | 앱 + 전문가 옵션 |
| Lab 10. Aria Gate             | expert-approved aria excerpt   | 비정기      | 전문가 필수     |
| Lab 11. Portfolio             | curated final folder           | 월말       | 전문가 평가     |

## 8.5 언어별 Diction Mini-module

| 언어             | 순서 | 앱 깊이       | 훈련과제                                                                                   | 피드백                               | 전문가 필요 지점                                    |
| -------------- | -: | ---------- | -------------------------------------------------------------------------------------- | --------------------------------- | -------------------------------------------- |
| IPA Foundation |  0 | 모든 언어 공통   | IPA symbol → sound → sung vowel                                                        | symbol match, self-label          | 없음                                           |
| Italian        |  1 | 가장 깊게      | pure vowel, stress, consonant doubling, open/closed e/o, legato phrase                 | vowel consistency, text rhythm    | aria recitative/role diction                 |
| English        |  2 | 중간         | stress, schwa, diphthong timing, final consonants, legato English                      | diphthong timing, text clarity    | dialect, poetry style, over-diction 방지       |
| German         |  3 | 고급 starter | umlaut/front rounded vowels, ich/ach, final devoicing, consonant clusters, Lied phrase | phoneme checklist, cluster timing | Lieder style, vowel color, long text prosody |

권장 순서는 **IPA → Italian → English → German**이다. 단, 영어권 사용자를 위한 제품에서는 English text comprehension을 병렬로 열 수 있다. 성악 기술 관점의 gateway는 Italian이 더 적합하다. Italian diction은 phonetics와 legato, technical vocal requirements와 연결되며, 대학 diction curriculum에서도 English/Italian을 German/French보다 먼저 두는 사례가 반복된다. [B/C] ([OhioLINK ETD Center][10])

## 8.6 Appoggio / Legato Training Cards

| Card                                  | 학습목표                                      | 훈련과제                                             | 앱 피드백                                                     | 졸업기준                             |
| ------------------------------------- | ----------------------------------------- | ------------------------------------------------ | --------------------------------------------------------- | -------------------------------- |
| Appoggio 1. Silent Inhale → Easy Tone | 사용자가 과흡기·밀기 없이 짧은 phrase를 시작한다.           | 4초 조용한 흡기 → 6초 [a] 또는 [i] mp.                    | onset abruptness, duration, relative loudness drift, RPE. | 3회 연속 strain ≤2/10, clipping 없음. |
| Appoggio 2. Breath-paced Text         | 사용자가 한 breath 안에서 짧은 텍스트를 안정적으로 말하고 노래한다. | Italian 5–7 syllable phrase speak→sing.          | phrase duration, final cutoff, self “push?” check.        | 2세션 연속 편안함 유지.                   |
| Appoggio 3. Phrase Reset              | 사용자가 긴장 누적 전에 멈추고 reset한다.                | 3 phrases, 각 phrase 후 10초 rest.                  | rest timer, fatigue prompt.                               | 다음날 hoarseness 없음.               |
| Legato 1. Vowel Chain                 | 사용자가 모음 사이를 끊지 않고 연결한다.                   | [i-e-a-o-u] on 3-note pattern.                   | gap detection, pitch continuity.                          | no-gap 80% 이상.                   |
| Legato 2. Vowel Skeleton              | 사용자가 가사 전에 vowel line을 만든다.               | art song phrase에서 consonant 제거 후 vowel만 singing. | pitch/rhythm, vowel duration.                             | vowel skeleton 안정 후 text unlock. |
| Legato 3. Text Return                 | 사용자가 consonant를 넣어도 line을 유지한다.           | vowel skeleton → syllables → full text.          | consonant delay, phrase break, rhythm.                    | A/B에서 text 추가 후 line 손실 없음.      |

## 8.7 Art Song / Aria Excerpt Difficulty Criteria

| 기준        | App-safe art song excerpt                                  | Expert-gated aria excerpt                                            |
| --------- | ---------------------------------------------------------- | -------------------------------------------------------------------- |
| 길이        | 20–40초                                                     | 10–30초라도 expert-approved                                             |
| 음역        | 사용자의 comfortable range 안                                   | passaggio·고음·저음 극단 포함 가능성 검토                                         |
| Tessitura | 중간 음역 중심                                                   | 높은 tessitura 또는 지속 고음이면 gate                                         |
| Dynamic   | p–mf 중심                                                    | forte, crescendo climax, orchestral projection 요구 시 gate             |
| 언어        | IPA·translation 제공 가능                                      | 원어·style·role diction 필수                                             |
| 음악 난이도    | 단순 rhythm, 짧은 phrase, 적은 leap                              | recitative, coloratura, large leap, cadenza, long breath phrase gate |
| 텍스트       | age/context 적절                                             | dramatic role/context 검토                                             |
| 조성/key    | app-approved key                                           | aria는 원조/표준키 요구 가능성 검토                                               |
| 분류        | art song, folk/classical arrangement, sacred short excerpt | opera/oratorio aria, role-based excerpt                              |

RCM은 단계별 repertoire list와 상위 단계 aria를 구분하고, ABRSM은 모든 곡이 모든 singer에게 적합하지 않다고 명시하며, NATS rules는 aria/art song 분류와 원어·key 기준을 둔다. [B] ([rcmusic-kentico-cdn.s3.amazonaws.com][5])

## 8.8 Recording A/B Review Rubric

| 평가 차원     | 앱이 볼 수 있는 것                       | 사용자가 평가할 것         | 전문가가 볼 것                                |
| --------- | --------------------------------- | ------------------ | --------------------------------------- |
| Pitch     | 음정 중심, drift, 큰 이탈                | 불안정이 긴장과 연결되는지     | passaggio/registration 원인               |
| Rhythm    | beat alignment, phrase timing     | text가 음악을 방해하는지    | style rubato, language prosody          |
| Legato    | gap, abrupt stop, consonant delay | line이 끊겨 들리는지      | vowel modification, breath coordination |
| Diction   | IPA checklist, stress marker      | 의미 전달, 과장/부족       | 언어별 style, dialect                      |
| Breath    | phrase duration, rest compliance  | 밀었는지, 숨이 부족했는지     | appoggio strategy                       |
| Dynamics  | relative contour only             | 편안한 크기인지           | projection, resonance, MdV              |
| Resonance | 자동 점수 없음                          | A/B에서 더 자유롭게 느껴지는지 | acoustic/technical diagnosis            |
| Health    | red flag log                      | 다음날 피로             | referral 필요 여부                          |

## 8.9 Classical Portfolio Criteria

고급 성악 포트폴리오는 다음 산출물로 정의한다.

| 산출물                  | 최소 기준                                       |
| -------------------- | ------------------------------------------- |
| Baseline + Final A/B | 같은 조건의 30초 녹음 2쌍                            |
| Appoggio clips       | 중간 음역 phrase 2개, strain log 포함              |
| Legato clips         | vowel skeleton 1개 + full text 1개            |
| Italian diction      | IPA, translation, spoken, sung clip         |
| English diction      | stress/diphthong annotation + sung clip     |
| German diction       | IPA + consonant/vowel checklist + sung clip |
| Art song excerpt     | 2개, 각 20–40초, 난이도 rubric 포함                 |
| Passaggio log        | recognition note, 전문가 질문 1개 이상              |
| Pre-MdV clip         | expert gate 통과자만                            |
| Aria excerpt         | expert-approved 사용자만                        |
| Safety log           | red flag 없음 또는 referral 처리 완료               |
| Reflection           | “무엇이 좋아졌는가 / 무엇은 전문가에게 물어볼 것인가”             |

졸업 기준은 “고음을 낼 수 있다”가 아니라, **안전하게 반복하고, 녹음 근거를 비교하고, 언어·레퍼토리·건강 판단을 설명하며, 전문가 리뷰가 필요한 지점을 구분할 수 있다**로 설정한다. [B]

## 8.10 금지 피드백 목록

앱에서 다음 피드백은 금지한다.

| 금지 피드백                             | 이유                               |
| ---------------------------------- | -------------------------------- |
| “당신은 soprano/tenor/baritone입니다”    | voice type/fach는 장기 전문 판단 필요.    |
| “결절/폴립 가능성이 있습니다”                  | 병명 추정은 의료 영역.                    |
| “쉰소리지만 계속 연습하세요”                   | red flag 무시.                     |
| “고음을 더 밀어 올리세요”                    | 과압·긴장 위험.                        |
| “복압을 더 세게 주세요”                     | appoggio 오해 위험.                  |
| “후두를 내리세요/올리세요” 자동 지시              | 개별 진단 없는 조작 지시.                  |
| “singer’s formant 점수 70점”          | 기기·vowel·loudness·voice type 영향. |
| “projection이 부족하니 더 크게”            | 스마트폰 mic로 객석 투사 판정 불가.           |
| “passaggio를 없애세요”                  | passaggio handling은 전문가 영역.      |
| “messa di voce 고음 forte challenge” | 고급·고부하 기술.                       |
| “아리아 원조로 불러야 통과”                   | 사용자 상태·성부·key 검토 필요.             |
| “통증은 정상입니다”                        | 즉시 중단해야 할 수 있음.                  |

---

# 9. Source Bibliography

1. **NATS, Science-Informed Voice Pedagogy: Terminology and Definitions for Voice Pedagogy.** breath management, appoggio, passaggio, vowel terminology의 핵심 근거. ([가창교사협회][2])
2. **American Academy of Teachers of Singing / NATS, In Support of Fact-Based Voice Pedagogy and Terminology.** support/appoggio 언어와 과압 위험에 대한 근거. ([americanacademyofteachersofsinging.org][8])
3. **Journal of Singing / NATS, Voice Pedagogy for the 21st Century.** 현대 voice pedagogy 역량, health, repertoire, diction, technology의 통합 근거. ([가창교사협회][1])
4. **NATS Journal of Singing.** NATS의 공식 refereed journal이며 diction, voice science, medicine, pedagogy를 다루는 출처로 검토. ([가창교사협회][25])
5. **Matthew Hoch, A Brief History of Lyric Diction Pedagogy, Journal of Singing.** IPA와 lyric diction 표준화 근거. ([가창교사협회][9])
6. **Journal of Singing, Registers—The Snake Pit of Voice Pedagogy.** register/passaggio 논쟁성과 지각적 한계 근거. ([가창교사협회][24])
7. **The Voice Foundation, Journal of Voice.** peer-reviewed voice medicine and research journal로서 voice science, medicine, SLP, pedagogy를 다룸. ([보이스 재단][16])
8. **NIDCD directory, The Voice Foundation.** voice research, medicine, science, education 조직으로 검토. ([NIDCD][26])
9. **ASHA Practice Portal, Voice Disorders.** 음성장애 범주와 청각 인상만으로 severity 판단 불가 근거. ([ASHA][13])
10. **NIDCD, Taking Care of Your Voice.** red flag와 ENT/SLP 상담 권고 근거. ([NIDCD][14])
11. **ASHA, Vocal Cord Nodules and Polyps.** 2–3주 hoarseness와 laryngoscopy/stroboscopy 필요성 근거. ([ASHA][15])
12. **ASHA/NATS/PAVA/VASTA Joint Statement, Characterizing the Roles of Voice Professionals.** laryngologist, SLP, singing teacher 등 interdisciplinary management 근거. ([ASHA][27])
13. **Lã & Fiuza, Real-Time Visual Feedback in Singing Pedagogy.** 시각 피드백, KR, self-regulation, 과도한 subglottal pressure 주의 근거. ([MDPI][17])
14. **Sundberg, Level and Center Frequency of the Singer’s Formant.** singer’s formant의 음향적 특성과 vowel/loudness/voice classification 의존성 근거. ([PubMed][7])
15. **Ritzerfeld & Miller, Formant Tuning and Feedback in the Male Passaggio.** male passaggio의 harmonic/formant interaction 근거. ([PubMed][18])
16. **Echternach et al., Laryngeal Evidence for First and Second Passaggio in Professionally Trained Sopranos.** soprano passaggio의 다양한 패턴과 기전 불확실성 근거. ([PLOS][4])
17. **Köberlein et al., Influence of Messa di Voce Speed on Vocal Stability of Professionally Trained Singers.** MdV의 고급성·복합성 근거. ([PLOS][19])
18. **Pulte, Messa di Voce dissertation.** MdV 교육 전통과 제한적 실험 근거로 보조 검토. ([Rave][28])
19. **Royal Conservatory of Music, Voice Syllabus 2025.** 단계별 repertoire, 언어, aria 수준 구분 근거. ([rcmusic-kentico-cdn.s3.amazonaws.com][5])
20. **ABRSM Singing Performance Grades syllabus.** 곡 적합성, range/content/context 고려 근거. ([abrsm.org][20])
21. **London College of Music Classical Singing Repertoire List.** classical repertoire scope와 suitability 기준 근거. ([lcme.uwl.ac.uk][21])
22. **NATS National Student Auditions Regulations.** art song/aria 분류, 원어·key 기준 근거. ([가창교사협회][22])
23. **Rollins College Singing Diction syllabus.** IPA와 Italian/German/French/English diction 학습 outcome 근거. ([rpublic.rollins.edu][3])
24. **Mahaney, Diction for Singers dissertation.** English/Italian first, German/French later 등 diction sequence 관찰 근거. ([OhioLINK ETD Center][10])
25. **University of North Texas, Vocal Studies Courses.** advanced diction, vocal literature, respiration/phonation/resonation/articulation curriculum 근거. ([music.unt.edu][11])
26. **Conservatoire de Paris, Italian Lyric Diction.** Italian diction과 characteristic legato, technical vocal requirements 연결 근거. ([conservatoiredeparis.fr][12])
27. **Scenario / opera lyric diction article.** opera singer language learning이 fluency보다 lyric diction 중심이라는 근거. ([UCC Journals][29])
28. **Frontiers in Digital Health, Influence of Recording Instrumentation on Measurements of Voice.** 스마트폰·태블릿 녹음 조건이 acoustic measures에 미치는 영향 근거. ([Frontiers][6])
29. **Acoustics Today, smartphone acoustical measurements.** smartphone-based sound level measurement와 calibration 한계 근거. ([Acoustics Today][23])

유튜브, 블로그, 개인 코치 의견은 본 설계의 1차 근거로 사용하지 않았다. 이번 프레임워크는 NATS, Journal of Singing, Voice Foundation/Journal of Voice, ASHA, NIDCD, peer-reviewed research, 대학·콘서바토리·시험 syllabus를 중심으로 통합했다.

[1]: https://www.nats.org/_Library/JOS_On_Point/JOS-078-01-2021-11.pdf "President's Message"
[2]: https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Terminology_and_Definitions_for_Science-Informed_Voice_Pedagogy.pdf "https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Terminology_and_Definitions_for_Science-Informed_Voice_Pedagogy.pdf"
[3]: https://rpublic.rollins.edu/sites/Syllabi/CourseSyllabi/MUS223H1X-201001.pdf "Microsoft Word - Diction Syllabus"
[4]: https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0175865 "https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0175865"
[5]: https://rcmusic-kentico-cdn.s3.amazonaws.com/rcm/media/main/documents/examinations/syllabi/rcm-voice-syllabus-2025-edition.pdf "https://rcmusic-kentico-cdn.s3.amazonaws.com/rcm/media/main/documents/examinations/syllabi/rcm-voice-syllabus-2025-edition.pdf"
[6]: https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2025.1610772/full "Frontiers | Influence of recording instrumentation on measurements of voice in sentence contexts: use of smartphones and tablets"
[7]: https://pubmed.ncbi.nlm.nih.gov/11411472/ "https://pubmed.ncbi.nlm.nih.gov/11411472/"
[8]: https://www.americanacademyofteachersofsinging.org/wp-content/uploads/2020/09/In-Support-of-Fact-Based-Voice-Pedagogy-and-Terminology.pdf "https://www.americanacademyofteachersofsinging.org/wp-content/uploads/2020/09/In-Support-of-Fact-Based-Voice-Pedagogy-and-Terminology.pdf"
[9]: https://www.nats.org/_Library/JOS_On_Point/JOS-081-4-2025-419.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-081-4-2025-419.pdf"
[10]: https://etd.ohiolink.edu/acprod/odb_etd/ws/send_file/send?accession=osu1148931700&disposition=inline "Microsoft Word - Document.doc"
[11]: https://music.unt.edu/voice/courses.html "Courses - Division of Vocal Studies |  University of North Texas"
[12]: https://www.conservatoiredeparis.fr/en/disciplined/italian-lyrical-diction-accompanists "Italian lyrical diction (accompanists) | Conservatoire national supérieur de musique et de danse de Paris"
[13]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOoq0NAFoFEPic3UweDivJRq7wUmOkUy3R52Nz7vTFLOZhL7qXHiY "https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOoq0NAFoFEPic3UweDivJRq7wUmOkUy3R52Nz7vTFLOZhL7qXHiY"
[14]: https://www.nidcd.nih.gov/health/taking-care-your-voice "https://www.nidcd.nih.gov/health/taking-care-your-voice"
[15]: https://www.asha.org/public/speech/disorders/vocal-cord-nodules-and-polyps/?srsltid=AfmBOoo-Y4rw5aLKBCdoy2USzSRs-IvrRwW83cdEOG7FDLw2Hga7lekc "https://www.asha.org/public/speech/disorders/vocal-cord-nodules-and-polyps/?srsltid=AfmBOoo-Y4rw5aLKBCdoy2USzSRs-IvrRwW83cdEOG7FDLw2Hga7lekc"
[16]: https://voicefoundation.org/journal-of-voice/?utm_source=chatgpt.com "Journal of Voice"
[17]: https://www.mdpi.com/2076-3417/12/21/10781 "https://www.mdpi.com/2076-3417/12/21/10781"
[18]: https://pubmed.ncbi.nlm.nih.gov/27816356/ "https://pubmed.ncbi.nlm.nih.gov/27816356/"
[19]: https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0325284 "https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0325284"
[20]: https://www.abrsm.org/sites/default/files/2023-10/Singing%20Performance%20Grades%20Syllabus_0.pdf "https://www.abrsm.org/sites/default/files/2023-10/Singing%20Performance%20Grades%20Syllabus_0.pdf"
[21]: https://lcme.uwl.ac.uk/media/wzipr0ry/classical-singing-repertoire-list.pdf "https://lcme.uwl.ac.uk/media/wzipr0ry/classical-singing-repertoire-list.pdf"
[22]: https://www.nats.org/_Library/NSA_Files/Regulation_Changes_NSA_Committee_7_11_2017.pdf "https://www.nats.org/_Library/NSA_Files/Regulation_Changes_NSA_Committee_7_11_2017.pdf"
[23]: https://acousticstoday.org/wp-content/uploads/2017/06/2-faber.pdf "6217_AcousticsToday_SUMMER_2.indd"
[24]: https://www.nats.org/_Library/JOS_On_Point/JOS-077-02-2020-175.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-077-02-2020-175.pdf"
[25]: https://www.nats.org/featured-article.html "https://www.nats.org/featured-article.html"
[26]: https://www.nidcd.nih.gov/directory/voice-foundation?utm_source=chatgpt.com "The Voice Foundation | NIDCD"
[27]: https://www.asha.org/siteassets/governance/pava-joint-statement-characterizing-the-roles-of-voice-professionals.pdf?srsltid=AfmBOooap88yNqM9AbOdWi-mg-9D6Dkqs2eVPoKQEgVZPpmb3E6rvmgd&utm_source=chatgpt.com "Characterizing the Roles of Voice Professionals: A Joint ..."
[28]: https://rave.ohiolink.edu/etdc/view?acc_num=osu1129655696 "https://rave.ohiolink.edu/etdc/view?acc_num=osu1129655696"
[29]: https://journals.ucc.ie/index.php/scenario/article/download/scenario-13-2-12/html-en?inline=1 "journals.ucc.ie"
