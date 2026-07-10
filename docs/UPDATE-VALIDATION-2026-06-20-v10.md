# v10 업데이트 검증 — 2026-06-20

## 검증 범위

- v9 경로 길이와 카드 참조 유지
- Universal Core Cycle 1 상세 12일과 path 순서 일치
- Repertoire Application Project 1 상세 12일과 path 순서 일치
- 날짜별 목표·단계·시도 상한·피드백·자기점검·회복 대체 존재
- low/mid 키별 훈련 cue와 반주 파일 존재
- guide fade: full → 부분 guide → backing only → backing-only key transfer
- Flutter nested asset 디렉터리 명시
- WAV 형식·sample rate·채널·peak·checksum·rights inventory
- Dart 괄호 정적 균형
- JSON/YAML 파싱

## 정적 검증 결과

`python tools/validate_v10.py`

```text
status: PASS
JSON: 17
YAML: 1
Dart delimiter files: 86
card library: 126
path card IDs: 110
fallback targets: 10

Beginner: 48
Universal Core: 12 cycles / 144 slots
Repertoire Application: 6 projects / 72 slots
Advanced cycles: 각 40 slots

Universal Core Cycle 1 blueprints: 12
Repertoire Project 1 blueprints: 12
Core prototype cue WAV: 11
Repertoire prototype WAV: 9
WAV: mono / 24 kHz / 16-bit PCM
prototype peak: full scale 0.50 이하
rights/WAV inventory: 일치
SHA-256: 일치
```

## 추가 정적 점검

- 모든 blueprint `cardId`가 첫 cycle/project path와 같은 순서인지 확인
- blueprint가 참조하는 모든 audio cue 존재 확인
- `neutral_001`의 low/mid guide, melody, slow guide, backing과 click 존재 확인
- `recommendedKeys == [low, mid]` 확인
- Core cue가 low/mid 쌍으로 구성됐는지 확인
- `pubspec.yaml`에서 중첩 asset 디렉터리를 각각 등록했는지 확인
- `LessonBlueprintPanel`, `RepertoirePracticePanel`, `TrainingAudioPlaybackAdapter` 연결 marker 확인
- 제3자 음원과 사람 보컬 녹음 미포함 선언 확인

## 실행하지 못한 검증

현재 환경에는 Dart/Flutter SDK와 Android/iOS 실기기가 없으므로 다음은 실행하지 못했다.

```text
dart analyze
flutter test
flutter build apk / ios build
실제 bundle asset 로딩
Android/iOS 훈련 음원 재생
Bluetooth/스피커/이어폰 지연과 볼륨
마이크 녹음과 훈련 음원 동시 사용
화면 overflow 및 접근성
초보자 usability
12일 retention/transfer 학습효과
발성 전문가 음역·가이드·호흡 검수
```

## 출시 판단

v10은 **기능·커리큘럼 검증용 vertical slice**이며 출시 승인 상태가 아니다. 합성 cue는 최종 강사 master가 아니고, full scale 0.50 peak 제한도 모든 기기에서의 안전 음량을 보장하지 않는다. 실기기·전문가·사용자 검증을 모두 통과해야 한다.
