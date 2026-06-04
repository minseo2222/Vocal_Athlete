# 중급 커리큘럼 구현 — 수동 검증 절차 (I1~I6)

> 졸업→장르→분기 진입→경로 진행이 앱에서 동작함을 확인하는 절차.
> 자동 검증: `flutter test`(141 green) + `flutter analyze`(클린). 본 문서는 *수동 흐름*.

## 구현 요약 (코드화 완료)
- **카드**: 중급 IC-01~12·IM-01~12·CL-01~09·GY-01~09 = card_library 이식(I1).
- **manifest**: buildCoreManifest(32) + buildMusical/Classical/Gayo(74/68/64)(I2).
- **분기 진입**: `Progression._enterCourse(genre)` 실 manifest 로드·index 0(I3).
- **분기 완주**: 코스 끝 → graduated + maintenance(고급 미생성, ADR-0010)(I4).
- **안전 게이트**: `safetyApproved=false`(기본) → pending 카드(belt/트웽/cover/messa/런)
  코스에서 제외. HITL 사인오프 완료 시에만 true(I5).
- **정합 가드**: 전 manifest cardId가 라이브러리에 존재(I6).

## 롤아웃 스위치 (중요)
ADR-0010 P10 설계상 장르 코스는 *released* 상태여야 진입(미release → 유지 모드 대기,
출시 시 자동 연결). 미들 코스는 *구현·게이트 완료*이나 **앱 기본은 미release**(staged
rollout). 즉 현재 앱에서 졸업→장르픽 = 유지 모드(코스 미연결)가 기본. 미들 코스를
실제로 켜려면 두 스위치:
1. **장르 release** — `progression.toggleRelease(genre)`(P10 자동연결 트리거).
2. **안전 사인오프** — `Progression(safetyApproved: true)` (HITL-SIGNOFF 완료 후만).
   미사인오프(기본)면 release돼도 belt/트웽/cover/messa/런 카드는 코스에서 제외.

> 이 두 스위치 분리는 *재설계가 아니라 기존 ADR-0010 P10 + I5 안전 게이트*. 앱 전역
> 기본 release/approve 결정은 롤아웃·안전 사인오프 사안이라 본 구현 범위 밖(자가 결정 ❌).

> **세션-독립 검증(W1~W5)**: 두 스위치의 진실은 이제 체크인 상수(`kReleasedGenres`·
> `kSafetySignoff`)에 박혀 있고, `docs/verification/`의 단일 소스·하네스가 정합을
> 강제한다. 신규 세션 재확인: `docs/verification/NEW-SESSION-REVERIFY.md`.

## 수동 검증 (개발 빌드, 코스 연결 시)
release 플래그를 켠 개발 빌드 기준:
1. 경고 → 확인 → 홈 → 오늘 시작 → 초급 레슨 진행.
2. (초급 졸업 시뮬: 1-슬롯 manifest) 졸업 → 장르 픽커 → 장르 선택.
3. release된 장르면 → **코어(IC) 레슨부터** 진행(todaysLesson = IC-xx).
4. 코어 통과 → 분기(IM/CL/GY) 레슨 연속(단일 manifest).
5. safetyApproved=false면 belt/트웽 등 게이트 카드 *미등장*(코스 길이 단축).
6. 분기 완주 → 유지 모드 배지(고급 미생성).

## 잔존(범위 밖, 의도적)
- **G4 고급 트랙**: 풀 벨트·완전 cover·풀 messa·고난도 런 = 미생성(신규 고위험 안전
  설계 + HITL 필요). 중급 천장(진입 한정)까지만 구현.
- **G5 periodization/디로드**: 미반영(코어 갭 후보).
- **belt 등 안전 카드 활성화**: HITL-SIGNOFF 완료 전 게이트 잠금(자가 승인 ❌).
- **실 마이크 곡선**: 코드 완료, 기기 육안 확인 미수행.
- 앱 전역 release/approve 기본값: 롤아웃·사인오프 결정(범위 밖).
