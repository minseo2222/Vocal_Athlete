# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `6. Registration & Range #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `06-registration-range.md`

---

# 1. Executive Summary

본 설계안은 NATS·Journal of Singing·ASHA·NIDCD·Voice Foundation·Journal of Voice·대학 보컬 페다고지 과정·스마트폰 음향측정 연구 등 **29개 핵심 출처**를 비교해 도출했다.

근거 등급은 다음처럼 적용했다.

| 등급    | 의미                                             |
| ----- | ---------------------------------------------- |
| **A** | 체계적 문헌고찰, 임상 가이드라인, 검증된 측정 연구 등 강한 근거          |
| **B** | 복수 연구에서 반복 관찰되거나 교육·임상 현장에서 넓게 수용되는 합의         |
| **C** | 전문기관·전문가의 교육적 권고 또는 커리큘럼 관행                    |
| **D** | 소규모·예비 연구, 직접 비교 연구 부재, 제품 설계를 위한 추론 또는 MVP 기준 |

## 핵심 제품 결정

| 질문                                                     | 결론                                                                                                                                                                                                    | 상태·근거                                               |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| 1. Chest/Head/Mix는 어떻게 사용되는가?                          | **Chest와 Head는 사용자가 지각하는 음색·감각·기능을 설명하는 교육 용어**로 유지하되, 이를 성대의 단일 생리 상태와 동일시하지 않는다. M1/M2는 후두 진동기전 설명에 가깝다. **Mix는 고정된 제3의 레지스터가 아니라 chest-like와 head-like 특성을 연결하는 여러 coordination의 포괄어**로 취급한다.      | 합의 경향 **B**, Mix의 독립 레지스터 여부는 논쟁 **D**. ([NATS][1]) |
| 2. 무엇이 논쟁적인가?                                          | Head와 falsetto의 관계, chest/head와 M1/M2의 대응, mix의 정체, TA/CT 근육 우세, 고정 passaggio 음, 최적 vowel·exercise·진도는 합의되지 않았다.                                                                                      | 논쟁 **B–D**. ([NATS][2])                             |
| 3. 중급 공통 코어의 필수 요소                                     | 용어 불확실성 이해, robust↔light 음색 구별, 개인 전환구간 인식, 상·하행 저부하 navigation, comfortable/usable range 구분, 점진적 interval expansion, 조옮김 판단, 노력도·피로·증상에 따른 자기조절이다.                                                   | 합의 **B**                                            |
| 4. 고급 장르 트랙으로 넘길 내용                                    | Classical cover·formant/vowel 전략·secondo passaggio 최적화, belt/high belt, chest-dominant mix, intentional break/yodel, reinforced falsetto, whistle, distortion·scream·growl, 극단 음량·고음 tessitura를 분리한다. | 합의 경향 **B/C**. ([Berklee Online][3])                |
| 5. Passaggio handling을 고급으로 미루고 recognition만 가르쳐도 되는가? | **부분적으로만 타당하다.** 공통 코어는 정교한 장르별 handling을 미뤄도 되지만, recognition에서 끝내면 안 된다. 사용자가 전환 징후를 느낄 때 **음량 감소, 범위 축소, 과제 변경, 조옮김, 중단** 중 하나를 선택할 수 있어야 한다.                                                      | 조기 인식 **B/C**, 정확한 교육 시점 **D**. ([NATS][1])         |
| 6. Usable range가 maximum range보다 유리한 이유                | 한 번 도달한 최고·최저음보다 **반복 가능성, 노력도, 음질 선택 가능성, 구절 전이, 다음 날 회복**이 실제 노래와 안전에 더 직접적이다. VRP도 음역 극단에서 사용 가능한 음량 폭이 좁아짐을 보여 준다. 다만 usable range의 정확한 컷오프는 임상 표준이 아니라 제품 정의다.                                   | 원리 **A/B**, 컷오프 **D**. ([NATS][1])                  |
| 7. 스마트폰 range mapping 설계                               | 조용한 환경·고정 거리·동일 기기에서 무반주 단일 음성을 수집하고, pitch confidence·신호 품질·반복성·사용자 노력도·증상을 결합한다. 결과는 Comfortable / Usable / Exploratory / Untested와 **Transition Uncertainty Band**로 표시한다.                          | 측정 원리 **A/B**, 분류 기준 **D**. ([PubMed][4])           |
| 8. 자동 분석이 위험한 항목                                       | 질환·성대 조직 상태·안전한 발성 여부·M1/M2·mix·TA/CT balance·정확한 passaggio·Fach/voice type·피로 회복 완료·절대 SPL을 녹음만으로 판정해서는 안 된다.                                                                                        | 합의 **A/B**. ([ASHA][5])                             |

**권장 산출물은 32개 레슨의 Universal Core**다. 이 코어의 졸업 결과는 “더 높은 음을 냈다”가 아니라 다음 다섯 가지다.

1. 오늘 훈련해도 되는지 스스로 결정한다.
2. 자신의 comfortable·usable·exploratory range를 구분한다.
3. 전환구간을 하나의 고정 음이 아닌 불확실성 구간으로 인식한다.
4. 전환에서 밀어붙이지 않고 저부하 대안을 선택한다.
5. 곡의 조와 tessitura를 자신의 현재 usable range에 맞춘다.

---

# 2. Evidence Review

## 2.1 출처를 해석할 때의 주의점

NATS의 과학 기반 용어집은 현재 교육 현장에서 사용할 수 있는 공통 언어를 제공하지만, 모든 항목이 실험적으로 확정된 생리학적 사실이라는 뜻은 아니다. Journal of Singing 논문은 연구와 교육을 연결하는 데 강점이 있으나, 일부는 실험논문이 아니라 전문가 종설이다. 대학 커리큘럼은 무엇이 반복적으로 교육되는지를 보여 주지만, 특정 교육 순서가 다른 순서보다 우월함을 입증하지는 않는다. **따라서 용어집·커리큘럼을 근거 B/C로, 체계적 고찰·임상 가이드라인·측정 타당도 연구를 A/B로 분리했다.** ([NATS][1])

## 2.2 Chest / Head / Mix 학파별 비교

| 접근              | 주된 용어와 가정                                                               | 강점                                                                  | 한계와 앱 위험                                                         | 근거                                       |
| --------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------- | ---------------------------------------------------------------- | ---------------------------------------- |
| **전통 클래식 페다고지** | chest, head, middle, primo/secondo passaggio, cover                     | 사용자가 음색 변화와 레퍼토리 문제를 빠르게 이해하기 쉽다.                                   | 성별·성종별 고정 음표나 “가슴/머리에서 공명한다”는 문자적 설명으로 오해될 수 있다.                 | 교육 현장 합의 **B/C**                         |
| **후두 진동기전 접근**  | M0, M1, M2, M3; 성대 진동양식 차이                                              | chest/head의 감각 언어와 생리학을 분리할 수 있다. Roubeau 등은 네 가지 주요 후두 진동기전을 정리했다. | 스마트폰 음향만으로 M1/M2를 직접 확인할 수 없다. M1=TA, M2=CT라는 단순 근육 등식도 충분하지 않다. | 기전 **B**, 앱 추론 금지 **A/B**. ([PubMed][6]) |
| **CCM·Mix 접근**  | chest mix, head mix, balanced mix, speech mix 등                         | 현대 장르에서 사용자가 원하는 연속적 음색과 기능을 설명하기 좋다.                               | 학교별 정의가 크게 다르다. 서로 다른 coordination을 동일한 “mix”로 부를 수 있다.          | 존재·다양성 **B**, 단일 정의 **D**. ([NATS][1])   |
| **음향·지각 접근**    | robust/light, bright/dark, open/close timbre, source–filter interaction | 같은 후두기전에서도 vowel·음량·공명 전략에 따라 음색이 달라질 수 있음을 설명한다.                   | 사용자가 복잡한 음향학을 생리학적 진단처럼 받아들일 수 있다.                               | **B**. ([NATS][2])                       |
| **임상·보컬헬스 접근**  | 기능, 증상, 노력도, endurance, instrumental assessment                         | 안전 경계와 진단 권한이 명확하다.                                                 | 임상 평가는 음악적 커리큘럼이나 장르 선택을 대신하지 않는다.                               | **A**. ([ASHA][5])                       |

### 통합 해석

NATS는 mixed registration을 chest/modal과 falsetto/head의 지각적·기전적·음향적 혼합으로 설명하면서도 **별도의 후두 레지스터로 보지 않는다**. 반면 Lee 등의 2023년 연구는 연구자가 정의한 “50–50 mix”에서 chest·falsetto와 구별되는 음향·공기역학적 패턴을 보고했다. 그러나 전체 공기역학 표본은 12명, 고속영상 표본은 3명이었고, 연구 자체도 chest-dominant·head-dominant 등 여러 mix가 존재한다고 인정한다. 따라서 이 연구는 **특정 mix task가 측정 가능한 고유 configuration을 가질 수 있음**을 뒷받침하지만, 모든 mix를 하나의 보편적 제3 기전으로 분류할 근거는 아니다. **[논쟁, D]** ([NATS][1])

### 제품 용어 정책

사용자 UI에는 다음과 같이 이중 언어 체계를 적용하는 것이 안전하다.

* **Chest-like / Robust quality:** 사용자가 듣고 느끼는 결과.
* **Head-like / Light quality:** 사용자가 듣고 느끼는 결과.
* **Mixed quality / Blended coordination:** 두 특성 사이의 기능적·지각적 선택군.
* **M1/M2:** 교육용 참고 정보로만 제공하고 사용자의 녹음을 자동 분류하지 않는다.
* “당신은 M1이다” 대신 “현재 녹음은 더 robust하게 들렸다고 사용자가 표시했다”라고 표현한다.

이 정책은 생리학적 과잉주장을 피하면서도 기존 보컬 교육 언어와의 호환성을 유지한다. **[통합 설계, B/D]**

## 2.3 Passaggio 교육 시점

Passaggio는 단순히 하나의 음표에서 성대가 “바뀌는” 사건이 아니라, 음향적 또는 생리적 전환이 나타날 수 있는 구간이다. NATS 역시 passaggio를 레지스터 사이의 음향적·생리적 전환으로 정의한다. **[B]** ([NATS][1])

교육 현장에서는 registration이 비교적 이른 단계에 등장하고, 이후 acoustics·range·motor learning이 연결되는 경우가 많다. 그러나 “몇 번째 주에 passaggio를 가르쳐야 가장 안전하고 효과적인가”를 직접 비교한 강한 연구는 확인되지 않았다. **[근거 부족, D]** ([NATS][7])

따라서 다음 구분이 타당하다.

| 공통 코어에서 조기 도입                    | 고급·장르 트랙으로 연기                                     |
| -------------------------------- | ------------------------------------------------- |
| 전환 징후 알아차리기                      | 클래식 primo/secondo passaggio의 세밀한 vowel/formant 전략 |
| 전환 위치가 과제·모음·방향에 따라 달라질 수 있음을 이해 | 고음 M1-dominant belt 또는 chest-dominant mix 유지      |
| 음량·범위 줄이기                        | 장르별로 break를 숨기거나 드러내는 미학                          |
| SOVT·다른 모음·하행 접근으로 바꾸기           | 높은 tessitura에서 장시간 동일 coordination 유지             |
| 조옮김 또는 중단 결정                     | 개인별 장기 passaggio 재조직                              |

**결론:** recognition만 가르치고 아무 대응도 가르치지 않는 것은 부적절하다. **Recognition + low-load response는 공통 코어**, 예술적·생리적으로 정교한 handling은 고급 트랙이다. **[B/D]**

## 2.4 Usable range와 maximum range

VRP는 주파수와 음압의 절대 발성 능력을 나타내는 검사 개념이다. 정상적인 VRP에서는 음역 극단으로 갈수록 가능한 음량 범위가 좁아진다. 또한 VRP 연구는 유도 과제, 마이크, 측정 거리, 반복 수 등의 프로토콜 차이가 결과에 큰 영향을 줄 수 있다고 보고한다. **[A]** ([NATS][1])

따라서 앱에서 “최고음”은 다음 이유로 교육 목표가 되기 어렵다.

* 한 번 도달한 음은 반복되지 않을 수 있다.
* 정확한 음높이만 맞아도 노력도·통증·음질 제어가 나쁠 수 있다.
* glide, sustained vowel, 짧은 구절, 큰 음량에서 경계가 달라진다.
* 극단음 도전은 게임화될수록 밀어붙이기를 유발한다.
* 기기·방·알고리즘의 octave error가 “신기록”으로 저장될 수 있다.

반면 **usable range는 특정 과제와 조건에서 반복적으로 사용할 수 있는 음역**으로 정의할 수 있다. 다만 이는 확립된 임상 규준이 아니라 제품이 검증해야 할 기능적 construct다. **[원리 B, 제품 정의 D]**

권장 운영 정의는 다음과 같다.

| 영역                    | 제품 정의                                                                    |
| --------------------- | ------------------------------------------------------------------------ |
| **Comfortable Core**  | 낮은 노력도로 여러 번 반복되고, 짧은 구절에도 전이되며, 다음 날 악화가 없는 음역                          |
| **Usable Range**      | 정해진 모음·음량·과제에서 반복 가능하지만 comfortable core보다 선택 폭이나 endurance가 제한될 수 있는 음역 |
| **Exploratory Range** | 한 번 도달했거나 신호 신뢰도가 낮고, 노력도·반복성·다음 날 상태가 확인되지 않은 음                         |
| **Untested**          | 아직 평가하지 않은 영역                                                            |
| **Maximum Observed**  | 내부 연구 데이터로만 보관하고 사용자 성취 배지나 리더보드로 노출하지 않음                                |

## 2.5 Glide와 SOVT

SOVT는 성도에 부분적 폐쇄를 만들어 음원과 필터의 상호작용을 조정하는 임상·교육 과제다. Straw phonation, lip trill, /m/, /v/, /w/ 등이 이에 포함될 수 있다. **[B]** ([ASHA][8])

그러나 다음 두 가지를 구분해야 한다.

1. SOVT가 많은 사용자에게 낮은 부담의 navigation 과제가 될 수 있다는 것.
2. 모든 사용자에게 동일하게 “안전한 발성”을 보장하거나 특정 레지스터를 자동 형성한다는 것.

두 번째 주장은 근거가 부족하다. 따라서 앱은 “이 과제에서 더 편했습니까?”를 물어야 하며 “SOVT이므로 안전합니다”라고 선언하면 안 된다. 또한 SOVT에서 나온 range와 open vowel의 range를 같은 것으로 합치지 말고 **task-specific map**으로 보존해야 한다. **[B/D]**

## 2.6 Vocal fatigue와 range expansion 위험

음성 피로는 단일 음향 변수로 규정하기 어렵고, vocal demand와 그에 대한 개인의 반응을 분리해야 한다는 것이 최근 전문가 합의다. 체계적 문헌고찰에서도 사용된 생리·음향·자기보고 측정이 매우 이질적이었다. EASE 같은 자기보고 도구는 현재 singing voice 상태 변화를 포착하는 데 유용하지만 질환을 진단하지는 않는다. **[A/B]** ([PubMed][9])

범위 확장 위험은 “고음” 자체보다 다음 조합에서 커진다.

* 기존 comfortable edge 밖에서 높은 노력도와 반복 횟수가 증가할 때.
* 높은 음량·긴 지속시간·극단 tessitura가 함께 요구될 때.
* 쉰 상태, 피곤한 상태, 감염 중에 edge testing을 할 때.
* 사용자가 pitch success를 위해 과도한 adduction과 pressed production을 사용할 때.

NIDCD는 쉰 상태나 피곤한 상태에서 노래하지 않고 음역 극단을 피하도록 권고한다. Herbst는 과도한 adduction·TA-dominant 전략이 pressed voice와 충돌력 증가 위험을 낳을 수 있다고 설명한다. **[A/B]** ([NIDCD][10])

반면 “한 세션에 정확히 몇 반음까지”, “몇 회 반복하면 안전한가”, “range expansion 후 몇 시간 쉬어야 하는가”에 대한 보편적 근거는 부족하다. 앱의 수치 제한은 보수적인 **제품 안전 가설 D**로 출시 후 검증해야 한다.

## 2.7 스마트폰 측정 근거

스마트폰 녹음은 통제된 조건에서 여러 음향 변수를 추적할 수 있지만, 기기·녹음 방식·방의 음향·배경 소음에 따라 값이 달라진다. 특히 방과 배경 소음의 영향이 마이크 종류보다 클 수 있다는 연구도 있다. **[A/B]** ([PubMed][4])

Pitch tracking은 다음 오류에 취약하다.

* 약한 기본주파수.
* 낮은 신호대잡음비.
* 잔향.
* 발성 시작·끝의 transient.
* breathy·noisy·distorted production.
* 옥타브를 공유하는 배음으로 인한 octave error.
* 반주·화음이 포함된 polyphonic signal.

pYIN 같은 알고리즘은 여러 pitch candidate와 확률을 유지해 오류를 줄이고, CREPE 같은 모델도 다른 방식의 추정을 제공하지만 어떤 알고리즘도 모든 음색·환경에서 완전하지 않다. **[B]** ([EECS Webspace][11])

따라서 자동 분석의 목적은 “정답 판정”이 아니라 **신뢰도 추정과 재측정 요청**이어야 한다.

---

# 3. Consensus

다음은 비교한 출처들 사이에서 상대적으로 견고한 합의만 추린 것이다.

| 전문가 합의                                                     |      등급 | 제품 해석                                                                |
| ---------------------------------------------------------- | ------: | -------------------------------------------------------------------- |
| 레지스터는 pitch 하나만의 문제가 아니라 성대 진동, 음향, 음량, 음색, 지각이 결합된 현상이다.  |   **B** | 단일 음표에 “레지스터 정답” 라벨을 붙이지 않는다. ([NATS][2])                            |
| Chest/head 감각은 교육적으로 유용하지만 실제 소리가 가슴이나 머리에서 생성된다는 의미는 아니다. |   **B** | “가슴에 울려야 성공” 같은 센서 판정을 금지한다. ([NATS][1])                             |
| Chest-like와 head-like 음색 지각은 실제 후두기전과 완전히 일치하지 않을 수 있다.    |   **B** | 지각 라벨과 기전 라벨을 데이터 모델에서 분리한다. ([NATS][1])                             |
| Mix라는 단어는 여러 종류의 중간·혼합 coordination을 포괄한다.                 |   **B** | Mix를 단일 클래스가 아닌 사용자 목표·스펙트럼으로 표시한다. ([NATS][1])                      |
| 개인의 전환은 하나의 고정 음보다 구간으로 다루는 편이 타당하다.                       | **B/C** | `Passaggio note` 대신 `Transition uncertainty band`를 사용한다. ([NATS][1]) |
| 전환구간은 모음, 음량, 상·하행 방향, 의도한 음색에 따라 다르게 나타날 수 있다.            |   **B** | 전환 지도를 task·vowel·direction별로 저장한다. ([NATS][12])                     |
| 음역 평가는 녹음 조건과 유도 프로토콜을 표준화해야 한다.                           |   **A** | 동일 기기·거리·환경을 유지하고 기기가 바뀌면 새 baseline을 만든다. ([ASHA Publications][13]) |
| 절대 최고·최저음은 실제 노래 기능을 충분히 나타내지 않는다.                         | **A/B** | 주요 KPI를 maximum note가 아닌 repeatable usable range로 바꾼다. ([NATS][1])   |
| 음성 피로는 개인차가 크고 단일 음향 지표로 안전하게 판단할 수 없다.                    | **A/B** | acoustic trend와 사용자 자기보고를 결합하되 진단 라벨을 만들지 않는다. ([PubMed][9])         |
| 통증, 갑작스러운 음성 변화, 쉰 목소리, 고음 소실, 노력 증가 같은 증상은 성취 데이터보다 우선한다. |   **A** | 증상 입력이 있으면 edge expansion을 즉시 잠근다. ([NIDCD][10])                     |
| 녹음만으로 성대 조직과 질환을 진단할 수 없다.                                 |   **A** | 앱은 선별·교육·의뢰 안내만 하고 진단하지 않는다. ([ASHA][5])                             |
| 기초 기능과 장르별 음색·스타일 기술은 분리해 순차적으로 교육하는 편이 일반적이다.             | **B/C** | Universal Core 졸업 후 genre branch를 연다. ([Berklee Online][14])         |

---

# 4. Controversies

## 4.1 전문가 논쟁

| 논쟁                                                                | 양측 주장                                                               | 비판적 판단                                                                                     | 앱 정책                                                                  |
| ----------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| **Mix는 제3 레지스터인가?**                                               | NATS는 별도 후두 레지스터가 아니라고 본다. Lee 등은 특정 50–50 mix에서 구별되는 패턴을 보고했다.     | 후자의 표본과 과제 정의가 제한적이며 mix 변형 전체를 대표하지 않는다. **[D]**                                          | “Mix detected” 자동 라벨 금지. 사용자가 선택한 mixed-quality 목표만 기록한다. ([NATS][1]) |
| **Head voice와 falsetto는 같은가?**                                    | 어떤 전통은 성별·장르에 따라 구분하고, 다른 접근은 같은 M2 계열 용어로 본다.                      | 용어 사용의 지역·장르 차이가 크다. **[C/D]**                                                             | 온보딩에서 사용자의 기존 용어를 묻고 앱 표준 용어에 매핑한다. ([NATS][2])                       |
| **Chest=M1, Head=M2인가?**                                          | 용어집에서는 교육적 대응을 제시한다. 일부 연구는 음고가 근활성 비율에 더 큰 영향을 줄 수 있음을 보인다.        | 완전한 일대일 대응은 과도한 단순화다. **[B/D]**                                                            | 음향만으로 M1/M2를 추론하지 않는다. ([NATS][1])                                    |
| **TA가 chest, CT가 head를 만든다는 설명**                                  | 전통적 설명은 이해하기 쉽다. EMG 연구에서는 높은 음에서 label과 무관하게 CT 우세 또는 유사 활성도 가능했다. | 교육 은유로는 제한적으로 유용하지만 진단 모델로는 부족하다. **[D]**                                                  | 근육 balance 점수·애니메이션 피드백 금지. ([PubMed][15])                            |
| **Passaggio 음표는 성종별로 고정 가능한가?**                                   | 전통 표는 대표 음을 제시한다. 실제 전환은 개인·모음·방향·음량에 따라 달라진다.                      | 고정 표는 탐색 시작점 이상이 될 수 없다. **[C/D]**                                                         | 성별·voice type 기반 사전 passaggio 자동 설정 금지.                               |
| **Break는 항상 숨겨야 하는가?**                                            | 클래식·일부 팝에서는 매끄러운 연결이 목표다. yodel·country·folk·효과음에서는 break 자체가 미학이다. | 안전 문제와 장르 미학을 혼동하면 안 된다. **[B/C]**                                                         | Core는 선택권과 제어를 가르치고, 의도적 break는 장르 트랙으로 보낸다.                          |
| **SOVT가 최적의 전환 운동인가?**                                            | 흔히 효율적인 저부하 과제로 사용된다. 개인·과제별 반응과 다른 운동 대비 우월성은 일관되지 않다.             | 하나의 옵션이지 만능 처방이 아니다. **[B/D]**                                                             | lip trill이 안 되면 /m/, /v/, /w/, straw 등 대체 과제를 제공한다. ([ASHA][8])       |
| **Passaggio는 초급인가 고급인가?**                                         | 조기 인식은 자기조절에 유리하다. 세밀한 조정은 충분한 기초가 필요하다.                            | recognition과 기본 response는 조기, 장르별 optimization은 후기 배치가 가장 합리적이다. 정확한 시점 비교 근거는 없다. **[D]** | Core에서 recognition+navigation, genre track에서 detailed handling.       |
| **Range expansion은 strength training인가 coordination learning인가?** | 일부는 progressive overload로, 다른 접근은 coordination·acoustics 문제로 본다.    | 발성에는 조직 부하·운동학습·음향이 모두 관여하며 단일 체력 모델로 환원하기 어렵다. **[C/D]**                                  | 세션별 반음 목표보다 반복성·노력도·회복을 progression trigger로 사용한다.                    |

## 4.2 근거 부족

다음 항목은 현재 Universal Core의 과학적 사실로 제시하면 안 된다.

| 근거 부족 주장                               |    등급 | 제품 처리              |
| -------------------------------------- | ----: | ------------------ |
| 모든 사람에게 적용되는 정확한 chest/head 전환 음표      | **D** | 제공하지 않음            |
| 녹음만으로 “안전한 mix” 여부 판정                  | **D** | 제공하지 않음            |
| 모든 사용자에게 최적인 glide 모음 또는 자음            | **D** | 개인 반응 기반 A/B 탐색    |
| 한 세션당 안전한 확장 반음 수                      | **D** | 보수적 제품 제한 후 검증     |
| 음역이 넓을수록 보컬 기술과 건강이 우수하다는 가정           | **D** | KPI에서 제외           |
| 특정 spectral slope만으로 chest·head·mix 분류 | **D** | 연구 모드 외 사용 금지      |
| 스마트폰 loudness를 절대 dB SPL로 해석           | **D** | 캘리브레이션 없이는 상대값만 사용 |
| 앱이 추정한 vocal fatigue score로 훈련 복귀 허가   | **D** | 사용자 증상·전문가 평가 우선   |
| range만으로 Fach·voice type·성별 정체성 추론     | **D** | 금지                 |
| 고정된 휴식 시간 후 완전 회복되었다는 판정               | **D** | 다음 세션 baseline 재확인 |

---

# 5. Curriculum Design Implications

## 5.1 Curriculum Architecture

권장 구조는 **32 Lessons / 8 Blocks / 4 Lessons**다.

| 블록                                | 사용자가 할 수 있게 되는 것                               |
| --------------------------------- | ---------------------------------------------- |
| 1. Safety & Measurement Readiness | 오늘 훈련 가능 여부를 결정하고 신뢰할 수 있는 녹음을 만든다.            |
| 2. Comfortable Baseline           | 자신의 편안한 중심 음역과 경계를 반복 측정한다.                    |
| 3. Registration Literacy          | chest/head/mix 용어를 절대적 생리 라벨이 아닌 기능적 언어로 사용한다. |
| 4. Glide Navigation               | 상·하행 glide로 음색 변화 구간을 밀지 않고 통과한다.              |
| 5. Passaggio Recognition          | 개인의 전환 불확실성 구간을 찾고 기본 대응을 선택한다.                |
| 6. Controlled Expansion           | 중심에서 바깥으로 짧은 interval을 점진적으로 확장한다.             |
| 7. Functional Usable Range        | 음 하나가 아니라 구절·tessitura·조 선택에 range를 적용한다.      |
| 8. Integration & Graduation       | 지도 갱신, 자기교정, 장르 트랙 진입 여부를 결정한다.                |

### 공통 졸업 조건

다음 수치는 임상 규준이 아니라 MVP 검증용 기본값이다. **[D]**

* 통증은 항상 0이어야 한다.
* 갑작스러운 쉰 목소리·음성 소실·급격한 음역 변화가 없어야 한다.
* usable 판정 시 사용자 노력도는 기본적으로 3/10 이하여야 한다.
* 한 번의 성공으로 음을 승급시키지 않는다.
* 경계음은 서로 다른 날의 반복 자료가 있어야 한다.
* pitch·continuity 점수는 건강 판정이 아니라 과제 수행 점수로만 쓴다.
* 다음 날 고음 소실·거칠음·노력 증가가 있으면 새 경계음을 취소한다.

## 5.2 32-Lesson Module

### Lessons 1–8: Safety & Comfortable Baseline

|  L | 학습목표                                          | 훈련과제                         | 피드백                                | 졸업기준                        |      근거 |
| -: | --------------------------------------------- | ---------------------------- | ---------------------------------- | --------------------------- | ------: |
|  1 | 오늘 `Train / Reduce / Pause–Refer` 중 하나를 선택한다. | 증상 시나리오 8개와 실제 상태 체크         | 선택 결과와 위험 이유                       | Red 시나리오에서 훈련을 한 번도 선택하지 않음 |   **A** |
|  2 | 자신의 정상 speaking·singing baseline을 기록한다.       | 말하기 샘플, 쉰 느낌·통증·고음 소실·노력도 입력 | 개인 baseline 카드                     | 증상·노력도 입력을 누락 없이 2회 완료      | **A/B** |
|  3 | 재현 가능한 스마트폰 녹음 환경을 만든다.                       | 고정 거리·방향, 소음·clipping·잔향 점검  | `Capture Pass / Retake`            | 연속 2개 샘플이 품질 게이트 통과         | **A/B** |
|  4 | pitch tracker의 한계를 인식하고 오검출을 수정한다.            | 의도적 octave-error·저신뢰 샘플 비교   | 후보 음과 confidence 표시                | 예시 오류 4개 중 3개 이상 올바르게 수정    | **B/D** |
|  5 | 편안한 중간 음역 anchor를 찾는다.                        | /m/ 또는 편한 모음으로 3음 패턴         | 안정도·노력도·사용자 편안함                    | 통증 0, 노력도 ≤3, 2회 반복 가능      | **B/D** |
|  6 | comfortable low boundary를 밀지 않고 탐색한다.         | anchor에서 반음계 하행, 실패 즉시 복귀    | `Comfortable / Exploratory / Stop` | 마지막 comfortable 음을 스스로 구별   | **B/D** |
|  7 | comfortable high boundary를 밀지 않고 탐색한다.        | anchor에서 반음계 상행, 음량 증가 금지    | 경계 접근 알림과 effort prompt            | 노력도 상승 전에 중단·복귀 가능          | **A/B** |
|  8 | 음역 경계의 일간 변동을 이해한다.                           | 다른 날 동일 프로토콜 재측정             | 두 지도 overlay                       | 경계가 ±1반음 내 재현되거나 변동 이유를 기록  | **A/D** |

### Lessons 9–16: Registration Literacy & Glide Navigation

|  L | 학습목표                                      | 훈련과제                                   | 피드백                         | 졸업기준                        |      근거 |
| -: | ----------------------------------------- | -------------------------------------- | --------------------------- | --------------------------- | ------: |
|  9 | chest/head/M1/M2/mix를 서로 다른 종류의 라벨로 구분한다. | 용어 카드 분류                               | `지각·교육 용어 / 기전 용어 / 불확실 용어` | 핵심 용어 90% 이상 올바르게 분류        | **B/C** |
| 10 | robust↔light 음색을 연속체로 듣는다.                | 검증된 예시음의 상대 비교                         | 이분법 대신 slider               | 예시의 상대적 방향을 80% 이상 판별       | **B/D** |
| 11 | 편한 overlap 음에서 두 가지 음색 선택을 시도한다.          | 같은 음을 더 robust하게, 더 light하게 가볍게 탐색     | 사용자의 자기라벨과 음향 차이 시각화        | 통증 없이 두 결과가 사용자에게 구별됨       | **B/D** |
| 12 | 상행과 하행에서 접근성이 달라질 수 있음을 경험한다.             | 동일 음을 아래·위에서 접근                        | 방향별 effort·success 비교       | 더 쉬운 접근 방향을 스스로 선택          |   **B** |
| 13 | 짧은 SOVT glide를 연속적으로 수행한다.                | /m/, /v/, lip trill 중 편한 방식으로 3도 glide | pitch continuity와 신뢰도       | 양방향 2회 연속, 불편감 없음           | **B/D** |
| 14 | glide span을 개인 상태에 맞게 조절한다.               | 3도→5도 또는 유지                            | span 증가보다 continuity 우선 피드백 | span 확대 또는 유지 결정을 스스로 설명    | **B/D** |
| 15 | SOVT 결과를 open vowel에 부분 전이한다.             | SOVT glide 후 짧은 모음 glide               | 두 과제를 별도 map으로 비교           | open vowel에서 무리 없이 짧은 전이 2회 | **B/D** |
| 16 | 전환 중 밀어붙이지 않고 경로를 바꾼다.                    | 상행 실패 시 음량 감소·하행 재접근·span 축소           | 선택한 전략의 결과 비교               | 3개 실패 상황 중 3개에서 안전 대안 선택    |   **B** |

### Lessons 17–24: Passaggio Recognition & Controlled Expansion

|  L | 학습목표                                        | 훈련과제                                            | 피드백                           | 졸업기준                            |      근거 |
| -: | ------------------------------------------- | ----------------------------------------------- | ----------------------------- | ------------------------------- | ------: |
| 17 | 전환 징후와 단순 pitch miss를 구별한다.                 | timbre change·flip·effort rise·tracker error 예시 | 가능한 원인 복수 제시                  | 단일 원인으로 단정하지 않고 재측정 선택          |   **B** |
| 18 | 자신의 전환 순간을 직접 태그한다.                         | 상·하행 glide 중 화면 tap                             | 음향 이벤트와 사용자 태그 overlay        | 두 번의 glide에서 유사 구간 태그           | **B/D** |
| 19 | 하나의 passaggio 음이 아닌 불확실성 band를 만든다.         | 두 모음·두 방향·두 과제 비교                               | 겹치는 확률 구간 표시                  | 최소 2개 과제에서 band 근거 확보           | **B/D** |
| 20 | 전환 징후에 대한 기본 대응을 자동화한다.                     | `Reduce / Change task / Transpose / Stop` 시뮬레이션 | 안전 우선 순위 피드백                  | 4개 상황 모두 적절한 대응 선택              | **A/B** |
| 21 | 중심 음역에서 3음 interval을 안정화한다.                 | 1–2–3–2–1 패턴을 중심에서 시작                           | 정확도보다 effort·repeatability 우선 | 연속 3키에서 통증 0, 노력도 ≤3            | **B/D** |
| 22 | 5음 interval로 범위를 확장한다.                      | 1–2–3–4–5–4–3–2–1                               | 음역 edge 접근 알림                 | 기존 usable 범위 내 3회 안정 수행         | **B/D** |
| 23 | 새 high candidate를 탐색하되 바로 usable로 승급하지 않는다. | 기존 edge 위 한 음만 저부하 과제로 테스트                      | `Candidate—Not Yet Usable`    | 두 날에 3/4 성공, 노력도 ≤3, 다음 날 악화 없음 |   **D** |
| 24 | 새 low candidate를 같은 원칙으로 탐색한다.              | 기존 low edge 아래 한 음만 테스트                         | fry·tracker error 가능성 경고      | 두 날 반복과 사용자 확인 후에만 승급           |   **D** |

### Lessons 25–32: Functional Range & Graduation

|  L | 학습목표                                           | 훈련과제                                            | 피드백                           | 졸업기준                         |      근거 |
| -: | ---------------------------------------------- | ----------------------------------------------- | ----------------------------- | ---------------------------- | ------: |
| 25 | 단일 음 도달과 usable sustain을 구별한다.                 | 각 음을 짧게 유지하는 과제                                 | 안정 구간·저신뢰 구간 표시               | 지정 시간 약 1.5초를 2회 안정 유지       | **A/D** |
| 26 | tessitura가 edge note보다 부하를 더 잘 설명할 수 있음을 이해한다. | 같은 최고음을 가진 낮은·높은 tessitura 구절 비교                | effort·반복성 비교                 | 더 지속 가능한 구절을 정확히 선택          | **B/D** |
| 27 | 세션 중·다음 날 vocal demand response를 기록한다.         | 전·후·다음 날 effort·고음 접근·거칠음 자기보고                  | 개인 변화 그래프, 진단 라벨 없음           | 악화 시 progression을 스스로 취소     | **A/B** |
| 28 | 자신의 usable range에 맞는 조를 선택한다.                  | 동일 구절을 ±1–3 semitone 조옮김                        | range occupancy·edge dwell 표시 | 3개 구절에서 지속 가능한 조 선택          | **B/D** |
| 29 | overlap zone에서 두 음색 옵션을 선택한다.                  | 동일 짧은 구절을 robust/light 옵션으로 수행                  | 사용자 선호·노력도·반복성                | 두 옵션 중 기능적으로 적합한 것을 설명       | **B/D** |
| 30 | 장르 중립적 구절에서 전환을 관리한다.                          | 중간 음역에서 상·하행하는 무가사 또는 중립 음절 구절                  | transition band와 전략 로그        | 밀어붙이지 않고 2회 완주               | **B/D** |
| 31 | 잘못된 자동 분석을 교정하고 지도를 갱신한다.                      | octave error·소음·의도적 break가 포함된 세션 검토            | `Accept / Correct / Discard`  | 오류 샘플을 usable range에 포함하지 않음 |   **B** |
| 32 | 독립적으로 안전한 range session을 완성한다.                 | readiness→capture→map→phrase→recovery plan 전 과정 | 최종 competency dashboard       | 아래 모듈 졸업기준 전부 충족             | **A–D** |

## 5.3 중급 공통 코어와 고급 장르 트랙의 경계

| Universal Intermediate Core      | Advanced Genre Track                          |
| -------------------------------- | --------------------------------------------- |
| chest/head/mix 용어의 불확실성 이해       | 특정 학교의 mix definition 숙달                      |
| robust/light 음색 지각               | chest-dominant·head-dominant mix의 장르별 미세 조정   |
| transition band 인식               | primo/secondo passaggio의 정밀한 vowel/formant 계획 |
| 짧은 저부하 glide와 양방향 접근             | 고음 장시간 유지와 공연 수준 endurance                    |
| 기본 unload·transpose·stop 전략      | belt/high belt 및 고강도 speech-like singing      |
| comfortable/usable range mapping | classical cover, singer’s formant 관련 전략       |
| 짧은 interval expansion            | intentional yodel·flip·reinforced falsetto    |
| 조와 tessitura 선택                  | distortion, scream, growl, whistle, 극단 fry    |
| 피로·증상 자기조절                       | 부상·수술 후 return-to-performance                 |

---

# 6. App Implementation Implications

## 6.1 Range Map UX

### 권장 화면 구조

**가로축:** 음명 또는 cents 기반 pitch
**세로 레이어:** 과제·모음·방향·상대 음량
**시간축:** 오늘 지도와 개인 baseline 비교

| UX 요소                       | 표시 방식                              | 의미                | 금지되는 해석            |
| --------------------------- | ---------------------------------- | ----------------- | ------------------ |
| Comfortable Core            | 단단한 내부 band                        | 낮은 노력·높은 반복성      | “해부학적으로 이상적인 음역”   |
| Usable Range                | Comfortable 바깥의 중간 band            | 특정 과제에서 반복 가능     | “항상 공연 가능한 음역”     |
| Exploratory                 | 점선·개별 점                            | 한 번 도달 또는 검증 부족   | “확장 성공”            |
| Untested                    | 빈 영역                               | 데이터 없음            | “부를 수 없음”          |
| Transition Uncertainty Band | 음영 처리된 구간                          | 여러 과제에서 변화가 모인 영역 | “확정 passaggio”     |
| Confidence badge            | High / Medium / Low                | 신호 품질·알고리즘 합의·반복성 | “보컬 건강 점수”         |
| Task chips                  | `/m/`, vowel, glide, scale, phrase | 과제별 지도 필터         | 과제 간 range를 무조건 합침 |
| Daily overlay               | 오늘 vs 개인 baseline                  | 일간 변동             | 타인·성종 평균과 경쟁       |
| Key Fit                     | 곡의 음역·tessitura overlay            | 조옮김 의사결정          | 자동 voice type 판정   |

### Transition Band 생성

전환 band는 다음 이벤트의 **확률적 중첩**으로 생성한다.

* 사용자가 직접 태그한 timbre·effort 변화.
* 상·하행 glide에서 반복되는 pitch discontinuity.
* 동일 구간에서 pitch confidence가 떨어지는 현상.
* 모음이나 과제를 바꿨을 때 변화가 사라지는지 여부.
* robust/light 선택이 어려워지는 구간.

중요한 제한은 다음과 같다.

* pitch discontinuity만으로 passaggio라고 판정하지 않는다.
* tracker octave error, 의도적 break, 호흡 재시작, 소음 가능성을 먼저 검사한다.
* band는 음 하나보다 넓게 나타날 수 있고 세션마다 이동할 수 있다.
* 앱 문구는 “전환 가능성이 반복된 구간”이어야 하며 “당신의 secondo passaggio는 F♯4”라고 말해서는 안 된다.

## 6.2 분석 파이프라인

```text
Readiness Gate
→ Capture Quality Check
→ Monophonic Segmentation
→ 복수 F0 추정기와 후보 확률
→ Octave-error / clipping / noise / reverb 검사
→ 사용자 확인
→ 과제별 pitch event 저장
→ 노력도·증상·반복성 결합
→ Comfortable / Usable / Exploratory 분류
→ 다음 날 recovery 확인 후 지도 확정
```

### 최소 데이터 모델

| 필드                                                           | 용도                 |
| ------------------------------------------------------------ | ------------------ |
| `device_id`, OS, microphone route                            | 기기 변경 감지           |
| source–mic 거리·방향 프로토콜 버전                                     | 재현성                |
| room noise, clipping, reverb proxy                           | capture confidence |
| F0 candidate, probability, octave alternatives               | pitch 추정           |
| note, cents deviation, duration, voiced continuity           | 수행 피드백             |
| task, vowel, direction, interval span                        | task-specific map  |
| relative amplitude                                           | 동일 세션 내 변화만 비교     |
| user effort, discomfort, dryness, hoarseness, high-note loss | 안전·피로 자기보고         |
| user label: robust/light/mixed/uncertain                     | 지각 데이터             |
| next-day response                                            | candidate 승급·취소    |
| algorithm version                                            | 모델 업데이트 후 재현성      |

## 6.3 스마트폰 기반 매핑 프로토콜

1. **Pre-check:** 통증·쉰 느낌·감염·갑작스러운 음역 변화·피로 확인.
2. **Capture check:** 반주 없이 말하기와 중간음 샘플을 녹음.
3. **Anchor:** 편한 중간음에서 /m/ 또는 모음.
4. **Comfortable map:** 중심에서 아래·위로 짧게 이동.
5. **Glide map:** 상행과 하행을 별도로 수집.
6. **Vowel comparison:** 최소 두 과제의 지도를 별도로 저장.
7. **Transition tagging:** 사용자가 느낀 변화를 직접 표시.
8. **Phrase transfer:** 짧은 장르 중립적 구절에 적용.
9. **Recovery check:** 세션 직후 및 다음 날 상태 입력.
10. **Map promotion:** 반복 자료가 확인된 음만 usable로 승급.

## 6.4 앱이 자동으로 피드백해도 되는 것

| 자동화 수준     | 항목                                                                                                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **허용**     | pitch candidate, note duration, pitch continuity, clipping, background noise, 음성/무성 구간, 반복성, 상·하행 방향, 동일 기기 내 상대 진폭 변화                                                          |
| **조건부 허용** | “전환 후보”, “오늘 baseline과 다른 패턴”, “effort를 다시 확인하세요”, “재측정이 필요합니다”                                                                                                                 |
| **금지**     | 병리 진단, 성대 부종·결절·출혈·흉터 판정, muscle tension dysphonia 판정, M1/M2 판정, mix 인증, 안전한 placement 판정, TA/CT 균형 판정, 정확한 passaggio 음 판정, Fach·voice type·성별 추론, fatigue clearance, 절대 SPL 판정 |

ASHA는 청지각적 음질만으로 장애의 중증도나 원인을 항상 판단할 수 없으며, 포괄적 평가는 임상·기기 평가를 포함해야 한다고 명시한다. **[A]** ([ASHA][5])

## 6.5 특히 위험한 자동 분석

### 1. Spectral feature 기반 register classifier

모음·음량·마이크·방·공명 전략이 spectrum을 바꾸므로, 분류기가 실제 후두기전이 아니라 녹음 조건이나 장르를 학습할 가능성이 높다. 연구용 feature로 저장할 수는 있지만 사용자에게 생리 라벨로 반환해서는 안 된다. **[B/D]**

### 2. “안전 점수”

pitch accuracy와 smoothness가 높아도 과도한 effort가 존재할 수 있다. 반대로 의도적 yodel이나 stylistic break는 건강한데 낮은 점수를 받을 수 있다. 따라서 하나의 `Vocal Safety Score`를 만들지 않는다. **[A/B]**

### 3. 최대음 자동 progression

최고음 도달만으로 다음 반음을 unlock하면 tracker 오류·과도한 음량·일시적 성공을 보상한다. Unlock 조건은 반복성, 노력도, 사용자 증상, 다음 날 반응을 모두 통과해야 한다. **[B/D]**

### 4. Fatigue detection

앱은 “피로가 있다”고 진단하는 대신 다음처럼 표현해야 한다.

> 오늘의 자기보고 노력도와 고음 접근성이 개인 baseline보다 변했습니다. 범위 확장 대신 휴식 또는 비발성 학습을 선택하십시오.

이는 진단이 아니라 변화 탐지다. **[A/B]**

---

# 7. Safety Considerations

## 7.1 세 단계 안전 상태

| 상태                         | 조건 예시                                                      | 앱 행동                                     |
| -------------------------- | ---------------------------------------------------------- | ---------------------------------------- |
| **Train**                  | 통증 없음, 평소 speaking voice, 갑작스러운 변화 없음, effort가 baseline 수준 | 현재 comfortable/usable 범위에서 훈련            |
| **Reduce / Pause**         | 피곤함, 감염·감기, 가벼운 쉰 느낌, 평소 되던 고음 소실, effort 증가               | edge testing 잠금; 용어·청음·조옮김 같은 비고강도 학습 제공 |
| **Stop / Seek Evaluation** | 통증, 갑작스러운 음성 소실, 격한 발성 직후 급성 쉰 목소리, 호흡·삼킴 문제, 급격한 음역 변화    | 발성 중단 및 의료 평가 안내                         |

NIDCD는 쉰 상태나 피곤한 상태에서 노래하지 않고 음역 극단을 피하도록 권고한다. 격한 발성 중 갑작스러운 음성 소실은 성대출혈 가능성이 있어 즉시 총체적 음성 휴식과 진료가 필요할 수 있다. **[A]** ([NIDCD][10])

Voice Foundation도 격한 음성 사용 후 수분에서 하루 이내 갑작스러운 쉰 목소리가 나타나는 경우 출혈 가능성을 경고한다. **[A]** ([Voice Foundation][16])

지속되는 dysphonia는 앱 훈련으로 교정하려 하지 말고 이비인후과·후두 전문의와 음성 전문 SLP 평가를 안내해야 한다. 임상 가이드라인은 증상이 4주 내 호전되지 않으면 후두 관찰 또는 의뢰를 권고하며, 전문 음성 사용자나 red flag가 있으면 더 이른 평가가 타당하다. **[A]** ([AAO-HNS][17])

## 7.2 Safety Rules

1. **통증은 정상 훈련 신호가 아니다.** 즉시 발성을 중단한다. **[A]**
2. 쉰 상태·피곤한 상태·감염 중에는 range edge를 테스트하지 않는다. **[A]**
3. 고음·저음 성공을 위해 음량을 자동으로 높이라는 피드백을 제공하지 않는다. **[A/B]**
4. 사용자가 연속 두 번 effort 상승을 보고하면 해당 세션의 edge progression을 잠근다. **[제품 기본값 D]**
5. 새로운 edge note는 같은 날의 한 번 성공으로 usable에 포함하지 않는다. **[D]**
6. 다음 날 평소 고음 소실·거칠음·effort 증가가 있으면 이전 세션의 새 edge를 취소한다. **[B/D]**
7. 최대음 기록·리더보드·친구 비교·연속 신기록 보상을 사용하지 않는다. **[안전 설계 D]**
8. 반주가 섞인 녹음, 잔향이 큰 방, clipping 샘플에서는 range 판정을 하지 않는다. **[A/B]**
9. 기기가 바뀌면 기존 절대 loudness와 직접 비교하지 않는다. **[A/B]**
10. 앱은 치료·재활·return-to-sing 결정을 내리지 않는다. **[A]**

## 7.3 High Risk Skills To Gate

아래 기술은 반드시 해롭다는 뜻이 아니다. **높은 부하, 전문적 미세조정, 스마트폰의 해석 불확실성 때문에 무감독 Universal Core에서 잠가야 한다는 뜻**이다.

| Gate 대상                                       | 위험 또는 불확실성                                          | 권장 해제 조건                            |
| --------------------------------------------- | --------------------------------------------------- | ----------------------------------- |
| High belt·고음 M1-dominant production           | 높은 음고·음량·adduction이 결합될 수 있음                        | Core 졸업 + 장르 전문 트랙 또는 전문가 지도        |
| 장시간 높은 tessitura                              | edge note보다 누적 vocal demand가 큼                      | phrase endurance 평가와 회복 모니터링        |
| Extreme soft/loud at range edge               | 음역 극단에서 dynamic margin이 좁음                          | calibrated 환경 또는 전문가 피드백            |
| Distortion, scream, growl, false-fold effects | pitch tracker와 음질 classifier가 오작동하고 조직 사용을 추론하기 어려움 | 별도 전문 과정·명확한 중단 규칙                  |
| Whistle/M3 탐색                                 | tracker octave error와 무리한 접근 위험                     | 고급 트랙, 최대음 게임화 금지                   |
| Extreme fry/M0를 low range 성취로 사용              | speech fry·tracker error·기전 혼동                      | 교육 목적 명확화, usable singing range와 분리 |
| 빠른 yodel·intentional break                    | 반드시 위험하지 않지만 앱이 실패와 의도를 구분하기 어려움                    | 장르 트랙에서 사용자 의도 태그                   |
| 고음 edge에서 messa di voce·극단 dynamic 변화         | range·pressure·closure 요구가 복합적                      | 전문 지도                               |
| 부상·수술·질환 후 return-to-sing                     | 의학적 상태를 앱이 판정할 수 없음                                 | 후두 전문의·음성 전문 SLP clearance          |
| 지속적인 쉰 목소리를 가진 사용자                            | 구조적·염증성·신경학적 원인 가능                                  | 임상 평가 후 사용 범위 결정                    |

---

# 8. Recommended Framework

## 8.1 Universal Registration & Range Framework

권장 제품 구조는 다음 다섯 층으로 구성한다.

### Layer 1 — State Gate

모든 발성 과제보다 먼저 사용자의 오늘 상태를 확인한다.

`Train → Reduce → Pause/Refer`

증상 게이트는 어떤 gamification이나 학습 streak보다 우선한다.

### Layer 2 — Perceptual Literacy

사용자는 chest/head/mix를 “정답 생리 상태”가 아니라 **소리·감각·기능을 대화하기 위한 언어**로 배운다.

주요 학습결과:

* robust와 light를 상대적으로 구별한다.
* 자신의 표현과 앱 표준 표현을 연결한다.
* uncertainty를 정상적인 정보로 받아들인다.
* tracker 결과와 자신의 감각이 다를 때 재측정한다.

### Layer 3 — Low-Load Navigation

사용자는 전환을 제거하려 하지 않고 여러 경로를 탐색한다.

* 상행과 하행.
* SOVT와 open vowel.
* 짧은 glide와 discrete interval.
* 음량 감소.
* span 축소.
* 조옮김.
* 중단.

### Layer 4 — Task-Specific Functional Map

하나의 “내 음역” 숫자가 아니라 다음 지도를 보유한다.

* SOVT glide map.
* Open-vowel glide map.
* Sustained-note map.
* Short-phrase map.
* Comfortable core.
* Usable band.
* Transition uncertainty band.
* Recovery-qualified edge.

### Layer 5 — Genre Gate

Universal Core 졸업 후 사용자 목표에 따라 분기한다.

| 트랙                  | 주요 registration 과제                                                      |
| ------------------- | ----------------------------------------------------------------------- |
| Classical           | cover, vowel migration/modification, passaggio zones, sustained legato  |
| Pop/Musical Theatre | speech-like registration, chest/head-dominant mix, belt                 |
| R&B/Gospel          | reinforced falsetto, registration contrast, agility through transitions |
| Folk/Country        | intentional break, yodel-like transitions                               |
| Rock/Metal          | distortion·high-load effects, 전문 안전 프로토콜                                |
| Choral              | blend·dynamic range·section tessitura·self-to-other balance             |

## 8.2 모듈 최종 Graduation Criteria

다음 기준은 Universal Core를 통과해 고급 장르 트랙으로 갈 수 있는지를 판단한다.

| 역량                           | 졸업기준                                                       |
| ---------------------------- | ---------------------------------------------------------- |
| **Safety Decision**          | 통증·급성 변화·쉰 상태가 있는 시나리오에서 훈련을 선택하지 않는다.                     |
| **Measurement Literacy**     | clipping·소음·octave error·반주 포함 샘플을 식별하고 폐기한다.              |
| **Terminology Literacy**     | chest/head/mix와 M1/M2의 차이를 설명하고 mix를 단일 제3 레지스터로 단정하지 않는다. |
| **Comfortable Map**          | 서로 다른 날의 반복 자료로 comfortable low/high boundary를 보유한다.       |
| **Usable Map**               | 각 경계음에 과제·모음·방향·노력도·반복성 정보가 연결되어 있다.                       |
| **Transition Recognition**   | 자신의 전환 가능 구간을 고정 음이 아닌 uncertainty band로 표시한다.             |
| **Safe Response**            | 전환에서 reduce·change task·transpose·stop 중 적절한 전략을 선택한다.     |
| **Bidirectional Navigation** | 상행과 하행에서 각자 쉬운 접근 경로를 사용할 수 있다.                            |
| **Functional Transfer**      | 짧은 구절의 tessitura를 지도와 비교하고 적절한 조를 선택한다.                    |
| **Self-Regulation**          | 세션 후 또는 다음 날 악화가 있으면 새 edge를 취소하고 progression을 중단한다.       |
| **Uncertainty Management**   | 앱과 사용자 판단이 충돌할 때 앱 점수를 맹신하지 않고 재측정·폐기·전문가 의뢰 중 하나를 선택한다.   |

## 8.3 제품 출시 권장 순서

### MVP

* Safety readiness.
* 통제된 monophonic range mapping.
* Comfortable / Usable / Exploratory 구분.
* 사용자 effort·symptom logging.
* 동일 기기 내 longitudinal comparison.
* pitch confidence와 octave correction.
* 조옮김 추천.
* **Register classifier, voice type classifier, vocal health score는 제외.**

### V2

* 사용자 태그 기반 transition uncertainty band.
* 과제·모음·방향별 지도.
* next-day recovery loop.
* 개인별 glide 대안 추천.
* 곡 tessitura import와 key-fit 분석.

### 임상·전문 검증 이후에만 고려

* 특정 장르 registration model.
* 전문가가 검토하는 mix annotation.
* calibrated microphone 기반 VRP.
* 고급 vocal load monitoring.
* return-to-performance workflow.

## 8.4 검증해야 할 제품 연구 과제

| 검증 항목                 | 핵심 지표                                                        |
| --------------------- | ------------------------------------------------------------ |
| Range map test–retest | 경계음 차이, 과제별 재현성, 기기별 편향                                      |
| Pitch tracking        | octave error율, high/low register별 오류, noisy/breathy voice 오류 |
| Transition band       | 사용자 반복 태그와 전문가 평가의 일치도                                       |
| Usable classification | 다음 날 상태와 구절 전이 예측력                                           |
| Safety gate           | red flag 누락률을 최소화하고 불필요한 경고율 측정                              |
| UX 행동                 | maximum-note 도전보다 key selection·self-regulation을 실제로 증가시키는지  |
| 장르 공정성                | 클래식·CCM·합창·비서구적 음색에서 특정 음색이 실패로 오분류되지 않는지                    |
| 기기 공정성                | 저가·고가 스마트폰 및 유·무선 마이크에서 결과 변동                                |
| 사용자 집단                | 훈련 수준·연령·음역·언어별 차이; 성별을 생리적 proxy로 사용하지 않음                   |

**최종 권고:** Universal Vocal Core의 Registration & Range 모듈은 “레지스터를 맞히는 앱”이 아니라 **사용자가 자신의 전환과 기능적 음역을 안전하게 탐색하고, 불확실성을 관리하며, 지속 가능한 조와 과제를 선택하게 하는 시스템**이어야 한다.

---

# 9. Source Bibliography

## NATS / Journal of Singing

1. NATS, *Terminology and Definitions for Science-Informed Voice Pedagogy*. Chest/head, M0–M3, mixed registration, passaggio, VRP 정의의 핵심 전문 용어 자료. ([NATS][1])
2. Herbst, C. T. “Registers—The Snake Pit of Voice Pedagogy, Part 1: Proprioception, Perception, and Laryngeal Mechanisms.” *Journal of Singing*, 2020. 레지스터 지각·용어·기전·continuum 논의. ([NATS][2])
3. Michael, D. D. “Don’t Throw the Baby Out with the Bathwater: The Muscular Basis for Register Adjustment.” *Journal of Singing*, 2024. 후두근과 음향·공명의 통합적 해석. ([NATS][12])
4. Bigler, M., & Osborne, W. “Voice Pedagogy for the 21st Century: The Summation of Two Summits.” *Journal of Singing*, 2021. 보컬 페다고지 핵심 역량에 대한 전문가 논의. ([NATS][18])
5. NATS, *Day-by-Day One-Semester Voice Pedagogy Course Plan*. Registration, acoustics, range, motor learning의 교육 순서 참고자료. ([NATS][7])

## Register Science / Peer-Reviewed Research

6. Roubeau, B., Henrich, N., & Castellengo, M. “Laryngeal Vibratory Mechanisms: The Notion of Vocal Register Revisited.” *Journal of Voice*, 2009. M0–M3 후두 진동기전 종설. ([PubMed][6])
7. Lee, Y. et al. “Differences Among Mixed, Chest, and Falsetto Registers: A Multiparametric Study.” *Journal of Voice*, 2023. 특정 50–50 mix의 음향·공기역학·고속영상 연구. ([Kyushu University Library Collections][19])
8. Kochis-Jennings, K. A. et al. “Laryngeal Muscle Activity and Vocal Fold Adduction During Chest, Chestmix, Headmix, and Head Registers in Females.” *Journal of Voice*, 2012. ([PubMed][15])
9. Kochis-Jennings, K. A. et al. CT/TA muscle activity in chest, chestmix, headmix, and head registration, preliminary study, 2014. 단순 TA=chest, CT=head 가정의 한계를 보여 주는 소표본 연구. ([PubMed][20])
10. Cutchin, G. M. et al. “Data Collection Methods for the Voice Range Profile: A Systematic Review.” *American Journal of Speech-Language Pathology*, 2020. VRP 프로토콜 변이와 표준화 필요성. ([ASHA Publications][13])

## Vocal Demand / Fatigue

11. Hunter, E. J. et al. “Toward a Consensus Description of Vocal Effort, Vocal Load, Vocal Loading, and Vocal Fatigue.” 2020. Vocal demand와 response를 구분하는 전문가 합의. ([PubMed][9])
12. Calvache, C. et al. “Systematic Review of Literature on Vocal Demand Response: Understanding Physiology, Measurements, and Associated Factors.” 2023. 피로·부하 측정의 이질성 검토. ([Europe PMC][21])
13. Phyland, D. J. et al. “Development and Preliminary Validation of the EASE: A Tool to Measure Perceived Singing Voice Function.” 2013. 가창 상태 자기보고 도구. ([PubMed][22])

## ASHA / NIDCD / Voice Foundation / Clinical Safety

14. ASHA, *Voice Disorders Practice Portal*. 포괄적 평가, 임상 권한, 음향측정 오류, SOVT 및 치료 범위. ([ASHA][5])
15. NIDCD, *Taking Care of Your Voice*. 쉰 상태·피로 상태·음역 극단 관련 안전 권고. ([NIDCD][10])
16. NIDCD, *What Is Hoarseness?* 과사용, 일시적 쉰 목소리, 성대출혈 긴급성. ([NIDCD][23])
17. The Voice Foundation, *Symptoms of Vocal Fold Scarring*. 고음 소실, 노력 증가, 피로, pitch instability와 stroboscopy의 역할. ([Voice Foundation][24])
18. The Voice Foundation, *Symptoms of Laryngitis*. 급성 쉰 목소리와 격한 음성 사용 후 출혈 red flag. ([Voice Foundation][16])
19. AAO-HNS, *Clinical Practice Guideline: Hoarseness (Dysphonia), Update*. 지속 dysphonia와 조기 후두 평가 기준. ([AAO-HNS][17])

## Smartphone / Acoustic Measurement

20. Awan, S. N. et al. “Validity of Acoustic Measures Obtained Using Various Recording Methods.” 2024. 스마트폰 기반 음향 추적의 가능성과 조건. ([PubMed][4])
21. Bottalico, P. et al. “Reproducibility of Voice Parameters: The Effect of Room Acoustics and Microphones.” 방·배경 소음·마이크가 음성 변수에 미치는 영향. ([PMC][25])
22. Mauch, M., & Dixon, S. “pYIN: A Fundamental Frequency Estimator Using Probabilistic Threshold Distributions.” 2014. 복수 pitch candidate와 확률 기반 추정. ([EECS Webspace][11])
23. Kim, J. W. et al. “CREPE: A Convolutional Representation for Pitch Estimation.” 2018. 데이터 기반 monophonic pitch estimation. ([arXiv][26])
24. Beauchamp, J. W. “Fundamental Frequency Estimation of Musical Signals Using a Two-Way Mismatch Procedure.” Octave error, 낮은 SNR, 잔향, 약한 F0의 문제. ([Beauchamp Computer Music Project][27])

## University / Conservatory Curriculum Sources

25. Berklee Online, *Voice Technique 101*. 건강한 습관, range·control·지속 가능한 practice를 기초 수준에 배치. ([Berklee Online][14])
26. Berklee Online, *Voice Advanced Professional Certificate*. 기초 technique 이후 range expansion과 장르별 skill을 분리. ([Berklee Online][3])
27. Berklee Online, *Popular Singing Styles: Developing Your Sound*. Mix, belt, register, key choice를 중급 장르·스타일 과정으로 배치. ([Berklee Online][28])
28. NYU Steinhardt, Vocal Performance / Advanced Certificate in Vocal Pedagogy Curriculum. Pedagogy research·practice, singing voice care, advanced coaching의 분리. ([NYU Steinhardt][29])
29. Shenandoah Conservatory, Voice Pedagogy Programs. 생리학·음향학·motor learning·cognitive science와 classical/CCM 분기. ([Shenandoah University][30])
30. Boston Conservatory at Berklee, MM in Vocal Pedagogy. Anatomy·physiology·comparative pedagogy·clinical collaboration·장르별 training 통합. ([Boston Conservatory][31])

[1]: https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Terminology_and_Definitions_for_Science-Informed_Voice_Pedagogy.pdf "https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Terminology_and_Definitions_for_Science-Informed_Voice_Pedagogy.pdf"
[2]: https://www.nats.org/_Library/JOS_On_Point/JOS-077-02-2020-175.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-077-02-2020-175.pdf"
[3]: https://online.berklee.edu/certificates/voice-advanced-professional "https://online.berklee.edu/certificates/voice-advanced-professional"
[4]: https://pubmed.ncbi.nlm.nih.gov/38749007/ "https://pubmed.ncbi.nlm.nih.gov/38749007/"
[5]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOor3rPwDftoEvpZCzmPj_4USj436c3fXQ8o_idy46fTVYPEiUXUM "https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOor3rPwDftoEvpZCzmPj_4USj436c3fXQ8o_idy46fTVYPEiUXUM"
[6]: https://pubmed.ncbi.nlm.nih.gov/18538982/ "https://pubmed.ncbi.nlm.nih.gov/18538982/"
[7]: https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Day_by_Day_1_semester_Course_Plan_Multiple_Suggested_Resources_by_Topic.pdf "https://www.nats.org/_Library/Science_Informed_Voice_Pedagogy_Resource/Day_by_Day_1_semester_Course_Plan_Multiple_Suggested_Resources_by_Topic.pdf"
[8]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOophnmBauA7k68gaWOljGf66DCQ2xc123_OeDrtmyEXhkQz3V-Y8 "https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOophnmBauA7k68gaWOljGf66DCQ2xc123_OeDrtmyEXhkQz3V-Y8"
[9]: https://pubmed.ncbi.nlm.nih.gov/32078404/ "https://pubmed.ncbi.nlm.nih.gov/32078404/"
[10]: https://www.nidcd.nih.gov/health/taking-care-your-voice "https://www.nidcd.nih.gov/health/taking-care-your-voice"
[11]: https://webspace.eecs.qmul.ac.uk/s.e.dixon/pub/2014/MauchDixon-PYIN-ICASSP2014.pdf "https://webspace.eecs.qmul.ac.uk/s.e.dixon/pub/2014/MauchDixon-PYIN-ICASSP2014.pdf"
[12]: https://www.nats.org/_Library/JOS_On_Point/JOS-080-5-2024-543.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-080-5-2024-543.pdf"
[13]: https://pubs.asha.org/doi/10.1044/2020_AJSLP-20-00023 "https://pubs.asha.org/doi/10.1044/2020_AJSLP-20-00023"
[14]: https://online.berklee.edu/courses/voice-technique-101 "https://online.berklee.edu/courses/voice-technique-101"
[15]: https://pubmed.ncbi.nlm.nih.gov/21596521/ "https://pubmed.ncbi.nlm.nih.gov/21596521/"
[16]: https://voicefoundation.org/health-science/voice-disorders/voice-disorders/laryngitis/symptoms-of-laryngitis/ "https://voicefoundation.org/health-science/voice-disorders/voice-disorders/laryngitis/symptoms-of-laryngitis/"
[17]: https://www.entnet.org/resource/aao-hnsf-updated-cpg-hoarseness-press-release-fact-sheet/ "https://www.entnet.org/resource/aao-hnsf-updated-cpg-hoarseness-press-release-fact-sheet/"
[18]: https://www.nats.org/_Library/JOS_On_Point/JOS-078-01-2021-11.pdf "https://www.nats.org/_Library/JOS_On_Point/JOS-078-01-2021-11.pdf"
[19]: https://catalog.lib.kyushu-u.ac.jp/opac_download_md/4772304/med3508.pdf "https://catalog.lib.kyushu-u.ac.jp/opac_download_md/4772304/med3508.pdf"
[20]: https://pubmed.ncbi.nlm.nih.gov/24856144/ "https://pubmed.ncbi.nlm.nih.gov/24856144/"
[21]: https://europepmc.org/article/pmc/pmc10972624 "https://europepmc.org/article/pmc/pmc10972624"
[22]: https://pubmed.ncbi.nlm.nih.gov/23583205/ "https://pubmed.ncbi.nlm.nih.gov/23583205/"
[23]: https://www.nidcd.nih.gov/health/hoarseness "https://www.nidcd.nih.gov/health/hoarseness"
[24]: https://voicefoundation.org/health-science/voice-disorders/voice-disorders/vocal-fold-scarring/symptoms-of-vocal-scarring/ "https://voicefoundation.org/health-science/voice-disorders/voice-disorders/vocal-fold-scarring/symptoms-of-vocal-scarring/"
[25]: https://pmc.ncbi.nlm.nih.gov/articles/PMC6529301/ "https://pmc.ncbi.nlm.nih.gov/articles/PMC6529301/"
[26]: https://arxiv.org/abs/1802.06182 "https://arxiv.org/abs/1802.06182"
[27]: https://cmp.ischool.illinois.edu/beaucham/papers/JASA.04.94.pdf "https://cmp.ischool.illinois.edu/beaucham/papers/JASA.04.94.pdf"
[28]: https://online.berklee.edu/courses/popular-singing-styles-developing-your-sound "https://online.berklee.edu/courses/popular-singing-styles-developing-your-sound"
[29]: https://steinhardt.nyu.edu/degree/mm-classical-voice-advanced-certificate-vocal-pedagogy/curriculum "https://steinhardt.nyu.edu/degree/mm-classical-voice-advanced-certificate-vocal-pedagogy/curriculum"
[30]: https://www.su.edu/conservatory/areas-of-study/pedagogy-voice/ "https://www.su.edu/conservatory/areas-of-study/pedagogy-voice/"
[31]: https://bostonconservatory.berklee.edu/vocal-pedagogy/mm-vocal-pedagogy "https://bostonconservatory.berklee.edu/vocal-pedagogy/mm-vocal-pedagogy"
