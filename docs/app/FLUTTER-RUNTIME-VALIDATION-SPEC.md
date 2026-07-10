# FLUTTER RUNTIME VALIDATION SPEC — v14

## 목적

Python 정적 검증, Flutter 분석·테스트, Android build, 실기기 검증을 분리한다. 정적 PASS를 앱 실행 PASS로 표현하지 않는다.

## 고정 환경

```text
Flutter 3.44.2 stable
Dart: 해당 Flutter SDK에 포함된 버전
Java 17 for Android CI
```

저장 위치:

```text
.flutter-version
.github/workflows/flutter-validation.yml
```

## 로컬 명령

```bash
./tools/run_flutter_validation.sh
```

실행 순서:

```text
content manifest freshness check
repository validator
flutter --version / flutter doctor
flutter pub get
dart analyze
flutter test
flutter test integration_test
flutter build apk --debug
```

각 로그는 `build/validation-logs/`에 저장한다.

## CI

일반 push/PR:

```text
manifest check
v14 repository validator
dart analyze
unit/widget tests
Android debug APK build
```

수동 workflow dispatch:

```text
Android emulator integration tests
```

## 현재 제작 환경 결과

현재 컨테이너에는 Flutter/Dart가 없어 로컬 스크립트가 tool guard에서 exit 127로 중단된다. 따라서 v14 코드와 workflow는 구현됐지만 다음은 아직 실행 결과가 아니다.

- Dart analyzer 통과
- Flutter unit/widget/integration test 통과
- Android debug build 통과
- native permission dialog
- 실제 마이크·재생·오디오 route 전환

## 통과 정의

- manifest/validator: failure 0
- `dart analyze`: error 0
- `flutter test`: failure 0
- integration tests: 대상 device/emulator에서 failure 0
- Android debug build: 성공
- 실기기 smoke: 권한 허용·거부, 녹음·재생·삭제, pause/resume, 통화/오디오 route interruption 기록
