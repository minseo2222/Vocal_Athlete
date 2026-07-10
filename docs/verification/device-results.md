# 기기 마이크 검증 — 결과 로그 (W3)

> `DEVICE-MIC-VERIFICATION.md` §4 템플릿으로 런마다 항목을 append.
> 최신 종합 결과를 `verification-status.json`의 `device.status`와 일치시킬 것.

## 현재 상태: UNVERIFIED (미수행)

아직 기기 육안 검증을 수행한 사람 기록이 없다. `RecordingPitchSource`는 코드·analyze
검증만 완료(단위 테스트 대상 아님). 실 기기에서 소리→곡선 반응은 *미확인*이다.

---

<!-- 검증 런을 아래에 append (최신이 위로) -->

### 검증 런 — 2026-06-23 (빌드/실행 파이프라인, 자동)
- 앱 버전(빌드): 1.18.0+18 / app-debug.apk (163,747,853 bytes)
- 기기: emulator-5554 (Google Pixel 7 AVD, Android 16 / API 36, android-x64)
- 관측자: 자동(에이전트) — adb logcat 기반
- 종합: **PARTIAL** — 빌드·설치·실행·렌더 PASS / 마이크·오디오 육안 QA는 미수행(사람 필요)
- 사전 수정: Android 네이티브 셸이 불완전(누락된 gradle/MainActivity + AndroidManifest v1 embedding)해 빌드 불가였음 → `flutter create . --platforms=android` 재생성 + AndroidManifest v2 embedding 보강으로 해결.
- 단계별:
  - 빌드: pass — `flutter build apk --debug` 성공(첫 빌드 후 재빌드 ~24s)
  - 설치: pass — `Installing app-debug.apk... ~1.8s` (에뮬레이터)
  - 실행: pass — `Start proc com.example.vocal_athlete`, `MainActivity` 시작, FATAL/크래시 없음
  - Flutter 엔진: pass — `FlutterJNI: flutter was loaded normally!`, Impeller(OpenGLES), `Sending viewport metrics`, 프로세스 생존 확인(pidof)
  - S1 경고화면(LaunchWarning): **미관측(육안 필요)**
  - S2~S8 마이크→피치, 권한 다이얼로그: **미수행** — 에뮬레이터 가상 마이크 입력 + 사람 청취 필요
  - 녹음/재생/삭제/재시작 영속성: **미수행** — 사람 조작 필요
- 비고:
  - `flutter test integration_test -d emulator-5554`는 `WebSocketChannelException: Connection closed before full header`로 로드 실패(2회 재시도 동일). 앱의 Dart VM service는 `127.0.0.1:33613`에서 정상 listen 중이었으므로 **앱 결함이 아니라 호스트↔에뮬레이터 VM service 연결(방화벽/loopback) 제약**으로 판단. 자동 on-device E2E는 이 환경에서 BLOCKED.
  - 호스트 단위/위젯 테스트는 251개 전부 PASS(`flutter test`), `flutter analyze --fatal-infos` 0건.
  - applicationId가 기본값 `com.example.vocal_athlete`임(릴리스 전 고유 ID로 변경 권장).
  - **종합 device.status는 여전히 UNVERIFIED** — 핵심인 소리→피치 반응·녹음 경로의 육안 QA가 미수행이므로 통과로 승급하지 않음(정직 원칙).
