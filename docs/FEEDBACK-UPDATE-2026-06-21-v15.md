# FEEDBACK UPDATE — v15 — 2026-06-21

## 수용한 피드백

업로드된 통합 음색 리서치를 수용하되, 별도의 12주 음색 코스를 추가하지 않았다. 음색은 기존 장기 구조 안에서 **관찰 → 조절 → 재현 → 프레이즈 전이 → 장르 적용**으로 나누어 배치했다.

```text
Beginner Foundation: 내 소리 관찰과 낮은 부하의 hum-to-vowel
Universal Vocal Core: source/filter/learning-safety 기반 음색 조절 나선
Repertoire Application: 동일 프레이즈 A/B/C와 마이크 조건 비교
Advanced Genre Labs: 장르 미학 적용 — rollout/HITL 전에는 미출시
```

## 구현한 내용

1. 업로드 원문을 `docs/research/v15/TIMBRE-INTEGRATED-RESEARCH.md`에 보존하고 R1–R39를 CSV/JSON 레지스터로 정규화했다.
2. 근거를 `S` 건강한 가수 직접 연구, `C` 임상, `M` 운동학습·음향 간접 근거, `P` 공식 교육과정·전문가 체계, `D` 제품 가설로 구분했다.
3. 8개 앵커 출처는 v15에서 spot check했고, 나머지 31개는 `imported_pending_full_recheck` 상태로 남겼다.
4. `TONE-01~13`에 layer, 사용자 선택 tag, A/B/C 순서, 시도·take 상한, 부하·fallback 메타데이터를 정리했다.
5. `TONE-07`은 bright→warm 2 take, `TONE-12`는 clean→warm→speech-like 3 take로 연결했다. 정답 음색이나 종합점수는 만들지 않았다.
6. 저장된 사용자 tag, 편안함, 같은 조건 확인, Best/표준샘플만 요약하는 `내 음색 팔레트`를 추가했다. 음향·성대·건강 추론은 하지 않는다.
7. Beginner Day 37·38에 `TONE-02`와 `TONE-03`을 배치하고, 공통 코어와 곡 적용 훈련에는 단계별 음색 과제를 나선형으로 재배치했다.
8. `TONE-11`의 20–30cm를 절대 정답으로 쓰지 않고, 기기별 시작 위치 뒤 clipping/noise를 보고 거리를 조절하도록 수정했다.
9. Day 1·24·48 `CARD-13`이 한 개의 녹음 한도를 공유하던 결함을 수정했다. baseline/midpoint/graduation은 독립 slot, ID, one-take budget을 사용한다.
10. `content_manifest_v15.json`을 생성하고 런타임 콘텐츠 revision을 v15 manifest로 연결했다.

## 유지한 제품 경계

- 음색 종합점수 없음
- 성대 접촉·후두 위치·음성 건강 자동 판정 없음
- 유명 가수·아이돌 유사도 없음
- 사용자를 “pressed singer” 같은 정체성으로 라벨링하지 않음
- strong twang, belt, rasp, growl, scream 일반 공개 없음
- 클라우드 음성 업로드·모델 학습 추가 없음
- 쉰 느낌에서는 음색 실험 대신 no-voice/recovery 대체

## 제한

현재 환경에서는 정적 검증만 수행했다. Flutter type analysis, widget/integration test, Android/iOS build, 실제 녹음·재생·삭제, 사용자 이해도, 전문가 안전 검수, 학습효과는 아직 검증하지 못했다.
