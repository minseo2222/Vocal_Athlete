# v9 업데이트 검증 — 2026-06-19

## 수행한 정적 검증

`python tools/validate_v9.py` 결과: **PASS**

| 검증 | 결과 |
|---|---|
| JSON 파싱 | 12개 PASS |
| YAML 파싱 | 1개 PASS |
| Dart delimiter 검사 | 78개 PASS |
| 카드 라이브러리 ID | 126개, 중복 0 |
| path 참조 고유 카드 | 110개, dangling 0 |
| fallback target | 10개, dangling 0 |
| Beginner | 48레슨 |
| 표준샘플 | Day 1/24/48 |
| 정상 Beginner의 CARD-18 | 0회 |
| CARD-14 청음 과제 | 3회 |
| Universal Core | 12 microcycles × 12 = 144 |
| UC-17 checkpoint | Day 36/72/108/144 |
| Repertoire Application | 6 projects × 12 = 72 |
| 프로젝트 경계 | 모두 RA-09 시작 / RA-10 종료 |
| Advanced cycles | 7개 경로 각각 40 |
| 정상 Advanced의 CARD-18 | 0회 |
| R&B/Rock/Worship | 전용 RB/RK/WC 카드 확인 |
| app version | `1.9.0+9` |
| verification version | `v9` |

## 문서 정합성 확인

다음 canonical 문서가 v9 구조와 일치하는지 marker 기반으로 확인했다.

- `CONTEXT.md`
- `CONTEXT-MAP.md`
- `docs/app/APP-SPEC.md`
- `docs/curriculum/CURRICULUM-REVIEW.md`
- `docs/curriculum/LEARNING-METHODOLOGY-SPEC.md`
- `docs/curriculum/REPERTOIRE-APPLICATION-SPEC.md`
- `docs/curriculum/universal-core/CURRICULUM.md`
- `docs/verification/VERIFICATION-STATUS.md`
- `docs/verification/verification-status.json`

## 수행하지 못한 검증

현재 환경에 Dart/Flutter CLI와 모바일 실기기가 없어 다음은 실행하지 못했다.

- `dart analyze`
- `flutter test`
- Android/iOS build
- 실제 마이크 권한·녹음·재생·삭제
- F0·timing 정확도
- guide/backing asset 재생
- 사용자의 delayed retention/transfer
- 음성 안전과 학습 효과

따라서 정적 검증 통과를 컴파일 성공, 출시 가능, 보컬 학습 효과 검증으로 표현하지 않는다.

## 출시 판정

- Beginner: 조건부 MVP 후보
- Universal Core: 설계 단계, 미출시
- Repertoire Application: 구조 단계, 미출시
- Advanced Genre Labs: 미출시
- v9 methodology: `implemented_unverified`
