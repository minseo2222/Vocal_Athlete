# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `7. Diction - Korean Lyric Clarity #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `07-korean-diction.md`

---

# 1. Executive Summary

검토한 핵심 결론은 하나입니다. **한국어 노래 딕션 앱은 “정확한 발음 점수”를 주는 앱이 아니라, 사용자가 가사를 청자가 회수할 수 있게 만드는 수행 능력 앱**이어야 합니다. NATS/Journal of Singing의 lyric diction 전통은 IPA·언어별 딕션·텍스트 분석을 체계화해 왔지만, 한국어는 **한글-음운 규칙-노래 시간 배치**가 결합되어야 하므로 romanization이나 IPA만으로는 충분하지 않습니다. ([NATS][1])

근거등급은 다음처럼 표시합니다. **[A] 강한 연구 근거, [B] 반복적 교육 현장 합의, [C] 전문가 의견, [D] 제한적 근거**.

**[A] 노래 딕션은 일반 발음과 다릅니다.** 말과 노래는 같은 조음기관을 쓰지만, 노래에서는 음높이, 길어진 모음, 공명, 박자, 반주, 고음역, 레가토가 발음의 시간 구조를 바꿉니다. Voice Foundation은 혀·입술·연구개 등 조음기관이 단어 인식을 만든다고 설명하고, sung text intelligibility 연구는 노래가 말보다 음악적 제약을 추가한다고 정리합니다. ([음성재단][2])

**[A/B] 한국어 노래 딕션의 핵심은 “모음 유지 → 자음 타이밍 → 받침 폐쇄/연결 → 청취 검증”입니다.** 한국어 받침은 표기 그대로 모두 강하게 방출되는 것이 아니라, 표준 발음에서 7개 종성으로 제한되고, 환경에 따라 비음화·된소리되기·연음 등이 발생합니다. 앱은 “받침을 크게 말하라”가 아니라 **모음을 충분히 유지한 뒤, 받침을 늦고 짧게 닫거나 다음 음절로 연결하는 능력**을 훈련해야 합니다. ([국립국어원][3])

**[A/D] 자동 평가는 가능하지만, 자동 ‘발음 점수’는 위험합니다.** lyrics-to-audio alignment, syllable timing, vowel duration, consonant closure timing, 녹음 품질, 반복 녹음 전후 변화는 평가할 수 있습니다. 하지만 한국어 singing phoneme recognition은 데이터·고음·긴 모음·반주·스타일 변형 때문에 아직 제한이 큽니다. 따라서 앱은 “정답 발음 87점”보다 “이 음절에서 모음이 너무 일찍 닫혔습니다” 같은 **국소적·설명 가능한 피드백**을 제공해야 합니다. ([MDPI][4])

**[B] 제품 설계 목표는 ‘무엇을 가르칠까’가 아니라 ‘사용자가 무엇을 할 수 있게 될까’입니다.** 최종 사용자는 다음을 할 수 있어야 합니다: 가사를 말하듯 이해한다 → 박자 위에 얹는다 → 모음을 유지한다 → 자음을 정확한 타이밍에 배치한다 → 받침을 한국어 규칙대로 처리한다 → 녹음해서 청취 가능성을 검증한다. ASHA의 말소리 훈련 원칙인 establishment → generalization → maintenance와 self-monitoring 구조는 앱 커리큘럼에도 적합합니다. ([ASHA][5])

---

# 2. Evidence Review

## 2.1 검색 → 비교 → 비판 → 통합 → 커리큘럼 변환

| 근거군                           | 검토 출처                                                                                           | 비교한 내용                                                                         | 비판적 판단                                             | 앱 커리큘럼 전환                                                             |
| ----------------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ | -------------------------------------------------- | --------------------------------------------------------------------- |
| **Lyric diction 전통**          | NATS/Journal of Singing, Journal of Singing manual mimicry                                      | IPA, 언어별 딕션, 가사 전달, 조음 제스처                                                     | [B] 서양 성악 중심 체계는 강하지만 한국어 노래에 그대로 이식하면 부족          | 한글 우선 + IPA/발음 힌트 보조 + 녹음 기반 자기 점검 ([NATS][1])                        |
| **음성·조음 생리**                  | Voice Foundation, NATS terminology                                                              | 조음기관, 공명, 발성기관, 음향 측정                                                          | [A] 노래와 말은 같은 기관을 쓰지만 노래의 시간·공명 조건은 다름             | 모음 유지, 자음 폐쇄, 공명 변화, 녹음 피드백을 분리 ([음성재단][2])                           |
| **건강·안전**                     | NIDCD, ASHA Voice Disorders                                                                     | 쉰 목소리, 고음 상실, 통증, 과사용, muscle tension dysphonia                                | [A] 앱이 진단하면 안 됨. 중단·휴식·전문가 의뢰 규칙 필요                | “통증/쉰소리/말하기 힘듦” 감지 시 훈련 중단 UX ([청각 및 의사소통 장애 연구소][6])                 |
| **Sung text intelligibility** | Fine & Ginsborg, Gregg & Scherer, Collister & Huron                                             | 고음, 모음 식별, 반주·공간·청자·음악 구조                                                      | [A] 명료도는 가수만의 문제가 아님. 환경·청자·음악도 영향                 | 앱은 “청자가 들을 확률을 높이는 행동”만 평가해야 함 ([Frontiers][7])                       |
| **자음 지속·타이밍**                 | Vurma et al. 2025, singing intelligibility 연구                                                   | CV/VC 인식, 고음·반주·잔향, 자음 길이                                                      | [A/D] 자음 지속이 인식에 도움 될 수 있으나 모든 언어·장르에 일반화 불가       | “자음 크게”가 아니라 “모음 손실 없이 필요한 순간에 배치” ([ISCA Archive][8])                |
| **한국어 음운·받침**                 | 국립국어원 표준 발음, 한국어 release/nonrelease 연구                                                          | 7종성, 비음화, 된소리되기, 종성 무파열                                                        | [A/B] 말 발음 규칙은 강하지만 노래에서는 박자·음가에 맞춘 시간 배치가 추가됨     | 받침을 “소리값 + 타이밍 + 연결”로 훈련 ([국립국어원][3])                                 |
| **한국어 딕션 연구**                 | Clara Lee, Alabama choral Korean diction, UNT Korean diction                                    | IPA, 한글, romanization, 비한국어권 가수 교육                                             | [B/C] 한국어 노래 딕션 연구는 존재하지만 대규모 앱 평가 연구는 부족          | 앱 UI는 한글 중심, IPA/로마자 보조, 발음 규칙 시각화 ([Claremont Scholarship][9])       |
| **대학·컨서버토리 커리큘럼**             | Berklee, NYU, Juilliard, NEC, Royal Academy                                                     | 딕션, 언어, 레퍼토리, 텍스트 분석, 스타일                                                      | [B] 딕션은 독립 과목이면서도 노래·연기·레퍼토리와 통합됨                  | 앱도 단독 발음 drill → 실제 곡 phrase 적용으로 진행 ([Berklee College of Music][10]) |
| **자동 평가·ASR**                 | singing lyric alignment, automatic pronunciation evaluation, Korean singing phoneme recognition | forced alignment, phoneme recognition, singing ASR, intelligibility prediction | [A/D] alignment는 가능성이 높지만, 한국어 노래 발음 전체 점수는 아직 제한적 | 자동 평가는 timing·duration·녹음조건·반복 변화 중심 ([Telecom Paris][11])            |

---

## 2.2 한국어 노래 · 영어 CCM · 클래식 성악 비교

| 비교 항목                | 한국어 노래                                                                                                                      | 영어 CCM                                                                                                                                | 클래식 성악                                                                                                 | 제품 설계 함의                                                                                                 |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- |
| **Vowel treatment**  | [B] 한글 음절의 모음 핵이 음정을 실어 나릅니다. ㅓ/ㅡ/ㅢ/ㅐ/ㅔ 등은 로마자만으로 설명하면 오류가 많습니다. 고음에서는 약간의 모음 조정이 필요할 수 있으나, 한국어 모음 정체성을 잃으면 가사 회수가 어려워집니다. | [B/C] speech-like delivery, accent, mic, 장르적 vowel color가 중요합니다. Berklee의 American Diction은 pop/rock/jazz 스타일에서 발음·가사 전달·해석을 함께 다룹니다. | [A/B] IPA 기반 다국어 딕션, legato, resonance, high pitch vowel modification이 핵심입니다. 고음에서 모음 식별이 어려워질 수 있습니다. | 같은 “모음 정확도”라도 장르별 목표가 다릅니다. 한국어 모듈은 **모음 핵 유지 + 한국어 모음 구별**을 우선해야 합니다. ([Berklee College of Music][10])  |
| **Consonant timing** | [A/B] 초성은 모음 진입을 방해하지 않게 준비하고, 받침은 늦게 닫거나 다음 음절로 연결합니다. 종성은 7개 소리값으로 제한되고 많은 경우 무파열적입니다.                                    | [B/C] 영어는 어말 자음·자음군이 의미를 크게 좌우하고, CCM에서는 마이크와 리듬 groove 때문에 자음이 더 rhythmic하게 처리될 수 있습니다.                                              | [B] 언어별 자음 규칙을 지키되, legato와 vowel line을 해치지 않도록 자음을 앞당기거나 분산시키는 교육 관행이 있습니다.                           | 한국어 앱은 영어식 final consonant release를 기본값으로 삼으면 안 됩니다. “받침을 들리게”보다 “받침 때문에 모음을 잃지 않게”가 우선입니다. ([국립국어원][3]) |
| **Intelligibility**  | [B/D] 흔한 실패는 모음 조기 종료, 받침 과방출/누락, 연음·비음화·된소리되기 미처리, 로마자 기반 오독입니다. 대규모 빈도 연구는 부족합니다.                                         | [B/C] 가사 명료도는 발음뿐 아니라 믹스, 마이크, 스타일, groove, singer identity의 영향을 받습니다.                                                                | [A] 고음, 반주, 잔향, 외국어, vowel migration 때문에 청취자가 단어를 놓칠 수 있습니다.                                           | 앱은 “청자가 lyric을 복원할 수 있는가”를 녹음 리뷰와 blind lyric check로 검증해야 합니다. ([Frontiers][7])                          |

---

# 3. Consensus

## 3.1 전문가들이 동의하는 내용

1. **[A] 노래 딕션은 일반 발음의 확대판이 아닙니다.**
   노래는 음높이, 지속시간, 공명, 반주, 템포, 레가토 때문에 말의 발음 시간을 재배치합니다. 따라서 “정확히 말하기”에서 끝나지 않고, **모음이 음정을 유지하는 동안 자음이 어디에 붙는가**를 설계해야 합니다. ([음성재단][2])

2. **[A] 가사 명료도는 singer-only metric이 아닙니다.**
   연구는 intelligibility가 performer, listener, environment, music 모두의 영향을 받는다고 봅니다. 앱은 환경·청자 변수를 통제할 수 없으므로 “발음 완벽도”가 아니라 **사용자 행동 변화**를 평가해야 합니다. ([Frontiers][7])

3. **[A] 모음 유지 능력은 핵심입니다.**
   고음·긴 음가·공명 변화는 모음 식별을 어렵게 만들 수 있습니다. 특히 클래식에서는 vowel modification이 필요할 수 있고, 한국어에서도 고음에서 모음 정체성을 보존하는 훈련이 필요합니다. ([Frontiers][7])

4. **[A/B] 한국어 받침은 표기 그대로 세게 터뜨리는 대상이 아닙니다.**
   표준 발음에서 받침 소리는 7개 종성으로 제한되고, 환경에 따라 비음화·된소리되기 등이 발생합니다. 한국어 종성 파열음은 영어식 release와 다르게 처리됩니다. ([국립국어원][3])

5. **[B] 딕션 교육은 isolated drill에서 끝나면 안 됩니다.**
   컨서버토리·대학 보컬 커리큘럼은 diction, language, repertoire, text analysis, performance를 함께 다룹니다. 앱도 “자모 연습 → 단어 → 리듬 낭독 → 멜로디 → 실제 곡”으로 일반화해야 합니다. ([Berklee College of Music][12])

6. **[A/B] 발음 점수 없이도 향상은 만들 수 있습니다.**
   ASHA의 말소리 훈련 구조는 establishment, generalization, maintenance와 self-monitoring을 강조합니다. 앱에서는 “정답 점수” 없이도 전후 녹음 비교, 자기 체크, listener transcript test, 과제별 pass/fail로 향상을 만들 수 있습니다. ([ASHA][5])

7. **[A] 안전 UX는 필수입니다.**
   지속적 쉰소리, 고음 상실, 목의 통증·거침, 말하기 effort 증가는 의료적 확인이 필요한 신호일 수 있습니다. 앱은 이런 신호를 발견하면 훈련 강도를 낮추거나 중단하고 ENT/SLP 안내를 해야 합니다. ([청각 및 의사소통 장애 연구소][6])

---

## 3.2 필수 질문에 대한 직접 답

| 질문                              | 답변                                                                                                                                                             | 근거 수준                           |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| **1. 노래 딕션과 일반 발음은 어떻게 다른가?**   | 일반 발음은 말의 자연 속도와 억양에서 작동합니다. 노래 딕션은 음정, 박자, 긴 모음, 공명, 레가토, 반주 속에서 **가사가 들리도록 시간 배치를 재설계**합니다.                                                                  | [A] ([음성재단][2])                 |
| **2. 한국어 가사에서 가장 흔한 문제는 무엇인가?** | 대규모 빈도 연구는 부족합니다. 앱 설계 관점의 대표 risk pattern은 모음 조기 종료, 받침 과방출, 받침 누락, 초성 늦음, 연음·비음화·된소리되기 미처리, ㅓ/ㅡ/ㅢ/ㅐ/ㅔ 로마자 오독입니다.                                             | [B/D] ([국립국어원][3])              |
| **3. 받침은 어떻게 처리되는가?**           | 받침은 우선 표준 발음의 7종성·음운 변동을 따릅니다. 노래에서는 모음 핵을 유지한 뒤 받침을 늦고 짧게 닫고, 다음 음절이 모음이거나 규칙상 연결될 때는 분리된 폭발음처럼 처리하지 않습니다.                                                    | [A/B] ([국립국어원][3])              |
| **4. 자음 timing은 어떻게 교육하는가?**    | 먼저 말 리듬으로 자음 위치를 느끼고, 그다음 chant, 한 음, 짧은 선율, 실제 phrase로 옮깁니다. 초성은 모음 onset을 방해하지 않게 준비하고, 종성은 모음 지속을 훔치지 않게 늦게 닫습니다.                                           | [A/B] ([ISCA Archive][8])       |
| **5. 모음 유지 능력은 왜 중요한가?**        | 노래에서 음정과 공명은 대부분 모음 핵 위에 지속됩니다. 모음이 너무 빨리 닫히면 음정, legato, 가사 인식이 동시에 손상됩니다. 고음에서는 모음 식별 자체도 어려워질 수 있습니다.                                                       | [A] ([Frontiers][7])            |
| **6. 발음 점수 없이도 향상을 만들 수 있는가?**  | 가능합니다. 전후 녹음 비교, self-monitoring, blind lyric recognition, 과제별 졸업기준을 쓰면 “점수” 없이도 행동 변화가 생깁니다.                                                                  | [A/B] ([ASHA][5])               |
| **7. 앱에서 자동 평가 가능한 항목은?**       | 가사-오디오 alignment, 음절 onset/offset, vowel duration ratio, 긴 음에서 vowel stability proxy, consonant burst/closure 위치, 녹음 품질, 반복 전후 변화, 사용자 self-report는 가능성이 있습니다. | [A/D] ([Telecom Paris][11])     |
| **8. 자동 평가하면 안 되는 항목은?**        | 절대적 한국어 발음 순도, 예술적 해석의 옳고 그름, jaw/tongue tension 진단, 성대 질환, 문화적 authenticity, 모든 장르에 적용되는 단일 발음 점수는 자동 판정하면 안 됩니다.                                             | [A/C/D] ([청각 및 의사소통 장애 연구소][6]) |

---

# 4. Controversies

| 논쟁 지점                                    | 서로 갈리는 입장                                                                                                 | 제품팀 판단                                                                                                           |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Vowel modification vs lyric fidelity** | [A/B] 클래식은 고음·공명을 위해 vowel modification을 허용합니다. 반면 한국어 가사 명료도 앱은 모음 정체성을 더 오래 보존해야 합니다.                   | 스타일 프리셋을 둡니다. “Korean pop/ballad”, “musical”, “classical/art song”별 vowel tolerance를 다르게 설정합니다. ([Frontiers][7]) |
| **자음은 beat 전인가, beat 위인가?**              | [C/D] 성악 교육에서는 모음이 beat 위에 오도록 자음을 미리 준비하는 관행이 있지만, CCM·랩성 phrasing·한국어 빠른 음절에서는 groove에 따라 달라집니다.        | 앱은 절대 규칙을 주지 말고 “vowel onset이 음악적으로 늦었는가 / consonant가 vowel을 먹었는가”를 기준으로 피드백합니다.                                 |
| **자음을 길게 하면 항상 명료해지는가?**                 | [A/D] 특정 연구에서는 voiced consonant duration 증가가 인식에 도움을 줄 수 있습니다. 하지만 과도한 자음은 legato, 음정, 스타일을 해칠 수 있습니다.    | “자음 길이 증가”를 기본 처방으로 삼지 말고, 청취 실패 음절에 한해 국소적으로 적용합니다. ([ISCA Archive][8])                                         |
| **한국어 딕션에 IPA가 충분한가?**                   | [B/C] IPA는 유용하지만 한국어 노래에서는 한글, 표준 발음 규칙, 실제 노래 타이밍이 함께 필요합니다. romanization-only는 오류 위험이 큽니다.              | UI 기본은 한글, 보조층으로 IPA·로마자·입모양 힌트를 제공합니다. ([NATS][1])                                                              |
| **CCM 딕션의 표준화 수준**                       | [B/C] 클래식 딕션은 비교적 체계화되어 있으나, CCM pedagogy는 스타일 다양성 때문에 합의가 덜 단단합니다.                                       | 영어 CCM을 한국어 기준으로 일반화하지 말고, 비교 모듈로만 사용합니다. ([NATS][13])                                                           |
| **AI pronunciation score**               | [D] singing ASR와 Korean singing phoneme recognition은 가능성이 있지만, 데이터·반주·고음·스타일 변형 때문에 완전한 발음 채점기로 쓰기 어렵습니다. | global score 금지. task-specific, confidence-aware feedback만 사용합니다. ([MDPI][4])                                    |

---

## 근거 부족으로 분리해야 할 주장

1. **[D] “한국어 노래 딕션을 0~100점으로 정확히 자동 채점할 수 있다.”**
   singing ASR·Korean singing phoneme recognition 연구는 진행 중이지만, 앱 상용 환경에서 절대 점수로 쓰기에는 근거가 약합니다. ([MDPI][4])

2. **[D] “모든 받침은 크게 들려야 한다.”**
   한국어 받침은 표준 발음의 7종성·무파열성·연결 규칙을 고려해야 하므로, 영어식 release나 과장된 폭발은 오히려 부정확할 수 있습니다. ([국립국어원][3])

3. **[D] “턱·혀 긴장은 오디오만으로 판정 가능하다.”**
   긴장은 중요한 위험 요인이지만, 앱 오디오만으로 의학적·기능적 긴장을 진단하는 것은 안전하지 않습니다. self-report와 영상 체크는 보조로만 써야 합니다. ([청각 및 의사소통 장애 연구소][6])

4. **[D] “영어 CCM 딕션 규칙을 한국어에도 그대로 적용하면 된다.”**
   영어의 final consonant, diphthong, cluster 처리와 한국어 받침·음절 timing은 다릅니다. 한국어 모듈은 한국어 음운 규칙을 중심으로 설계해야 합니다. ([국립국어원][3])

---

# 5. Curriculum Design Implications

## 5.1 연구 결과를 앱 학습목표로 변환

| 학습목표: 사용자가 할 수 있게 될 것                     | 훈련과제                                       | 앱 피드백                                     | 졸업기준                                          | 근거                                   |
| ----------------------------------------- | ------------------------------------------ | ----------------------------------------- | --------------------------------------------- | ------------------------------------ |
| **모음과 자음의 역할을 분리해 들을 수 있다.**              | 같은 가사를 말하기 → 리듬 낭독 → 한 음 노래로 녹음            | “이 음절은 자음보다 모음 시간이 짧습니다.”                 | 사용자가 문제 음절 80% 이상을 스스로 표시                     | [A/B] ([음성재단][2])                    |
| **한국어 모음 핵을 음정 위에서 유지할 수 있다.**            | ㅏ/ㅓ/ㅗ/ㅜ/ㅡ/ㅣ/ㅐ/ㅔ를 2~4초 sustain, 짧은 선율 적용    | “모음이 1.2초 지점에서 닫혔습니다. 받침을 뒤로 미세요.”        | 긴 음 5개 중 4개에서 vowel duration 목표 충족            | [A] ([Frontiers][7])                 |
| **초성을 늦지 않게 준비할 수 있다.**                   | ㄱ/ㄷ/ㅂ/ㅈ/ㅅ/ㅎ onset drill → beat 위 phrase    | “자음 시작은 맞지만 모음 onset이 beat보다 늦습니다.”       | 8개 phrase 중 6개에서 vowel onset 안정               | [B/D] ([ISCA Archive][8])            |
| **받침을 한국어식으로 늦게 닫을 수 있다.**                | CV-C, CVC 단어에서 모음 유지 후 closure             | “받침이 너무 일찍 닫혀 음정 지속이 줄었습니다.”              | 지정 음절 80%에서 vowel-to-coda ratio 개선            | [A/B] ([국립국어원][3])                   |
| **연음·비음화·된소리되기를 노래 phrase 안에서 처리할 수 있다.** | 표준 발음 규칙별 mini phrase 녹음                   | “여기서는 표기보다 실제 소리 연결을 우선하세요.”              | 규칙별 예문 3개씩 pass                               | [A/B] ([국립국어원][14])                  |
| **턱·혀 effort를 낮추면서 명료도를 유지할 수 있다.**       | 같은 phrase를 effort 7/10 → 4/10으로 재녹음        | “명료도는 유지됐고 self-effort가 낮아졌습니다.”          | self-effort 4 이하, 통증 없음, lyric recognition 유지 | [C/D] ([청각 및 의사소통 장애 연구소][6])        |
| **가사 명료도를 청취 기준으로 검증할 수 있다.**             | lyric hidden playback, 본인/타인 transcription | “청자가 놓친 음절이 반복됩니다.”                       | 2명 이상 청취자 또는 self blind test에서 핵심어 80% 회수     | [A/B] ([Frontiers][7])               |
| **실제 곡에서 딕션을 유지할 수 있다.**                  | 2마디 → 4마디 → full phrase로 일반화               | “drill에서는 pass, 실제 phrase에서는 받침이 앞당겨집니다.” | 실제 곡 phrase 3회 중 2회 기준 통과                     | [B] ([Berklee College of Music][12]) |

---

# 6. App Implementation Implications

## 6.1 자동 평가 가능한 항목

| 자동 평가 항목                       | 구현 방식                                                               | 피드백 예시                                          | 근거 수준                                               |
| ------------------------------ | ------------------------------------------------------------------- | ----------------------------------------------- | --------------------------------------------------- |
| **가사-오디오 alignment**           | 사전에 입력된 한글 가사와 녹음을 forced alignment                                 | “3번째 음절이 반 박 늦게 시작됩니다.”                         | [A/D] ([Telecom Paris][11])                         |
| **음절 onset/offset**            | energy, pitch, consonant burst, lyric alignment 조합                  | “초성 준비가 늦어 모음이 beat 뒤에 옵니다.”                    | [A/D] ([ISCA Archive][15])                          |
| **vowel duration ratio**       | 한 음절 안에서 vowel-like voiced segment 비율 추정                            | “받침이 너무 일찍 닫혀 모음 지속이 짧습니다.”                     | [A/D] ([Frontiers][7])                              |
| **긴 음의 vowel stability proxy** | formant/spectral centroid/voicing continuity 추적. 단, 절대 모음 정답 판정은 금지 | “긴 음 중간에 모음 색이 급격히 바뀝니다.”                       | [A/D] ([Bowling Green State University Portal][16]) |
| **자음 위치·길이 추정**                | plosive burst, fricative noise, nasal continuity, closure gap       | “자음이 길어져 다음 모음 진입을 가립니다.”                       | [A/D] ([ISCA Archive][8])                           |
| **녹음 품질**                      | clipping, SNR, 반주 과다, mic distance 변화                               | “반주가 커서 딕션 분석 신뢰도가 낮습니다. a cappella로 다시 녹음하세요.” | [A] ([ACM Digital Library][17])                     |
| **전후 변화**                      | 같은 과제의 baseline vs retry 비교                                         | “모음 지속이 22% 늘었습니다.”                             | [A/B] ([ASHA][5])                                   |
| **self-report**                | effort, 통증, 턱/혀 긴장, 피로도 입력                                          | “effort가 높습니다. 반복 횟수를 줄이세요.”                    | [A/C] ([청각 및 의사소통 장애 연구소][6])                       |

---

## 6.2 자동 평가하면 안 되는 항목

| 금지 또는 제한 항목                 | 이유                                                                | 제품 규칙                                  |
| --------------------------- | ----------------------------------------------------------------- | -------------------------------------- |
| **절대 발음 점수**                | singing ASR와 한국어 singing phoneme recognition은 아직 데이터·스타일·반주 한계가 큼 | “정답률 92점” 대신 “이 음절의 모음 길이/자음 위치” 제공    |
| **성대 질환·muscle tension 진단** | 의료·임상 판단 영역                                                       | “진단” 금지. 증상 체크 후 전문가 안내                |
| **턱·혀 긴장 자동 판정**            | 오디오만으로 확정 불가                                                      | self-check, 영상 거울 과제, effort scale만 제공 |
| **문화적 authenticity 판정**     | 표준 발음과 예술적 정체성은 다름                                                | “한국인처럼/비한국인처럼” 표현 금지                   |
| **장르별 예술 선택의 옳고 그름**        | classical, CCM, Korean pop의 목표가 다름                                | style profile별 권장 범위만 제시               |
| **romanization 기반 채점**      | 한국어 모음·받침·음운 변동을 왜곡할 수 있음                                         | 한글 중심, romanization은 보조 표시             |

---

## 6.3 App Feedback Rules

1. **[A/D] Global score를 피하고, 음절 단위 feedback을 준다.**
   예: “좋은 발음입니다”보다 “두 번째 음절에서 받침 closure가 너무 빨라 모음이 짧아졌습니다.”

2. **[B] 피드백은 항상 행동 지시로 끝난다.**
   예: “받침을 세게 하세요”가 아니라 “모음을 beat 끝까지 유지한 뒤, 마지막 10~20% 지점에서 닫아보세요.”

3. **[A/D] confidence-aware feedback을 적용한다.**
   반주가 크거나 잡음이 많으면 분석하지 말고 “신뢰도 낮음: a cappella로 재녹음”을 표시합니다.

4. **[A/B] style profile을 먼저 묻는다.**
   Korean pop, musical, Korean art song/classical, CCM crossover는 vowel modification과 consonant timing tolerance가 다릅니다.

5. **[A] safety interrupt를 둔다.**
   통증, 쉰소리, 고음 상실, 말하기 effort가 입력되면 그날의 고음·반복 drill을 중단합니다. ([청각 및 의사소통 장애 연구소][6])

---

# 7. Safety Considerations

**[A] 앱은 보컬 건강을 평가하거나 치료하지 않습니다.** NIDCD는 쉰 목소리, 고음 상실, 목의 거침·통증, 말하기 effort 증가 등을 voice problem의 신호로 설명하며, 필요 시 의사·ENT·SLP 상담을 권합니다. ASHA도 muscle tension dysphonia 같은 기능적 음성장애가 구조적 병변 없이 나타날 수 있다고 설명합니다. ([청각 및 의사소통 장애 연구소][6])

제품 안전 규칙은 다음과 같습니다.

| 상황                         | 앱 행동                                         | 근거    |
| -------------------------- | -------------------------------------------- | ----- |
| 통증, 타는 느낌, 쉰소리, 말하기 어려움    | 즉시 훈련 중단, hydration/rest 안내, 반복 시 ENT/SLP 권장 | [A]   |
| 고음 drill 중 effort 7/10 이상  | 음역 낮추기, tempo 낮추기, 반복 횟수 제한                  | [A/C] |
| 턱·혀 긴장 self-report 6/10 이상 | diction 강도보다 release drill로 전환               | [C/D] |
| 사용자가 “목을 밀어서 자음 내기”를 선택    | 위험 feedback: loudness가 아니라 timing을 조정하라고 안내  | [A/B] |
| 지속적 문제                     | 앱 내 해결 시도 중단, 전문가 상담 안내                      | [A]   |

---

# 8. Recommended Framework

## 8.1 Korean Singing Diction Framework

| Layer                                | 사용자가 할 수 있게 될 것                         | 핵심 훈련                                  | 앱 평가                           | 졸업기준                       |
| ------------------------------------ | --------------------------------------- | -------------------------------------- | ------------------------------ | -------------------------- |
| **1. Hangul-to-Sound Layer**         | 표기와 실제 소리 차이를 구분한다                      | 7종성, 연음, 비음화, 된소리되기                    | rule quiz + 녹음 예문              | 규칙 예문 80% pass             |
| **2. Speech-to-Song Layer**          | 말 가사를 리듬과 선율로 옮긴다                       | 말하기 → 박자 낭독 → chant → melody           | syllable timing alignment      | 4마디 phrase에서 핵심어 timing 안정 |
| **3. Vowel Carrier Layer**           | 모음 핵으로 음정을 유지한다                         | long vowel, melisma, high pitch vowel  | vowel duration/stability proxy | 긴 음 5개 중 4개 pass           |
| **4. Consonant Timing Layer**        | 자음을 모음 앞뒤에 정확히 배치한다                     | onset prep, coda late closure          | onset/closure timing           | 문제 음절 80% 개선               |
| **5. Korean Coda Layer**             | 받침을 방출·누락하지 않고 처리한다                     | 7종성, 무파열 closure, linking              | coda timing + rule check       | 받침 phrase 3개 연속 pass       |
| **6. Low-Effort Articulation Layer** | 명료도와 effort를 분리한다                       | jaw/tongue release, smaller consonants | self-effort + audio change     | effort 4 이하, 명료도 유지        |
| **7. Listener Verification Layer**   | 청자가 가사를 회수하는지 확인한다                      | blind lyric playback, transcription    | self/listener recognition      | 핵심어 80% 회수                 |
| **8. Style Transfer Layer**          | Korean pop, musical, classical에 맞게 조절한다 | style profile별 phrase                  | tolerance-adjusted review      | 같은 가사 2가지 스타일 수행           |

---

## 8.2 Beginner / Intermediate / Advanced Split

| Level            | 목표                      | 사용자가 졸업 시 할 수 있는 것                                                           |
| ---------------- | ----------------------- | ---------------------------------------------------------------------------- |
| **Beginner**     | 한국어 노래 딕션의 기본 단위 습득     | 한글 음절에서 모음 핵과 초성/종성을 분리하고, 짧은 phrase에서 모음을 자음보다 먼저 유지한다                      |
| **Intermediate** | 한국어 음운 규칙과 노래 timing 결합 | 받침, 연음, 비음화, 된소리되기를 실제 멜로디 안에서 처리한다                                          |
| **Advanced**     | 장르·고음·빠른 가사·실전 검증       | Korean pop, musical, classical 스타일에서 intelligibility와 musical line을 동시에 유지한다 |

---

## 8.3 30-Lesson Structure

|  # | Level        | 사용자가 할 수 있게 될 것                               | 훈련과제                          | 앱 피드백                             | 졸업기준                     |
| -: | ------------ | --------------------------------------------- | ----------------------------- | --------------------------------- | ------------------------ |
|  1 | Beginner     | [A] 자신의 현재 가사 명료도 baseline을 만든다               | 4마디 한국어 가사 녹음                 | “분석 가능한 구간/불명확 구간” 표시             | baseline 저장              |
|  2 | Beginner     | [B] 말 리듬과 노래 리듬을 분리한다                         | 말하기 → 박수 → 리듬 낭독              | syllable grid 표시                  | 박자 오차 감소                 |
|  3 | Beginner     | [A] 모음 핵을 찾는다                                 | 각 음절에서 모음만 sustain            | vowel duration 표시                 | 8개 중 6개 pass             |
|  4 | Beginner     | [B] ㅏ/ㅓ/ㅗ/ㅜ를 구분해 유지한다                         | 2초 sustain + 짧은 선율            | vowel drift warning               | 80% 안정                   |
|  5 | Beginner     | [B] ㅡ/ㅣ/ㅐ/ㅔ/ㅢ risk vowel을 인식한다                | minimal phrase drill          | 혼동 가능 음절 표시                       | self-identification pass |
|  6 | Beginner     | [B] 초성을 모음 앞에 준비한다                            | ㄱ/ㄷ/ㅂ/ㅈ onset drill           | vowel onset late/early            | 6/8 pass                 |
|  7 | Beginner     | [B] ㅅ/ㅆ/ㅈ/ㅊ을 과장 없이 낸다                         | fricative/affricate phrase    | noise length 경고                   | 모음 손실 없음                 |
|  8 | Beginner     | [B] ㄴ/ㅁ/ㅇ/ㄹ로 legato를 유지한다                     | nasal/liquid phrase           | 끊김 표시                             | 3회 연속 pass               |
|  9 | Beginner     | [A] 7종성 받침을 안다                                | ㄱㄴㄷㄹㅁㅂㅇ coda map              | rule quiz                         | 90% quiz pass            |
| 10 | Beginner     | [A/B] 받침을 늦게 닫는다                              | CVC long note                 | closure too early 표시              | vowel ratio 목표           |
| 11 | Intermediate | [A/B] 받침+모음 연결을 처리한다                          | linking phrase                | 분리/연결 비교                          | 4/5 pass                 |
| 12 | Intermediate | [A] 비음화를 적용한다                                 | ㄱ/ㄷ/ㅂ + ㄴ/ㅁ phrase            | rule reminder                     | 예문 80% pass              |
| 13 | Intermediate | [A] 된소리되기를 인식한다                               | 받침 뒤 ㄱㄷㅂㅅㅈ phrase             | expected sound 표시                 | 80% pass                 |
| 14 | Intermediate | [B] 겹받침을 노래 안에서 단순화한다                         | 겹받침 lyric drill               | coda map feedback                 | 4/5 pass                 |
| 15 | Intermediate | [B/D] 자음-before-beat 전략을 쓴다                   | 느린 tempo → 원 tempo            | vowel beat alignment              | 3 tempo pass             |
| 16 | Intermediate | [B] 빠른 음절에서 모음을 잃지 않는다                        | 8분/16분 음표 lyric               | swallowed vowel 표시                | 핵심어 80%                  |
| 17 | Intermediate | [A/B] 긴 음 끝의 받침을 늦게 닫는다                       | long note + coda release      | closure timing                    | 5개 중 4개                  |
| 18 | Intermediate | [A/B] melisma에서 한 모음을 유지한다                    | 한 음절 여러 음                     | vowel color drift                 | 3회 pass                  |
| 19 | Intermediate | [C/D] 턱 effort를 낮춘다                           | same phrase effort 7→4        | self-effort 비교                    | effort 4 이하              |
| 20 | Intermediate | [C/D] 혀 effort를 낮춘다                           | ㄹ/ㄴ/ㅅ phrase release          | self-report + timing              | 통증 없음, timing 유지         |
| 21 | Advanced     | [B/C] Korean pop식 자연스러운 diction을 만든다          | mic-friendly phrase           | over-articulation 경고              | listener 핵심어 80%         |
| 22 | Advanced     | [B/C] musical theatre식 text clarity를 만든다      | spoken-intent phrase          | consonant/vowel balance           | 감정어 회수                   |
| 23 | Advanced     | [A/B] classical/art song식 legato diction을 만든다 | legato Korean phrase          | vowel line break 표시               | phrase continuity pass   |
| 24 | Advanced     | [A/B] 고음에서 모음 정체성을 유지한다                       | high pitch vowel phrase       | vowel drift + effort              | effort 5 이하              |
| 25 | Advanced     | [B/C] 작은 소리에서도 가사를 유지한다                       | soft dynamic phrase           | consonant loss 표시                 | lyric hidden 80%         |
| 26 | Advanced     | [B/D] 빠른 가사에서 받침을 과방출하지 않는다                   | fast lyric phrase             | coda burst/closure                | tempo 90% pass           |
| 27 | Advanced     | [B] 영어 CCM과 한국어 받침 차이를 구분한다                   | 같은 문장 Korean/English contrast | final release warning             | contrast quiz pass       |
| 28 | Advanced     | [A/B] 녹음 리뷰로 문제 음절을 찾는다                       | self annotation               | 앱 annotation과 비교                  | 70% 일치                   |
| 29 | Advanced     | [A/B] blind lyric test를 수행한다                  | 가사 숨기고 재청취                    | 놓친 핵심어 표시                         | 핵심어 80%                  |
| 30 | Advanced     | [B] 실제 곡 phrase에서 통합 수행한다                     | full 8–16마디 capstone          | timing/vowel/coda/listener report | 2회 연속 pass               |

---

## 8.4 Self Assessment System

앱의 self assessment는 “나는 발음을 잘했는가?”가 아니라 **“청자가 가사를 회수할 수 있는 행동을 했는가?”**를 묻습니다.

| 영역                    | 0점                   | 1점               | 2점                      | 3점                         |
| --------------------- | -------------------- | ---------------- | ----------------------- | -------------------------- |
| **Vowel Continuity**  | 모음이 거의 유지되지 않음       | 긴 음에서 자주 닫힘      | 대부분 유지되나 고음/빠른 음절에서 흔들림 | 음정 위에서 모음 핵 유지             |
| **Consonant Timing**  | 자음 때문에 beat와 모음이 무너짐 | 일부 초성/종성이 늦거나 빠름 | 대부분 안정                  | 자음이 명료하지만 모음을 방해하지 않음      |
| **Batchim Handling**  | 받침 누락/과방출 빈번         | 7종성 일부 혼동        | 대부분 규칙 적용               | 연음·비음화·된소리까지 phrase 안에서 적용 |
| **Effort**            | 통증/목 조임 있음           | effort 7 이상      | effort 4~6              | effort 0~3, 통증 없음          |
| **Listener Recovery** | 가사 없이 이해 어려움         | 핵심어 일부만 회수       | 핵심어 대부분 회수              | 문장 의미와 감정어까지 회수            |

권장 UX는 총점이 아니라 badge입니다.

* **Vowel Carrier Ready**
* **Coda Control Ready**
* **Speech-to-Song Ready**
* **Listener Verified**
* **Style Transfer Ready**

---

## 8.5 Recording Review Rubric

| 평가축            | 4 Excellent           | 3 Functional | 2 Developing      | 1 Needs Reset     | 자동/수동                    |
| -------------- | --------------------- | ------------ | ----------------- | ----------------- | ------------------------ |
| **모음 유지**      | 긴 음과 빠른 음절 모두 모음 핵 유지 | 대부분 유지       | 받침 전 모음 조기 종료     | 모음이 자음에 먹힘        | 자동 보조 + self             |
| **초성 timing**  | 모음 onset이 beat와 안정    | 일부 늦음        | 자음 준비가 늦어 가사 흐림   | beat와 단어 모두 흔들림   | 자동 보조                    |
| **받침 처리**      | 7종성·연결 규칙 자연스러움       | 일부 과방출/누락    | 받침이 모음 시간을 자주 훔침  | 영어식 release 또는 무시 | 자동 보조 + rule check       |
| **한국어 모음 구별**  | ㅓ/ㅡ/ㅢ 등 구별 안정         | 일부 혼동        | 로마자 영향이 들림        | 의미 혼동 수준          | self/listener            |
| **턱·혀 effort** | effort 낮고 명료도 유지      | 약간의 긴장       | 긴장이 명료도에 영향       | 통증/목 조임           | self, 자동 진단 금지           |
| **청취 명료도**     | 가사 없이 핵심어 회수          | 대부분 회수       | 반복 청취 필요          | 의미 회수 어려움         | listener/self blind test |
| **장르 적합성**     | 목표 스타일에 맞음            | 약간 불일치       | style과 diction 충돌 | 스타일 미정            | 수동/사용자 선택                |

---

## 8.6 App Feedback Rules: 구체 문구

| 감지 상황         | 피드백 문구                                                                  |
| ------------- | ----------------------------------------------------------------------- |
| 모음이 너무 짧음     | “이 음절은 받침이 일찍 닫혀 모음이 짧아졌습니다. 같은 음을 다시 부르되 모음을 먼저 80% 유지하고 마지막에 닫아보세요.”  |
| 초성이 늦음        | “자음은 들리지만 모음 onset이 beat보다 늦습니다. 자음을 살짝 먼저 준비하고, beat 위에는 모음이 오게 해보세요.” |
| 받침 과방출        | “한국어 받침이 영어 final consonant처럼 터져 들립니다. 폭발시키지 말고 짧게 닫아보세요.”              |
| 받침 누락         | “가사 의미를 구분하는 종성 closure가 약합니다. 소리를 크게 내기보다 닫히는 순간을 분명히 만드세요.”           |
| 연음 미처리        | “여기는 표기보다 실제 연결 소리가 중요합니다. 음절을 끊지 말고 다음 모음으로 이어보세요.”                    |
| 고음 모음 흔들림     | “고음에서 모음 색이 바뀝니다. 입을 더 크게 벌리기보다 모음 핵을 유지하며 effort를 낮춰보세요.”              |
| 턱/혀 effort 높음 | “명료도를 높이려고 힘이 들어갔습니다. 같은 phrase를 70% 볼륨, effort 4 이하로 다시 녹음하세요.”        |
| 분석 신뢰도 낮음     | “반주나 잡음 때문에 딕션 분석 신뢰도가 낮습니다. a cappella 또는 작은 반주로 다시 녹음하세요.”            |
| 안전 신호         | “통증이나 쉰소리가 있으면 오늘의 drill을 중단하세요. 증상이 반복되면 음성 전문가에게 상담하세요.”              |

---

# 9. Source Bibliography

아래 출처들을 1차·2차 근거로 사용했습니다. YouTube, 개인 블로그, 개인 코치 의견은 1차 근거로 사용하지 않았습니다.

1. **NATS / Journal of Singing — Matthew Hoch, “A Brief History of Lyric Diction Pedagogy.”** Lyric diction pedagogy의 역사, IPA, 다국어 딕션 표준화 근거. ([NATS][1])
2. **NATS / Journal of Singing — “Manual Mimicry in the Teaching and Learning of…”** 모음·자음 조음 제스처와 intelligibility 훈련 근거. 
3. **NATS Science-Informed Voice Pedagogy Resource.** acoustic analysis, consonant/vowel terminology, 불필요한 긴장 관련 용어 근거. ([NATS][18])
4. **Voice Foundation — Voice Anatomy & Physiology.** 발성·공명·조음기관 역할 근거. ([음성재단][2])
5. **NIH/NIDCD — Taking Care of Your Voice.** 성대 건강, 쉰소리, 고음 상실, 과사용, 휴식·전문가 의뢰 기준. ([청각 및 의사소통 장애 연구소][6])
6. **ASHA — Voice Disorders Practice Portal.** muscle tension dysphonia와 SLP/임상 판단 관련 근거. ([ASHA][19])
7. **ASHA — Speech Sound Disorders: Articulation and Phonology.** establishment-generalization-maintenance, self-monitoring, 말소리 평가 원칙. ([ASHA][5])
8. **Fine & Ginsborg, Frontiers in Psychology — “Making myself understood.”** sung text intelligibility의 performer/listener/environment/music 요인. ([Frontiers][7])
9. **Gregg & Scherer, Journal of Voice — “Vowel Intelligibility in Classical Singing.”** 고음·formant·vowel migration과 클래식 모음 식별 근거. ([Bowling Green State University Portal][16])
10. **Collister & Huron — “Comparison of Word Intelligibility in Spoken and Sung Phrases.”** 말과 노래의 단어 명료도 차이 근거. ([Knowledge Bank][20])
11. **Vurma et al., Interspeech 2025 — voiced consonant duration in sung recognition.** 자음 지속시간과 CV/VC 인식 관련 근거. ([ISCA Archive][8])
12. **국립국어원 — 표준 발음법 관련 자료.** 7종성, 받침, 비음화, 된소리되기 등 한국어 음운 규칙. ([국립국어원][3])
13. **Kim — Korean release/nonrelease phonetic characterization.** 한국어 종성 무파열성과 영어와의 차이 근거. ([SNU Open Repository][21])
14. **Clara N. Lee — “Adapting the IPA Systems of Korean Diction to Classical Vocal Method.”** 한국어 노래 딕션에서 IPA의 유용성과 한계. ([Claremont Scholarship][9])
15. **Sooyeon Lee — “A Study of Korean Diction for Choral Conductors.”** 로마자 표기의 한계, 한글·IPA 필요성. ([DSpace Repository][22])
16. **Jungwon Nho — “Korean Diction for Non-Korean-Speaking Singers.”** 한국어 예술가곡·IPA·한글 딕션 교육 자료. ([UNT Digital Library][23])
17. **Berklee — American Diction for Singers.** CCM/pop/rock/jazz 맥락의 영어 딕션·가사 전달 교육. ([Berklee College of Music][10])
18. **Berklee — Introduction to Classical Art Song and Lyric Diction.** IPA, 외국어 가곡, lyric diction 교육 근거. ([Berklee College of Music][12])
19. **NYU Steinhardt — Classical Voice Curriculum.** diction, repertoire, acting, movement 통합 커리큘럼 근거. ([NYU Steinhardt][24])
20. **Juilliard Vocal Arts curriculum/requirements.** English/French/German/Italian diction 요구 근거. ([Juilliard School][25])
21. **New England Conservatory — Vocal Studies courses.** lyric diction, pedagogy, language course 구조. ([New England Conservatory of Music][26])
22. **Royal Academy of Music — Vocal Studies.** language tuition, performance technique, repertoire 통합 근거. ([Royal Academy of Music][27])
23. **Mesaros & Virtanen — Automatic Recognition of Lyrics in Singing.** singing lyric recognition과 speech-to-song adaptation 한계. ([Springer][28])
24. **Gupta et al. — Automatic Pronunciation Evaluation of Singing.** forced alignment 기반 singing pronunciation evaluation 가능성. ([ISCA Archive][15])
25. **Sharma & Wang — Automatic Prediction of Song Intelligibility.** 반주·음질·vocal quality가 intelligibility에 미치는 영향과 자동 예측 연구. ([ACM Digital Library][17])
26. **MDPI Applied Sciences — Korean singing phoneme recognition.** 한국어 singing phoneme recognition의 데이터·모델 한계와 가능성. ([MDPI][4])

[1]: https://www.nats.org/_Library/JOS_On_Point/JOS-081-4-2025-419.pdf "Journal of Singing Volume 81, Number 4"
[2]: https://voicefoundation.org/health-science/voice-disorders/anatomy-physiology-of-voice-production/ "Voice Anatomy & Physiology - THE VOICE FOUNDATION"
[3]: https://www.korean.go.kr/front/onlineQna/onlineQnaView.do?mn_id=216&pageIndex=1&qna_seq=313220&searchCondition=&searchKeyword= "국립국어원"
[4]: https://www.mdpi.com/2076-3417/14/18/8532?utm_source=chatgpt.com "Phoneme Recognition in Korean Singing Voices Using ..."
[5]: https://www.asha.org/practice-portal/clinical-topics/articulation-and-phonology/?srsltid=AfmBOor7c3vLZ38iXa0SaMgsWTieN99wQ8I3N-uwAv66yuhYfU6q9o4o "Speech Sound Disorders: Articulation and Phonology"
[6]: https://www.nidcd.nih.gov/health/taking-care-your-voice "Taking Care of Your Voice | NIDCD"
[7]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2014.00809/full "Frontiers | Making myself understood: perceived factors affecting the intelligibility of sung text"
[8]: https://www.isca-archive.org/interspeech_2025/vurma25_interspeech.pdf?utm_source=chatgpt.com "The Role of Voiced Consonant Duration in Sung Vowel- ..."
[9]: https://scholarship.claremont.edu/cgu_etd/689/ "
\"Adapting the IPA Systems of Korean Diction to Classical Vocal Method: \" by Clara N. Lee
"
[10]: https://college.berklee.edu/courses/psvc-131?utm_source=chatgpt.com "American Diction for Singers"
[11]: https://telecom-paris.hal.science/hal-03255334/file/2021_Phoneme_level_lyrics_alignment_and_text-informed_singing_voice_separation.pdf?utm_source=chatgpt.com "Phoneme Level Lyrics Alignment and Text-Informed Singing ..."
[12]: https://college.berklee.edu/courses/psvc-320?utm_source=chatgpt.com "Introduction to Classical Art Song and Lyric Diction"
[13]: https://www.nats.org/_Library/JOS_On_Point/JOS-076-3-2020-273_-_Bartlett-Naismith_-_An_Investigatin_of_CCM.pdf?utm_source=chatgpt.com "An Investigation of Contemporary Commercial Music (CCM ..."
[14]: https://www.korean.go.kr/front/page/pageView.do?mn_id=95&page_id=P000102 "국립국어원"
[15]: https://www.isca-archive.org/interspeech_2018/gupta18_interspeech.pdf?utm_source=chatgpt.com "Automatic Pronunciation Evaluation of Singing"
[16]: https://profiles.bgsu.edu/en/publications/vowel-intelligibility-in-classical-singing/ "
        Vowel Intelligibility in Classical Singing
      \-  Bowling Green State University Portal"
[17]: https://dl.acm.org/doi/abs/10.1109/TASLP.2019.2955253?utm_source=chatgpt.com "Automatic Evaluation of Song Intelligibility Using Singing ..."
[18]: https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Terminology_and_Definitions_for_Science-Informed_Voice_Pedagogy.pdf "3 Terminology and Definitions FINAL.docx"
[19]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOoosMFzCfBqgofanDwXfsS6D6Dpp5Y8CyWlR4WG-WMIt3UCEoXF_ "Voice Disorders"
[20]: https://kb.osu.edu/bitstreams/46189ec4-63a2-5d0b-98e9-1567f503ca84/download "EMR000050"
[21]: https://s-space.snu.ac.kr/bitstream/10371/86108/1/3.%202241039.pdf "DBPIA-NURIMEDIA"
[22]: https://ir.ua.edu/items/c168c8fb-8c2e-4aaa-97a6-7581af578c55 "A study of Korean diction for choral conductors using the principles of the Korean writing system"
[23]: https://digital.library.unt.edu/ark%3A/67531/metadc1833493/ "Korean Diction for Non-Korean-Speaking Singers: A Study for Singing Korean Art Songs - UNT Digital Library"
[24]: https://steinhardt.nyu.edu/degree/bm-vocal-performance-classical-voice/curriculum?utm_source=chatgpt.com "Curriculum | BM, Vocal Performance: Classical Voice"
[25]: https://www.juilliard.edu/music/vocal-arts/vocal-arts-master-music?utm_source=chatgpt.com "Vocal Arts - Master of Music"
[26]: https://necmusic.smartcatalogiq.com/en/2024-2025/nec-academic-catalog-2024-2025/courses/vc-voice?utm_source=chatgpt.com "VC - Voice - New England Conservatory of Music"
[27]: https://www.ram.ac.uk/study/departments/vocal-studies?utm_source=chatgpt.com "Vocal Studies"
[28]: https://link.springer.com/article/10.1155/2010/546047?utm_source=chatgpt.com "Automatic Recognition of Lyrics in Singing - Springer Nature"
