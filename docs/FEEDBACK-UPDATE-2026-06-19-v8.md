# v8 피드백 반영 업데이트 — 2026-06-19

## 1. 입력

- 사용자 제공 `리서치 결과 모음.zip`: 20개 심층 리서치
- 기존 음색 리서치: 1개
- 총 21개 원문을 v8 source bundle에 편입

## 2. 핵심 결정

1. 원문을 삭제·요약 대체하지 않고 정규화된 보존본으로 저장한다.
2. 출처가 끊긴 문서와 URL이 있는 문서를 상태로 구분한다.
3. 건강한 가수 직접 연구, 임상, 운동학습 간접 근거, 전문가 합의, 제품 가설을 분리한다.
4. Universal Core는 직렬 모듈 소비가 아니라 네 번의 spiral pass로 운영한다.
5. Repertoire Application은 Global→Local→Recall→Transfer 구조로 정교화한다.
6. Advanced Lab은 장르별 기술 목록이 아니라 반복 곡 프로젝트 cycle로 운영한다.
7. 당일 성공과 학습을 구분하고 retention·transfer·독립 산출물을 평가한다.

## 3. 리서치 정규화

추가:

- `docs/research/v8/source-bundle/01~21`
- `EVIDENCE-TAXONOMY.md`
- `EVIDENCE-MATRIX.md`
- `SOURCE-STATUS-MATRIX.md`
- `SOURCE-REGISTER.csv`
- `SOURCE-RECOVERY-BACKLOG.md`
- `VERIFIED-ANCHOR-SOURCES.md`
- `RHYTHM-TIME-INTERIM-REVIEW.md`
- `SOVT-TRANSFER-INTERIM-REVIEW.md`

초기 5개 문서에는 세션 종속 `turn...` 인용이 725회 출현한다. 문서별 고유 합계는 195개이고, 문서 간 중복을 제거한 전체 고유 참조는 176개다. 이들은 실제 서지·URL 복구 전까지 개별 claim의 검증 근거로 사용하지 않는다.

중복 처리:

- 09 가요/K-pop = 배경 연구
- 11 Advanced Gayo = canonical Lab 연구
- 10 Vocal Load = 운영 모델·제품 가설
- 18 Safety/Recovery = 안전 canonical

## 4. 커리큘럼 변경

### Beginner Foundation

- 48레슨과 Day 1/24/48 표준샘플 유지
- 정상 경로에는 유성 micro-win을 유지하지만, 쉰 느낌에는 no-voice 대체 레슨 허용
- 완주는 다음 단계 해금이며 skill 증명은 표준샘플·delayed/transfer evidence로 분리

### Universal Vocal Core

144레슨을 다음 네 패스로 재배치:

1. Map / Coordinate
2. Stabilize / Compare
3. Retain / Vary
4. Transfer / Check

각 36슬롯 패스에 breath/phonation, pitch/ear, rhythm/time, timbre/range, diction/phrase, checkpoint가 재등장한다. `UC-17`은 12슬롯마다 나오며 공식 milestone은 36/72/108/144다.

### Repertoire Application

72레슨을 다음 네 단계로 재배치:

1. Global Map
2. Local Scaffold
3. Recall / Fade
4. Transfer / Portfolio

guide vocal과 시각 도움을 단계적으로 줄이고, 다른 key/tempo/phrase에서 전이를 확인한다. 이 과정은 노래 제작 기능이 아니라 보컬 기술 적용 훈련이다.

### Advanced Genre Labs

가요, 뮤지컬, 성악, R&B/Soul, Rock/Band, CCM/Worship 문서를 다음 공통 구조로 상세화했다.

- baseline/intent
- 낮은 부하의 skill contrast
- phrase integration
- limited performance + recovery

고위험 기술은 여전히 미출시다.

## 5. 평가·자산 변경

- `ASSESSMENT-RUBRIC.md`: E0 완료부터 E5 독립 산출물까지 증거 계층 추가
- `PORTFOLIO-SPEC.md`: 공통 rubric + 장르 rubric
- `REPERTOIRE-ASSET-SPEC.md`: range, tessitura, rhythm, vowel/consonant, guide dependency 등 난이도 차원 상세화
- 4마디가 저작권 면책 기준이 아님을 명시
- one-take는 완벽함이 아니라 지정 부하 안에서의 독립 산출물로 정의

## 6. 제품·계측 변경

- `METRICS-AND-EXPERIMENTS.md`에 자기판단, feedback reveal, no-overlay, retention, transfer, guide fade, recovery no-voice 이벤트 추가
- `path.dart`에 v8 spiral/transfer stage 반영
- `path_test.dart` 기대값 갱신
- `tools/validate_v8.py` 추가

## 7. 공식 앵커 재검증

공식 NATS, NIDCD, ASHA, PubMed/PMC에서 다음 최소 주장을 다시 확인했다.

- 공통 보컬 기능 영역: respiration, phonation, resonance, registration, articulation
- 당일 수행과 retention/transfer의 구분
- 쉰·피곤한 목소리에서 노래 회피와 극단적 음역 회피
- easy phonation/resonant hierarchy의 임상 맥락
- SOVT 물리적 원리와 임상 프로토콜의 한계
- beat synchronization을 pitch와 분리해 볼 근거

기록: `docs/research/v8/VERIFIED-ANCHOR-SOURCES.md`.

## 8. 아직 완료하지 않은 것

- 01–05의 176개 전체 고유 임시 참조 복구
- 06–20 URL의 주장 단위 일괄 검증
- Rhythm & Time 보컬 학습자 직접 개입 연구
- 세 프레이즈의 실제 guide/backing/rights 자산 제작
- Flutter analyze/test
- Android/iOS 실기기 피치·녹음 QA
- 고급 장르 HITL와 runtime cap 검증
- 평가 루브릭 평가자간 신뢰도 시험

## 9. 다음 버전 제안

v9는 새 장르 확장보다 다음 vertical slice가 우선이다.

1. `neutral_001` 실제 음원·가사 timing·권리·QA 완성
2. Universal Core 1개 36-slot pass의 카드별 variant/cue/asset 상세화
3. retention/transfer checkpoint UI·event 연결
4. 01–05 출처 복구 P0/P1 주장부터 진행
5. 실제 Flutter/Android 테스트 환경에서 build·audio QA
