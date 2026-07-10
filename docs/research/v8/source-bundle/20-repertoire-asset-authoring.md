# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `20. #Ub808#Ud37c#Ud1a0#Ub9ac - #Ud6c8#Ub828 #Uc790#Uc0b0 #Uc81c#Uc791 #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `20-repertoire-asset-authoring.md`

---

# 1. Executive Summary

2026년 6월 18일 기준으로 보컬 페다고지, 단계별 시험·레퍼토리 기준, 음악교육 연구, 대학 보컬 커리큘럼, 음성 건강 및 저작권 1차 자료 **35건**을 비교 검토했다. 유튜브·블로그·개인 코치 자료는 핵심 근거로 사용하지 않았다.

핵심 결론은 다음과 같다.

> 앱의 4마디 프레이즈는 “짧은 노래”가 아니라, **한 가지 보컬 능력이 실제 반주·가사·리듬 안에서도 유지되는지를 확인하는 통제된 전이 과제**여야 한다.

보컬 학습은 설명을 아는 것보다 실제 시도와 피드백을 통해 형성되는 절차적·운동 학습에 가깝다. 따라서 각 자산은 반드시 **학습목표 → 훈련과제 → 우선 피드백 → 독립 수행 졸업기준**을 가져야 한다. 가이드 보컬과 피아노 멜로디는 초기 참조점이지 최종 수행 조건이 아니며, 사용자가 반주만 듣고 새 키·새 템포에서도 기술을 유지할 수 있을 때 학습 완료로 보아야 한다. ([NATS][1])

ABRSM·Trinity·RCM 및 Berklee 자료는 공통적으로 짧고 단순한 음형, 제한된 음역, 순차진행과 작은 도약, 단순 리듬, 강한 반주 지원에서 시작해 더 긴 프레이즈, 큰 도약, 당김음·복합박자·반주 독립성·장르 표현으로 진행한다. 다만 이는 인과효과를 입증한 실험이 아니라 장기간 축적된 교육 기준이므로 대부분 **B 수준 교육 현장 합의**로 분류해야 한다. ([ABRSM][2])

본 보고서의 반음 수, CTZ 비율, 키·템포 개수, 자동 통과 임계치는 여러 자료를 통합한 **제품 설계 가설[D]**이다. 출시 전 실제 사용자 데이터와 보컬 페다고그 검토로 보정해야 한다.

### 필수 질문 12개에 대한 제품 결정

| 질문                   | 권고 결정                                                                                                                                             | 근거 판정                                                                                    |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| 1. 초중급 4마디 조건        | 하나의 주기술만 목표로 한다. 초급 기본값은 4/4 또는 3/4, P4–P5 음역, 반복음·순차진행·3도 중심, 2+2마디 호흡, 1개 안정 모음 또는 단순 CV, 당김음 0–1회다. 4마디가 보편적 최적 길이라는 증거는 없으므로 8마디 전이 자산도 병행한다. | **[B 방향·D 수치]** ([ABRSM][2])                                                             |
| 2. 난이도               | range 하나가 아니라 13개 요인의 가중 점수와 range·tessitura·breath·고위험 style의 안전 병목을 함께 사용한다.                                                                    | **[B 개념·D 공식]**                                                                          |
| 3. range/tessitura   | 성별·성부 이름이 아니라 개인별 Comfortable Training Zone, 이하 CTZ를 기준으로 조옮김한다. Tessitura는 음표 개수가 아니라 실제 발성 지속시간 분포로 계산한다.                                       | **[B 합의·D 경계값]** ([NATS][3])                                                             |
| 4. melodic contour   | 초급: 반복·한 방향·단일 아치. 중급: 한 개 정점, 시퀀스, 제한된 방향전환. 고급: 다중 정점, 각진 도약, 반음계, 레지스터 교차.                                                                     | **[B 합의]** ([NATS][4])                                                                   |
| 5. rhythmic pattern  | 초급: 4분·2분음표와 제한된 8분음표. 중급: 타이·간단한 당김음·6/8·셋잇단음. 고급: 지속적 16분음표, back-phrasing, 박자 변화·복합 변위.                                                        | **[B 합의]** ([ABRSM][2])                                                                  |
| 6. 모음·자음             | 초급: 한 개 단모음과 단순 CV/비음·유음. 중급: 2–5개 모음, 흔한 이중모음, 단일 파열·마찰음과 제한된 종성. 고급: 빠른 모음 교대, 자음군, offbeat consonant, 다언어·장르별 타이밍. 보편적인 “쉬운 모음 순서”는 입증되지 않았다.  | **[B 방향·D 세부 순서]** ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5])  |
| 7. 가이드 자산            | Map 단계에는 guide vocal+피아노 멜로디+supportive backing. Recall에서는 guide vocal 제거. Transfer·졸업에서는 lead와 click을 제거하고 independent backing만 쓴다.              | **[B 합의]** ([ABRSM][2])                                                                  |
| 8. key variant       | 반주·피아노는 논리적으로 12개 조를 지원하고, low/mid/high 세 개 레지스터 배치를 제공한다. 인간 guide vocal은 3개 앵커 레지스터를 녹음한다.                                                      | **[B 조옮김 원칙·D 개수]** ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5]) |
| 9. tempo variant     | 기준 템포의 80/90/100/110/120%, 총 5개를 기본으로 한다. 다만 80·120%가 장르 그루브를 훼손하면 연습 모드로만 제공한다.                                                                  | **[D 근거 부족/제품 가설]**                                                                      |
| 10. neutral vs genre | Neutral은 하나의 기술과 단순 화성·평면적 딕션을 격리한다. Genre phrase는 동일한 기술 골격에 groove, diction, register strategy, ornament, dynamics, instrumentation을 더한다.       | **[B 방향·D 구현]**                                                                          |
| 11. manifest         | 정체성·권리·음악 구조·음성/언어·난이도·교육 설계·변형·오디오 stem·피드백·안전·QA·분석정보를 버전 관리한다.                                                                                 | **[B 메타데이터 합의·D 스키마]**                                                                   |
| 12. 저작권              | 멜로디·가사·편곡·연주·마스터를 자체 제작하고 각각의 권리와 기여자를 관리한다. 짧은 프레이즈나 흔한 음계라는 이유만으로 타 작품의 인식 가능한 표현을 복제해서는 안 된다.                                                  | **[A 법적 1차 자료]** ([U.S. Copyright Office][6])                                            |

---

# 2. Evidence Review

## 2.1 검토 방법

1. **검색:** 보컬 페다고지와 단계별 공식 syllabus를 우선 검색하고, 음악교육 연구·대학 커리큘럼·음성 건강·저작권 자료로 보완했다.
2. **비교:** 초급에서 고급으로 갈 때 반복되는 변화—음역, 도약, 프레이즈 길이, 리듬, 반주 지원, 딕션, 장르 요구—를 기관 간 비교했다.
3. **비판:** 시험기관 기준은 교육 표준이지 실험 연구가 아니며, 대학 커리큘럼은 실제 학습 효과의 인과 증거가 아님을 구분했다.
4. **통합:** 반복되는 방향성만 Consensus로 채택하고, 기관별 차이는 Controversy, 직접 연구가 없는 숫자는 Insufficient Evidence로 분리했다.
5. **커리큘럼 변환:** 모든 결과를 사용자가 할 수 있게 될 행동과 앱 내 과제·피드백·졸업기준으로 재구성했다.

### 근거 등급

* **A:** 강한 연구 근거 또는 1차 공중보건·법적 권위자료
* **B:** 여러 기관·연구·현장에서 반복되는 교육 합의
* **C:** 전문 페다고그·연구자의 체계적 전문가 의견
* **D:** 직접 근거가 제한적인 제품 가설

## 2.2 Evidence Review Table

| 검토 자료                              | 비교 결과                                                                                                           | 비판·한계                                                                 | 판정                                                                                   | 앱 설계 변환                                                            |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------ |
| NATS motor-learning 자료             | 노래는 실제 수행과 반복을 통해 학습되는 복합 운동 기술이며, 설명·모델링만으로는 충분하지 않다.                                                          | 2025 연구는 관찰 수가 적고 교사 자기평가를 포함한다.                                      | **B·Consensus** ([NATS][1])                                                          | 설명 화면보다 사용자 발성 시도 시간을 늘린다.                                         |
| 피드백 빈도 연구·개관                       | 한 번에 가장 중요한 오류를 피드백하고, 숙련과 함께 피드백 빈도를 줄이는 것이 자율성·유지에 유리하다.                                                      | 복잡한 초급 과제에서는 초기에 더 빈번한 피드백이 필요할 수 있다.                                 | **B·Consensus** ([NATS][7])                                                          | 한 시도에 primary feedback 1개, secondary feedback 최대 1개.               |
| 모바일 biofeedback                    | pitch stability, onset, legato 등 특정 목표에는 시각화가 유용할 수 있다.                                                         | 저자가 일부 결과를 일화적이라고 명시했고, 기기·알고리즘 오차가 있다.                               | **C·Controversy** ([NATS][8])                                                        | 피치·온셋 등 측정 가능한 항목에만 제한적으로 사용한다.                                    |
| 초보자 pitch-matching 실험              | 초보 47명 연구에서 시각 피드백과 유사 음색의 청각 피드백이 향상을 보였고, 시각 피드백군은 전이에서도 이점을 보였다.                                             | 작은 표본, 단일음 중심이며 실제 노래 프레이즈와 다르다. 기존 연구 결과도 혼재한다.                      | **B·Controversy** ([Frontiers][9])                                                   | 초기 pitch mapping에 실시간 시각 피드백을 쓰되 최종 단계에서는 제거한다.                    |
| 역사적 vocalise·bel canto progression | 느린 템포, 짧은 구간, 제한된 음역, 순차진행에서 더 긴 프레이즈·큰 도약·장식으로 점진화한다.                                                          | 클래식 전통에서 나온 전문가 재구성이며 CCM 전반에 그대로 일반화할 수 없다.                          | **B·Consensus** ([NATS][4])                                                          | neutral etude의 기본 복잡도 곡선을 구성한다.                                    |
| NATS tessitura 연구                  | 단순 최고·최저음보다 음높이별 지속시간 분포가 실제 부하를 더 잘 표현한다.                                                                      | 개인별 안전 경계나 보편적 비율을 제시하지 않는다.                                          | **B 방향·D 경계값** ([NATS][3])                                                           | duration-weighted pitch histogram을 manifest에 저장한다.                 |
| ABRSM 2025                         | 저학년은 짧은 vocal passage, 작은 도약, 단순 박자와 vocal-line-doubling을 사용하고 상급으로 갈수록 길이·도약·당김음·반주 독립성이 증가한다.                 | 시험 syllabus이며 학습 효과 실험은 아니다.                                          | **B·Consensus** ([ABRSM][2])                                                         | 4마디 초급과 8–12마디 상급 progression의 기준점으로 사용한다.                         |
| Trinity Rock & Pop                 | 초기 단계는 순차진행·제한 음역·supportive backing이며, 상위 단계는 넓은 음역, 빠른 레지스터 변화, syncopation, melisma, 장르 효과와 반주 독립성을 요구한다.    | 시험곡·응시자 레퍼토리 기준이어서 micro-etude와 동일하지 않다.                              | **B·Consensus** ([Trinity College][10])                                              | PDS에 genre styling과 accompaniment independence를 별도 차원으로 둔다.        |
| RCM Voice Syllabus 2025            | 레퍼토리와 vocalise의 조옮김을 넓게 허용하며, 초기 모음 훈련 후 더 많은 모음·확장된 vocalise를 도입한다.                                            | RCM의 vocalise는 대체로 레벨 5 이후의 확장 에튀드로, 앱의 4마디 micro-etude와 동일한 범주가 아니다. | **B·Consensus** ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5]) | 개인 음역에 맞춘 키 선택과 4마디/8마디 자산을 분리한다.                                  |
| RCM Voice Series                   | 기초 단계에서 technique·musicianship을 다루고, 상위 단계에서 agility·control용 vocalise를 도입한다. 반주 트랙도 제공한다.                      | 기관의 출판·평가 체계이며 직접 비교 연구가 아니다.                                         | **B·Consensus** ([Royal Conservatory][11])                                           | Advanced Genre Lab 진입 전 foundation prerequisite를 둔다.               |
| Berklee sight-singing              | 기초 notation·stepwise melody에서 intervals, compound meter, syncopation·tuplets로 복잡도가 증가하며 4마디 작곡·노래 과제를 사용한다.     | 대학 과목 구조이지 4마디가 최적임을 증명하지 않는다.                                        | **B·Consensus** ([Berklee Online][12])                                               | 4마디를 micro-task 단위로 사용하되 8마디 전이 과제로 확장한다.                          |
| Berklee voice/genre 과정             | 건강한 기초 technique와 ear-training을 장르 심화의 선행조건으로 둔다.                                                               | 기관 철학과 과정 설계다.                                                        | **B·Consensus** ([Berklee Online][13])                                               | 장르 효과보다 pitch/rhythm/healthy coordination을 먼저 unlock한다.            |
| NYU 세 전공 커리큘럼                      | Contemporary, Classical, Music Theatre 모두 technique, musicianship, diction/text, performance/application을 결합한다. | 과목 편성은 개별 교육 요소의 효과 크기를 보여주지 않는다.                                     | **B·Consensus** ([NYU Steinhardt][14])                                               | 앱도 technique module과 repertoire application을 분리하지 않고 연결한다.         |
| NAfME 수행평가                         | 연주 녹음 청취, 자기평가, 피드백 반영, 재수행이 평가 흐름에 포함된다.                                                                       | 일반 음악교육 모델이며 전문 보컬 앱에 특화되지 않았다.                                       | **B·Consensus** ([NAfME][15])                                                        | 첫 시도→재생/자가평가→집중 재시도→최종 수행 구조를 사용한다.                                |
| 음악 피드백·메타인지 연구                     | 84명 무작위 배정 연구에서 피드백 훈련이 메타인지 향상과 연결되었다.                                                                         | 예비교사 대상이며 singing-specific 효과는 아니다.                                   | **B 일반·D 보컬 적용** ([Frontiers][16])                                                   | 사용자가 피드백 전 자신의 오류를 먼저 선택하게 한다.                                     |
| 음악 수행의 주의 초점 systematic review     | 음악에서 internal/external focus 결과가 일관되지 않고 과제·측정 방식 차이가 크다.                                                       | 일반 운동학의 외적 초점 우위를 보컬 앱에 단순 적용하기 어렵다.                                  | **A·Controversy** ([Frontiers][17])                                                  | 신체 부위 명령만 고집하지 말고 소리·문구·리듬 결과 중심 cue를 A/B 시험한다.                    |
| practice variability pilot         | 변형 연습이 전이에 도움을 줄 가능성이 있으나 결과가 부분적이다.                                                                            | 피아노 동작 연구이며 singing transfer 근거가 아니다.                                 | **D·Insufficient Evidence** ([Frontiers][18])                                        | 새 키·새 템포 전이는 졸업조건에 넣되 효과 크기를 실험한다.                                 |
| 학습자 선택 레퍼토리                        | 자기 선택이 연습 지속과 전략 사용을 높일 가능성이 보고되었다.                                                                             | 단일 사례 연구로 일반화가 어렵다.                                                   | **D·Insufficient Evidence** ([Cambridge University Press & Assessment][19])          | 사용자가 동일 난이도의 장르 sibling을 선택할 수 있게 한다.                              |
| 레퍼토리 적합성 연구                        | 곡 선택에는 range, tessitura, tempo, difficulty뿐 아니라 신체·정서·문화적 적합성을 함께 고려해야 한다.                                      | 박사논문과 전문가 기반 rubric 중심이다.                                             | **C·Consensus에 가까운 의견** ([uknowledge.uky.edu][20])                                   | manifest에 언어·연령·문화·가사 주제 태그를 포함한다.                                 |
| 자음 인지 실험                           | 42명 실험에서 높은 음정, 잔향, 큰 반주가 특정 유성 자음 인지를 악화시켰고 자음 지속시간 연장이 일부 조건에서 도움이 되었다.                                       | /m n l v/와 특정 음향 조건에 한정된다. 모든 언어·자음에 일반화할 수 없다.                       | **B 좁은 근거·D 일반화** ([AIP Publishing][21])                                             | 고음·큰 반주 자산에서 diction 목표를 별도 검수하고 자음 타이밍을 메타데이터화한다.                 |
| NIDCD 음성 건강                        | 쉰 목소리·피로 상태에서의 무리한 발성, 과도한 고저음·고강도 사용을 피하고 심각·지속 증상에는 의료평가가 필요하다.                                               | 교육 자산의 세부 반복 횟수나 강도를 정해주지는 않는다.                                       | **A·Consensus** ([NIDCD][22])                                                        | 통증·쉰 목소리·갑작스러운 음역 손실을 hard stop으로 둔다.                              |
| NATS 아동·청소년 자료                     | 연령에 적합한 재료·도전 수준·가사와 안전한 환경을 강조한다.                                                                              | 성인 앱 설계에는 직접 적용되지 않는다.                                                | **B·Consensus** ([NATS][23])                                                         | 미성년자 콘텐츠에 별도 가사·고강도·레지스터 제한을 적용한다.                                 |
| USCO/WIPO 저작권 자료                   | 음악작품·가사와 녹음물은 별도 권리이며, 아이디어·방법과 구체적 표현은 구분된다.                                                                   | 실제 침해 판단은 국가·사안별 법률분석이 필요하다.                                          | **A·Consensus/법적 원칙** ([U.S. Copyright Office][6])                                   | composition, lyrics, arrangement, performance, master 권리를 별도 관리한다. |
| USCO의 짧은 표현·음악 요소 기준               | 제목·짧은 문구, 흔한 음계·아르페지오 등은 보호성이 제한될 수 있지만, 마디 수만으로 자동 안전지대가 생기지는 않는다.                                             | 등록 가능성과 침해 여부는 동일한 질문이 아니다.                                           | **A 원칙·D 위험판정** ([U.S. Copyright Office][24])                                        | “4마디라 안전하다”는 규칙을 금지하고 인식 가능 유사성을 검수한다.                             |

---

# 3. Consensus

다음 항목은 여러 연구·기관에서 반복되며, 앱 커리큘럼의 기본 전제로 채택할 수 있다.

| 전문가 합의                                                                  | 제품팀 결정                                                                                    | 수준                                       |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ---------------------------------------- |
| 노래는 실제 발성 시도와 수정이 필요한 운동 기술이다.                                          | 설명·영상보다 singing attempt 비율을 높이고, 시도 사이 설명은 짧게 제한한다.                                       | **[B·Consensus]** ([NATS][1])            |
| 초급 과제는 한 번에 적은 변수를 다뤄야 한다.                                              | 각 phrase에 `primary_skill` 하나와 `secondary_skill` 최대 하나만 지정한다.                              | **[B·Consensus]** ([NATS][7])            |
| 짧고 제한된 음역·순차진행에서 길고 넓고 리드미컬하게 독립적인 과제로 진행한다.                            | L1–L5 progression을 range 하나가 아닌 melody, rhythm, breath, diction, accompaniment까지 함께 확장한다. | **[B·Consensus]** ([ABRSM][2])           |
| 총 음역보다 주로 머무는 tessitura와 개인 적합성이 중요하다.                                  | 모든 자산을 개인 CTZ에 맞춰 조옮김하고, 음높이별 발성 지속시간을 계산한다.                                              | **[B·Consensus]** ([NATS][3])            |
| 모델·반주는 초기에 도움이 되지만 점차 줄어야 한다.                                           | guide vocal → piano guide → supportive backing → independent backing 순으로 지원을 소거한다.        | **[B·Consensus]** ([ABRSM][2])           |
| 피드백은 우선순위가 명확해야 하고 매 시도마다 과도하게 주어져서는 안 된다.                              | 가장 큰 오류 하나만 즉시 제시하고, 연속 수행 중에는 피드백 빈도를 줄인다.                                               | **[B·Consensus]** ([NATS][7])            |
| 초급 단계에서도 pitch뿐 아니라 rhythm, listening, notation/inner hearing이 함께 필요하다. | pitch-only 점수 대신 pitch·rhythm·breath·diction·independence를 분리한다.                          | **[B·Consensus]** ([ABRSM][2])           |
| 장르 기술은 기초 coordination을 대체하지 않는다.                                       | 장르 자산은 neutral core의 sibling으로 제작하고, 선행 능력 통과 후 unlock한다.                                 | **[B·Consensus]** ([Berklee Online][13]) |
| 완성 여부는 가이드가 있을 때의 성공이 아니라 독립성과 전이로 판단해야 한다.                             | backing-only 수행과 새 키 또는 새 템포 수행을 졸업기준에 포함한다.                                              | **[B 방향·D 구체 기준]**                       |
| 안전성과 권리 상태는 평균 품질점수로 상쇄할 수 없다.                                          | 안전 위반·권리 불명확은 난이도나 음악적 완성도와 무관하게 출시 차단 조건으로 둔다.                                           | **[A·Consensus]** ([NIDCD][22])          |

---

# 4. Controversies

## 4.1 전문가 논쟁 Controversy

| 쟁점                              | 상반된 관점                                                                                        | 제품팀 통합안                                                                                                                |
| ------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| 실시간 pitch visualization         | 초보자의 pitch mapping을 돕는 결과가 있으나, 화면 의존·시각적 주의 분산과 제거 후 성능 저하 가능성도 보고된다. ([Frontiers][9])       | L1–L2의 isolate 단계에서만 제공하고, 연속 프레이즈에서는 사후 요약으로 전환한다. 최종 시도에는 제거한다. **[B·Controversy]**                                  |
| 사람 guide vocal vs 피아노           | 사람 음색이 vocal imitation에 유리할 수 있으나, 사용자가 guide의 timbre·발성 습관을 모방하거나 의존할 수 있다. ([Frontiers][9]) | pitch·vowel·style 지도를 위해 사람 guide를 제공하되, 별도 piano guide와 neutral guide를 함께 제공한다. 음색 유사도는 채점하지 않는다. **[B·Controversy]** |
| Internal vs external focus      | 일반 운동학에서는 외적 초점이 자주 권고되지만, 음악 수행 연구의 결과와 측정법은 일관되지 않는다. ([Frontiers][17])                     | “목을 내려라” 같은 신체 명령보다 “음이 한 줄로 연결되게” 같은 결과 cue를 기본으로 하되, 사용자 반응에 따라 cue 유형을 실험한다. **[A·Controversy]**                    |
| 느린 연습                           | 리듬·음정 격리에는 유용하지만, 지나치게 느리면 실제 호흡·groove·consonant timing이 달라질 수 있다.                           | 80% 버전은 practice-only로 분류하고, 최종 장르 수행은 90–110% 범위에서 평가한다. **[D·Controversy]**                                          |
| 장르별 register·belt·distortion 지도 | 장르 적합성을 위해 필요하다는 견해와, 기초 coordination 전에는 위험하거나 오도될 수 있다는 견해가 공존한다.                           | clean coordination을 선행조건으로 하고 belt·distortion·scream은 L4–L5 human gate 아래 둔다. **[B/C·Controversy]**                    |
| 자동 객관점수와 예술성                    | pitch·rhythm은 측정할 수 있지만, intentional scoop, back-phrasing, vibrato, character를 단순 오차로 볼 수 없다. | 정확도와 표현 rubric을 분리하고, 의도된 장식 구간에는 별도 target envelope를 쓴다. **[B 방향·D 구현]**                                              |
| 모든 키 제공 필요성                     | 포괄적 조옮김은 개인 적합성을 높이지만, 사람 guide 녹음·음색 품질·저장 비용이 증가한다.                                         | 피아노·반주는 12키 procedural render, 사람 guide는 세 레지스터 앵커만 제작한다. **[D·제품 절충]**                                                |

## 4.2 근거 부족 Insufficient Evidence

다음 항목은 전문가 합의로 표현해서는 안 된다.

| 근거가 부족한 주장                                   | 현재 판정                                                                    | 검증 계획                                               |
| -------------------------------------------- | ------------------------------------------------------------------------ | --------------------------------------------------- |
| 4마디가 모든 초급자에게 가장 효과적이다.                      | 4마디는 기관·과정에서 자주 쓰이는 편리한 단위일 뿐 최적성은 입증되지 않음. **[D]**                      | 4마디와 8마디의 완료율·전이·피로도를 비교한다.                         |
| 초급 range는 반드시 P5여야 한다.                       | 교육적 기준점은 있으나 개인 CTZ와 과제 종류에 따라 달라짐. **[D]**                              | P4/P5/M6 변형을 무작위 배정해 오류와 편안함을 비교한다.                 |
| 특정 모음은 모든 사용자에게 항상 쉽다.                       | 언어·음높이·레지스터·개인 해부학에 따라 달라짐. **[D]**                                      | 사용자별 모음 정확도·편안함 프로파일을 학습한다.                         |
| 자음 난이도의 보편적 순서가 있다.                          | 특정 자음과 음향조건에 대한 연구만 존재한다. **[D]**                                        | 언어별 confusion matrix를 구축한다.                         |
| key variant는 정확히 12개, guide vocal은 3개가 최적이다. | 포괄성과 제작비를 고려한 설계안일 뿐 학습효과 근거는 없음. **[D]**                                | 사용자 선택 분포와 guide 사용률로 축소·확대한다.                      |
| tempo variant 5개가 최적이다.                      | 직접 근거 없음. **[D]**                                                        | 3개 대 5개 변형의 학습완료율과 제작비를 비교한다.                       |
| ±50/40/35/30 cents가 적절한 졸업 기준이다.             | 50 cents를 정답 범위로 쓴 소규모 연구는 있으나, 프레이즈 평가 기준은 아님. **[D]** ([Frontiers][9]) | 전문가 평정과 사용자 음성 데이터로 ROC·오분류를 검증한다.                  |
| CPB 대비 40–85%가 안전한 breath demand 경계다.        | 제품 내부 상대척도이며 임상 기준이 아님. **[D]**                                          | 편안함·중도 이탈·호흡 추가 발생률로 보정한다.                          |
| 마이크 신호만으로 위험한 발성을 확실히 탐지할 수 있다.              | 음향신호만으로 진단·안전을 보장할 근거가 부족함. **[D]**                                      | 자동 탐지는 경고 보조로만 사용하고 self-report·human review를 유지한다. |

---

# 5. Curriculum Design Implications

## 5.1 능력 기반 레벨 체계

여기서 `CTZ`는 사용자가 중간 음량에서 편안하다고 보고한 훈련 가능 음역으로, 최대 음역이나 의학적 진단값이 아니다. `CPB`는 중간 음량에서 편안하게 완주한 기준 프레이즈 지속시간으로, 임상적 최대발성지속시간과 구분한다. 두 개념과 아래 수치는 **제품 가설[D]**이다.

| 레벨                             | 사용자가 할 수 있게 되는 것                                          | 학습목표                                              | 훈련과제                                           | 피드백                                                          | 졸업기준                                                                                                |
| ------------------------------ | --------------------------------------------------------- | ------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| **L1 Foundation**              | 제한된 음역의 4마디를 모델을 듣고 정확히 재현한다.                             | 반복음·순차진행, 안정 모음, 기본 pulse                         | P4–P5, 4/4 또는 3/4, 한 모음/단순 CV, 1–2마디 호흡 구간     | stable-vowel pitch, 시작 박, 계획 호흡                              | guide vocal을 끈 뒤 3회 중 2회 통과, pitch frame 80% 이상 ±50 cents, onset 중앙오차 ≤0.20 beat, 불편감 ≤3/10 **[D]** |
| **L2 Guided Transfer**         | 피아노 멜로디 또는 supportive backing만으로 단순 가사와 당김음을 유지한다.        | 3도·P4, 두 모음, 단순 자음, 한 번의 syncopation              | 4마디, M6 이내, 2+2마디 호흡, 0.5–1.0 syllable/beat    | pitch+rhythm 중 더 큰 오류 하나, consonant landing                  | backing-only 3회 중 2회, pitch 82% 이상 ±40 cents, onset ≤0.15 beat, 계획 호흡 준수 **[D]**                    |
| **L3 Independent Application** | 4–8마디를 lead 없이 수행하고 새 키 또는 새 템포로 옮긴다.                     | octave 이내 contour, 6/8·triplet·간단한 melisma, 반주 독립 | neutral core와 genre sibling 한 쌍                | 의도된 ornament를 제외한 pitch contour, onset grid, breath·diction  | backing-only 통과 후 새 키 또는 90/110% 템포에서 재통과, pitch 85% 이상 ±35 cents, onset ≤0.12 beat **[D]**         |
| **L4 Genre Adaptation**        | 동일한 기술을 서로 다른 장르의 groove·diction·register strategy에 적용한다. | 10th–11th 가능, 반복 레지스터 교차, 지속 syncopation, 장르 장식   | 8마디 또는 고밀도 4마디, 두 장르 sibling 비교                | 장르 target envelope, phrase placement, self-effort, 표현 rubric | 두 가지 변형에서 독립 수행, 다음 세션 유지, pitch 88% 이상 ±30 cents는 비장식 구간에만 적용 **[D]**                              |
| **L5 Advanced Genre Lab**      | 고난도 스타일 선택을 통제하고 clean 대안을 유지한다.                          | 큰 도약·즉흥·고강도·특수효과의 선택적 사용                          | coach-gated phrase, clean base와 style layer 분리 | 자동점수보다 전문가 rubric·사용자 감각·안전 신호 우선                            | clean version 선통과, 인간 검토 승인, 통증·쉰 목소리·과도한 노력 없음. 보편적 cents 기준 미사용 **[B 방향·D 구현]**                   |

## 5.2 연구 결과의 커리큘럼 변환

| 연구에서 얻은 원칙    | 학습목표                             | 훈련과제                                                          | 피드백                                     | 졸업기준                                  |
| ------------- | -------------------------------- | ------------------------------------------------------------- | --------------------------------------- | ------------------------------------- |
| 실제 시도가 학습의 중심 | 사용자가 설명 없이 과제를 실행한다.             | 한 설명 뒤 최소 2회 연속 발성                                            | 첫 시도에는 결과만 보여주고 다음 시도 전 한 개 cue 제공      | 도움 없이 같은 동작을 다시 수행                    |
| 한 번에 핵심 한 가지  | 주목해야 할 변수를 구분한다.                 | pitch-only, rhythm-only, vowel-only isolate 후 통합              | 가장 큰 오류 한 개만 강조                         | primary skill 통과 후 secondary skill 추가 |
| 제한된 음역에서 확대   | 편안한 영역에서 contour를 제어한다.          | P4/P5 → M6 → octave → 10th 이상                                 | CTZ 바깥 체류시간과 peak note 표시               | 다음 폭의 phrase를 불편감 없이 수행               |
| 반주 지원의 점진적 감소 | 외부 모델 없이 음정과 pulse를 유지한다.        | full guide → piano → supportive backing → independent backing | 지원을 제거한 뒤 변화한 오류만 제시                    | lead·click 없이 통과                      |
| 가사·딕션의 단계적 통합 | 모음 중심 pitch를 자음이 있는 실제 문구로 전이한다. | vowel-only → CV → 원문 가사                                       | consonant 구간을 pitch 채점에서 제외하고 타이밍 별도 채점 | 가사 추가 후에도 pitch/rhythm 유지             |
| 새 키·템포 전이     | 한 녹음의 모방이 아니라 상대적 패턴을 재현한다.      | CTZ 안의 다른 키와 ±10% 템포                                          | 원본과 전이 수행의 변화량                          | 한 개 이상 전이 조건 통과                       |
| 장르 중립에서 장르 적용 | 기술 골격을 groove·diction과 분리해 이해한다. | neutral core 후 genre sibling                                  | 기술 오류와 style 선택을 분리 표시                  | 두 버전 모두 수행                            |
| 자기평가와 유지      | 사용자가 자신의 오류와 편안함을 식별한다.          | 녹음 청취 후 예상 오류 선택                                              | 앱 평가와 자기평가의 일치 여부                       | 다음 세션 첫 시도에서 지원 없이 재현                 |

---

# 6. App Implementation Implications

## 6.1 런타임 학습 상태

| 단계                   | 제공 자산                                                                       | 사용자가 하는 일                  | 앱 피드백·진행 조건                      |
| -------------------- | --------------------------------------------------------------------------- | -------------------------- | -------------------------------- |
| **A. Map**           | full guide vocal, piano melody, supportive backing, 1마디 count-in, 선택적 click | 듣고 contour·가사·호흡 위치를 표시한다. | 아직 점수화하지 않거나 pitch 방향만 표시        |
| **B. Isolate**       | vowel guide 또는 rhythm-only click                                            | primary skill만 연습한다.       | 한 개 핵심 피드백, 즉시 재시도               |
| **C. Guided Phrase** | guide vocal light 또는 piano melody, backing                                  | 4마디 전체를 수행한다.              | pitch/rhythm/breath 중 가장 큰 오류 하나 |
| **D. Recall**        | guide vocal off, piano guide optional, backing                              | 기억한 프레이즈를 재현한다.            | 사후 요약, 실시간 시각화 축소                |
| **E. Transfer**      | independent backing, 새 키 또는 ±10% tempo, count-in만                           | 같은 능력을 새 조건에 적용한다.         | 원본 대비 성능 저하량과 comfort 확인         |
| **F. Retention**     | 다음 세션 backing-only 또는 a cappella                                            | 장기 유지 여부를 확인한다.            | 통과 시 졸업, 실패 시 필요한 한 단계만 복귀       |

이 지원 소거 방식은 초기에 참조점을 제공하되 피드백 의존을 막으려는 motor-learning 원칙과 graded syllabus의 반주 독립성 progression을 결합한 것이다. ([NATS][7])

## 6.2 적응 엔진

1. **CTZ 캘리브레이션:** 중간 음량의 짧은 음형에서 편안한 하한·상한과 사용자의 노력도를 수집한다. 최대음을 요구하지 않는다.
2. **키 선택:** phrase의 duration-weighted median pitch가 CTZ 중앙에 가까우면서 outer zone 체류와 peak penalty가 최소인 조를 선택한다.
3. **CPB 캘리브레이션:** 비최대 강도의 짧은 프레이즈로 편안한 연속발성 기준을 얻는다.
4. **한 번에 한 차원 조절:** 실패 시 key/range, tempo/rhythm, lyric/vowel, accompaniment 중 하나만 완화한다.
5. **성공 시 지원 감소 우선:** 바로 음역·템포를 올리기보다 guide vocal 또는 piano melody를 먼저 제거한다.
6. **연속 실패 fallback:** 원문 가사 → 단모음, independent backing → supportive backing, 현재 key → CTZ 중앙 key 순으로 돌아간다.
7. **안전 override:** range·tessitura·breath·genre-style 안전 조건을 넘으면 평균 난이도와 무관하게 과제를 잠근다.

## 6.3 자동 피드백 정책

| 영역      | 측정 단위                                      | 피드백 원칙                        | 금지 사항                                            |
| ------- | ------------------------------------------ | ----------------------------- | ------------------------------------------------ |
| Pitch   | 안정 모음 구간의 cents·contour                    | 전체 평균보다 가장 큰 구간 오류와 방향을 보여준다. | 자음 시작, 의도된 scoop, vibrato edge를 음정 실패로 채점하지 않는다. |
| Rhythm  | 음절/모음 onset의 beat offset                   | 빠름·느림과 해당 음절을 표시한다.           | 기기 latency 보정 없이 절대 ms를 채점하지 않는다.                |
| Breath  | 계획 breath mark, 구간 완주, 추가 호흡               | “계획 위치 준수/추가 호흡 발생”으로 기술한다.   | 폐기능·질환을 추론하지 않는다.                                |
| Diction | phoneme timing과 인지 confidence              | 자음이 너무 빠르거나 늦은 위치를 제시한다.      | 음향 confidence가 낮을 때 단정적으로 발음 오류라 하지 않는다.         |
| Style   | annotated groove·ornament·dynamic envelope | 기술 정확도와 별도의 선택 rubric으로 표시한다. | 특정 가수 timbre와 유사한지 채점하지 않는다.                     |
| Effort  | 사용자 self-rating                            | 시도 후 0–10 편안함·노력도를 받는다.       | 음향신호만으로 긴장·질환을 진단하지 않는다.                         |

피드백은 **결과지식(KR)**과 **수행지식(KP)**을 분리하고, 한 시도에서 사용자가 바꿀 수 있는 항목만 제시한다. 복잡한 과제 초기에는 더 자주 제공하되, 단순화되거나 숙련되면 빈도를 줄인다. ([NATS][7])

## 6.4 콘텐츠 그래프

각 phrase family는 다음 그래프로 연결한다.

`neutral isolate → neutral full phrase → genre sibling A → genre sibling B → new-key transfer → new-tempo transfer → retention`

* **Repertoire Application:** L1–L3 neutral core와 저위험 genre sibling 중심
* **Advanced Genre Lab:** L4–L5, 장르별 timing·register·ornament 선택, human-gated high-load asset
* 장르 선택은 난이도를 바꾸는 것이 아니라 동일한 `technical_spine_id`의 다른 적용 방식으로 관리한다.
* D 수준 가설은 manifest의 `evidence_status: hypothesis`로 표시하고 분석실험 ID와 연결한다.

---

# 7. Safety Considerations

본 앱은 보컬 교육도구이며 의료 진단·치료도구가 아니다.

| 안전 영역   | 필수 제품 정책                                                                                                             | 근거                              |
| ------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| 세션 시작   | 현재 통증, 쉰 목소리, 비정상적 피로, 감기·질환으로 목소리가 불편한지 확인한다. 해당 시 고강도 훈련을 잠근다.                                                     | **[A·Consensus]** ([NIDCD][22]) |
| 즉시 중단   | 통증, 따가움, 갑작스러운 음역 손실, 갑작스러운 심한 쉰 목소리, 목소리가 끊기는 느낌을 사용자가 보고하면 세션을 종료한다.                                               | **[A·Consensus]** ([NIDCD][22]) |
| 의료 안내   | 심각하거나 지속되는 쉰 목소리, 호흡·삼킴 곤란, 발성 시 통증, 완전한 음성 소실 등에는 이비인후과 등 적절한 의료평가를 안내한다.                                           | **[A·Consensus]** ([NIDCD][25]) |
| 음역      | 최대 음역 테스트를 일상 캘리브레이션으로 사용하지 않는다. CTZ 밖 음표는 자동으로 조옮김하거나 자산을 차단한다.                                                     | **[B 방향·D 구현]**                 |
| 반주 음량   | 사용자가 반주를 이기기 위해 더 크게 부르지 않도록 backing volume calibration과 guide ducking을 제공한다.                                        | **[A/B]** ([NIDCD][22])         |
| 고강도 스타일 | scream, growl, distortion, extreme belt는 clean alternative 통과 후 L5·human gate에서만 제공한다. 앱 단독으로 “힘을 더 주라”는 지시를 하지 않는다. | **[B/C·안전 우선]**                 |
| 반복량     | 고부하 자산은 기본 3회 연속 후 휴식 화면을 넣고, 노력도 5/10 초과 시 다음 시도를 잠근다. 이는 임상 기준이 아닌 보수적 제품 safeguard다.                              | **[D·제품 가설]**                   |
| 미성년자    | 연령에 맞는 음역·가사·캐릭터·강도를 적용하고 성인 발성효과 모방을 요구하지 않는다.                                                                      | **[B·Consensus]** ([NATS][23])  |
| 자동평가    | 음색, 성별, 성부, fach, 질환을 자동 추론하지 않는다. 낮은 분석 confidence에서는 점수 대신 재녹음을 요청한다.                                              | **[D·제품 안전 원칙]**                |
| 음성 데이터  | 원음 저장은 opt-in으로 하고, 평가에 필요하지 않은 원음은 기기 내 처리 또는 단기 삭제를 기본으로 한다.                                                       | **[D·제품·개인정보 원칙]**              |

---

# 8. Recommended Framework

## 8.1 Training Phrase Production Principles

| 원칙                                  | 제작 규칙                                                                              | 근거                                                                           |
| ----------------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| 1. Capability first                 | “무엇을 가르치는가”가 아니라 “가이드 없이 무엇을 수행할 수 있게 되는가”로 제목과 목표를 작성한다.                          | **[B]**                                                                      |
| 2. One primary target               | 각 자산은 primary skill 1개, secondary skill 최대 1개만 가진다.                                | **[B]** ([NATS][7])                                                          |
| 3. Four bars are a unit, not a law  | 4마디는 isolate/application 단위, 8마디는 통합·호흡·전이 단위로 사용한다.                               | **[B 방향·D 구분]**                                                              |
| 4. User-relative pitch              | 고정된 남성/여성 key 대신 CTZ에 맞춰 조옮김한다.                                                    | **[B]** ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5]) |
| 5. Tessitura over headline range    | 최고·최저음뿐 아니라 음높이별 지속시간, peak 반복, outer-zone 체류를 계산한다.                               | **[B]** ([NATS][3])                                                          |
| 6. Support must fade                | 모든 guide asset에는 제거 시점과 backing-only 졸업 버전이 있어야 한다.                                | **[B]**                                                                      |
| 7. Neutral–genre pairing            | 동일한 technical spine으로 neutral과 genre sibling을 만든다.                                 | **[B 방향·D 구현]**                                                              |
| 8. Difficulty is multidimensional   | range가 쉬워도 lyric density·syncopation·breath·style이 높으면 상위 난이도로 분류한다.               | **[B]**                                                                      |
| 9. Safety is a bottleneck           | 안전 관련 차원은 평균점수로 상쇄하지 않는다.                                                          | **[A/B]**                                                                    |
| 10. Feedback measures the task      | guide 가수와의 음색 유사도가 아니라 target pitch, timing, breath plan, phoneme placement를 측정한다. | **[B]**                                                                      |
| 11. Rights are first-class metadata | 작곡·가사·마스터·연주·sample provenance가 완성되지 않으면 제작 완료로 보지 않는다.                            | **[A]**                                                                      |
| 12. Transfer is the finish line     | 동일 녹음 모방이 아니라 새 키·템포·장르 sibling에서 기술을 유지해야 졸업한다.                                   | **[B 방향·D 기준]**                                                              |

---

## 8.2 Phrase Difficulty Framework

### 8.2.1 PDS 계산법

13개 차원을 각각 1–5로 평가한다.

| 차원                        |     가중치 |
| ------------------------- | ------: |
| Range                     |      10 |
| Tessitura                 |      12 |
| Interval size             |       8 |
| Contour                   |       6 |
| Rhythm density            |       8 |
| Syncopation               |       8 |
| Phrase length             |       6 |
| Breath demand             |      10 |
| Lyric density             |       7 |
| Vowel difficulty          |       5 |
| Consonant timing          |       6 |
| Tempo                     |       6 |
| Genre styling requirement |       8 |
| **합계**                    | **100** |

`Base PDS = Σ(차원 점수 × 가중치) ÷ 100`

|  Base PDS | 기본 레벨 |
| --------: | ----: |
| 1.00–1.69 |     1 |
| 1.70–2.39 |     2 |
| 2.40–3.19 |     3 |
| 3.20–3.99 |     4 |
| 4.00–5.00 |     5 |

### 안전·난이도 병목 규칙

* `range`, `tessitura`, `breath demand`가 4이면 L1–L3에 배정할 수 없다.
* `genre styling requirement`가 5이면 자동으로 L5와 human gate를 요구한다.
* 어떤 차원도 표시 레벨보다 2단계 이상 높을 수 없다.
* 개인 CTZ 위반은 PDS와 무관하게 `unavailable_for_user` 처리한다.
* 평균점수와 병목을 결합한 이 체계는 **PDS v0.9 제품 가설[D]**로 출시 데이터에 따라 재가중한다.

### 8.2.2 13개 난이도 차원의 1–5 정의

| 차원                   | 1                        | 2                       | 3                                     | 4                                    | 5                                           |
| -------------------- | ------------------------ | ----------------------- | ------------------------------------- | ------------------------------------ | ------------------------------------------- |
| **Range**            | P5 이내, 7 semitones 이하    | M6 이내, 9 이하             | octave 이내, 12 이하                      | 11th 이내, 약 17 이하                     | 11th 초과, 최대 2 octaves 내 개인화                 |
| **Tessitura**        | CTZ outer 20% 체류 ≤5%     | 6–15%                   | 16–25%                                | 26–40% 또는 반복 register crossing       | >40%, 반복 극단음·고강도 결합                         |
| **Interval size**    | 반복음·2도                   | 3도, P4 1회               | 반복 P4/P5, 6도 1회                       | 6·7도·octave                          | octave 초과 또는 큰 도약의 빠른 교대                    |
| **Contour**          | 한 방향 또는 단일 아치, 방향전환 ≤1   | 한 정점, 방향전환 ≤2           | 2–3개 정점, sequence, 한 번의 zone crossing | 각진 도약, 반음계, 다중 정점                    | 불규칙·비조성·다중 register contour                 |
| **Rhythm density**   | 평균 onset ≤0.75/beat      | 0.76–1.0, 짧은 8분음표 묶음    | 1.01–1.5, triplet/16분음표 일부            | 1.51–2.0, 혼합 subdivision 지속          | >2.0 또는 rap·ornament burst                  |
| **Syncopation**      | 없음, pickup만 허용           | 4마디당 간단한 offbeat/tie 1회 | 전체 마디의 25–50%                         | 50% 초과, barline tie·back-phrasing    | 지속 metric displacement·polyrhythm           |
| **Phrase length**    | 최장 무호흡 구간 ≤1마디           | ≤2마디                    | 3–4마디                                 | 5–6마디                                | 7–8마디 또는 계획 호흡 없음                           |
| **Breath demand**    | voiced duration ≤CPB 40% | ≤55%                    | ≤70%                                  | ≤85%                                 | >85% 또는 고강도 지속 결합                           |
| **Lyric density**    | ≤0.5 syllable/beat       | 0.51–1.0                | 1.01–1.5                              | 1.51–2.0                             | >2.0, patter·rap                            |
| **Vowel difficulty** | 안정 단모음 1개                | 단모음 2개, 반복·순차음에서 교대     | 흔한 모음 3–5개와 일반 이중모음                   | 빠른 교대, 고음 지속 이중모음                    | 다언어·희귀 모음·극단적 스타일 요구                        |
| **Consonant timing** | 단순 CV, 비음·유음, 자음군 없음     | 박 위 단일 파열·마찰음, 단순 종성    | 유·무성 교대, 제한 자음군·offbeat onset         | 조밀한 자음군, 반복 파열음, 의도적 선행·지연           | patter/rap 속도, 다언어의 정밀 타이밍                  |
| **Tempo**            | 72–96 BPM, steady        | 60–112 BPM              | 48–132 BPM 또는 swing·ritard            | 40–160 BPM, 급변·복합부하                  | <40 또는 >160, free time·metric modulation    |
| **Genre styling**    | neutral, 특수효과 없음         | 저위험 style cue 1개        | 두 요소의 조정 또는 짧은 ornament               | 지속 register strategy, 고급 melisma·고강도 | distortion·growl·scream·extreme belt·고난도 즉흥 |

**Tempo는 단조롭게 빠를수록 어렵다는 척도가 아니다.** 느린 템포의 긴 sustain과 빠른 템포의 articulation을 모두 고려하고, rhythm density와 함께 계산해야 한다. 절대 BPM 구간은 **[D]**다.

---

## 8.3 Range / Tessitura Limits by Level

`CTZ outer zone`은 개인 CTZ 음역의 상·하단 각각 20% 구간이다. Tessitura 비율은 음표 수가 아니라 **voiced duration**으로 계산한다.

| 레벨     | 총 range 권고       | 중앙 영역 체류 |  Outer-zone 제한 | 최대 도약 기본값     | 설계 목적                    |
| ------ | ---------------- | -------: | -------------: | ------------- | ------------------------ |
| **L1** | P4–P5            |     ≥90% |  CTZ 경계음 사용 금지 | 3도            | pitch mapping과 안정된 onset |
| **L2** | M6 이내            |     ≥85% | ≤15%, 짧은 접촉 1회 | P4, 선택적 P5 1회 | 작은 도약과 가사 통합             |
| **L3** | octave 이내        |     ≥75% |           ≤25% | P5, 6도 1회     | 반주 독립·장르 기초              |
| **L4** | 10th–11th 이내     |     ≥60% |           ≤40% | 6도–octave     | register crossing·장르 표현  |
| **L5** | 2 octaves 이내 개인화 |   고정값 없음 |  전문가·사용자 상태 기반 | octave 초과 가능  | 고급 장르·즉흥·고강도             |

방향성은 graded repertoire와 vocalise progression에 부합하지만, 비율과 반음 수는 **[D]**다. ([ABRSM][2])

### 추가 규칙

* 최고음이 한 번 등장하는 phrase와 최고음에서 2마디 머무는 phrase를 동일하게 평가하지 않는다.
* 고음과 큰 반주, 높은 lyric density가 동시에 나타나면 복합부하 penalty를 준다.
* optional riff·ad-lib는 `base_range`와 `extended_range`로 분리한다.
* 키를 낮추면 저음 tessitura가 불편해질 수 있으므로 최고음만 보고 조옮김하지 않는다.

---

## 8.4 Rhythm / Melody / Lyric Complexity Table

| 레벨            | Melodic contour                               | Rhythm                                                             | 가사 밀도·호흡                          | 모음                         | 자음                                    |
| ------------- | --------------------------------------------- | ------------------------------------------------------------------ | --------------------------------- | -------------------------- | ------------------------------------- |
| **L1 초급**     | 반복음, 순차진행, 단일 상승·하강 또는 단일 아치, 3도 이내 도약        | 4/4·3/4, 2분·4분음표, 제한적 8분음표, syncopation 없음                         | ≤0.5 syllable/beat, 1–2마디마다 계획 호흡 | 단모음 1개 또는 두 모음의 느린 교대      | /m n l/ 계열과 단순 CV, 자음군·복잡 종성 없음       |
| **L2 초급 전이**  | 한 정점, 3도와 P4, 한 번의 P5                         | 8분음표 지속 가능, pickup, 당김음 또는 tie 1회                                  | 0.5–1.0, 2+2마디 호흡                 | 단모음 2개, 쉬운 이중모음 제한         | 박 위 단일 파열·마찰음, 간단 종성                  |
| **L3 중급**     | sequence, 2개 정점, P4/P5 반복, 6도 1회              | 6/8, triplet, tie, 간단한 syncopation, swing 기초                       | 1.0–1.5, 3–4마디 무호흡 가능             | 일반 3–5개 모음, 흔한 이중모음        | offbeat onset, 유·무성 교대, 제한 자음군        |
| **L4 상급**     | 다중 정점, 각진 6·7도·octave, 반음계, register crossing | 16분음표, 지속 syncopation, back-phrasing, 박자·템포 변화 일부                  | 1.5–2.0, 장르별 breath placement     | 빠른 모음 교대, 고음 이중모음·모음 수정 요구 | 조밀한 자음군, 반복 파열음, 선행·지연 consonant      |
| **L5 고급 Lab** | octave 초과, 비정형 contour, 다중 register, 즉흥 변형    | mixed meter, metric displacement, polyrhythm, free time, rap burst | >2.0 또는 7–8마디 장구간                 | 다언어·희귀 모음·극단적 스타일          | patter/rap 속도, 다언어 diction, 효과와 동시 조정 |

정확한 모음·자음 순서는 언어별 검증이 필요하다. RCM의 단계적 모음 도입과 자음 인지 연구는 방향성을 제공하지만 보편적 난이도 순위를 확정하지 않는다. ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5])

---

## 8.5 Guide Vocal / Guide Melody / Backing Track / Click Usage Policy

| 학습 단계               | Guide vocal        | Piano guide melody | Backing track             | Click                    | 졸업 가능 여부 |
| ------------------- | ------------------ | ------------------ | ------------------------- | ------------------------ | -------- |
| Map                 | Full               | On                 | Supportive                | count-in+선택적 full click  | 불가       |
| Isolate pitch/vowel | Full 또는 vowel-only | On                 | 단순 pad/없음                 | Off                      | 불가       |
| Isolate rhythm      | 말하기 guide 또는 light | 선택적                | rhythm-only               | On                       | 불가       |
| Guided phrase       | Light              | On                 | Supportive                | count-in, 필요 시 low click | 불가       |
| Recall              | Off                | Optional           | Supportive→independent    | count-in만                | 조건부      |
| Transfer            | Off                | Off                | Independent               | count-in만                | 가능       |
| Retention           | Off                | Off                | Independent 또는 a cappella | Off                      | 가능       |

### 각 stem의 역할

* **Guide vocal:** 모음, 자음, phrasing, style intent를 들려준다. 초급 neutral guide는 명확한 pitch, 중간 음량, 최소한의 vibrato·ad-lib로 제작한다.
* **Style guide vocal:** neutral guide와 별도 stem으로 제공하며 해당 장르 cue만 시범한다.
* **Piano guide melody:** 음정·contour 참조용이다. 반주와 분리해 사용자가 끌 수 있어야 한다.
* **Supportive backing:** L1–L2에서 vocal line의 harmony·bass cue가 명확해야 한다.
* **Independent backing:** L3 이상에서 melody를 직접 doubling하지 않고 화성·groove만 제공한다.
* **Click:** rhythm isolate와 latency calibration에만 사용한다. 최종 장르 수행에서는 제거한다.
* **Count-in:** 자유박자 자산을 제외하고 일반적으로 1마디 제공한다.
* **채점:** guide vocal의 timbre·vibrato와의 유사도는 점수에 포함하지 않는다.

---

## 8.6 Key Variant Policy

### 권고 수량

* **Piano melody·MIDI·backing:** 12개 조 지원
* **Register placement:** low / mid / high 3종
* **Human guide vocal:** 3개 앵커 레지스터
* **논리적 조합:** 최대 36개이지만 모두 오디오 파일로 사전 렌더링할 필요는 없다.

### 구현 규칙

1. 기본 작곡 데이터는 scale degree 또는 MIDI로 보존한다.
2. 사용자의 CTZ 중앙, outer-zone 체류, peak note, 최저음 접근성을 함께 계산해 조를 선택한다.
3. backing과 piano는 MIDI·분리 stem 기반으로 재렌더링하며 완성 mix를 단순 pitch-shift하지 않는다.
4. 인간 guide는 low/mid/high에 녹음한다. 앵커에서 너무 멀리 이동해 formant·음색 품질이 손상될 경우 guide vocal 대신 piano guide를 제공한다.
5. “남성 키/여성 키”라는 라벨 대신 `register_low`, `register_mid`, `register_high`를 사용한다.
6. 동일 phrase의 조옮김으로 register strategy가 달라지면 단순 variant가 아니라 별도 난이도 annotation을 생성한다.
7. 선택된 조가 CTZ를 벗어나면 사용자가 직접 강행할 수 없도록 경고·재배치를 제공한다.

RCM이 레퍼토리와 vocalise의 조옮김을 폭넓게 허용하는 것은 개인 음역 적합성 원칙을 지지하지만, 12키·3앵커라는 개수 자체는 **[D]**다. ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5])

---

## 8.7 Tempo Variant Policy

### 권고 수량

| Variant         | 기준 BPM 대비 | 용도                                         |
| --------------- | --------: | ------------------------------------------ |
| Practice Slow   |       80% | 음정·가사·리듬 격리. 장르 점수에는 사용하지 않을 수 있음          |
| Practice        |       90% | 통합 연습                                      |
| Canonical       |      100% | 원래 groove·호흡·표현 기준                         |
| Transfer Fast 1 |      110% | 일반 tempo transfer                          |
| Transfer Fast 2 |      120% | articulation·agility challenge, 스타일 허용 시에만 |

### 정책

* 기본 제공 수는 **5개[D]**다.
* 정식 졸업 평가는 원칙적으로 90/100/110% 중 하나에서 시행한다.
* 80%에서 호흡 요구가 오히려 증가하거나 groove가 변하면 별도 `practice_interpretation`으로 태그한다.
* 120%에서 lyric density·breath·consonant score가 상위 레벨로 이동하면 별도 난이도 자산으로 본다.
* click과 MIDI는 재렌더링하고, backing은 pitch-preserving time stretch 후 transient·groove QA를 실시한다.
* 사람 guide vocal의 극단적 time stretch는 피하고 필요하면 별도 녹음한다.
* rubato, recitative, free-time asset은 퍼센트 변형 대신 `timing map variants`를 사용한다.

---

## 8.8 Asset Manifest Schema

실제 구현에서는 아래 manifest를 JSON Schema로 검증하고, 권리·기여자 정보는 별도 rights ledger와 연결하는 것이 적합하다.

```json
{
  "schema_version": "1.0.0",
  "asset": {
    "asset_id": "NEU-L2-007",
    "version": "1.2.0",
    "title_internal": "Simple Syncopation",
    "product_surface": ["repertoire_application"],
    "technical_spine_id": "SPINE-SYNC-01",
    "family_id": "FAM-SYNC-01",
    "status": "qa_review"
  },
  "rights": {
    "composition_owner": "COMPANY",
    "lyrics_owner": "COMPANY",
    "arrangement_owner": "COMPANY",
    "master_owner": "COMPANY",
    "contributors": [
      {
        "contributor_id": "C-001",
        "roles": ["composer", "lyricist"],
        "agreement_id": "AGR-001",
        "assignment_complete": true
      }
    ],
    "samples": [],
    "voice_performance_release_id": "REL-001",
    "ai_assistance_disclosed": false,
    "similarity_review": {
      "melody_fingerprint_pass": true,
      "rhythm_fingerprint_pass": true,
      "human_review_pass": true,
      "reviewer_id": "MUS-014"
    },
    "rights_status": "cleared"
  },
  "pedagogy": {
    "evidence_level": "D",
    "evidence_status": "product_hypothesis",
    "outcome": "사용자가 lead 없이 한 번의 단순 당김음을 유지한다.",
    "primary_skill": "simple_syncopation",
    "secondary_skill": "pitch_contour",
    "prerequisites": ["L2_STEPWISE", "L2_EIGHTH_NOTE"],
    "task_sequence": [
      "rhythm_speak",
      "vowel_only",
      "guided_phrase",
      "backing_only",
      "tempo_transfer"
    ],
    "feedback_priority": ["onset_timing", "pitch_contour"],
    "graduation": {
      "required_independent_passes": 2,
      "window_attempts": 3,
      "transfer_required": true,
      "retention_required": true,
      "max_self_effort": 3
    }
  },
  "music": {
    "bars": 4,
    "meter": "4/4",
    "canonical_bpm": 92,
    "mode": "major",
    "canonical_key": "C",
    "pitch_range_semitones": 7,
    "lowest_midi_relative": 0,
    "highest_midi_relative": 7,
    "duration_weighted_pitch_histogram": {},
    "max_interval_semitones": 4,
    "interval_profile": ["P1", "M2", "m3", "P4"],
    "contour_type": "single_arch",
    "direction_changes": 2,
    "mean_onsets_per_beat": 0.95,
    "peak_onsets_per_beat": 2.0,
    "syncopated_bars": [3],
    "breath_marks": ["2:4"],
    "harmony_function": ["I", "IV", "V", "I"]
  },
  "voice_and_text": {
    "language": "ko-KR",
    "lyrics_id": "LYR-NEU-007",
    "ipa_tokens": [],
    "vowels": ["a", "i", "eo"],
    "consonants": ["m", "n", "g", "d"],
    "syllable_count": 12,
    "mean_syllables_per_beat": 0.75,
    "register_strategy": "neutral_comfort",
    "intended_ornaments": [],
    "excluded_pitch_scoring_windows": [],
    "age_rating": "all"
  },
  "difficulty": {
    "system_version": "PDS-0.9",
    "scores": {
      "range": 1,
      "tessitura": 2,
      "interval_size": 2,
      "contour": 2,
      "rhythm_density": 2,
      "syncopation": 2,
      "phrase_length": 2,
      "breath_demand": 2,
      "lyric_density": 2,
      "vowel_difficulty": 2,
      "consonant_timing": 2,
      "tempo": 1,
      "genre_styling": 1
    },
    "base_score": 1.76,
    "final_level": 2,
    "safety_override": false
  },
  "variants": {
    "keys_supported": 12,
    "register_profiles": ["low", "mid", "high"],
    "tempo_percentages": [80, 90, 100, 110, 120],
    "genre_siblings": ["GAYO-SYNC-01", "CCM-SYNC-01"]
  },
  "audio": {
    "sample_rate_hz": 48000,
    "bit_depth": 24,
    "stems": {
      "guide_vocal_full": "AUD-001",
      "guide_vocal_style": null,
      "piano_guide_melody": "AUD-002",
      "backing_supportive": "AUD-003",
      "backing_independent": "AUD-004",
      "click": "AUD-005",
      "count_in": "AUD-006"
    },
    "stem_alignment_pass": true,
    "loudness_profile_id": "LP-APP-01"
  },
  "feedback": {
    "pitch_target_curve_id": "PTC-001",
    "rhythm_target_id": "RTG-001",
    "phoneme_target_id": "PHO-001",
    "device_latency_calibration_required": true,
    "minimum_analysis_confidence": 0.8,
    "low_confidence_action": "request_retake"
  },
  "safety": {
    "vocal_load": "low",
    "outer_ctz_limit_percent": 15,
    "high_intensity": false,
    "human_gate_required": false,
    "stop_prompt_enabled": true,
    "clean_alternative_asset_id": null
  },
  "qa": {
    "score_midi_match": true,
    "lyrics_alignment_pass": true,
    "all_key_render_pass": true,
    "all_tempo_render_pass": true,
    "pedagogy_review_status": "passed",
    "vocal_safety_review_status": "passed",
    "rights_review_status": "passed",
    "audio_review_status": "passed",
    "release_approved_by": ["PED-004", "MUS-014", "LEG-003"]
  },
  "analytics_and_privacy": {
    "experiment_ids": ["EXP-4BAR-8BAR-01"],
    "raw_voice_retention": "opt_in",
    "derived_metrics_retention": "policy_defined"
  }
}
```

---

## 8.9 Neutral Phrase 10개 기획안

아래 자산은 장르적 음색이 아니라 기술 전이를 중심으로 한다. 공통 졸업 규칙은 **최근 3회 중 backing-only 2회 통과 + 새 키 또는 새 템포 1회 + 불편감 3/10 이하**다. 수치는 **[D]**다.

| ID / 레벨                                 | 학습목표                                | 훈련과제                                         | 피드백                                 | 졸업기준                                      |                                                     |
| --------------------------------------- | ----------------------------------- | -------------------------------------------- | ----------------------------------- | ----------------------------------------- | --------------------------------------------------- |
| **N01 Stepwise Echo / L1 / 4 bars**     | 반복음과 순차진행을 듣고 재현한다.                 | P4 범위, `1-2-3-2                              | 1-2-1`, `/ma/`, 2마디 call을 변형 반복     | 안정 모음 pitch와 첫 onset                      | guide vocal off, pitch 80% ±50c, 두 call의 contour 유지 |
| **N02 Single Arch / L1 / 4**            | 한 개 정점으로 올라갔다 내려온다.                 | P5 단일 아치, `/no/`, 2마디 상승+2마디 하강              | 정점 도달, 하강 시 pitch sag               | 정점·종지음 통과, 추가 호흡 없음                       |                                                     |
| **N03 Repeated-Note Onset / L1 / 4**    | 같은 음에서 onset을 일정하게 반복한다.            | 4분음표 반복음, `/ma-na-la/`, range 3도             | onset 지연·과도한 흔들림                    | 8개 onset 중 7개가 timing window 내            |                                                     |
| **N04 Breath Punctuation / L1–2 / 4**   | 계획된 위치에서만 호흡한다.                     | 자체 원문 “천천히 / 다시 이어 가”, 2+2마디 breath mark     | 추가 호흡, phrase-end pitch             | 두 구간 모두 완주하고 breath mark 준수               |                                                     |
| **N05 Thirds plus One Fourth / L2 / 4** | 3도와 P4를 구분해 정확히 이동한다.               | 3도 3회, P4 1회, M6 range, 안정 CV                | 도약 후 landing pitch                  | 네 도약 중 세 번 이상 target window, backing-only |                                                     |
| **N06 Descending Release / L2 / 4**     | 하행 시 음정과 종성 release를 유지한다.          | P5 하행, 자체 원문 “이제 편히 놓아”, 마지막 종성 별도 표시        | 하행 flatness, final consonant timing | 마지막 모음 길이와 종성 위치 모두 통과                    |                                                     |
| **N07 Simple Syncopation / L2 / 4**     | 한 번의 offbeat entry를 pulse 안에서 유지한다. | 4/4, 3마디째 한 번의 당김음, click→backing            | onset beat offset                   | click 제거 후 당김음과 다음 downbeat 유지            |                                                     |
| **N08 Vowel Ladder / L2 / 8**           | 동일 contour에서 모음 변화에도 pitch를 유지한다.   | 같은 2마디 motif를 `/a-e-i-o-u/`로 반복              | 모음별 pitch 변화와 안정도                   | 가장 약한 모음도 기준치 통과, 새 key에서 반복              |                                                     |
| **N09 Consonant Clock / L2 / 4**        | 자음을 beat에 맞추고 모음을 음높이에 정렬한다.        | `/ma-da-ga-va/`, 단일 파열·마찰음, 1 syllable/beat  | consonant onset과 vowel landing 분리   | 80% 이상 phoneme event가 타이밍 범위 내            |                                                     |
| **N10 Transfer Twin / L3 / 8**          | 같은 기술을 다른 key·tempo에서 재현한다.         | 앞 4마디 canonical, 뒤 4마디 동일 spine의 변형, lead 없음 | 원본 대비 pitch·timing 저하량              | 새 key와 110% tempo 중 하나에서 성능 저하가 허용범위 내    |                                                     |

---

## 8.10 장르별 Phrase 기획안

아래 장르 자산은 특정 아티스트·곡을 모방하지 않고, **장르의 일반적 수행 요소를 기술적 feature로 명시**한다. 모든 가사·멜로디·편곡·마스터는 신규 제작한다.

### A. 가요 / K-pop 5개

| ID                                            | 학습목표                                          | 훈련과제                                                         | 피드백                                     | 졸업기준                                   |
| --------------------------------------------- | --------------------------------------------- | ------------------------------------------------------------ | --------------------------------------- | -------------------------------------- |
| **K01 Conversational Verse Grid / L2 / 4**    | 말하듯 부르면서 subdivision을 유지한다.                   | P5, 8분음표 중심, anticipatory entry 1회, 자체 한국어 10–14음절           | consonant onset, 구절 가속 여부               | backing-only에서 median onset ≤0.15 beat |
| **K02 Ballad Legato Release / L2–3 / 4**      | 긴 모음 뒤 종성을 정확히 놓는다.                           | M6, 2+2 breath, 지속음 2개, 낮은 lyric density                     | sustain pitch, final consonant release  | 두 지속음 모두 안정, 계획 호흡 준수                  |
| **K03 Pre-Chorus Climb / L3 / 8**             | 반복 sequence로 상승하면서 노력도를 통제한다.                 | octave 내 상승 sequence, 마지막 peak 1회, gradual dynamic build     | outer-zone 체류, peak pitch, effort       | 두 key에서 완주, 노력도 ≤3/10                  |
| **K04 Dance Chorus Independence / L3 / 4**    | 강한 groove에서 melody lead 없이 syncopation을 유지한다. | 반복 motif, 2개 syncopated bars, independent electronic backing | beat placement와 vocal-line independence | 90/100/110% 중 두 템포 통과                  |
| **K05 Three-Note Ad-lib Transition / L4 / 4** | straight ending과 3-note melisma를 선택적으로 수행한다.  | pentatonic 3-note turn, 두 ending 제공                          | note segmentation, intended scoop mask  | straight와 embellished 버전 모두 통과         |

### B. 뮤지컬 5개

| ID                                         | 학습목표                                              | 훈련과제                                             | 피드백                               | 졸업기준                                            |
| ------------------------------------------ | ------------------------------------------------- | ------------------------------------------------ | --------------------------------- | ----------------------------------------------- |
| **M01 Speech-to-Song / L2 / 4**            | 말의 강세를 음표와 연결한다.                                  | 같은 원문을 speak rhythm → pitch 3음 → full phrase로 전환 | 단어 강세와 musical downbeat           | 말·노래 버전의 강세 위치 일치                               |
| **M02 Legato Story Line / L2 / 8**         | 가사 의미를 유지하며 긴 선율을 연결한다.                           | M6, 2+2+4 breath plan, 중간 lyric density          | 모음 연결, breath punctuation         | lead 없이 8마디 완주, 가사 누락 없음                        |
| **M03 Character Objective Shift / L3 / 8** | 같은 음형을 두 가지 의도로 표현한다.                             | 4마디마다 dynamic·articulation 목표 변경                 | 기술 정확도와 표현 self-rating 분리         | 두 버전 모두 pitch/rhythm 유지, 의도 구분 가능               |
| **M04 Patter Precision / L3–4 / 4**        | 높은 음절 밀도에서 자음을 명료하게 배치한다.                         | 1.5–2 syllables/beat, 제한 자음군, range P5           | phoneme timing, tempo drift       | 90%와 100%에서 가사 누락·추가 없음                         |
| **M05 Mix/Belt Pre-Peak / L4 / 4**         | clean speech-like coordination으로 peak 전 구간을 수행한다. | M6–octave, peak는 짧게, clean guide와 안전 gate        | pitch·effort·outer-zone, 음색 모방 제외 | clean version 통과, effort 안전 기준, human review 권장 |

### C. 성악 5개

| ID                                       | 학습목표                                            | 훈련과제                                          | 피드백                                 | 졸업기준                            |
| ---------------------------------------- | ----------------------------------------------- | --------------------------------------------- | ----------------------------------- | ------------------------------- |
| **C01 Single-Vowel Legato / L1–2 / 4**   | 순차음 사이 모음 연결을 유지한다.                             | P5, `/a/` 또는 `/u/`, 느린 4분음표, 단일 아치            | pitch continuity, unintended breaks | piano guide off 후 한 선처럼 연결      |
| **C02 Portamento Third/Fourth / L2 / 4** | 3도·P4 이동을 통제된 연결로 수행한다.                         | 두 음 portamento isolate 후 4마디 통합               | 시작·도착 pitch, 이동시간                   | 두 interval을 서로 다른 속도로 재현        |
| **C03 Five-Vowel Cantilena / L3 / 8**    | 여러 모음에서 균일한 line을 유지한다.                         | octave 내 cantilena, 5개 모음, 2개 breath mark     | 모음별 pitch·legato 편차                 | 가장 약한 모음에서도 line 유지             |
| **C04 Triplet Agility / L3–4 / 4**       | 짧은 triplet 음형을 가볍고 균등하게 수행한다.                   | P5 범위 3·5음 agility cell, vowel-only→text      | 음표 분리·tempo 균등성                     | 90/100/110%에서 세 음의 균등성 유지       |
| **C05 Recitative-to-Cantilena / L4 / 8** | text-driven free rhythm에서 metered legato로 전환한다. | 자체 신규 다언어 원문, 앞 4마디 speech-like, 뒤 4마디 legato | diction·timing map·호흡               | 두 timing mode를 구분하고 종지 pitch 유지 |

### D. R&B 5개

| ID                                             | 학습목표                                         | 훈련과제                                                            | 피드백                                 | 졸업기준                               |
| ---------------------------------------------- | -------------------------------------------- | --------------------------------------------------------------- | ----------------------------------- | ---------------------------------- |
| **R01 Pocket Placement / L2–3 / 4**            | 의도된 behind-the-beat 배치를 tempo drift 없이 유지한다. | straight backing, annotated delayed vowel landing               | 목표 placement 대비 onset, 전체 tempo     | 모든 음이 늦어지는 drift 없이 지정 음절만 지연      |
| **R02 Three-Note Melisma / L3 / 4**            | 한 모음에서 세 음을 분리해 연결한다.                        | scale degrees `1-2-3-2`, phrase-final melisma                   | note segmentation, 종지 landing       | 네 음 모두 인식되고 종지음 안정                 |
| **R03 Pentatonic Call–Response / L3 / 8**      | 듣고 응답하며 contour를 변형한다.                       | 2마디 call, 2마디 response ×2, pentatonic P5/M6                     | contour 유사성과 변형 범위                  | 원형 1회, 허용 변형 1회 성공                 |
| **R04 Consonant Delay–Vowel Landing / L4 / 4** | 자음을 유연하게 배치하면서 모음을 target beat에 놓는다.         | 두 음절에 의도적 consonant delay annotation                            | consonant와 vowel onset 별도 평가        | 두 층의 타이밍을 각각 허용범위 내 수행             |
| **R05 Dual Ad-lib Ending / L4 / 8**            | 화성 안에서 두 ending을 선택·구성한다.                    | straight ending, upper-neighbor ending, pentatonic ending 중 두 개 | chord-tone landing, contour, breath | 서로 다른 ending 두 개를 backing-only로 수행 |

### E. Rock 5개

| ID                                        | 학습목표                                   | 훈련과제                                                   | 피드백                           | 졸업기준                          |
| ----------------------------------------- | -------------------------------------- | ------------------------------------------------------ | ----------------------------- | ----------------------------- |
| **RO01 Clean Speech Attack / L2 / 4**     | clean하고 명확한 speech-like onset을 반복한다.   | P5, 중간 음량, 짧은 4분음표·8분음표, rasp 없음                       | onset timing·pitch, effort    | 여덟 onset 중 일곱 이상 통과           |
| **RO02 Sustained Chorus Rise / L3 / 4**   | driving backing 위에서 P5 상승·지속음을 유지한다.   | P5 rise, 마지막 2-beat sustain, backing volume 제한         | pitch sag, outer-zone, effort | 지속음 안정, 과도한 음량 증가 없음          |
| **RO03 Driving Eighths / L3 / 4**         | 반복 8분음표에서 consonant precision을 유지한다.   | 1 syllable/beat 이상, 파열음 교대, 좁은 range                   | timing·가사 누락·tempo drift      | 100/110%에서 가사와 pulse 유지       |
| **RO04 Clean Register Crossing / L4 / 8** | distortion 없이 register crossing을 반복한다. | octave range, crossing 2회, clean guide                 | pitch continuity와 self-effort | 두 key에서 clean version 통과      |
| **RO05 Supervised Texture Slot / L5 / 4** | clean base 위에 승인된 texture를 선택적으로 추가한다. | clean master asset+별도 texture layer; 앱 단독 scream 지시 금지 | 자동점수보다 human rubric·안전 보고     | clean 선통과, coach 승인, 안전 경고 없음 |

### F. CCM 5개

| ID                                                | 학습목표                                  | 훈련과제                                             | 피드백                              | 졸업기준                         |
| ------------------------------------------------- | ------------------------------------- | ------------------------------------------------ | -------------------------------- | ---------------------------- |
| **W01 Congregational Legato / L2 / 4**            | 다수가 따라 부를 수 있는 좁은 음역의 선율을 안정적으로 수행한다. | P5–M6, 순차진행, 자체 비경전적 긍정 원문                       | pitch·legato·가사 명료도              | backing-only, 추가 호흡 없이 완주    |
| **W02 Contemporary Verse Syncopation / L2–3 / 4** | 단순 당김음과 대화형 가사를 유지한다.                 | offbeat 1–2회, 낮은 intensity, 한국어 또는 영어 자체 원문      | onset grid·consonant placement   | click 제거 후 syncopation 유지    |
| **W03 Pre-Chorus Dynamic Build / L3 / 8**         | 음량을 갑자기 밀지 않고 점진적 build를 만든다.         | sequence, octave 이내, dynamic envelope annotation | pitch·effort·dynamic curve       | peak 전 effort 안정, 두 key 통과   |
| **W04 Open-Vowel Cadence / L3 / 4**               | 종지의 개방 모음을 안정적으로 지속한다.                | 마지막 2–3 beats sustain, 자음 release 지정             | sustain pitch·release            | 종지음과 종성 timing 모두 통과         |
| **W05 Repeated-Chorus Stamina / L4 / 8×2**        | 같은 후렴을 두 번 불러도 정확도·노력도를 유지한다.         | 중간 음역, 두 번째 반복의 dynamic plan 변경                  | 1·2회차 성능 차이, fatigue self-report | 두 반복의 정확도 저하가 허용범위 내, 불편감 없음 |

---

## 8.11 Copyright-safe Production Rules

저작권 관련 정책은 지역별 법률검토를 대체하지 않는다.

| 규칙                             | 제작 요구사항                                                                                                | 근거                                      |
| ------------------------------ | ------------------------------------------------------------------------------------------------------ | --------------------------------------- |
| 1. 모든 핵심 표현을 신규 제작             | melody, lyrics, arrangement, guide performance, backing, master를 자체 제작하거나 명시적 양도로 확보한다.                | **[A]** ([U.S. Copyright Office][6])    |
| 2. Composition과 master 분리      | 작곡·가사 권리와 특정 녹음·연주의 권리를 각각 manifest에 기록한다.                                                             | **[A]** ([U.S. Copyright Office][6])    |
| 3. Interpolation 금지            | 기존 곡의 hook, riff, vocal run, signature intro, lyric fragment를 재연주해 삽입하지 않는다.                           | **[A 원칙·C 위험정책]**                       |
| 4. “짧아서 안전” 금지                 | 4마디·몇 음이라는 길이만으로 안전판정을 내리지 않는다. 인식 가능한 선택·배열·리듬 결합을 검토한다.                                              | **[A]** ([U.S. Copyright Office][24])   |
| 5. 공통 재료와 표현 구분                | 음계, 아르페지오, 통상적 화음은 재료로 쓸 수 있지만 특정 작품의 고유한 결합을 모사하지 않는다.                                                | **[A]** ([U.S. Copyright Office][26])   |
| 6. Artist sound-alike brief 금지 | “○○ 가수처럼” 대신 `behind-beat`, `three-note melisma`, `speech-like onset` 같은 기능적 기술어를 사용한다.                | **[C/D 제품 위험정책]**                       |
| 7. Public domain 주의            | 원곡이 공공영역이어도 현대 편곡·번역·녹음은 별도 권리가 있을 수 있으므로 해당 소스를 복제하지 않는다.                                             | **[A 원칙]** ([U.S. Copyright Office][6]) |
| 8. Sample·loop provenance      | 모든 loop, sample, virtual-instrument library의 상업적 앱 내 배포·stem 제공 허용 범위를 확인하고 영수증·license version을 보존한다. | **[C 실무 합의]**                           |
| 9. 기여자 계약                      | composer, lyricist, arranger, singer, musician, engineer의 양도·work-for-hire·인접권 동의를 확인한다.               | **[A/C]**                               |
| 10. Voice consent              | guide singer의 동의 범위를 보존하고 승인되지 않은 voice clone·artist imitation을 사용하지 않는다.                              | **[C/D 제품 정책]**                         |
| 11. Similarity QA              | interval/rhythm fingerprint 자동 검색 후 음악 전문가가 인식 가능 유사성을 인간 검토한다. 자동 통과만으로 법적 안전을 보장하지 않는다.              | **[C/D]**                               |
| 12. 교육 예외에 의존하지 않기             | 상업용 앱은 “교육 목적”이라는 이유만으로 저작권 곡 사용이 허용된다고 가정하지 않는다.                                                      | **[A 원칙]** ([WIPO][27])                 |
| 13. 버전 추적                      | 원본 MIDI·score·lyrics·session·stem·계약·review 결과에 immutable ID와 변경이력을 부여한다.                              | **[C 실무 합의]**                           |
| 14. 출시 전 법무 gate               | 유사성 flag, 외부 sample, 번역·경전 인용, public-domain 편곡이 포함된 자산은 법무 검토 없이 출시하지 않는다.                            | **[A/C]**                               |

---

## 8.12 QA Checklist for Phrase Assets

### A. Pedagogy QA

* [ ] 사용자가 할 수 있게 될 행동이 한 문장으로 정의되어 있다.
* [ ] Primary skill은 1개, secondary skill은 최대 1개다.
* [ ] 학습목표·과제·피드백·졸업기준이 모두 manifest에 있다.
* [ ] 선행 자산과 다음 전이 자산이 연결되어 있다.
* [ ] guide 지원이 제거되는 단계가 명시되어 있다.
* [ ] backing-only 또는 a cappella 최종 버전이 있다.
* [ ] neutral core와 genre sibling의 기술 골격이 실제로 동일하다.
* [ ] 4마디와 8마디 버전이 서로 다른 교육 목적을 가진다.

### B. Difficulty QA

* [ ] 13개 PDS 점수가 모두 입력되어 있다.
* [ ] range와 max interval이 MIDI에서 자동 계산되었다.
* [ ] tessitura가 voiced duration으로 계산되었다.
* [ ] 평균 rhythm density와 peak-bar density가 모두 확인되었다.
* [ ] breath demand가 CPB 상대값으로 기록되었다.
* [ ] style requirement가 실제 stem·annotation과 일치한다.
* [ ] 평균점수가 안전 병목을 가리지 않는다.
* [ ] 표시 레벨보다 2단계 높은 hidden spike가 없다.

### C. Score·Lyrics·Phonetics QA

* [ ] score, MIDI, guide vocal, piano guide의 음표가 일치한다.
* [ ] 가사 음절과 note onset이 정렬되어 있다.
* [ ] breath marks가 score·lyrics·audio에 동일하게 표시된다.
* [ ] 언어 코드와 IPA/phoneme 데이터가 검수되었다.
* [ ] 모음·자음 난이도 태그가 실제 원문과 일치한다.
* [ ] 의도된 scoop, melisma, consonant delay가 annotation되어 있다.
* [ ] 미성년자에게 부적합한 가사·캐릭터·강도 요소가 없다.

### D. Audio QA

* [ ] full guide, style guide, piano melody, supportive backing, independent backing, click, count-in이 분리 stem으로 존재한다.
* [ ] 모든 stem의 시작점과 bar grid가 sample-accurate하게 정렬되어 있다.
* [ ] independent backing에 guide melody bleed가 없다.
* [ ] guide vocal의 pitch·rhythm·가사 오류가 없다.
* [ ] neutral guide에 불필요한 vibrato·ad-lib·artist-like mannerism이 없다.
* [ ] backing 음량이 사용자의 oversinging을 유도하지 않는다.
* [ ] key·tempo render에서 artifact, formant distortion, transient smearing이 없다.
* [ ] stem checksum과 source-session ID가 기록되었다.

### E. Variant QA

* [ ] 12개 key의 range·tessitura가 자동 재계산되었다.
* [ ] low/mid/high register profile이 실제 CTZ 배치 차이를 만든다.
* [ ] 사람 guide anchor의 유효 transposition 범위가 품질검수되었다.
* [ ] 80/90/100/110/120% variant의 groove·호흡 변화가 검토되었다.
* [ ] variant가 난이도 band를 넘으면 별도 난이도로 재분류되었다.
* [ ] 특정 key·tempo에서 가사 발음이나 backing instrument가 비현실적으로 변하지 않는다.

### F. Feedback·Assessment QA

* [ ] 기기 latency calibration이 적용된다.
* [ ] consonant와 breath noise가 pitch scoring에서 제외된다.
* [ ] vibrato·intentional ornament용 target envelope가 있다.
* [ ] 낮은 confidence에서는 잘못된 단정 대신 재녹음을 요청한다.
* [ ] 한 시도에 primary feedback 하나만 우선 노출한다.
* [ ] guide가 꺼진 조건의 점수를 별도 저장한다.
* [ ] 전이·다음 세션 유지가 졸업조건에 포함된다.
* [ ] timbre, 성별, 성부, 질환을 추론하거나 채점하지 않는다.

### G. Safety QA

* [ ] 자산의 vocal load가 low/medium/high로 표시되어 있다.
* [ ] CTZ outer-zone 제한과 peak repetition이 검토되었다.
* [ ] 고음·고강도·긴 phrase·큰 반주가 동시에 몰리지 않는다.
* [ ] high-load 자산에는 clean alternative가 있다.
* [ ] L5 효과 자산은 human gate가 켜져 있다.
* [ ] 통증·쉰 목소리·갑작스러운 음역 손실 stop flow가 작동한다.
* [ ] 앱 문구가 의료 진단이나 안전 보장을 주장하지 않는다.

### H. Copyright·Rights QA

* [ ] 작곡·가사·편곡·연주·마스터의 권리자가 확인되었다.
* [ ] 모든 기여자 계약·release가 저장되어 있다.
* [ ] 외부 sample·loop가 없거나 라이선스 범위가 확인되었다.
* [ ] melody·rhythm fingerprint 검사가 통과되었다.
* [ ] 인간 similarity review가 완료되었다.
* [ ] artist name·song reference·sound-alike brief가 제작 문서에 없다.
* [ ] public-domain 자료 사용 시 편곡·번역·녹음 권리가 별도 검토되었다.
* [ ] `rights_status=cleared`가 아니면 배포 파이프라인이 차단된다.

### I. Release Gate

다음 중 하나라도 실패하면 P0 출시 차단으로 분류한다.

* [ ] 권리 상태 미확정
* [ ] CTZ·안전 병목 위반
* [ ] score/MIDI/audio 불일치
* [ ] guide melody bleed 또는 stem sync 오류
* [ ] manifest 필수 필드 누락
* [ ] human-gated 효과가 일반 사용자에게 노출
* [ ] 졸업 버전에 guide vocal 또는 click이 남아 있음

---

# 9. Source Bibliography

## Vocal pedagogy 및 repertoire pedagogy

1. Michaela Kelly, **“The Composition of a Voice Lesson: How a Motor Learning Classification Framework Affects Teacher Effectiveness,”** *Journal of Singing*, 2025. ([NATS][1])
2. Laura Crocco & David Meyer, **“Motor Learning and Teaching Singing: An Overview,”** *Journal of Singing*, 2021. ([NATS][7])
3. Heidi Moss Erickson, **“Mobile Apps and Biofeedback in Voice Pedagogy,”** *Journal of Singing*, 2021. ([NATS][8])
4. John Nix, **“Best Practices: Using Exercise Physiology and Motor Learning Principles in the Teaching Studio and the Practice Room,”** *Journal of Singing*, 2017. ([NATS][28])
5. NATS, **“Quantifying Repertoire Tessituras.”** ([NATS][3])
6. Steven Groth & John Seesholtz, **“Rethinking the Italian Twenty-Four Songs and Arias: Exploring Classical Vocal Literature Selection Through the Lens of Bel Canto Technique,”** *Journal of Singing*, 2025. ([NATS][4])
7. Elizabeth Gerbi, **“I Am the Very Model of a Modern Two Year Repertoire,”** *Journal of Singing*, 2020. ([NATS][29])
8. NATS Children & Youth Advisory Panel, **NSA Resources: Children & Youth Categories**, 2023. ([NATS][23])

## Conservatory·graded repertoire 기준

9. ABRSM, **Singing for Musical Theatre Practical Grades Syllabus, Grades 1–8**, 2025 edition. ([ABRSM][2])
10. Trinity College London, **Rock & Pop Vocals Syllabus**. ([Trinity College][10])
11. The Royal Conservatory of Music, **Voice Syllabus, 2025 Edition**. ([rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com][5])
12. The Royal Conservatory of Music, **Voice Series, 2025 Edition**. ([Royal Conservatory][11])

## Vocal etude·solfège·sight-singing 및 Berklee

13. Berklee Online, **Music Theory and Sight-Singing for Vocalists**. ([Berklee Online][12])
14. Berklee Online, **Ear Training 1**. ([Berklee Online][30])
15. Berklee Online, **Ear Training 2**. ([Berklee Online][31])
16. Berklee Online, **Voice Technique 101**. ([Berklee Online][13])
17. Berklee Online, **Jazz Singing 201**. ([Berklee Online][32])

## NYU 대학 보컬 커리큘럼

18. NYU Steinhardt, **BM Vocal Performance: Contemporary Voice Curriculum**. ([NYU Steinhardt][14])
19. NYU Steinhardt, **BM Vocal Performance: Classical Voice Curriculum**. ([NYU Steinhardt][33])
20. NYU Steinhardt, **MM Vocal Performance: Music Theatre Curriculum**. ([NYU Steinhardt][34])

## Music education·feedback·assessment 연구

21. NAfME, **Grade 2 General Music Performing Model Cornerstone Assessment**. ([NAfME][15])
22. Blanco, Tassani & Ramirez, **“Effects of Visual and Auditory Feedback in Violin and Singing Voice Pitch Matching Tasks,”** *Frontiers in Psychology*, 2021. ([Frontiers][9])
23. Li et al., **“The Effects of Musical Feedback Training on Metacognition and Self-Directed Learning,”** *Frontiers in Human Neuroscience*, 2023. ([Frontiers][16])
24. **“Focus of Attention in Musical Learning and Music Performance: A Systematic Review,”** *Frontiers in Psychology*, 2024. ([Frontiers][17])
25. **“Effects of Variability of Practice in Music: A Pilot Study on Fast Goal-Directed Movements in Pianists,”** *Frontiers in Human Neuroscience*, 2014. ([Frontiers][18])
26. Renwick & McPherson, **“Interest and Choice: Student-Selected Repertoire and Its Effect on Practising Behaviour,”** *British Journal of Music Education*. ([Cambridge University Press & Assessment][19])
27. Nicole Michelle Sonbert, **Evaluating Appropriate Repertoire for Developing Singers**, DMA dissertation, University of Kentucky, 2018. ([uknowledge.uky.edu][20])
28. Allan Vurma et al., **“The Role of Voiced Consonant Duration in Sung Text Intelligibility,”** *Journal of the Acoustical Society of America*, 2025. ([AIP Publishing][21])

## Vocal safety

29. U.S. National Institute on Deafness and Other Communication Disorders, **Taking Care of Your Voice**. ([NIDCD][22])
30. U.S. National Institute on Deafness and Other Communication Disorders, **Hoarseness**. ([NIDCD][25])

## Copyright-safe educational content

31. U.S. Copyright Office, **Circular 56A: Copyright Registration of Musical Compositions and Sound Recordings**. ([U.S. Copyright Office][6])
32. U.S. Copyright Office, **Circular 33: Works Not Protected by Copyright**. ([U.S. Copyright Office][24])
33. U.S. Copyright Office, **Compendium of U.S. Copyright Office Practices, Chapter 800: Performing Arts**. ([U.S. Copyright Office][26])
34. World Intellectual Property Organization, **Copyright**. ([WIPO][27])
35. World Intellectual Property Organization, **Intellectual Property and Music**. ([WIPO][35])

[1]: https://www.nats.org/_Library/JOS_On_Point/JOS-081-5-2025-533.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-081-5-2025-533.pdf"
[2]: https://www.abrsm.org/sites/default/files/2025-01/SfMT%20Practical%20Grades%20Syllabus%20G1-8%202025%20%2820250130%29.pdf "https://www.abrsm.org/sites/default/files/2025-01/SfMT%20Practical%20Grades%20Syllabus%20G1-8%202025%20%2820250130%29.pdf"
[3]: https://www.nats.org/_Quantifying_Repertoire_Tessituras.html "https://www.nats.org/_Quantifying_Repertoire_Tessituras.html"
[4]: https://www.nats.org/_Library/JOS_On_Point/JOS-081-5-2025-511.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-081-5-2025-511.pdf"
[5]: https://rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com/rcm_voice_syllabus_2025_edition_85447841d6.pdf "https://rcmusic-production-strapi-media.s3.ca-central-1.amazonaws.com/rcm_voice_syllabus_2025_edition_85447841d6.pdf"
[6]: https://www.copyright.gov/circs/circ56a.pdf "https://www.copyright.gov/circs/circ56a.pdf"
[7]: https://www.nats.org/_Library/JOS_On_Point/JOS_077_5_2021_693.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS_077_5_2021_693.pdf"
[8]: https://www.nats.org/_Library/JOS_On_Point/JOS_077_04_2021_485.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS_077_04_2021_485.pdf"
[9]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.684693/full "https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.684693/full"
[10]: https://www.trinitycollege.com/resource?id=7901 "https://www.trinitycollege.com/resource?id=7901"
[11]: https://www.rcmusic.com/about-us/rcm-publishing/voice-series-2025-edition "https://www.rcmusic.com/about-us/rcm-publishing/voice-series-2025-edition"
[12]: https://online.berklee.edu/courses/music-theory-and-sight-singing-for-vocalists "https://online.berklee.edu/courses/music-theory-and-sight-singing-for-vocalists"
[13]: https://online.berklee.edu/courses/voice-technique-101 "https://online.berklee.edu/courses/voice-technique-101"
[14]: https://steinhardt.nyu.edu/degree/bm-vocal-performance-contemporary-voice/curriculum "https://steinhardt.nyu.edu/degree/bm-vocal-performance-contemporary-voice/curriculum"
[15]: https://nafme.org/wp-content/uploads/2023/09/Grade_2_GenMus_Performing_MCA.pdf "https://nafme.org/wp-content/uploads/2023/09/Grade_2_GenMus_Performing_MCA.pdf"
[16]: https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2023.1304929/full "https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2023.1304929/full"
[17]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1290596/full "https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1290596/full"
[18]: https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2014.00598/full "https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2014.00598/full"
[19]: https://www.cambridge.org/core/journals/british-journal-of-music-education/article/interest-and-choice-studentselected-repertoire-and-its-effect-on-practising-behaviour/0B9C564E2BF0075D2D70CCC5C7E9ABFF "https://www.cambridge.org/core/journals/british-journal-of-music-education/article/interest-and-choice-studentselected-repertoire-and-its-effect-on-practising-behaviour/0B9C564E2BF0075D2D70CCC5C7E9ABFF"
[20]: https://uknowledge.uky.edu/music_etds/104/ "https://uknowledge.uky.edu/music_etds/104/"
[21]: https://pubs.aip.org/asa/jasa/article/158/4/3120/3368594/The-role-of-voiced-consonant-duration-in-sung "https://pubs.aip.org/asa/jasa/article/158/4/3120/3368594/The-role-of-voiced-consonant-duration-in-sung"
[22]: https://www.nidcd.nih.gov/health/taking-care-your-voice "https://www.nidcd.nih.gov/health/taking-care-your-voice"
[23]: https://www.nats.org/_Library/2023_24_NSA_Docs/New_NSA_C_Y_Resources.pdf "https://www.nats.org/_Library/2023_24_NSA_Docs/New_NSA_C_Y_Resources.pdf"
[24]: https://www.copyright.gov/circs/circ33.pdf "https://www.copyright.gov/circs/circ33.pdf"
[25]: https://www.nidcd.nih.gov/health/hoarseness "https://www.nidcd.nih.gov/health/hoarseness"
[26]: https://www.copyright.gov/comp3/chap800/ch800-performing-arts.pdf "https://www.copyright.gov/comp3/chap800/ch800-performing-arts.pdf"
[27]: https://www.wipo.int/en/web/copyright "https://www.wipo.int/en/web/copyright"
[28]: https://www.nats.org/_Library/JOS_On_Point/JOS-074-2-2017-215_-_Best_Practices-Exercise_Physiology_-_Nix.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-074-2-2017-215_-_Best_Practices-Exercise_Physiology_-_Nix.pdf"
[29]: https://www.nats.org/_Library/JOS_On_Point/JOS-076-4-2020-449.PDF "https://www.nats.org/_Library/JOS_On_Point/JOS-076-4-2020-449.PDF"
[30]: https://online.berklee.edu/courses/ear-training-1 "https://online.berklee.edu/courses/ear-training-1"
[31]: https://online.berklee.edu/courses/ear-training-2 "https://online.berklee.edu/courses/ear-training-2"
[32]: https://online.berklee.edu/courses/jazz-singing-201 "https://online.berklee.edu/courses/jazz-singing-201"
[33]: https://steinhardt.nyu.edu/degree/bm-vocal-performance-classical-voice/curriculum "https://steinhardt.nyu.edu/degree/bm-vocal-performance-classical-voice/curriculum"
[34]: https://steinhardt.nyu.edu/degree/mm-vocal-performance-music-theatre/curriculum "https://steinhardt.nyu.edu/degree/mm-vocal-performance-music-theatre/curriculum"
[35]: https://www.wipo.int/en/web/music "https://www.wipo.int/en/web/music"
