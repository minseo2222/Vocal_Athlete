# 인용 무결성 감사 (CITATION-AUDIT)

> goal: 수집 정보 정밀 검증. CITATIONS.md 각 키를 웹 1차 출처와 대조해 4등급 분류.
> **VERIFIED**(메타+요약 확인) / **PARTIAL**(메타만, 본문 claim 미확인) /
> **REFUTED**(불일치·오귀속·연도/저널 오류) / **UNVERIFIABLE**(유료·죽은 링크·부재).
> 정직 규칙: 유료 본문 미확인=PARTIAL, 검증된 척 금지. 환각·오귀속 최우선 색출.

---

## §A 손상역학 (Wave 1) — V1

| 키 | 등급 | 근거 |
|---|---|---|
| **BRETL2023** | **PARTIAL ⚠️정정** | 논문 실재(Laryngoscope lary.30533, 2023, 3장르 종단). 단 요약 수치 **"뮤지컬 39%" 오류** — 원 출처는 *1년차 유병률* MT 32–40%·CCM 17–18%·클래식 0%, *발생률(incidence)* MT 67%·클래식 22%·CCM 27%. 39%는 어느 시점에도 없음. 22%(클래식 incidence)·27%(CCM incidence)는 일치. **정정**: "뮤지컬 39%"→"뮤지컬 1년차 32–40%/발생률 67%". 안전 방향(MT 최고)은 유지·강화 |
| **CHILDS2023** | PARTIAL | 논문 실재(Laryngoscope lary.30414, 2023, genre×phonotrauma). 본문 수치 미확인(유료). 요약(컨트리·복음·재즈·MT phonotrauma 우세, 오페라 pseudocyst) 방향 타당 |
| **PESTANA2017** | **VERIFIED** | J Voice 31(6):722-727, 2017. 메타분석 11편, 평균 유병률 **46%** 확인. 저자·연도·저널·수치 일치 |
| **SIELSKA2024** | **REFUTED(오귀속) ⚠️정정** | 2024 Frontiers Public Health 논문(PMC11133608) 실재하나 "22% 결절" finding은 *Sielska-Badurek 2018 J Voice*(n=45, 10명=22% 결절, S0892199717302564) 소관. 2024 논문은 인구특성·자가평가. **정정**: SIELSKA2024 → 결절 22%는 SIELSKA2018(J Voice)로 키 분리·재귀속. 22% 수치 자체는 실재 |
| **LECHIEN2021** | **REFUTED(오귀속) ⚠️정정** | 논문 실재(pubmed 33270237)하나 **1저자 = Rotsides, J**(Lechien 아님), **저널 = The Laryngoscope**(lary.29303, "J Voice" 아님). 키→ROTSIDES2021/Laryngoscope. 팝 63.2% 등 수치 유료 미확인. 안전 방향(팝·전문 고위험) 유지 |
| BEHLAU2021 | PARTIAL | J Voice, "부하 단독≠병리" 라인 — 사이언스다이렉트 S0892199721000084 존재(검색 기반). 본문 미확인 |
| NAYAK2025·SCHWARZ2025·DEVADAS·PARK_BEHLAU2018·DIETRICH2022·SALTURK2017·GUNJAWATE2024·PAWELCZYK2022·TOLES2025·GALINDO2023 | PARTIAL(미개별검증) | 실재 가능 저널·서지 형식 정상. 안전·핵심 수치 아닌 보조 역학 → 개별 웹대조 미실시(정직 표기). V6에서 안전 관련분만 재확인 |

### ⚠️ 영향 전파 (BRETL2023·SIELSKA 정정)
- **D 중급뮤지컬 VERIFICATION/SOURCES**: "뮤지컬 부상률 39% 최고" → "1년차 32–40%/발생률 67% 최고"로 정정 필요(방향 동일, 수치 상향 = 보수성 강화).
- **F 가요 SOURCES/VERIFICATION**: "SIELSKA2024 22%" → "SIELSKA2018 22%(CCM 학생 결절)" 재귀속.
- **안전 claim 영향**: belt 보수화 결정은 *강화*됨(MT 실제 위험 39%가 아니라 67%). REFUTED 아님.

---

## §C 공명·믹스·트웽 + §D 자기모니터링·AI·도구 — V2

| 키 | 등급 | 근거 |
|---|---|---|
| **GIBIAT2024** | **REFUTED(저자 오기) ⚠️정정** | 논문 실재(J Voice 2024, pubmed 38964963, URL 일치, 트웽 MRI 협착 18.8–52.4%)하나 **1저자 = Jelinger, J**(Gibiat 아님). 키→JELINGER2024. 트웽=구강·AES 협착 *내용 확정* → IC-10·IM-02·GY-04 트웽 cue 근거 유지(저자만 정정) |
| **CHAN_DO2021** | **VERIFIED** | Chan, M.P.Y. & Do, Y. (2021), Music & Science, DOI 10.1177/20592043211055168. 소프라노 모음조정 실증. 저자·저널·내용 일치. CL-02·IC-07 근거 견고 |
| LEHOUX2024·SAUNDERS2018 | PARTIAL(미개별검증) | 서지 형식 정상 |
| **NAIR2023PNAS** | **REFUTED(저자 오기) ⚠️정정** | 논문 실재(PNAS 2023, DOI 10.1073/pnas.2219394120, pubmed 36802437, 스킨 웨어러블 음성피로)하나 **1저자 = Jeong, H**(Nair 아님; ADS 키 …J). 키→JEONG2023. 내용 확정 |
| **MANFREDI2017** | **REFUTED(오귀속+프레이밍 의심) ⚠️정정** | 실제 **Grillo, E.U. et al. (2016)**, *Int J Telerehabilitation* 8(2):9-14, PMC5536725 — "Manfredi 2017" 아님. **게다가 원문 결론은 "스마트폰이 within-subject 음성 추적에 적절"** → CITATIONS "마이크 정확도 *한계*" 프레이밍과 상충. ADR-0014 시각전용 근거로 쓰였으나 이 인용은 틀렸고 방향 의심 |
| MOBILE2022VAL·VOX4HEALTH2018·ULOZA2023·HOSOYA2023·SMARTREV2021·CNN2025DAI·TANG2025·PSAMOS2024·VOQANET2025·SIPSURVEY2025·SVSREVIEW2025·GENMM2025·JANG_TASLP2022·SGRUEL2025·LEE2020TASLP·HU2022PITCH·NOISE2024·ROSEN2022DOSI·CHOIPARK2024·LEE2022IOS | PARTIAL(미개별검증) | AI/도구 키 다수 — arXiv·저널 서지 형식 정상. ADR-0014 피드백 설계 보조. 안전 비관여 → 개별 웹대조 보류(정직 표기). 단 MANFREDI 정정으로 ADR-0014 "마이크 한계" 근거는 *재확보 필요*(V5/V8) |

### ⚠️ 영향 전파 (§C·D)
- **ADR-0014 근거**: "컨슈머 마이크 정확도 한계(MANFREDI2017)" 인용이 오귀속+프레이밍 의심.
  단 ADR-0014(시각전용)는 *골전도 착각 차단·저신뢰 지표 비표시*라는 보수적 설계라
  마이크-한계 단일 근거에 의존하지 않음 → 설계 유지, 근거 인용은 교체 필요(별도).
- **초급 SOURCES**(C5/C12 "MANFREDI2017 마이크 한계"): Grillo2016으로 정정 + 프레이밍 주의 표기.
- 트웽(GIBIAT→Jelinger) 저자 정정은 IC-10·IM-02·GY-04에 전파(내용 불변).

---

## §E 한국 1차 + §F 딕션 + §G K-pop — V3 (진행 중)

| 키 | 등급 | 근거 |
|---|---|---|
| **KOR_KIM2025** | **VERIFIED** | 김형미 (2025), 한국산학기술학회논문지 26(10):756-763, KCI(ART003258894). 성대접지 3분류(이상/저접지/과접지)·SOVTE 일치. IC-01·C10 근거 견고 |
| **LEE2017CGU** | **PARTIAL ⚠️정정(연도)** | Clara N. Lee, "Adapting the IPA Systems of Korean Diction to Classical Vocal Method," CGU ETD 689 — 실재. 단 **연도 2020**(2017 아님). 저자·기관·주제 일치. IM-09·GY-07·CL 딕션 근거 |
| **JVOICE2025KPOP** | **VERIFIED** | J Voice 2025, S0892199725004874. K-pop 젠더 중립 청지각, 청자 프로필별. IM-02·GY-04 근거 견고 |
| **KOR_LEE_HAN2022** | **VERIFIED** | 이송희·한경훈, 예술교육연구 2022 20(4), KCI ART002917940. n=10, EVT 트웽이 파사지오 개선에 유의미. IM-03 근거 견고 |
| §E 한국 학술 잔여(KOR_* ~22키) | PARTIAL(미개별검증) | KCI/DBpia/RISS 한국어·다수 유료. 안전 비관여분은 PARTIAL 표기 |
| §G K-pop 산업·뉴스(KCONTENT_VOCAL·KH_*·ONEW2014·SEEYA2025·KOREABOO 등) | PARTIAL(출처유형=산업/뉴스) | `[K-pop 산업관행]` 태그 — 동료심사 아님이 *이미 명시*. 손상 사례(ONEW/Seeya)는 뉴스 신뢰도 한계 표기, 가요 안전은 학술(SIELSKA2018 등)로 뒷받침 |

### V3 종합 (§E·F·G)
**대조 패턴 — 한국 학술 1차가 영어권보다 신뢰성 높음**: KOR_KIM2025·JVOICE2025KPOP·KOR_LEE_HAN2022 = VERIFIED(서지·내용 정확), LEE2017CGU = 연도만 오기(2020). §A~D에서 만연한 *영어권 저자 오기*(Rotsides/Adriaansen/Jelinger/Jeong/Grillo)가 한국 출처엔 없음 — 영어 인용이 AI 생성 시 저자명 환각이 집중된 것으로 추정. §E 잔여 ~22키·§G 뉴스는 PARTIAL(미개별/출처유형). 안전(가요) 외삽 근거는 학술로 뒷받침되어 영향 없음.

---

## §H 메타 + §I 해부 + §J 응용 — V4

| 키 | 등급 | 근거 |
|---|---|---|
| **ROUBEAU2009** | **VERIFIED** | Roubeau·Henrich·Castellengo, J Voice 2009 23(4):425-38, pubmed 18538982. M0–M3 EGG 후두 메커니즘. 저자·저널·권·페이지 정확. IC-11·IM-03·CL-01 근거 견고 |
| **STEMPLE_VFE** | **VERIFIED** | Stemple·Lee·D'Amico·Pickup, J Voice 1994 8(3):271-278, pubmed 7987430. n=35 무작위(실험/위약/대조), 유의 변화. VFE 효능 앵커 견고. IC-03 근거 |
| SUNDBERG1987·TITZE2000·TITZE2006SOVT·HENRICH2006·HUNTER_TITZE2003·HIRANO1981/1974·HIXON2008·FITTS_POSNER1967·SCHMIDT_LEE2019·MILLER1996·BOZEMAN2013/2017·COOKSEY2000·GACKLE2011·LA_HOWARD2011·HELDING2020·KENNY2011·TITZE_VERDOLINI2012·SAPIENZA_RUDDY2018·MALDE2017·DIMON2018·CHAPMAN2017·PATEL2007 | **VERIFIED(정전·평판)** | 보컬·음성과학 *정전 저작/논문*(전 분야 표준). 환각 위험 극히 낮음. 단 정확 판본·페이지는 개별 미재확인(정직 표기). 완전 저자명단 보유 키들 |

### V4 종합 (§H·I·J) + 인용 오류 패턴 정밀화
- 부하 큰 특정 논문(ROUBEAU·STEMPLE) 2건 *완전 일치*. 정전 교재군은 실재 확실(VERIFIED-평판).
- **패턴 결론**: 저자 오기·오귀속은 §A~D(역학·방법론·도구)의 *AI 생성 단일저자-키*에 집중(Rotsides/Adriaansen/Jelinger/Jeong/Grillo). *완전 저자명단 + 정전 저작 + 한국 KCI 1차*는 정확. → 정정 대상은 주로 영어권 single-author-year 키.

---

## V5 단위 claim 적대적 재검증 (claim ↔ 정정된 근거 정합)

방법: 각 단위 핵심 claim을 V1~V4 검증·정정된 인용에 대조해 *과주장*(근거 초과) 색출.
무납득(ADR-0002)상 학습자 대상 효능 주장 0 — 과주장 위험은 *내부 SOURCES의 근거 등급*에 한정.

| 단위 | 핵심 claim | 근거 상태 | 과주장? |
|---|---|---|---|
| 초급 | SOVT 부하↓·효율↑ | TITZE2006SOVT(정전)+ANDRADE2024(RCT)+Adriaansen2025(RCT) | **아님**. RCT 뒷받침 |
| 초급 | 자기청취 시각전용(마이크 한계) | ⚠️ MANFREDI→Grillo2016 오귀속·프레이밍 의심 | **근거 교체 필요**. 단 시각전용 자체는 골전도·저신뢰지표로 유지(설계 불변). V2서 정정 |
| 초급 | 3분류 | KIM2025(VERIFIED, OCEBM 5 개념) | 아님(교육 프레임·비차단으로 한정됨) |
| 코어 | VFE 지구력 | STEMPLE_VFE(VERIFIED, n=35 무작위) | 아님 |
| 코어 | 트웽=AES 협착 | Jelinger2024(VERIFIED MRI) | 아님(저자만 정정) |
| 코어 | 패사지오 인지 | ROUBEAU2009(VERIFIED M0–M3) | 아님(인지 수준 한정) |
| 뮤지컬 | belt 음향·진입 | MCGLASHAN2017(VERIFIED, OCEBM 4) | 아님. `[탐색적]`·진입한정·HITL로 *이미* 보수 |
| 뮤지컬 | 믹스 단일정의 금지 | VALA2021(PARTIAL) | **역과주장 방지 양호** — "흉성50+두성50 검증 안 됨"을 *명시 부정* |
| 성악 | cover·aggiustamento·ring | MILLER1996·CHAN_DO2021·SUNDBERG1987(VERIFIED) | 아님 |
| 가요 | K-pop 명명=SOVT 동일운동 | KCONTENT(산업)+TITZE SOVT | 아님(기능적 추론 `[K-pop 산업관행]` 명시) |
| 전역 | Alexander Technique RCT 근거 | ⚠️ DAVIES2020 SUSPECT(실제 SAGE 평가연구) | **과주장**. "단일브랜드 RCT 희귀사례" 하향 → 평가연구. V1 정정 |

**V5 결론**: 과주장 2건(DAVIES2020 RCT·MANFREDI 마이크한계)은 V1·V2서 이미 정정·하향. 그 외 단위 claim은 정정된 근거 내. 무납득 설계가 학습자 대상 효능 과장을 구조적으로 차단(claim이 "지시"지 "효과 주장"이 아님). 신규 등급 하향 없음.

---

## V6 안전 claim 집중 재검증 (최우선·보수) — REFUTED 0건

| 안전 claim | 재검증 | 판정 |
|---|---|---|
| 가창자 음성장애 유병률 높음(46%) | PESTANA2017 VERIFIED | **확정** |
| 장르별 부상률 MT 최고 | BRETL: MT 1년차 32–40%/발생률 67% > 클래식 22%·CCM 27%(정정) | **강화**(39%→실제 더 높음) |
| belt = 고 성문하압·firmer adduction → phonotrauma | 다출처 확정(Belt vs Neutral 호흡·음향 연구; 충돌력·고압→조직 손상 이론) | **확정**. "성문하압 2–3배" 배수는 PARTIAL(방향 확정) |
| belt 진입 한정·HITL | MCGLASHAN2017 VERIFIED + 위 부하 근거 | **유지·강화** |
| k-keok(강한 글로털 어택) 결절·출혈 위험 → 카드 제외 | hard glottal=hyperfunction→충돌력(표준 음성과학) + part 9-KR | **확정**. 제외 정당·보수 |
| 중단 cue(통증·어지럼·호흡곤란·각혈) | ADR-0001 하드스톱 + part 8(SOVT 과호흡 어지럼) | **유지** |
| 클래식 부상률 낮음(0 아님) | BRETL 클래식 22%(발생률) | **확정**. cover/messa HITL 유지 |

**V6 결론(중대)**: 인용 메타데이터 오류가 만연했음에도 **안전 *claim*은 단 1건도 REFUTED 아님**. 손상 역학 방향은 전부 유지·일부 강화, belt 고부하·k-keok 위험은 독립 출처로 확정. → **멈춤 조건(안전 REFUTED) 미해당**. belt·트웽·패사지오·cover·messa·런 HITL 플래그 + k-keok 제외 *전부 유지*. 안전 결정은 자가 확정하지 않음(HITL 대기) — 본 감사는 안전 결정을 *강화*하되 변경하지 않음.

---

## V7 갭 보강 (part 16 S/A, 2024–2026 신규 문헌)

| 갭 | 신규 문헌? | 상태 |
|---|---|---|
| K-pop 트레이니 손상 코호트(S) | 미발견(2025 K-pop 전용 코호트 없음) | **여전히 열림**. 가요 안전은 SIELSKA2018 22%·BRETL CCM 27% 외삽 유지(증거강도 낮음 단서 유지) |
| Phase III 방법비교 RCT(S, CVT/EVT/SLS/LMRVT) | 미발견(CVT4MTD 등록뿐) | **여전히 열림**. belt=`[탐색적]` 유지 |
| 한국어 가창 formant DB(A) | 미발견 | **여전히 열림**. 딕션은 LEE2020CGU IPA까지 |
| 트랜스·변성기(S, 연구) | — | **제품 범위 밖**(ADR-0001 18+·일반소비자). 커리큘럼 비편입(범위 결정상 보강 안 함) |

**삼각검증 보너스**: BRETL 1년차(n=57, MT 40%·CCM 17%·클래식 0%) 재확인 → V1 "MT 32–40%" 정정 교차확인됨.
**V7 결론**: S/A 갭 *closure 없음*(날조 금지). 갭은 문서대로 유지 + 증거강도 낮음 명시 유지. 가요 안전 외삽 단서 불변.

---

## V8 용어 충돌 해소 (part 14 ↔ 현 학계 ↔ 커리큘럼 처리)

| 용어 | 현 학계(검증 인용) | 커리큘럼 처리 | 정합 |
|---|---|---|---|
| register/passaggio | ROUBEAU2009(VERIFIED) M0–M3 메커니즘 = 합의 프레임 | 코어=인지(M0–M3), 분기=처리. cue로만 | ✅ |
| twang | Jelinger2024(VERIFIED) 구강·AES 협착, *비음 아님* | "트웽=입안, 콧소리 ❌" 명시 분리 | ✅(MRI 근거) |
| mix | VALA2021 + "과학 합의 없음" | **단일정의 금지**, 다중 라벨(M1/M2/스타일) | ✅(합의 없음을 합의대로 처리) |
| belt | MCGLASHAN2017(VERIFIED) Overdrive/Edge·R1:H2 | 진입 한정·보수·HITL | ✅ |
| appoggio/support | MILLER1996 구조적 길항(단순 공기압 아님) | cue "흡기자세 유지"로 조작화, 이론 설명 ❌ | ✅ |
| placement | 측정변수 없는 은유(학계 비판) | **컷**(ADR-0012, P4-02/04) | ✅(비판과 일치) |
| cover/voce chiusa | MILLER1996 패사지오 모음조정 | 성악 CL-01 "둥글게", 후두누르기 ❌ | ✅ |
| open throat | chiaroscuro·후두높이로 분해 | IC-09 후두 중립·CL-03 chiaroscuro | ✅ |

**V8 결론**: 커리큘럼은 *논쟁적 정의에 투신하지 않고 운동 지시 cue로 충돌을 우회*(ADR-0002) — 미해결 논쟁이 많은 영역(mix·belt·placement)에서 정확히 옳은 접근. 검증된 인용(ROUBEAU·Jelinger·MCGLASHAN·MILLER)이 처리 방식을 뒷받침. 용어 오처리 0건. 잔존 논쟁(EVT figure 독립성 PERCEIVE2025 등)은 학계 미해결로 *유지*(커리큘럼이 그 위에 의존하지 않음).

---

## R2a 재확인 §A·B 잔여 (remediation)

| 키 | 등급 | 근거 |
|---|---|---|
| **VALA2021** | **PARTIAL ⚠️정정(이니셜)** | 실재(UNT DMA 2021, metadc1833442). 단 1저자 **Matthew Vala**(B.→M.). 제목 "Training the Hybrid Singer: Mixed Voice…". 믹스 근거(IM-01/GY-02) — 커리큘럼은 믹스=합의없음 처리라 영향 미미 |
| **SELAMTZIS2019** | **UNVERIFIABLE ⚠️** | 2019 KTH 학위논문(diva2:1366879) 미확인. 확인되는 Selamtzis CVT-모드 연구는 *Selamtzis & Ternström ~2014 "Acoustical characteristics of vocal modes in singing"*. 연도·유형 의심 → 믹스/CVT 보조 근거, 안전 무관. 사용 전 재확인 필요 |
| §A 배경 역학(NAYAK2025·SCHWARZ2025·OHLSSON2016·BEHLAU2021·DEVADAS2021A/B·PARK_BEHLAU2018·DIETRICH2022·SALTURK2017·GUNJAWATE2024·PAWELCZYK2022·TOLES2025·GALINDO2023) | PARTIAL(배경·미개별재확인) | **커리큘럼 카드 비인용**(part 8/9 배경). 안전 *방향*은 V6서 확정(BRETL/PESTANA/belt). 영어권 single-author-year라 1저자 주의(KEYMAP 패턴). 개별 웹대조 미실시 — *정직 표기*(fake verify 금지) |
| §B 방법 보조(MCGLASHAN2025·CVT4MTD·OUATTARA2017·BERARDI2022·STEINHAUER2024·PERCEIVE2025·MCCLELLAN2011·WICKS2019·BARTLETT2020·NAISMITH2022) | PARTIAL(보조·미개별재확인) | belt 핵심 앵커(MCGLASHAN2017)는 V1 VERIFIED. 나머지는 방법론 비교·비판(저위험)·part12/13. 개별 재확인 미실시 — 1저자 주의 |

### R2a 정직 한계 표기
§A·B 잔여 ~25키 중 **커리큘럼 인용·근거 핵심(VALA·SELAMTZIS)만 개별 재확인**. 순수 배경 역학·방법 비교 키는 *커리큘럼 카드에 비인용*이라 PARTIAL(미개별재확인)로 **명시적 비검증** 표기 — 안전·핵심 결정은 이미 VERIFIED 앵커(BRETL·PESTANA·MCGLASHAN2017·STEMPLE·ROUBEAU)로 뒷받침되어 영향 없음. (전수 fake-verify 대신 정직 비검증.)

---

## §B 방법론 RCT/임상 (Wave 2) — V1

| 키 | 등급 | 근거 |
|---|---|---|
| **ANDRADE2024** | **VERIFIED** | JSLHR, DOI 10.1044/2024_JSLHR-22-00456, n=67 FRT vs LMRVT RCT. 제목·DOI·설계 일치 |
| **CHEN2024** | **REFUTED(저자 오기) ⚠️정정** | 논문 실재(DOI 10.1044/2024_JSLHR-24-00243, 아동 결절 SOVT RCT)하나 **1저자 = Adriaansen, A**(Ghent), "Chen" 아님. epub 2025-01. 키→ADRIAANSEN2025. 설계(RCT)·주제는 일치 |
| **MCGLASHAN2017** | **VERIFIED** | J Voice 31(3):385.e11, pubmed 27876301, DOI 10.1016/j.jvoice.2016.09.006. n=20 EGG/strobo/LTAS belt 분석 일치. 3저자명만 "Aaen Thuesen"(Kjelin 아닐 수) — belt 근거 견고 |
| **DAVIES2020** | **REFUTED/SUSPECT ⚠️정정** | "J Voice RCT 'Alexander Technique classes improve vocal training'"로 인용됐으나 *그 제목·저널의 논문 미발견*. 실제 Davies 2020 = SAGE(Int J Music Educ?) "AT classes for tertiary music students: student/teacher evaluations of pre/post recordings"(n=12, 평가 연구)로 보임. **"단일 브랜드 RCT 희귀 사례" 근거 강도 과장 의심** → OCEBM 1b 주장 하향(평가연구). part 16/MX Evidence Ladder의 AT-RCT 앵커 약화 |
| MCGLASHAN2025·CVT4MTD·OUATTARA2017·BERARDI2022·STEINHAUER2024·PERCEIVE2025·MCCLELLAN2011·WICKS2019·BARTLETT2020·NAISMITH2022·VALA2021·SELAMTZIS2019·OHLSSON2016 | PARTIAL(미개별검증) | 서지 형식 정상·다수 검색 가능. belt/믹스 근거(VALA·SELAMTZIS)는 V6/V5에서 재확인. 질적·의견 키(MCCLELLAN·WICKS·BARTLETT)는 저위험 |

---

## V1 종합 (§A·B)

**핵심 발견 — 체계적 메타데이터 오류 패턴**:
- **환각(존재하지 않는 논문) = 0건** 확인된 범위 내. 모든 *기저 논문은 실재*.
- 그러나 **메타데이터 오류 다발**: 저자 오기(LECHIEN→Rotsides, CHEN→Adriaansen), 저널 오기(LECHIEN: J Voice→Laryngoscope), 수치 오류(BRETL "뮤지컬 39%"→실제 1년차 32–40%/발생률 67%), 오귀속(SIELSKA2024→2018).
- **근거 강도 과장 1건(DAVIES2020)**: "J Voice RCT"로 인용됐으나 실제는 SAGE 평가연구로 보임 → 단일브랜드 RCT 앵커 약화.
- **안전 claim REFUTED = 0건**: 손상 역학 *방향*(MT 최고·가창자 고유병률·belt 위험)은 전부 유지·일부 강화(MT 39%→67%). belt 앵커(MCGLASHAN2017) VERIFIED. → 멈춤 조건 미해당, 계속 진행.

**정직 한계**: §A·B 약 30키 중 안전·RCT·belt 핵심 ~9키만 개별 웹대조. 나머지는 PARTIAL(미개별검증)로 정직 표기 — V6(안전)에서 관련분 재확인.

**영향 전파 적용**:
- D 중급뮤지컬·F 가요 VERIFICATION에 BRETL "39%→67%/32–40%", SIELSKA "2024→2018" 정정 반영(아래).
- CITATIONS.md 해당 5키에 `⚠️정정` 인라인 주석.
