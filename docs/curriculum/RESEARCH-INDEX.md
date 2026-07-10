# 커리큘럼 ↔ 리서치 인덱스 — v16

> 목적: 업로드된 20개 심층 리서치와 기존 음색 리서치 1개를 커리큘럼·제품 결정에 추적 가능하게 연결한다.  
> canonical source bundle: `docs/research/v8/source-bundle/`  
> 근거 분류: `docs/research/v8/EVIDENCE-TAXONOMY.md`  
> 적용 결정표: `docs/research/v8/EVIDENCE-MATRIX.md`


## 0. v16 음색 canonical research

음색 관련 현재 권위 자료는 다음이다.

- 원문 보존: `docs/research/v15/TIMBRE-INTEGRATED-RESEARCH.md`
- R1–R39 출처 레지스트리: `docs/research/v15/timbre-source-register.json` 및 `TIMBRE-SOURCE-REGISTER.csv`
- 주장→제품 적용 결정: `TIMBRE-EVIDENCE-APPLICATION-MATRIX.md`
- 검증된 외부 앵커: `VERIFIED-ANCHOR-SOURCES.md`

- v16 재검증 레지스트리: `docs/research/v16/timbre-source-register.json` 및 CSV
- v16 확인 요약: `TIMBRE-SOURCE-RECHECK.md`
- 현재 확인: v15 8개 + v16 5개 = 13개, pending 26개

기존 `docs/research/v8/source-bundle/21-timbre-resonance-integrated-research.md`는 역사 보존본이다. v15 원문·적용 결정은 계속 보존하며, v16부터 개별 재검증 상태는 `docs/research/v16/`을 우선한다. R1–R39가 모두 동일한 강도로 검증된 것은 아니며, 상업 페다고지의 고유 명칭·recipe·도표는 복제하지 않는다.

## 1. v8 리서치 묶음

| 번호 | 정규화 파일 | 주제 | 주 적용 영역 | 현재 상태 |
|---:|---|---|---|---|
| 01 | `01-beginner-foundation.md` | 초급 48일 기초 | Beginner Foundation | 임시 인용 복구 필요 |
| 02 | `02-universal-vocal-core.md` | 공통 중급 전체 | Universal Vocal Core | 임시 인용 복구 필요 |
| 03 | `03-breath-support.md` | 호흡·프레이즈 관리 | Core: Breath/Support | 임시 인용 복구 필요 |
| 04 | `04-phonation-onset.md` | 발성 시작·균형 발성 | Core: Phonation/Onset | 임시 인용 복구 필요 |
| 05 | `05-pitch-ear.md` | 청음·음정·내적 청취 | Core: Pitch/Ear | 임시 인용 복구 필요 |
| 06 | `06-registration-range.md` | 레지스터·usable range | Core: Registration/Range | 링크 일괄 검증 필요 |
| 07 | `07-korean-diction.md` | 한국어 가사 명료도 | Core·곡 적용·가요 | 링크 일괄 검증 필요 |
| 08 | `08-repertoire-application.md` | 프레이즈·곡 적용 | Repertoire Application | 링크 일괄 검증 필요 |
| 09 | `09-advanced-gayo-background.md` | 가요/K-pop 배경 분석 | Advanced Gayo 참고 | 링크 일괄 검증 필요 |
| 10 | `10-vocal-load-operating-model.md` | 부하 운영 모델 | Safety 운영 가설 | 링크 일괄 검증 필요 |
| 11 | `11-advanced-gayo-kpop-lab.md` | 가요 고급 Lab | Advanced Gayo canonical | 링크 일괄 검증 필요 |
| 12 | `12-advanced-musical-theatre-lab.md` | 뮤지컬 고급 Lab | Advanced Musical canonical | 링크 일괄 검증 필요 |
| 13 | `13-advanced-classical-lab.md` | 성악 고급 Lab | Advanced Classical canonical | 링크 일괄 검증 필요 |
| 14 | `14-advanced-rnb-soul-lab.md` | R&B/Soul 고급 Lab | Advanced R&B/Soul canonical | 링크 일괄 검증 필요 |
| 15 | `15-advanced-rock-band-lab.md` | Rock/Band 고급 Lab | Advanced Rock canonical | 링크 일괄 검증 필요 |
| 16 | `16-advanced-ccm-worship-lab.md` | CCM/Worship 고급 Lab | Advanced CCM canonical | 링크 일괄 검증 필요 |
| 17 | `17-portfolio-performance-mode.md` | 수행평가·포트폴리오 | Assessment·Portfolio | 링크 일괄 검증 필요 |
| 18 | `18-vocal-load-safety-recovery.md` | 안전·피로·회복 | Safety canonical | 링크 일괄 검증 필요 |
| 19 | `19-app-learning-methodology.md` | 운동학습·피드백·복습 | 전 단계 방법론 canonical | 링크 일괄 검증 필요 |
| 20 | `20-repertoire-asset-authoring.md` | 훈련 프레이즈 제작 | Asset authoring canonical | 링크 일괄 검증 필요 |
| 21 | `21-timbre-resonance-integrated-research.md` | 음색·공명 통합 역사본 | Timbre 전 단계 | v15 canonical 자료로 승계 |

세부 파일 상태는 `SOURCE-STATUS-MATRIX.md`, 원 링크 목록은 `SOURCE-REGISTER.csv`, 미복구 항목은 `SOURCE-RECOVERY-BACKLOG.md`를 따른다.

## 2. 근거 분류 규칙

v9은 주장과 제품 결정을 다음처럼 구분한다.

| 코드 | 의미 | 제품 적용 원칙 |
|---|---|---|
| `S` | 건강한 가수 대상 직접 연구 | 대상·과제·용량이 맞을 때 우선 적용 |
| `C` | 임상 음성치료 연구 | 원리를 참고하되 건강한 가창 효과로 직접 일반화 금지 |
| `M` | 운동학습·음악인지 간접 근거 | 피드백·복습·전이 설계에 적용 |
| `P` | 공식 교육과정·전문가 합의 | 모듈 구성과 교육 순서의 근거 |
| `D` | 제품 설계 가설 | 실험값으로 표시하고 안전선처럼 표현 금지 |

근거 강도와 제품 위험도는 별도 축이다. 연구가 많아도 고강도 belt·rasp·scream처럼 앱 단독 위험이 크면 HITL과 런타임 제한이 우선한다.

## 3. 단계별 연구 반영

### Beginner Foundation — 48레슨

- 낮은 노력의 coordination, SOVT, easy onset, 자기청취, 간단한 pulse·contour·한국어 bridge를 유지한다.
- SOVT 자체를 목표로 삼지 않고 허밍·모음·짧은 음절로 전이한다.
- Day 1/24/48 표준샘플은 시험이 아니라 동일 조건의 변화 기록이다.
- 근거 상태: 구조는 적용 가능하나 01번 문서의 임시 인용 복구가 남아 있다.

### Universal Vocal Core — 144레슨

- 12일 microcycle을 12회 순환한다.
- 각 microcycle에 pitch/ear, rhythm/time, phrase transfer, retrieval/checkpoint가 다시 등장한다.
- 세 microcycle이 `Map → Stabilize → Retain → Transfer` macro phase를 이룬다.
- SOVT·모음·onset·range는 개별 기술로 끝내지 않고 매 패스에서 프레이즈로 전이한다.
- 정확한 레슨 수와 카드 빈도는 `D` 등급 제품 가설이며 사용자 시험으로 조정한다.

### Repertoire Application — 72레슨

- 작곡·노래 제작이 아니라 배운 보컬 기술의 실제 프레이즈 전이 단계다.
- 12일 phrase project를 6회 운영하며 각 project 안에서 Global→Local→Global을 완결한다.
- 한 과제의 주목표는 1개, 보조목표는 최대 1개로 제한한다.
- guide vocal·피치 곡선·가사 표시 등 도움은 단계적으로 줄여 독립 수행을 확인한다.
- 4마디라는 길이는 저작권 면책 기준이 아니며, 출시 자산은 자체 제작 또는 명시적 라이선스를 사용한다.

### Advanced Genre Labs — 반복 40슬롯 cycle

- 가요, 뮤지컬, 성악, R&B/Soul, Rock/Band, CCM/Worship, 사용자 곡 프로젝트를 고급에서만 분기한다.
- 각 cycle은 진단/목표 → 기술 적용 → 구간 반복 → 녹음·회복의 네 단계다.
- 고급은 무한 콘텐츠 피드가 아니라 반복 가능한 곡 프로젝트다.
- belt, cover, messa, 고속 run, 강한 twang, distortion 계열은 근거 유무와 별개로 HITL·cap·fallback이 없으면 미출시다.

### Portfolio / Performance

- 일일 진행은 completion 기반을 유지한다.
- 레벨 인증은 retention, transfer, 자기수정이 확인되는 녹음 산출물 기반이다.
- 공통 루브릭과 장르별 모듈을 분리하고 단일 “가수 점수”는 만들지 않는다.

## 4. 중복 처리 결정

- 09번은 가요/K-pop 장르 배경 자료, 11번은 Advanced Gayo Lab의 canonical 설계다.
- 18번은 안전·회복의 canonical 근거, 10번은 VLU·일/주간 cap 같은 운영 가설 자료다.
- 기존 음색 리서치는 21번으로 편입하며, 음색은 점수보다 A/B·tone tag·재현성으로 평가한다.

## 5. 잔존 리서치 갭

1. **01–05 출처 복구**: `turn...` 임시 인용 725회 출현(문서별 고유 합계 195개·전체 고유 176개)을 실제 서지·URL로 연결해야 한다.
2. **Rhythm & Time 독립 심층문서**: 현재 Core·방법론 문서에 흩어져 있으므로 독립 모듈 수준으로 보강해야 한다.
3. **SOVT→가창 전이 용량**: 도구별·사용자별 최적 반복량은 확정 근거가 부족하다.
4. **한국어 가창 데이터**: 딕션·모음·받침의 자동 피드백 데이터셋이 부족하다.
5. **모바일 음향 검증**: F0, timing, clipping/noise, 녹음 조건을 Android 실기기에서 확인해야 한다.
6. **고강도 부하량**: 고음·belt·run·full take의 정확한 일/주간 cap은 제품 가설이며 전문가 검수와 관찰 데이터가 필요하다.
7. **평가 신뢰도**: 포트폴리오 루브릭의 평가자간 일치도와 사용자 자기평가 일치도를 시험해야 한다.

## 6. 커리큘럼 반영 원칙

- 출처가 미복구된 주장은 교육 아이디어로 참고할 수 있지만 “검증 완료”로 승급하지 않는다.
- 임상 근거는 치료 효과가 아니라 낮은 부하 과제의 원리와 단계화 참고로만 쓴다.
- 숫자 용량·임계점·주차는 제품 실험값으로 표시한다.
- 안전 관련 결정은 논문 수보다 증상 기반 중단, HITL, runtime cap, fallback을 우선한다.
- 새 카드에는 학습목표, 선행조건, cue, 반복 상한, 피드백, 대체과제, 산출물, 근거 태그가 모두 있어야 한다.

## 7. v9 재점검 추가 자료

- `docs/research/v9/CURRICULUM-RECHECK.md`
- `docs/research/v9/VERIFIED-SOURCES.md`
- `docs/curriculum/CURRICULUM-QUALITY-GATES.md`

v8 source bundle은 계속 보존하며, v9 자료는 코드 배치 재점검과 외부 앵커 검증을 추가한다.
