# v8 업데이트 검증 — 2026-06-19

## 수행한 정적 검증

| 검증 | 결과 |
|---|---|
| `tools/validate_v8.py` | PASS |
| JSON 파싱 | 11개 PASS |
| YAML 파싱 | 1개 PASS |
| Dart delimiter 검사 | 78개 파일 PASS |
| 카드 라이브러리 ID | 98개 |
| path 참조 고유 card ID | 86개, dangling 0 |
| fallback target | 10개, dangling 0 |
| Beginner manifest | 48 |
| 표준샘플 | Day 1/24/48 |
| Universal Core | 144, block 1–4 |
| Repertoire Application | 72, block 1–4 |
| Advanced cycle | 장르별 40 |
| source bundle | 21개 |
| 임시 turn 참조 | 725회 출현 / 문서별 고유 합계 195 / 전체 고유 176 |
| app version | `1.8.0+8` |
| verification version | `v8` |

## 웹 재검증

공식 또는 원 논문 페이지에서 다음을 확인해 `VERIFIED-ANCHOR-SOURCES.md`에 기록했다.

- NATS Voice Pedagogy Syllabus
- NATS Motor Learning and Teaching Singing
- NIDCD Taking Care of Your Voice
- ASHA Voice Disorders practice portal
- Titze 2006 SOVT rationale
- Kapsner-Smith et al. SOVT RCT
- Sowiński & Dalla Bella beat synchronization
- Moving to the Beat and Singing are Linked in Humans

## 수행하지 못한 검증

현재 실행 환경에 `dart`와 `flutter` CLI가 없어 다음을 실행하지 못했다.

- `dart analyze`
- `flutter test`
- Android/iOS build
- 실제 마이크 permission·녹음·재생·삭제
- 실제 F0/timing 정확도
- audio asset 재생

따라서 Dart delimiter와 저장소 smoke validation 통과를 컴파일 성공으로 표현하지 않는다.

## 출시 판정

- Beginner Foundation: 콘텐츠·기기 QA 전 출시 후보
- Universal Core: 설계 반영 완료, 실제 카드/자산/사용자 검증 전 미출시
- Repertoire Application: 구조 반영 완료, 실제 phrase asset 전 미출시
- Advanced Genre Labs: 전부 미출시
- 연구 통합: source recovery와 링크 검증 전 UNVERIFIED
