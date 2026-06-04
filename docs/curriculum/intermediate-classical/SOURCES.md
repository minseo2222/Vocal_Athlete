# 중급 성악 분기 — 출처 추적 (SOURCES)

> `CURRICULUM.md`·`cards.md` claim → `docs/CITATIONS.md` 키. ADR-0002 내부 전용.

## 카드별 출처

| 카드 | 핵심 claim | 출처 키 | OCEBM / 비고 |
|---|---|---|---|
| CL-01 cover/voce chiusa | secondo passaggio 모음 둥글게 | MILLER1996, ROUBEAU2009 | 5(정전)/M0–M3. 진입 한정 |
| CL-02 aggiustamento | f0 상승 시 모음 중립화(소프라노) | CHAN_DO2021 | 3b(실증). 한국 데이터=KOR_SOPRANO_ACOUSTIC |
| CL-03 chiaroscuro | 밝음+어둠 동시 균형 | MILLER1996, SUNDBERG1987 | 5/음향과학 |
| CL-04 singer's formant 인지 | 2.8–3.2kHz ring·비증폭 투과 | SUNDBERG1987, KOR_SOPRANO_ACOUSTIC | 정전/한국 1차. P4-06(성악 소관) |
| CL-05 legato | 끊김 없는 라인 | MILLER1996 | 5(정전) |
| CL-06 이탈리아어 딕션 | 순수모음·이중자음 | part 6, MILLER1996 | 표준 |
| CL-07 독일어 딕션 | 움라우트·자음군 | part 6 | 표준 |
| CL-08 messa di voce 기초 | 약→강→약 다이내믹 제어 | MILLER1996, TITZE_VERDOLINI2012 | 정전/제어. 기초 한정 |
| CL-09 레퍼토리 | legit 클래식 구절 | MILLER1996, KOR_JKSLP_BELCANTO | 정전/벨칸토 의학이해 |

## 매크로/설계 결정 출처
- **성악 분기 = cover/aggiustamento/ring(ADR-0012 성악 소관)**: 뮤지컬 §4·코어 §5에서 명시 이관. singer's formant P4-06.
- **비증폭 전제·chiaroscuro**: SUNDBERG1987(singer's formant 비증폭 투과력), MILLER1996.
- **클래식 부상률 상대적 낮음(0 아님)**: BRETL2023(클래식 3년차 22% — 3장르 중 최저), CHILDS2023(오페라 pseudocyst).

## 안전 관련 (VERIFICATION 참조)
- 고음·지속·messa di voce = `[HITL]`(CL-01·CL-08). BRETL2023(22%), 고음 무리·풀 messa는 고급.
- cover ≠ 후두 누르기(과압 위험) — cue로 가드.
