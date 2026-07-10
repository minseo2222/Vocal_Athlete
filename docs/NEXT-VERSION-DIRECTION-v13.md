# v13 업데이트 방향 — v12 완료 후 전체 재점검

## 1순위: Flutter 실행 검증 실제 수행

- `flutter pub get`
- `dart analyze`
- `flutter test`
- `flutter test integration_test`
- 실패 로그 보존
- compile/runtime 오류 수정

정적 검증은 강화됐지만, 실제 Flutter 컴파일과 widget/integration test 통과 없이는 고급 기능 확장을 멈춘다.

## 2순위: 복습 큐를 Today UX에 연결

v12는 설정 화면에서 복습 큐를 열 수 있다. v13에서는 다음을 검토한다.

- HomeScreen에 `오늘의 선택 복습` 카드 표시
- 복습을 정규 진도와 분리
- 복습 건너뛰기 문구 강화
- due task 완료 시 linked review evidence 생성

## 3순위: 콘텐츠 revision 강화

- 현재는 `track:cycle:version:day:cardId` 문자열 revision
- v13 이후 asset source hash 또는 bundle hash 추가 검토
- 과거 기록과 현재 blueprint가 달라졌을 때 비교 경고 표시

## 4순위: 첫 24일 vertical slice QA

- Universal Cycle 1 Day 1/6/12
- Repertoire Project 1 Day 1/11/12
- 녹음 take ID와 복습 task 연결
- review queue due item이 실제 학습 흐름에서 과하지 않은지 확인

## v13에서 제외

- 고급 장르 rollout
- 고위험 기술 해금
- 음색 종합점수
- 가수/원곡자 매칭률
- 클라우드 업로드
