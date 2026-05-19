# F0 — 스마트폰 스택·스캐폴드 결정

Status: ready-for-human

## What to build

V1 앱의 모바일 기술 스택과 프로젝트 스캐폴드 형태를 *결정*한다. 그린필드(코드 0)이며 이 결정이 이후 모든 슬라이스를 가른다. 후보: React Native(Expo) / Flutter / 네이티브(iOS+Android). 평가축: 1-커맨드 실행·CI 용이성, 실시간 오디오/피치(저지연 마이크 캡처) 접근성, 온디바이스 ML(피치 모델) 적합성, 단일 개발자 유지보수성, 세로 모바일 UI. 결과를 ADR로 기록한다.

## Acceptance criteria

- [ ] 스택 1개 확정 + 근거가 ADR로 기록됨
- [ ] 1-커맨드 실행/빌드 방법 정의(에뮬레이터/기기)
- [ ] 실시간 마이크 캡처·온디바이스 추론 가능성 확인됨(피치 슬라이스 A0/A1 전제)
- [ ] CI(lint+test) 골격 방침 정의

## Blocked by

- None - can start immediately
