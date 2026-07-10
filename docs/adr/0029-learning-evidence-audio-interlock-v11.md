# ADR-0029 — 학습 기록과 오디오 세션 무결성(v11)

- 상태: 채택
- 날짜: 2026-06-20

## Context

v10은 첫 24일 vertical slice의 콘텐츠와 합성 훈련 음원을 연결했다. 그러나 completion만으로는 사용자가 어떤 시도·자기점검·키 선택·녹음을 수행했는지 알 수 없었고, 가이드 재생과 녹음이 겹치거나 앱 백그라운드 전환 후 오디오가 남을 수 있는 상태였다.

## Decision

1. 일일 해금은 기존 completion 기반을 유지한다.
2. 시도·자기점검·예시 청취·키·녹음·회복 모드를 로컬 학습 기록으로 별도 저장한다.
3. 기록은 가창 점수나 evidence 달성 판정이 아니다.
4. 가이드 재생, 저장 take 재생, 마이크 캡처 사이에 명시적 interlock을 둔다.
5. 앱이 resumed가 아닌 상태로 전환되면 모든 재생을 멈추고 캡처를 취소한다.
6. best take 선택은 저장 메타데이터로 영속화한다.
7. Flutter 공식 `integration_test` runner에서 실행할 수 있는 첫 end-to-end flow scaffold를 둔다.

## Consequences

- completion과 learning evidence가 분리된다.
- 메타데이터 저장 오류는 일일 진행을 막지 않는다.
- 사용자가 시도 기록을 점수로 오해하지 않도록 지속적인 카피 검증이 필요하다.
- 앱 lifecycle 중단은 데이터 손실보다 안전과 개인정보를 우선해 캡처 취소로 처리한다.
- v11은 실제 E2/E3 달성 판정, native audio focus, 실기기 검증을 완료하지 않는다.
