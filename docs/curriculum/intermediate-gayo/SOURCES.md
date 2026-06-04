# 중급 가요 분기 — 출처 추적 (SOURCES)

> `CURRICULUM.md`·`cards.md` claim → `docs/CITATIONS.md` 키. ADR-0002 내부 전용.

## 카드별 출처

| 카드 | 핵심 claim | 출처 키 | OCEBM / 태그 |
|---|---|---|---|
| GY-01 스피치라이크 | 말하듯 CCM 토대 | part 5, SAUNDERS2018 | 5(교재) |
| GY-02 믹스 | 단일정의 ❌, 경험 | VALA2021, SELAMTZIS2019 | 4 |
| GY-03 K-pop SOVT 워밍업 | lip bubble=립트릴/siren=SOVT/kkook=균형onset | KCONTENT_VOCAL, part 9-KR 매핑, TITZE2006SOVT | `[K-pop 산업관행]` / 기능적 추론 |
| GY-04 트웽/꽥 | AES 협착·neutral 컨트라스트 | GIBIAT2024(MRI), JVOICE2025KPOP | 4·3b `[성악·CCM 병기]` |
| GY-05 라이트 belt 진입 ⚠️ | call-based·진입 한정 | MCGLASHAN2017, part 9-KR, KH_HEALTH | 4 `[탐색적 근거]`·`[K-pop 산업관행]` |
| GY-06 꺽기/런 기초 | 정확도→템포 | part 5, KOR_PRACTICAL_CASE | 한국 사례 |
| GY-07 한국어 가창 딕션 | VOT·종성·연음·비음화 | LEE2017CGU, KOR_SPEECHRATE, part 6-KR | 4 / 한국 1차 |
| GY-08 마이크 전제 명료도 | 증폭 policy·컴프레션 | KOR_COMPRESSION, part 6-KR | 한국 프로덕션 |
| GY-09 레퍼토리 | 가요 구절(라이트 belt) | part 9-KR, KCONTENT_VOCAL | 산업 |

## 매크로/설계 결정 출처
- **K-pop 명명연습 ↔ SOVT/Estill 매핑**: part 9-KR §"K-pop 명명 연습 ↔ 음성과학 매핑"(KCONTENT_VOCAL `[K-pop 산업관행]`). lip bubble=P3-17, siren=P3-19/20, kkook=P3-07.
- **k-keok 제외 결정**: part 9-KR 안전 한계("hard glottal 반복 → 결절·출혈 위험, 단시간·소량") → 중급 카드 제외(고급/HITL).
- **트웽 ≠ 비음**: GIBIAT2024(구강 AES). neutral 미적 컨트라스트 JVOICE2025KPOP.
- **마이크 전제**: KOR_COMPRESSION(모니터 컴프레션 영향).

## 안전 관련 (상세 = VERIFICATION)
- ⚠️ belt·트웽·런 = `[HITL]`. K-pop 손상 사례: ONEW2014(결절 수술), ALLKPOP_SEEYA2025(낭종), KOREABOO_LIST, KH_HEALTH.
- **S등급 갭**: K-pop 트레이니 손상 코호트 부재(part 16) → 서구 CCM(SIELSKA2024 22%) 외삽, 증거 강도 낮음.
