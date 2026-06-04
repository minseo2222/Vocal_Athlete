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
