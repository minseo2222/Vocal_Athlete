# v12 업데이트 방향 — v11 완료 후 전체 재점검

> 작성일: 2026-06-20. 아래 순서는 새 기능의 매력도가 아니라 학습효과·출시 리스크·의존성을 기준으로 정했다.

## 1. v11 이후 현재 상태

### 확보된 것

- 초급 48 → Universal Core 144 → 곡 적용 72 → 고급 장르 반복 구조
- 첫 Universal 12일·곡 적용 12일 상세 blueprint와 프로토타입 음원
- 녹음 A/B 로컬 저장·리뷰·삭제 기반
- 목 상태 adaptation과 vocal load 정책
- completion과 수행 메타데이터의 분리
- 가이드/녹음/생명주기 오디오 interlock

### 여전히 증명되지 않은 것

- Flutter compile·전체 테스트 성공
- Android/iOS 실제 마이크·재생·audio focus 동작
- 첫 12일의 학습효과와 지연 유지
- 목표 evidence E1~E5의 실제 달성
- 합성 cue의 교육적 적합성과 최종 강사 master 품질
- Cycle 2~12, Project 2~6의 실제 콘텐츠
- 고급 장르 전문가 승인

## 2. v12 권장 범위

### P0 — 실행 가능한 검증 파이프라인

1. Flutter SDK가 있는 환경에서 `dart analyze`, `flutter test`, integration test를 실행한다.
2. 실패를 문서화하고 수정해 녹색 상태를 만든다.
3. Android 실기기 1차 smoke matrix를 실행한다.
4. 가이드 재생 → 녹음 시작 → 앱 pause → 복귀 → 삭제 흐름을 검증한다.

이 항목이 실패하면 콘텐츠 확장을 멈춘다.

### P1 — 실제 지연 재현 체크포인트

현재 v11은 목표 evidence와 수행 흔적만 저장한다. v12에서는 다음을 추가한다.

- `dueAt` 기반 복습 큐
- immediate(E1)와 delayed(E2/E3) 기록 분리
- 콘텐츠 revision/hash
- 같은 과제 재현과 한 조건 전이 구분
- 사용자가 건너뛰어도 streak를 잃지 않는 복습 UX

### P1 — 첫 24일 평가 가능한 vertical slice

- Universal Day 1/6/12 checkpoint
- 곡 적용 Day 1 baseline / Day 11 재통합 / Day 12 지연·전이
- 녹음 take와 학습 기록 연결 ID
- 결과는 단일 점수가 아니라 pitch/rhythm/comfort/independence 영역별 증거로 표시

### P2 — 콘텐츠 확장

검증 파이프라인이 통과한 후에만 다음을 만든다.

- Universal Core Cycle 2 상세 12일
- Repertoire Project 2 자체 프레이즈·권리 기록·가이드 fade
- 사용자 comfortable range/key calibration 초안

## 3. v12에서 하지 않을 것

- 고급 장르 release
- belt/run/cover/messa 등 고위험 unlock
- 음색 종합 점수
- 유명 가수 유사도
- 전체 144+72일 자산 일괄 제작
- 클라우드 녹음 업로드

## 4. v12 성공 기준

- `dart analyze`와 `flutter test` 결과가 문서화되어 있다.
- integration test가 실제 device/emulator에서 실행된다.
- 앱 pause/전화·focus loss 시 오디오·캡처가 남지 않는다.
- D+1 지연 재현 과제가 자동 생성되고 완료 기록과 구분된다.
- baseline과 delayed take가 같은 콘텐츠 revision으로 연결된다.
- 사용자에게 evidence target과 achieved evidence를 혼동시키지 않는다.

## 5. 전체 로드맵 재점검

- **v12:** 검증 파이프라인 + 지연 재현 큐
- **v13:** Cycle 2 / Project 2 + comfortable range/key calibration
- **v14:** 초보자 5~10명 formative pilot와 UX 수정
- **v15:** 전문가 2인 audio/curriculum/safety review 및 첫 master 교체
- 이후에만 Beginner MVP release candidate와 고급 트랙 준비도를 재판정한다.
