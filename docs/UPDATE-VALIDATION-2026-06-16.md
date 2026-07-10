# 업데이트 검증 메모 — 2026-06-16

> 목적: 피드백 반영 업데이트 후 이 환경에서 수행한 확인과, 수행하지 못한 검증을 분리한다.

## 수행한 확인

- `docs/verification/verification-status.json` JSON 파싱 확인.
- 신규 핵심 문서 존재 확인.
  - `docs/app/MVP-SCOPE.md`
  - `docs/app/PRODUCT-LOOP-SPEC.md`
  - `docs/app/GAMIFICATION-SPEC.md`
  - `docs/verification/SAFETY-RELEASE-GATE.md`
  - `docs/app/DATA-PRIVACY-SPEC.md`
  - `docs/app/METRICS-AND-EXPERIMENTS.md`
  - `docs/adr/0017-mvp-product-loop-safety-gate.md`
  - `docs/research/PRODUCT-RESEARCH-ADDENDUM-2026-06-16.md`
  - `docs/research/EXTERNAL-RESEARCH-GAPS-2026-06-16.md`
- `LessonScreen` 완료 루프 정합성 확인.
  - entry/warmp-up 단계: `complete-button` 노출 없음.
  - entry 단계 CTA: `본운동으로 가기`.
  - main 단계 CTA: `쿨다운으로 가기`.
  - main 단계 완료 경로: `skip-cooldown`.
  - cooldown 단계 완료 경로: `complete-button`.
- 위 변경에 맞춰 widget/integration test 기대값을 갱신했는지 grep 기반으로 확인.

## 수행하지 못한 확인

이 컨테이너에는 Flutter/Dart CLI가 설치되어 있지 않아 다음 명령은 실행하지 못했다.

- `flutter test`
- `dart analyze`
- 실제 Android 기기 마이크/F0 검증

## 출시 전 필수 확인

1. 로컬 개발 환경에서 `flutter test` 전체 실행.
2. `dart analyze` 실행.
3. Android 실기기 3종 이상에서 `docs/verification/DEVICE-MIC-VERIFICATION.md` 기준으로 마이크/F0 확인.
4. 중급 공개 전 `docs/verification/SAFETY-RELEASE-GATE.md`의 runtime cap, fallback, stop signal, rollout config 테스트 구현.
