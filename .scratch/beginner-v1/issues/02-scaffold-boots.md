# F1 — 스캐폴드 부팅

Status: in-progress — 스캐폴드·스파이크·CI·테스트 완료(green). *실기기 지연 측정*(ADR-0013 조건부 검증)만 남음 — Android Studio/SDK + `flutter doctor` 필요(대화형, 사용자)

## 진행 메모

- `app/` Flutter 프로젝트 생성, `flutter analyze` 클린 + `flutter test` 2/2 통과
- 오디오 지연 스파이크: `app/lib/main.dart` + `app/lib/spike/pitch_naive.dart`(순수·교체 seam)
- 권한(Android RECORD_AUDIO / iOS 마이크), CI(`.github/workflows/flutter-ci.yml`), README 실행법
- **남은 AC**: 기기에서 `flutter run` → avg latency 실측 → 수용/폴백 판정 기록 후 본 이슈 done
- ⚠ 오디오 플러그인 리스크(2026-05): `record ^5.1.2`가 `record_linux 0.7.2` ↔ `record_platform_interface 1.5.0` 비호환으로 *앱 빌드 실패*(analyze/test는 통과 — Dart VM이라). → 스파이크 화면(`lib/spike/latency_spike.dart`)·`record` 의존 *제거*, 순수 `lib/spike/pitch_naive.dart`는 보존. F1 지연 스파이크/A1은 *검증된 오디오 경로*(다른 플러그인 핀·플랫폼 채널)로 재도입 필요 — **이 크로스플랫폼 깨짐 자체가 ADR-0013(Flutter 조건부)·ADR-0014(피치) 오디오 리스크의 실증 신호**로 기록. 현재 앱 = P1~P8 디버그 허브만(마이크 무관, 빌드 정상).



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
