# UPDATE VALIDATION — v15 — 2026-06-21

## Repository validation

명령:

```bash
python -B tools/validate_v15.py
```

결과: **PASS**

```text
JSON files: 26
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

first vertical-slice blueprints: 12 + 12
core cue WAV files: 11
repertoire WAV files: 9
content manifest files: 25
content manifest generator check: PASS

v15 timbre source registry: R1–R39 / 39 entries
spot-checked anchors: 8
pending full recheck: 31
uploaded integrated research SHA-256:
c56a464ed3e922e70cb066e95b47375ef4d4d579ed2547f75a983d3457eb5ea0

Tone cards: TONE-01~13
standard-sample milestones: Day 1 / 24 / 48
app version: 1.15.0+15
Flutter pin: 3.44.2
```

## 정적으로 확인한 무결성

- `CARD-13` Beginner index 0/23/47을 baseline/midpoint/graduation slot으로 매핑
- milestone-qualified take ID와 slot별 one-take cap
- `RecordingAbPanel`이 활성 milestone slot 안에서만 take 수를 계산
- Tone Profile은 저장된 사용자 tag·편안함·same-condition·Best/표준샘플에서만 파생
- 낮은 편안함·주의 느낌 tag는 편안한/reference category로 승격하지 않음
- Tone Profile에 spectral/formant/CPPS/jitter/shimmer/HNR 분석 의존성 없음
- v15 source register R1–R39 연속성과 CSV/JSON 동기화
- `TONE-01~13`의 1–3 take 상한과 안전 layer 존재
- TONE-11의 기기 상대적 거리 안내
- Repertoire Project 2/4/5/6의 모음 전이·bright/warm·마이크 조건·three-tone 과제
- ADR 번호 중복 없음
- v15 content manifest hash freshness

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
- 실제 마이크·로컬 파일·오디오 route QA

## 이 검증이 증명하지 않는 것

- Dart type correctness와 Flutter widget compilation
- plugin/native behavior와 앱 업그레이드 persistence
- 기기별 clipping/noise 안내의 정확도
- R1–R39 모든 출처와 파생 주장의 타당성
- 개인 사용자에 대한 보컬 안전성
- 음색 훈련의 실제 학습효과
- 훈련 음원의 권리 승인과 전문가 사인오프

## Patch reapplication verification

pristine v14에 v15의 62개 변경 파일을 덮어쓴 뒤 모든 비캐시 파일을 SHA-256으로 비교했다.

```text
v15 whole-project files: 486
reapplied-project files: 486
added files: 22
modified files: 40
deleted files: 0
missing: 0
extra: 0
content mismatch: 0
```

결과: **PASS**

## Package integrity

```text
full project ZIP entries: 486
patch ZIP entries: 62
full project ZIP test: PASS
patch ZIP test: PASS
```
