# UPDATE VALIDATION — v16 — 2026-06-21

## Repository validation

명령:

```bash
python -B tools/validate_v16.py
```

결과: **PASS**

```text
JSON files: 31
YAML files: 1
Dart delimiter files: 116
local/package imports checked: 243
card library: 126
path card IDs: 110
missing path card IDs: 0
fallback targets: 15
missing fallback targets: 0

Beginner Foundation: 48
Universal Vocal Core: 12 × 12 = 144
Repertoire Application: 6 × 12 = 72
Advanced Genre Lab cycles: each 40

v16 content manifest: 31 files
- blueprints: 3
- asset manifests: 1
- rights records: 3
- WAV audio: 24
manifest generator check: PASS

Beginner timbre blueprint: 2 lessons / Days 37–38
Universal Core Cycle 1 blueprint: 12 lessons / v16
Repertoire Project 1 blueprint: 12 lessons / v10
Timbre prototype WAV: 4
Core cue WAV: 11
Repertoire WAV: 9

Tone cards: TONE-01~13
Tone Profile: local practice-day × tag
minimum displayed history: 3 distinct practice days

Timbre source registry: R1–R39 / 39 entries
spot-checked in v15: 8
spot-checked in v16: 5
pending full recheck: 26

app version: 1.16.0+16
Flutter pin: 3.44.2
```

## 정적으로 확인한 무결성

- Beginner Day 37/38이 path의 `TONE-02/03`과 일치
- Beginner 음색 과제는 각각 최대 2회 시도
- 예시의 절대 음높이를 복제하지 않고 사용자 편한 한 음에서 수행하도록 지시
- 쉰 상태는 발성·속삭임 없이 듣기/구간 표시로 대체
- Universal Core Cycle 1 Day 6이 2회 제한 `TONE-02` blueprint와 일치
- 합성 cue 4개가 mono 24 kHz/16-bit PCM이며 선언 peak 0.38 이하
- rights.json의 파일 목록·SHA-256과 실제 WAV 일치
- content manifest의 31개 SHA-256과 실제 파일 일치
- `pubspec.yaml`에 timbre_v16 중첩 asset 디렉터리 명시
- Tone Profile은 같은 날 같은 tag를 안정 빈도에 1회만 반영
- 같은 날 편안함 기록 충돌 시 낮은 편안함 신호 보존
- 날짜 미상 legacy take는 안정 빈도에서 제외하고 reference는 보존 가능
- spectral/formant/jitter/shimmer/HNR/CPPS 기반 점수 없음
- R27의 잘못된 제목 수정 및 v16 연구 레지스트리 CSV/JSON 동기화
- ADR 번호 중복 없음

## Flutter runtime probe

명령:

```bash
./tools/run_flutter_validation.sh
```

결과:

```text
BLOCKED: flutter is not installed or not on PATH. Expected Flutter 3.44.x stable.
exit_code=127
```

따라서 아래는 이 환경에서 실행하지 못했다.

- `flutter pub get`
- `dart analyze`
- `flutter test`
- `flutter test integration_test`
- Android/iOS build
- 실제 asset 재생·마이크 녹음·A/B·삭제
- 화면 overflow·접근성
- Android/iOS audio route·interruption

## 이 검증이 증명하지 않는 것

- Dart type correctness와 Flutter widget compilation
- 합성 cue의 강사 master 적합성
- 개인 사용자에 대한 보컬 안전성
- tone tag의 이해도·일관성·재현성
- 2회 시도와 3학습일 기준의 최적성
- 출처 26개의 원문 타당성
- 실제 음색 학습효과
- 권리 기록의 법률 승인

## Patch reapplication verification

pristine v15에 v16의 46개 변경 파일을 덮어쓴 뒤 모든 비캐시 파일을 SHA-256으로 비교했다.

```text
v16 whole-project files: 507
reapplied-project files: 507
added files: 21
modified files: 25
deleted files: 0
missing: 0
extra: 0
content mismatch: 0
```

결과: **PASS**

## Package integrity

```text
full project ZIP file entries: 507
patch ZIP file entries: 46
full project ZIP test: PASS
patch ZIP test: PASS
```
