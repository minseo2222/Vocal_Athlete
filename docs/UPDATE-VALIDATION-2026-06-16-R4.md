# UPDATE-VALIDATION-2026-06-16-R4

## 수행 검증

- Dart 파일 괄호/대괄호/중괄호 균형 정적 검사.
- beginner 48, Universal Core 144, Repertoire Application 72, advanced cycle 40 길이 파싱 확인.
- path manifest가 참조하는 모든 cardId가 `card_library.dart`에 존재하는지 확인.
- `RA-01~08` 카드 존재 확인.
- pending safety card의 fallback target이 card library에 존재하는지 확인.
- `verification-status.json` JSON 파싱.
- 사용자-facing 주요 문서/코드에서 `Song Builder` 명칭을 superseded pointer/ADR context 외에는 제거했는지 확인.
- `LessonScreen` light/recovery mode marker(`light-mode-notice`, `recovery-adaptation-notice`, `recovery-mode-notice`) 확인.
- 전체 ZIP 및 패치 ZIP 압축 무결성 확인.

## 수행하지 못한 검증

현재 실행 환경에는 `dart`/`flutter` CLI가 없어 다음은 수행하지 못했다.

- `dart analyze`
- `flutter test`
- Android 실기기 마이크/F0/녹음 검증

로컬 개발 환경에서 위 검증은 반드시 추가 실행해야 한다.
