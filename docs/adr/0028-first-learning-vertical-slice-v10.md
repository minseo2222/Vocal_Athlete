# ADR-0028 — v10 첫 학습 vertical slice

- 상태: 채택, 미검증
- 날짜: 2026-06-20

## 결정

1. Universal Core cycle 1과 Repertoire Application project 1의 날짜별 콘텐츠를 asset JSON으로 분리한다.
2. 각 날짜에 주 목표, 보조 목표, 단계, 시도 상한, 피드백, 자기점검, recovery 대체를 명시한다.
3. 첫 Core cycle에는 낮은/중간 기준음·contour·pulse·phrase 원본 합성 cue를 제공한다.
4. 첫 Repertoire project에는 원본 네 마디 프레이즈의 낮은/중간 허밍 가이드·피아노 가이드·반주와 click을 제공한다.
5. 사용자는 원키나 최대 음역이 아니라 낮은 키/중간 키 중 편한 쪽을 선택한다.
6. 합성 파일의 prototype peak는 full scale 0.50으로 제한하되, 이를 보편적인 안전 음량 기준으로 주장하지 않는다.
7. 사용자 녹음과 훈련 음원 재생 adapter를 분리한다.
8. 합성 자산은 출시 master가 아니라 기능·학습 흐름 검증용 프로토타입으로 표시한다.

## 이유

경로와 카드 ID만 존재하면 실제로 무엇을 듣고 몇 번 시도하며 무엇을 확인하는지 검증할 수 없다. 또한 하나의 고정 기준음·반주를 모든 사용자에게 적용하면 usable range 원칙과 충돌한다. 첫 12일을 낮은/중간 선택형 end-to-end 구간으로 만들어 이후 사이클의 작성 표준과 사용자 시험 단위를 만든다.

## 결과

- 콘텐츠 검수·번역·CMS 이전이 쉬워진다.
- guide fade와 retention/transfer를 화면에서 확인할 수 있다.
- 사용자가 편한 키를 고를 수 있다.
- 앱 크기는 증가한다.
- 실제 전문가 음원, 모바일 QA, 사용자 학습효과 검증은 계속 release blocker다.
