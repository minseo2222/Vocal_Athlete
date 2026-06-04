# 검증 종합 (VERIFICATION-MASTER) — V1~V9

> 전 커리큘럼·인용 정밀 검증(goal: 수집 정보 정밀 검증·보완)의 종합. 세부는
> `docs/research/CITATION-AUDIT.md`(키별 4등급) + 각 단위 VERIFICATION.md.

## 1. 한 줄 결론

**인용 메타데이터 오류는 만연(특히 영어권 single-author-year 키의 저자 오기), 그러나 기저 논문은 모두 실재하고 안전 claim은 단 1건도 REFUTED 아님.** 안전 결정(belt 진입한정·k-keok 제외·HITL)은 검증으로 *강화*됐고 변경 없음.

## 2. 검증 등급 분포 (CITATIONS, 개별 웹대조분)

| 등급 | 키 | 비고 |
|---|---|---|
| VERIFIED | PESTANA2017·ANDRADE2024·MCGLASHAN2017·CHAN_DO2021·KOR_KIM2025·JVOICE2025KPOP·KOR_LEE_HAN2022·ROUBEAU2009·STEMPLE_VFE | 서지·내용 정확 |
| VERIFIED(정전·평판) | Sundberg·Titze·Hirano·Hixon·Miller·Schmidt&Lee·Fitts&Posner·Bozeman·Cooksey·Gackle·Malde·Dimon 등 | 정전 저작, 판본·페이지 개별 미재확인 |
| PARTIAL | CHILDS2023·BEHLAU2021·LEE2017CGU(연도)·§D AI도구 다수·§E 한국 잔여·§G 뉴스 | 메타만/유료/출처유형 |
| **REFUTED(정정)** | **BRETL2023**(수치 39%→67/32–40)·**SIELSKA2024**(→2018 오귀속)·**LECHIEN2021**(→Rotsides/Laryngoscope)·**CHEN2024**(→Adriaansen)·**GIBIAT2024**(→Jelinger)·**NAIR2023PNAS**(→Jeong)·**MANFREDI2017**(→Grillo2016+프레이밍)·**DAVIES2020**(RCT→평가연구 의심) | 8건, 전부 ⚠️정정 적용 |
| 환각(미존재) | **0건** | 기저 논문 전부 실재 |

## 3. 정정 8건 + 영향 전파

| 키 | 오류 | 정정 | 영향 단위 |
|---|---|---|---|
| BRETL2023 | "뮤지컬 39%" | 1년차 32–40%/발생률 67% | D 뮤지컬·F 가요(방향 강화) |
| SIELSKA2024 | "22% 결절" 귀속 | →SIELSKA2018 J Voice | F 가요(귀속만, 수치 유지) |
| LECHIEN2021 | 저자·저널 | →Rotsides, Laryngoscope | (역학 보조) |
| CHEN2024 | 저자 | →Adriaansen 2025 | 초급/코어 SOVT RCT(설계 유지) |
| GIBIAT2024 | 저자 | →Jelinger 2024 | IC-10·IM-02·GY-04 트웽(내용 유지) |
| NAIR2023PNAS | 저자 | →Jeong 2023 | 초급 C5(내용 유지) |
| MANFREDI2017 | 저자·연도·**프레이밍** | →Grillo2016; "마이크 한계" 부적합 | 초급 C5/C12·ADR-0014 근거 교체 필요 |
| DAVIES2020 | "J Voice RCT" | →SAGE 평가연구; OCEBM 1b 하향 | part16/MX Evidence Ladder 약화 |

## 4. 안전 (V6) — REFUTED 0건

손상 역학 방향 전부 유지·강화(MT 최고·가창자 46%·belt 고부하·k-keok 위험). belt 진입한정·트웽·패사지오·cover·messa·런 **HITL 플래그 유지**, k-keok **제외 유지**. 감사는 안전을 *강화*하되 자가 변경하지 않음(HITL 대기).

## 5. 잔존 미해결 (등급)

- **S**: K-pop 트레이니 손상 코호트 부재 / Phase III 방법비교 RCT 부재 → 가요·belt 증거강도 낮음 단서 유지. (제품 범위 밖: 트랜스·변성기)
- **S(R4 재개방)**: 메소드 효능 *가창자 RCT* 부재 — Davies 2020이 RCT가 아니라 SAGE 평가연구로 확인되어 "단일 브랜드 가창자 RCT 확보" 철회. part16 메소드효능 갭 🟡→🔴. Alexander part MX ★★★→★★ 하향. (커리큘럼 카드엔 belt 외 Alexander 직접 의존 없어 안전 무관.)
- **A**: 한국어 가창 formant DB 부재 / 다언어 딕션 / 장르 세분화.
- **인프라 A**: CITATIONS 영어권 single-author-year 키의 *저자명 신뢰 불가* — 후속 사용 전 1저자 재확인 권장(본 감사가 8건 정정, 미개별검증 다수 PARTIAL).

## 6. HITL 사인오프 최종 목록 (출시 전 필수)

1. **belt 계열**: IM-05 call-based 벨트진입·IM-03 패사지오처리·IM-02 트웽·IM-12 레퍼토리(뮤지컬) / GY-04 트웽·GY-05 belt진입·GY-06 런·GY-09 레퍼토리(가요) — 음역 상한·진입 강도·빈도.
2. **성악**: CL-01 cover 진입·CL-08 messa di voce 기초 — 고음·지속.
3. **초급 보강**: P1(b) 빨대 명시문구·P3 cue 변주축(보류 결정).
4. **k-keok**: 영구 제외 유지(고급/HITL 한정).
5. **ADR-0014 근거 교체**: MANFREDI→다른 마이크 한계 출처(또는 골전도·저신뢰지표 근거로 재서술). 시각전용 설계 자체는 불변.

## 7. 검증 한계 (정직)

- 학술 *본문* 다수 유료 → claim 정밀 수치는 PARTIAL 잔존(예 belt "성문하압 2–3배" 배수).
- §D AI도구·§E 한국 잔여·§G 뉴스는 미개별검증 PARTIAL(안전 비관여 우선순위).
- 본 감사의 핵심 성과: **환각 0건 확인 + 저자/수치/귀속 오류 8건 색출·정정 + 안전 무결성 확인**.
