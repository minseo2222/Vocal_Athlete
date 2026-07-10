# UPDATE VALIDATION — v14 — 2026-06-21

## 정적 검증

실행:

```bash
python tools/generate_content_manifest.py --version v14 --check
python tools/validate_v14.py
```

v14 validator가 확인하도록 구성한 항목:

- 모든 JSON/YAML 파싱
- Dart 문자열/주석 aware delimiter 균형
- local/package import target
- 카드 ID·경로·fallback 정합
- Beginner 48 / Universal Core 144 / 곡 적용 훈련 72 / 고급 각 40
- 첫 vertical slice blueprint 12 + 12
- v14 manifest 25개 파일 전체 SHA-256
- manifest generator freshness
- async metadata boundary와 legacy migration marker
- direct `shared_preferences` import 격리
- 곡 적용 훈련 시작 함수 단일 호출
- 카드별 복습 cue와 높은 키 처방 금지
- Flutter 3.44.2 CI gate marker
- 버전·문서·patch manifest 정합


실제 정적 결과:

```text
status: PASS
JSON: 23
YAML: 1
Dart delimiter: 111
local/package import: 233
card library: 126
path card IDs: 110
missing card/fallback: 0
Beginner: 48
Universal Core: 144
Repertoire Application: 72
Advanced: 각 40
first-slice blueprint: 12 + 12
content manifest: 25 files
  - blueprint 2
  - asset manifest 1
  - rights record 2
  - WAV 20
manifest generator check: PASS
metadata schema: 2
direct shared_preferences import: storage adapter 1개만
Repertoire start invocation: 1회
```

## Flutter 실행 시도

```bash
./tools/run_flutter_validation.sh
```

결과:

```text
exit_code=127
BLOCKED: flutter is not installed or not on PATH.
container_flutter_path=not_found
container_dart_path=not_found
```

따라서 현재 환경에서 실행되지 않은 항목:

```text
flutter pub get
dart analyze
flutter test
flutter test integration_test
flutter build apk --debug
```

GitHub Actions workflow는 추가했지만 이 ZIP 제작 환경에서 hosted workflow 성공 결과를 생성하지 않았다.

## 해석 제한

- Python 정적 PASS는 Flutter compile PASS가 아니다.
- SHA-256 일치는 교육 품질·권리 승인·보컬 안전을 증명하지 않는다.
- in-memory migration test는 실제 Android/iOS upgrade 무손실을 증명하지 않는다.
- 카드별 복습 cue 구현은 유지·전이 학습효과를 증명하지 않는다.
