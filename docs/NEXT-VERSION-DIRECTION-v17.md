# NEXT VERSION DIRECTION — v17

## 전체 점검 결론

v16은 첫 음색 과제를 blueprint·prototype audio·회복 대체·팔레트 집계까지 하나의 vertical slice로 연결했다. 그러나 아직 가장 큰 위험은 **합성 자산과 정적 코드가 실제 Flutter 앱에서 올바르게 재생되고, 사용자가 지시를 이해하며, 안전하게 자기판단을 할 수 있는지 검증되지 않았다는 점**이다.

## 1순위 — 실제 Flutter/Android 실행 검증

```text
flutter pub get
dart analyze
flutter test
flutter test integration_test
flutter build apk --debug
Android 실기기 smoke test
```

우선 확인할 흐름:

```text
Beginner Day 37/38 blueprint 로드
→ 저/중 prototype 재생
→ 시도 상한
→ 자기점검
→ 녹음 A/B
→ tone tag
→ Best take
→ Tone Profile 갱신
→ 쉰 상태 no-voice 대체
```

발생하는 type/API/widget/asset 오류를 먼저 수정한다.

## 2순위 — 최종 강사 guide 제작·검수 파이프라인

현재 v16 cue는 합성 prototype이다. 출시 전 다음이 필요하다.

- 남성/여성 고정이 아닌 낮은/중간 편안한 기준의 강사 가이드
- 지나친 비성·압착·음량 모방을 유도하지 않는 시범
- 레코딩 조건과 권리 동의
- 전문가 safety sign-off
- 기기별 loudness/clipping QA
- 합성 prototype과 teacher master의 명시적 교체 기록

정답/오답 발성 샘플을 사용자에게 흉내 내게 하지 않는다.

## 3순위 — Tone Profile 시간·migration 안정성

- 자정 경계와 timezone 변경 시 학습일 처리
- 날짜 미상 v14/v15 take migration
- 삭제 후 즉시 재계산
- 동일 세션 A/B가 같은 학습일로 처리되는지 확인
- raw take와 day-weighted frequency의 UI 이해도
- tone tag 전체 삭제와 원음 삭제 관계
- 사용자가 tag를 바꿀 수 있는 편집/철회 UX

필요하면 단순 local day가 아니라 저장 당시 timezone offset을 메타데이터에 포함한다.

## 4순위 — 소규모 사용성·안전 파일럿

초보자 5–10명과 보컬 전문가 검수로 다음을 확인한다.

- Hum-to-Vowel 지시를 한 번에 이해하는가
- 모음만 바꾸고 음높이·음량을 유지하는가
- low/mid 선택이 부담을 줄이는가
- 최대 2회가 충분하거나 과한가
- tag 용어가 정체성 라벨처럼 느껴지지 않는가
- 쉰 느낌에서 정말 발성을 멈추는가
- 3개 학습일 이후 팔레트가 의미 있다고 느끼는가

## 5순위 — 남은 음색 출처 26개 재검증

- 원 논문·DOI·공식 페이지 확인
- 건강한 가수와 임상 대상 분리
- 단일 사례·고강도 연구의 일반화 제한
- 한국어/K-pop 표본·방법 검토
- 상업 교수법 자료를 효능 근거와 분리
- 제품 수치는 계속 `D` 가설로 관리

## v17에서 제외할 것

- 자동 음색 점수
- spectral/formant/CPPS 사용자 표시
- 유명 가수·아이돌 매칭
- strong twang, belt, rasp, growl, scream 해금
- 고급 장르 rollout
- 클라우드 음성 업로드
- 실제 실행 검증 전 대규모 커리큘럼 확대

v17의 성공 기준은 **첫 음색 vertical slice가 실제 Android 기기에서 오류 없이 작동하고, 사용자가 한 변수·편안함·회복 경계를 이해하는지 확인할 수 있는 상태**다.
