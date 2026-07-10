# NEXT VERSION DIRECTION — v15

## 전체 재점검 결론

v14는 실행 검증을 자동화할 경계와 데이터 migration을 만들었다. 다음 병목은 코드 기능 추가가 아니라 **실제 CI/Android 결과를 받아 오류를 닫는 것**과 **첫 학습 구간의 실기기·사용자 QA**다.

## 1순위 — 실제 CI 실패 수정

- GitHub Actions 또는 Flutter 3.44.2 환경에서 `pub get`, analyze, unit/widget test, APK build 실행
- 실패 로그를 기준으로 compile/API/widget test 수정
- 수동 Android emulator integration job 실행
- 성공 commit과 로그 보존

## 2순위 — v13 → v14 실기기 upgrade migration

- 기존 진행·학습·복습 데이터 보존
- migration 중복 실행 없음
- 손상 데이터 quarantine
- 초기화 후 녹음 원음 보존
- Android DataStore/legacy 경계 실제 확인

## 3순위 — Android audio smoke

- 권한 허용·거부·재시도
- 녹음/정지/재생/삭제
- 가이드와 녹음 상호 배제
- 앱 pause/resume
- 통화·알림·블루투스 route 전환
- 로컬 저장 persistence

## 4순위 — 첫 24일 사용성 시험

- Universal Core Day 1/6/12
- 곡 적용 훈련 Day 1/11/12
- D+1/D+3 복습
- card-specific cue 이해도
- no-voice recovery 준수
- 녹음 부담과 화면 접근성

## 5순위 — 검증 후 콘텐츠 확장

- Cycle 2와 Project 2의 날짜별 blueprint
- 최종 강사 guide master와 권리 기록
- 편안한 key/range calibration
- 복습에서 새 take와 원 take A/B 연결 강화

## v15 제외

- 고급 장르 공개
- belt·고속 run·rasp·growl·scream 해금
- 종합 가수 점수
- 유명 가수 매칭
- 클라우드 음성 업로드
- 실행 검증 전 대규모 커리큘럼 추가
