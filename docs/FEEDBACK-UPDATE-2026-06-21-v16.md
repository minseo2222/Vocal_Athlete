# FEEDBACK UPDATE — v16 — 2026-06-21

## 수용한 방향

v15 종료 점검에서 정한 우선순위를 따라, 새 음색 기능을 넓히지 않고 **첫 음색 vertical slice의 실행 단위와 데이터 해석 결함**을 먼저 보완했다.

```text
Beginner Day 37 TONE-02
Beginner Day 38 TONE-03
Universal Core Cycle 1 Day 6 TONE-02
→ 상세 cue·시도 상한·저/중 음역 prototype·no-voice recovery 연결
```

또한 같은 날 반복 녹음이 `내 음색 팔레트`를 과도하게 지배하지 않도록 집계를 원본 take 수에서 **학습일 × tag** 중심으로 변경했다.

## 구현한 내용

1. `beginner_timbre_slice_v16.json`에 초급 Day 37·38의 날짜별 목표, 단계, 최대 2회 시도, 자기점검, 회복 대체를 정의했다.
2. Universal Core Cycle 1 Day 6의 Hum-to-Vowel blueprint를 v16으로 보강하고 시도 상한을 2회로 제한했다.
3. 저/중 음역 선택용 deterministic synthetic prototype WAV 4개를 생성했다.
4. `timbre_v16/rights.json`에 생성 방식, 권리 상태, SHA-256, peak 0.38 정책을 기록했다.
5. `content_manifest_v16.json`에 초급 blueprint와 음색 자산을 포함해 총 31개 파일을 고정했다.
6. LessonScreen이 Beginner Day 37·38에서만 상세 음색 blueprint를 로드하도록 연결했다.
7. 피곤함·쉰 느낌에는 예시 듣기·구간 표시·모음 순서 확인만 허용하고 발성·속삭임을 대체 과제로 쓰지 않았다.
8. Tone Profile을 로컬 학습일 단위로 집계해 같은 날 같은 tag 반복 take는 안정 빈도에 한 번만 기여하도록 했다.
9. 같은 날 같은 tag에 편안함 기록이 충돌하면 낮은 편안함 신호를 보존한다.
10. 최소 3개의 서로 다른 학습일 전에는 팔레트를 충분한 데이터로 해석하지 않는다.
11. 날짜가 없는 legacy take는 reference로 보존할 수 있지만 안정 빈도에서 제외한다.
12. 음색 출처 5개를 추가 재검증해 R1–R39 중 확인된 출처를 13개로 늘리고, 26개는 pending으로 유지했다.

## 유지한 경계

- 합성 cue는 최종 강사 master나 정답 음색이 아니다.
- 합성 cue는 정상/비정상 후두 설정 예시가 아니다.
- 음색 종합점수, 성대 상태 판정, 가수 유사도 없음.
- strong twang, belt, rasp, growl, scream 일반 공개 없음.
- 쉰 느낌에서 음색 실험 없음.
- 2회 시도, 3학습일, peak 0.38은 검증된 생물학적 기준이 아니라 제품 가설이다.

## 제한

현재 환경에는 Flutter/Dart와 모바일 실기기가 없어 실제 compile, widget/integration test, Android/iOS asset 재생, 녹음, 화면 overflow, 사용자의 tag 이해도, 발성 전문가 안전 검수와 학습효과를 확인하지 못했다.
