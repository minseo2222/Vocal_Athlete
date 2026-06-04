# 커리큘럼 ↔ 리서치 인덱스 + 갭맵 (Task A 산출물)

> 목적: `docs/research/` 26개 파일 + 인용/태그 인프라를 각 커리큘럼 단위에 매핑하고,
> 단위별 핵심 claim·1차 출처·잔존 갭·안전 플래그를 한 곳에 고정한다. 이후 단위 작업
> (B 초급 / C 중급코어 / D 중급뮤지컬 / E 성악 / F 가요)의 *기준표*.
> 준거: ADR-0001~0016, CONTEXT.md, part 16 갭 매트릭스, `docs/TAGS.md`, `docs/CITATIONS.md`.

---

## 0. 리서치 인프라

- **인용 키 표준**: `docs/CITATIONS.md` (~88 키, 예 `[CITE: TITZE2006]`, `[CITE: BRETL2023]`).
- **증거/관행 태그**: `docs/TAGS.md` — `[근거 부족]` · `[탐색적 근거]` · `[Phase III RCT 부재]` · `[성악·CCM 병기]` · `[K-pop 산업관행]`.
- **증거 2축 평가**: 연구 설계(OCEBM) + 확실성(GRADE) — *학술 근거 강도*와 *현장 채택*은 분리 축(part 0).
- **잔존 갭 시급성**: S(안전/핵심주장) / A(챕터 부분작성) / B(2판) — part 16 §"잔존 갭".

## 1. 리서치 파일 → 단위 매핑

| 파일 | 주제 | 주 공급 단위 |
|---|---|---|
| part 0 / 1 / 2 | 프레임·심층 리서치 토대 | 전 단위(설계 원리) |
| part HP | 인체해부·생리 토대(Hirano 성대5층·Hixon 호흡·Fitts&Posner·Cooksey/Gackle 변성기·Lã&Howard 호르몬) | 전 단위(내부 근거) |
| part HX | 인체-가창 응용 문헌(Body Mapping·운동학습 응용·MPA·Accent Method) | 전 단위(내부 근거) |
| part QI | 정량 인덱스(formant·PTP·성대접지·belt/twang 음향) | 코어·뮤지컬·성악·가요 |
| part MX | 학파 매트릭스·계보·Evidence Ladder | 방법론 근거(횡단) |
| part 3 | 온셋·포네이션·내전·SOVT 전수 | **초급**·코어(VFE·온셋) |
| part 4 | 공명·성도형상·모음조정·포먼트튜닝·플레이스먼트 | **코어**·성악(singer's formant) |
| part 5 | 레지스터·패사지오·믹스·벨트·트웽·스피치라이크 | **뮤지컬**·가요·성악(passaggio) |
| part 6 / 6-KR | 딕션·조음 / 한국어 가창 딕션 | 뮤지컬·**가요(6-KR)**·성악 |
| part 7 | 자기모니터링·평가·청지각(웨어러블·AI 도구·컨슈머앱 한계) | 전 단위(피드백 설계, ADR-0014) |
| part 8 | 워밍업·쿨다운·회복·부하관리·음성위생 | 전 단위(**안전**) |
| part 9 / 9-KR | 정규기관 커리큘럼 / 한국 기관·K-pop 산업 | 코어·성악·**가요** |
| part 10 | 국가별 커리큘럼 구조 비교 | 매크로 시퀀스 근거 |
| part 11 | 온라인 강의·AI 보컬 도구 사례 | 피드백·도구(ADR-0014) |
| part 12 / 13 | 대표 교수법 비교 / 교육자·연구자 방법론 | 방법론 근거(벨트=EVT/CVT 등) |
| part 14 | 논쟁 지점·정의 충돌(support/appoggio/placement/register/mix/belt/twang/open throat) | **용어 정합**(전 단위) |
| part 15 | 훈련법 DB·동의어 통합(P3-xx·P4-xx·P5-xx·P6-xx ID 원천) | 카드 ID 원천(전 단위) |
| RESEARCH_COMPILATION 1–3 | 외부 리서치 컴파일(Wave 통합) | 갱신 근거(전 단위) |

> **카드 ID 규약**: `P{part}-{nn}`(예 P3-07)은 part 15/해당 part의 훈련법 DB 행 ID. 커리큘럼 문서가
> 이 ID로 카드를 참조 → SOURCES.md에서 ID→1차 출처로 추적한다.

## 2. 단위별 현황 + 갭 + 안전 플래그

### B. 초급 (beginner) — 산출물 보강
- **현황**: `cards.md`(13 IN, 사인오프) + `CURRICULUM.md`(5블록) 존재. 보강 제안서 `.scratch/beginner-v1/research-augmentation-proposal.md`(미적용, P1 빨대지름·P2 안전cue·P3 변주 — HITL 대기).
- **핵심 claim**: SOVT(Titze 합리화), appoggio(Miller), 균형 onset, 자기청취(녹음 비교), 5블록 blocked→variable(ADR-0006), 졸업 4스킬.
- **주 출처**: part 3(SOVT/온셋), part 7(자기모니터링), part 8(워밍업·위생), part HP(해부).
- **갭**: 보강 제안 3건 판정 미완. 사인오프 카드의 출처 역추적(SOURCES) 부재.
- **안전 플래그(HITL)**: SOVT 강도·빨대 지름·호흡(과호흡/어지럼) 중단 cue 완전성 — *기존 카드 본문 변경은 사인오프 전 금지*.

### C. 중급 코어 (intermediate-core) — cards.md + SOURCES + VERIFICATION 필요
- **현황**: `CONTEXT.md`+`CURRICULUM.md`(블록1 브리지·블록2 공명/모음조정, 카드 ID 참조) 작성됨. `cards.md`(ADR-0015 스키마) 미생성.
- **핵심 claim**: P3-07 균형발성·3분류(김형미 2025 균형/저접지/과접지), VFE 4과제(Stemple, RCT 최강), §4.3 Appoggio 정교화, P4-09/10 모음조정·포먼트튜닝 기초, P4-07 후두높이 인지, P4-12 비음 분리, 패사지오 *인지*(P5-03/06).
- **주 출처**: part 3(VFE·온셋), part 4(공명·포먼트), part 5(패사지오 인지), part QI(formant·접지).
- **갭**: cards.md 스키마화. 모음조정 R1:f0 정량 앵커(part QI).
- **안전 플래그(HITL)**: 균형발성 압착·SOVT 부하. (벨트/고음은 코어 밖 → 분기.)

### D. 중급 뮤지컬 (intermediate-musical) — cards.md + SOURCES + VERIFICATION 필요
- **현황**: `CONTEXT.md`+`CURRICULUM.md`(블록3 레지스터·블록4 텍스트/딕션/캐릭터/곡) 작성됨. `cards.md` 미생성.
- **핵심 claim**: P5-04 믹스(단일정의 ❌, 경험으로), 구강 트웽(P15-20 oral), 패사지오 처리, P15-18 Bozeman 모음전환, **call-based 벨트 진입(ADR-0007 천장)**, P6-08/09/10 텍스트·딕션, 한국어 딕션 교차스트림.
- **주 출처**: part 5(레지스터·벨트·트웽), part 6(딕션), part 12/13(EVT/CVT 벨트 근거), part 14(belt/twang 용어), part 9-KR(K-pop neutral 병기).
- **갭**: 벨트 Phase III RCT 부재(`[Phase III RCT 부재]`), 벨트 entry 근거 `[탐색적 근거]`(McGlashan 2017).
- **안전 플래그(HITL) — S 등급**: **벨트·고음·트웽·패사지오 처리** = ADR-0008 명시 위험수용. *자가 확정 금지*, 사인오프 필요. 완화책(진입까지·call-based·"밝게 크게아님")은 유지하되 안전 결정은 HITL.

### E. 성악 (classical) — 신규 (범위 확인 대상)
- **현황**: 폴더·문서 없음. ADR-0011 장르 분기 중 하나로 예정(미생성).
- **예상 핵심 claim**: aggiustamento(고소프라노 모음조정), singer's formant(2.8–3.2kHz), 패사지오 *클래식 처리*(커버링), messa di voce(고급), 이태리어/독일어 딕션, chiaroscuro.
- **주 출처**: part 4(singer's formant·포먼트), part 5(passaggio/covering), part 12/13(Bel Canto/Miller/Bozeman), part 9/10(콘서바토리), part 6(IT/DE 딕션).
- **안전 플래그(HITL)**: 고음·messa di voce·지속 — 고급 영역. 신규 트랙 생성 = 범위 결정 → 착수 시 확인.

### F. 가요 (gayo) — 신규 (범위 확인 대상)
- **현황**: 폴더·문서 없음. ADR-0011 분기 예정(미생성).
- **예상 핵심 claim**: CCM 스피치라이크·믹스·벨트, 한국어 가창 딕션(part 6-KR), K-pop 명명연습↔음성과학 매핑(k-keok/꺽기/siren/lip bubble ↔ SOVT/Estill, `[K-pop 산업관행]`), 마이크 전제(증폭) 명료도 policy.
- **주 출처**: part 6-KR(한국어 딕션·판소리), part 9-KR(K-pop 산업·매핑), part 5(CCM 벨트/트웽), part 11(도구).
- **갭(S 등급)**: K-pop 트레이니 손상 코호트 부재, 한국어 가창 formant DB 부재(A), 판소리 안전성 정량연구 부재(A).
- **안전 플래그(HITL) — S 등급**: 벨트·고음·꺽기·판소리식 부하. 신규 트랙 = 범위 결정 → 착수 시 확인.

## 3. 전 단위 공통 — 범위 밖(ADR/제품 결정상 *포함 금지*)
- **변성기·청소년·아동 가창**(part 16 S갭): ADR-0001 만 18세 이상·변성기 종료 대상 → **범위 밖**. 연구상 S갭이나 본 제품 비대상.
- **트랜스/젠더 확정 음성 훈련**(part 16 S갭, 연구 완전누락): 본 제품 일반 소비자 V1 비대상. 향후 별도 검토.
- **임상·치료 전용 프로토콜**(LSVT 등 의학감독 필요): 교육용 차용 드릴만 허용, 치료 프로토콜 자체는 제외(ADR-0001 의료도구 아님).
- **무대공포 모듈·학술 정당화 온보딩·강사/임상 동반 트랙**: ADR-0001/0002로 제거됨 — 되살리지 않음.

## 4. 작업 순서 (의존) — 진행 현황
A ✅ → B 초급 ✅ → C 중급코어 ✅ → D 중급뮤지컬 ✅(belt HITL) → E 성악 ✅(cover/messa HITL) → F 가요 ✅(belt/트웽/런 HITL, k-keok 제외).
산출물: 각 단위 `docs/curriculum/<unit>/{CURRICULUM, cards, SOURCES, VERIFICATION}`
(성악·가요는 CONTEXT 포함 신규). 모든 안전 S등급 항목은 VERIFICATION에 `HITL 사인오프 필요` 플래그.
각 단위 = 수집→웹보강→교차검증(적대적)→정합→집필(CURRICULUM/cards/SOURCES/VERIFICATION)→자기비평→확정.
안전 플래그 항목은 VERIFICATION.md에 `HITL 사인오프 필요`로 표시하고 자가 확정하지 않는다.
