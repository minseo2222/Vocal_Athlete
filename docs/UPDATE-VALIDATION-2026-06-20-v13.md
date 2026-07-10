# Update Validation — v13 — 2026-06-20

## 정적 검증

실행:

```bash
python tools/validate_v13.py
```

결과:

```text
status: PASS
JSON: 21
YAML: 1
Dart delimiter: 105
card library: 126
path card IDs: 110
missing path cards: 0
fallback targets: 10
missing fallback targets: 0

Beginner Foundation: 48
Universal Vocal Core: 12 × 12 = 144
Repertoire Application: 6 × 12 = 72
Advanced genre cycles: 각 40

첫 vertical slice blueprint:
- Universal Core: 12
- Repertoire Application: 12

content manifest:
- algorithm: SHA-256
- tracked files: 4
- full hash recomputation: PASS
```

추가 검사:

- local/package import target smoke check: missing 0
- Today 선택 복습 marker
- due-only 복습 큐와 다음 날 재예약 marker
- linked `ReviewEvidenceRecord`
- 쉰 느낌에서 명시적 no-voice 흔적 요구
- source/current content revision 비교
- v13 app/version/document marker

## Flutter 실행 검증 시도

실행:

```bash
./tools/run_flutter_validation.sh
```

결과:

```text
exit code: 127
BLOCKED: flutter is not installed or not on PATH.
```

따라서 다음 명령은 시작되지 않았다.

```text
flutter pub get
dart analyze
flutter test
flutter test integration_test
```

SDK를 임시 설치하려는 네트워크 시도도 빌드 컨테이너의 DNS 제한으로 실패했다. 정적 PASS를 Flutter compile/test PASS로 표현하지 않는다.

## 실행하지 못한 검증

- Android/iOS build
- 실제 마이크 권한, 녹음, 재생, 삭제
- 앱 lifecycle, 통화/알림, Bluetooth route 변화
- 화면 overflow와 접근성
- Today 복습 발견성·부담감 사용자 시험
- E2/E3 유지·전이 학습효과

## 판정

v13 소스·문서·콘텐츠 manifest의 정적 정합성은 PASS다. Flutter 컴파일, 플러그인 런타임, 모바일 실기기, 학습효과는 BLOCKED 또는 UNVERIFIED다.
