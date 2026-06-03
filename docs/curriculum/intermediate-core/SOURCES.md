# 중급 코어 — 출처 추적 (SOURCES)

> `CURRICULUM.md`·`cards.md` 핵심 claim → `docs/CITATIONS.md` 키. ADR-0002: 내부 전용.

## 카드별 출처

| 카드 | 핵심 claim | 출처 키 | OCEBM / 비고 |
|---|---|---|---|
| IC-01 균형 발성 | 과기식/균형/과압착 3분류 | KOR_KIM2025 | 5(개념·교육, 한국1차). 비차단 정보 |
| IC-02 SOVT 세트 | 반폐쇄 부하 저감·워밍업 | TITZE2006SOVT, ANDRADE2024, part 3 | 1b(RCT). 초급 SOVT 상속 |
| IC-03 VFE 4과제 | knoll·글라이드·지속 지구력 | STEMPLE_VFE | RCT 정전(가창 지구력 최강근거) |
| IC-04 온셋 유형 | hard/balanced/breathy 대조 | part 3 P3-01~05 | 균형 onset=기본값, 유일정답 ❌ |
| IC-05 Appoggio 정교화 | 흡기자세 유지 호기 antagonism | MILLER1996 | 5(정전). 초급서 미룬 길항 |
| IC-06 SOVT→개모음 | carryover 전이 | TITZE2006SOVT, part 4 P4-05 | SOVT 효과 개모음 이전 |
| IC-07 모음조정·포먼트 기초 | R1:f0 관계 기초 | BOZEMAN2013, part 4 P4-09/10 | 5(음향 페다고지). *기초만* |
| IC-08 명료도↔효율 policy | 정답=장르·증폭 의존 | part 4 P4-13 | 개념 틀만, 적용=분기 |
| IC-09 후두 높이 인지 | 통제변수 인지 | part 4 P4-07 | 중립 높이. 장르 타깃=분기 |
| IC-10 비음 분리 | 의도/비의도 nasality, 트웽 협착 | GIBIAT2024(MRI), part 4 P4-12 | 4(영상). 운동 지시 cue로만 |
| IC-11 패사지오 인지 | primo/secondo 존재·관찰 | ROUBEAU2009(M0–M3), part 5 P5-03/06 | 인지 수준. 처리=분기 |

## 매크로/설계 결정 출처
- **공유 코어 + 블록3 분기**(ADR-0011): part 9/10(콘서바토리·국가별 시퀀스), part 5(전이목표 정반대 cover↔belt).
- **브리지=적응 완성 입구**(ADR-0004): TITZE_VERDOLINI2012(부하 점진), SCHMIDT_LEE2019(운동학습).
- **패사지오 인지까지만**: ROUBEAU2009 메커니즘, 장르 처리는 분기(part 5).

## 안전 관련 (VERIFICATION 참조)
- SOVT·Appoggio 호흡 안전: TITZE2006SOVT, part 8. 중단 cue는 초급 검증분 상속.
- 균형 발성 압착 주의: part 3, part 8.
