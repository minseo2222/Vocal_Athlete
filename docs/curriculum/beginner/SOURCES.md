# 초급 커리큘럼 — 출처 추적 (SOURCES)

> 목적: `CURRICULUM.md`·`cards.md`의 핵심 claim을 `docs/CITATIONS.md` 키로 역추적.
> ADR-0002: 출처·근거는 *내부 문서(본 파일)에만*, 학습자 cue는 지시문만.
> 신뢰도: OCEBM(연구설계) + 현장채택 2축. 안전 항목은 VERIFICATION.md 플래그 참조.

## 카드별 출처

| 카드 | 핵심 claim | 출처 키 | OCEBM / 비고 |
|---|---|---|---|
| C1 자세·Body Mapping | 6 Places of Balance 정렬 | MALDE2017, DIMON2018 | 5(교재) · Andover/Alexander 라인. 일러스트 자체제작(라이선스) |
| C2 흉곽-복부 호흡 | 늑골·복부 *결합* 호흡("복식 vs 흉식" 이분법 폐기) | HIXON2008 | 5(정전 교과서). part 14 *복식호흡* 카드 |
| C3 턱·혀·목 이완 | silent→voiced ah, 후두외근 긴장 완화 | DIMON2018(whispered ah), part HP §해부 | 5 |
| C4 가벼운 첫 소리 | /h/·/m/ easy onset, balanced onset | part 3 P3-01~05(온셋 유형) | 온셋 DB. *균형 onset이 유일 정답 아님*(스타일 의도) |
| C5 자기청취(골/공기 전도) | 시각 곡선 전용(골전도 착각 차단) | JEONG2023(전 NAIR), part 7 | ⚠️V2정정: MANFREDI2017→Grillo2016 오귀속·프레이밍 의심으로 *근거에서 제외*. 시각전용 근거는 골전도 착각·저신뢰지표 비표시(ADR-0014)로 유지 |
| C6 빨대 발성 | SOVT 역압·발성역치압↓·충돌력↓ | TITZE2006SOVT, TITZE2000, ANDRADE2024 | 1b(RCT, SOVT 비교). 빨대 지름=VERIFICATION P1 |
| C7 립 트릴 | SOVT 반폐쇄(립 트릴=lip bubble/buzz) | TITZE2006SOVT, part 3 | SOVT 하위군 |
| C8 허밍/NG-hum | /m/·/ŋ/ 비강 SOVT | TITZE2006SOVT, part 3 | SOVT 하위군 |
| C9 물저항 빨대 | 물 저항 SOVT(회복 도구) | TITZE2006SOVT, part 3 | 천식·호흡기 대체=VERIFICATION 안전 |
| C10 균형 발성 | 과기식↔균형↔과압착 3분류 | KOR_KIM2025(균형/저접지/과접지) | 5(개념·교육). 한국 1차 |
| C11 Self-Imitation | 녹음→재생→재모방 청지각 매칭 | part 7(자기모니터링), SCHMIDT_LEE2019(KR/KP) | 운동학습 피드백 변수 |
| C12 시각 피드백 피치매칭 | 피아노롤 목표선·실시간 곡선·±편차 | part 7, part 11, MANFREDI2017 | 컨슈머 정확도 정직 표기 |
| 표준샘플 SOP | 고정 과제 전후 A/B(VRP류) | KOR_VRP, part 7 | 한국 VRP 간이 프로토콜 |

## 매크로/설계 결정 출처

- **5블록 blocked→variable**(ADR-0006): SCHMIDT_LEE2019(blocked vs random), FITTS_POSNER1967(인지→연합→자동 3단계). *내부 설계 전용, 학습자 비노출*.
- **SOVT를 워밍업 겸용**: part 8(워밍업·부하관리), TITZE_VERDOLINI2012(부하 저감).
- **무성 레슨 0 / 유성 마이크로윈**: part 3(발성 개시 조기 도입), 균형 onset 라인.
- **시각 전용 피드백·저신뢰 비표시**(ADR-0014): MANFREDI2017(스마트폰 음향 한계), NAIR2023PNAS(웨어러블 dose), part 7/11.
- **졸업 = 완료 기반(시험 없음)**(ADR-0004): 운동학습 자동화 단계는 *시간 의존*(FITTS_POSNER1967) → 초급은 입문 토대까지.

## 안전 관련 출처 (상세 판정 = VERIFICATION.md)

- SOVT 안전·금기: TITZE2006SOVT, part 8. 빨대 지름 트레이드오프: TITZE(얇은 빨대 고저항) vs 초급 저저항 안전.
- 손상 역학 배경(설계 동기, 학습자 비노출): BRETL2023, PESTANA2017(유병률 46%), BEHLAU2021(부하 단독≠병리).
- 중단 cue 근거: part 8(과호흡·어지럼·LPR), 물저항 호흡기 주의.
