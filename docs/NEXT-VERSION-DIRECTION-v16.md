# NEXT VERSION DIRECTION — v16

## 전체 점검 결론

v15는 음색 리서치를 커리큘럼·카드·녹음 UI·사용자 기록으로 연결했다. 그러나 현재 가장 큰 위험은 “문서와 정적 코드가 연결됐다”는 사실을 “실제로 잘 가르치고 안전하게 작동한다”로 오해하는 것이다. v16은 새 음색 카드 확대보다 실행 검증과 첫 timbre vertical slice의 완성도를 우선한다.

## 1순위 — Flutter/Android 실제 검증과 오류 수정

```text
flutter pub get
dart analyze
flutter test
flutter test integration_test
flutter build apk --debug
Android 실기기 녹음·재생·삭제 smoke test
```

특히 `TONE-07` 2 take, `TONE-12` 3 take, tag sequence, Best take, Tone Profile 갱신, 쉰 상태 차단을 end-to-end로 확인한다.

## 2순위 — 첫 음색 vertical slice 상세화

- Beginner Day 37 `TONE-02` 상세 blueprint
- Beginner Day 38 `TONE-03` 상세 blueprint
- Universal Core Cycle 1의 `TONE-02` 상세 blueprint
- 낮은 강도의 최종 강사 guide/anti-pattern 자산
- no-voice recovery 대체
- 한 변수만 바꾸는 A/B 지시
- content manifest/rights record 편입

## 3순위 — Tone Profile 데이터·UX 검증

- tag가 없는 take와 기존 v14 take migration
- 삭제 후 즉시 재계산
- 같은 날 반복 take가 profile을 과도하게 지배하지 않는 집계 검토
- “자주 선택”과 “편안함”의 사용자 이해도 테스트
- 낮은 편안함 tag가 의료 경고처럼 보이지 않는지 확인
- profile 전체 삭제/녹음 삭제의 관계 확인

## 4순위 — 근거 정규화 계속

- pending 31개 출처의 원문·DOI·공식 페이지 재검증
- 건강한 가수 직접 근거와 임상 근거 분리 강화
- 한국어/K-pop 연구의 표본·방법·일반화 가능성 검토
- 제품 수치(레슨 수, take cap, 거리)의 `D` 상태 유지 또는 파일럿으로 조정

## 5순위 — 실사용 파일럿 설계

5–10명의 초보자와 다음을 본다.

- clean/warm/bright/speech-like tag를 이해하는가
- 같은 조건 A/B를 실제로 유지하는가
- 2–3 take 제한이 충분한가
- 첫 시도 후 자기판단이 가능한가
- 음색 팔레트가 동기를 높이는가, 정체성 라벨처럼 느껴지는가
- 피곤함·쉰 느낌에서 실제로 발성을 멈추는가

## v16 제외 범위

- 자동 음색 점수
- spectral/formant/CPPS 사용자 표시
- 유명 가수·아이돌 유사도
- 강한 twang, belt, rasp, growl, scream 해금
- 클라우드 음성 업로드
- 고급 장르 rollout

v16의 성공 기준은 “음색 기능이 더 많아짐”이 아니라 **첫 음색 과제가 실제 앱에서 오류 없이 작동하고, 사용자가 진단 없이 한 가지 톤을 편안하게 선택·재현할 수 있는지 확인할 수 있는 상태**다.
