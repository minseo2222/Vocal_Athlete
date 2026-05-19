# F1 — 스캐폴드 부팅

Status: in-progress — 스캐폴드·스파이크·CI·테스트 완료(green). *실기기 지연 측정*(ADR-0013 조건부 검증)만 남음 — Android Studio/SDK + `flutter doctor` 필요(대화형, 사용자)

## 진행 메모

- `app/` Flutter 프로젝트 생성, `flutter analyze` 클린 + `flutter test` 2/2 통과
- 오디오 지연 스파이크: `app/lib/main.dart` + `app/lib/spike/pitch_naive.dart`(순수·교체 seam)
- 권한(Android RECORD_AUDIO / iOS 마이크), CI(`.github/workflows/flutter-ci.yml`), README 실행법
- **남은 AC**: 기기에서 `flutter run` → avg latency 실측 → 수용/폴백 판정 기록 후 본 이슈 done



## What to build

**Flutter**(ADR-0013) 프로젝트를 스캐폴드해, 에뮬레이터/기기에서 *빈 화면이 1-커맨드로* 뜨게 한다. lint + 테스트가 CI에서 도는 최소 골격 포함. 비즈니스 로직 없음 — 워킹 스켈레톤의 토대. **추가**: ADR-0013 조건부 채택에 따라 *마이크→F0→화면 지연 스파이크* 1개를 포함해 본격 진행 전 실시간 오디오 지연을 실측(불충족 시 폴백 = 네이티브 1종 우선 재검토).

## Acceptance criteria

- [ ] 1-커맨드로 Flutter 앱이 에뮬레이터에서 부팅(빈 화면)
- [ ] lint + 단위테스트 1개가 로컬·CI에서 통과
- [ ] 세로 모바일 뷰포트 기본
- [ ] README에 실행/테스트 커맨드 명시
- [ ] 오디오 지연 스파이크: 마이크 캡처→임시 F0→화면 반영 지연 측정·기록(수용 가능 여부 판정; 불충족 시 폴백 트리거)

## Blocked by

- 01-stack-scaffold-decision (F0)
