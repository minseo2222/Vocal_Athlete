# Universal Core / Repertoire Application 구현 검증 — v10

## 권위 경로

```text
Beginner 48
→ Universal Core 144 (12 microcycles × 12)
→ Repertoire Application 72 (6 phrase projects × 12)
→ Advanced Genre Lab 40-slot repeat cycle
```

## 자동 검증

- Beginner 48, `CARD-13` Day 1/24/48
- `CARD-18`이 모든 정상 manifest에 없음
- Beginner `CARD-14` 최소 3회
- Universal 144, cycle 1–12 각각 12 slots
- 각 Universal cycle에 pitch, rhythm, phrase, review 포함
- `UC-17`이 index 35/71/107/143에만 존재
- Repertoire 72, project 1–6 각각 12 slots
- 각 project 첫 카드 `RA-09`, 마지막 카드 `RA-10`
- R&B/Rock/Worship path에 각각 RB/RK/WC 전용 카드 포함
- 모든 manifest cardId와 fallbackCardId가 library에 존재
- pending card는 승인 또는 safe fallback 없이는 원본 노출 금지
- 미출시 Advanced genre는 maintenance/wait로 이동

## 수동 검증

1. 목 상태가 정상일 때 recovery card가 오늘 레슨으로 나오지 않는다.
2. 피곤/쉰 상태에서 런타임 recovery/no-voice로 대체된다.
3. `UC-04`는 pressed 예시를 따라 하게 하지 않는다.
4. Universal Day 36/72/108/144에만 formal checkpoint가 기록된다.
5. Repertoire 프로젝트 첫날 whole take, 마지막 날 delayed whole take가 기록된다.
6. local loop 뒤 같은 프로젝트에서 whole phrase로 복귀한다.
7. RB/RK/WC 전용 카드가 해당 장르 화면과 자산에 연결된다.
8. 녹음 저장·재생·삭제·재시작 persistence를 실기기에서 확인한다.

## 실행 제한

정적 검사 통과는 Flutter compile, 실기기 오디오 동작, 학습 효과를 의미하지 않는다. `dart analyze`, `flutter test`, Android/iOS build, device QA, 사용자 retention/transfer test 결과를 별도 기록해야 한다.

## v10 첫 vertical slice 추가 검증

### 자동

- Universal Cycle 1 blueprint 12개가 path 첫 12개 cardId와 일치
- Repertoire Project 1 blueprint 12개가 path 첫 12개 cardId와 일치
- 모든 날짜에 주 목표·보조 목표·3단계 이상·시도 상한·회복 대체 존재
- Core cue와 neutral_001 WAV가 RIFF/WAVE 형식이며 rights checksum 기록 존재
- `pubspec.yaml`에 중첩 asset 디렉터리를 명시적으로 등록
- Repertoire manifest의 모든 audio path가 실제 파일로 연결

### 수동

1. Core Day 1/3/4/5/9/10/11의 예시 cue가 해당 날짜 목표와 일치하는지 전문가 확인
2. Repertoire의 count-in, 멜로디, 반주 길이가 맞는지 청취 확인
3. guide fade Day 1→12가 과제 의도와 일치하는지 확인
4. 작은 화면에서 lesson sheet scroll과 녹음 panel이 함께 사용 가능한지 확인
5. 합성 가이드가 최종 사람 보컬 모범으로 오인되지 않는지 카피 확인
