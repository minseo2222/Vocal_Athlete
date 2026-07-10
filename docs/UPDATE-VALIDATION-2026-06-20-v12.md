# v12 Validation Report

## 정적 검증

`tools/validate_v12.py`로 다음을 확인한다.

- JSON/YAML 파싱
- Dart delimiter balance
- 경로가 참조하는 카드 ID 존재
- fallback target 존재
- v12 파일 존재
- review queue repository key/화면 marker 존재
- contentRevision/recordedTakeIds/bestTakeId marker 존재
- pubspec version `1.12.0+12`

## 실행 검증 스크립트

`tools/run_flutter_validation.sh`를 추가했다.

실행 순서:

```bash
cd app
flutter pub get
dart analyze
flutter test
flutter test integration_test
```

현재 환경에는 Flutter SDK와 모바일 실기기가 없어 위 명령을 실제로 실행하지 못했다.

## 남은 검증

- Android/iOS build
- Android RECORD_AUDIO runtime permission
- iOS microphone permission
- 실제 녹음 시작/정지/재생/삭제
- app lifecycle pause/resume 중 audio session 처리
- 복습 큐 UX 전환율과 학습효과
