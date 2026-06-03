# 중급 뮤지컬 분기 — 출처 추적 (SOURCES)

> `CURRICULUM.md`·`cards.md` claim → `docs/CITATIONS.md` 키. ADR-0002 내부 전용.

## 카드별 출처

| 카드 | 핵심 claim | 출처 키 | OCEBM / 태그 |
|---|---|---|---|
| IM-01 믹스 | 단일 정의 ❌, 경험·다중라벨 | VALA2021, SELAMTZIS2019 | 4 / 과학 합의 없음 명시 |
| IM-02 구강 트웽 | AES 협착·2.5–3.5kHz, 구강(비음 ❌) | GIBIAT2024(MRI) | 4(영상) |
| IM-03 패사지오 처리 | 관리(제거 ❌), 믹스/belt 방향 | ROUBEAU2009, KOR_LEE_HAN2022 | M0–M3 / 한국 파일럿(EVT 트웽) |
| IM-04 Bozeman 모음전환 | H2가 R1 통과 지점 조정 | BOZEMAN2013, BOZEMAN2017 | 5(음향 페다고지) |
| IM-05 call-based 벨트 진입 ⚠️ | R1:H2·높은 CQ·성문하압 2–3배 | MCGLASHAN2017, JVOICE2025KPOP | 4 `[탐색적 근거]`·`[성악·CCM 병기]` |
| IM-06 자음 에너지 | 배우-스피치 브리지 | part 6 P6-08 | — |
| IM-07 텍스트 해체-재구성 | Rodenburg 텍스트 우선 루프 | (Rodenburg 현장 라인, CITATIONS 키 없음 — `[근거 부족]` 표기) | 5(현장) |
| IM-08 명료도 블라인드 | 시각/구조 피드백(청각 ❌) | part 6 P6-10, MANFREDI2017 | ADR-0014 |
| IM-09 한국어 딕션 | VOT·종성·연음·비음화 | LEE2017CGU, part 6-KR | 4 / 한국 1차 |
| IM-10 패터 | 조음 템포 램프 | part 6 P6-07 | — |
| IM-11 영어 딕션 | 이중모음/r 정책 | LABOUFF2008 | 5(표준 교재) |
| IM-12 레퍼토리 | legit + 라이트 belt-진입 구절 | SAUNDERS2018(cross-training) | 5(교재) |

## 매크로/설계 결정 출처
- **belt 진입 한정(ADR-0007)·명시 위험수용(ADR-0008)**: BRETL2023(뮤지컬 부상률 39% 최고), CHILDS2023(MT phonotrauma 우세) → 진입까지만·call-based·"밝게 크게아님".
- **텍스트→캐릭터→곡 순서**: part 6(Rodenburg 라인), SAUNDERS2018.
- **트웽 ≠ 비음**: GIBIAT2024(구강 AES) vs 연구개 nasality 분리(part 4/14).

## 안전 관련 (상세 = VERIFICATION)
- ⚠️ belt·고음·트웽·패사지오 처리 = S등급. 손상 역학 BRETL2023/CHILDS2023/LECHIEN2021/PESTANA2017.
- 완화: ADR-0007 진입 한정, call-based 짧게, 중단 cue(통증·다음날 쉰목).
