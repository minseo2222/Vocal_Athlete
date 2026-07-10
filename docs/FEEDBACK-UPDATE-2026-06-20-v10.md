# v10 피드백 반영 업데이트 — 2026-06-20

## 목표

v9에서 구조만 완성된 첫 Universal Core 12일과 첫 곡 적용 12일을 실제로 검토 가능한 하나의 학습 vertical slice로 만든다.

## 커리큘럼 구현

- `app/assets/curriculum/universal_core_cycle_01.json`: 날짜별 12레슨
- `app/assets/curriculum/repertoire_project_01.json`: 날짜별 12레슨
- 각 레슨에 주 목표 1개, 보조 목표 최대 1개, 단계, 시도 상한, 피드백, 자기점검, 회복 대체, 증거 수준을 명시
- Core는 호흡→발성→SOVT 전이→청음→리듬→음색→편한 음역→딕션→프레이즈→지연 재현을 연결
- 곡 적용은 전체 기준 take→부분 교정→가이드 축소→반주 only→지연 재현으로 진행

## 앱 구현

- `LessonBlueprint`/asset repository/화면 panel
- `RepertoireAsset` parser와 `RepertoirePracticePanel`
- `TrainingAudioPlaybackAdapter`
- lesson sheet scroll 처리
- self-check chips와 시도 후 feedback prompt
- 명시적 nested asset directory 등록
- 낮은 키/중간 키 선택 UI와 키별 guide/backing 연결

## 원본 프로토타입 자산

- Universal Core cue 11개: 낮은/중간 기준음·contour·phrase와 pulse
- `neutral_001` 음원 9개: 낮은/중간 허밍·피아노·느린 가이드·반주와 공통 click
- 모든 파일은 내부 스크립트로 생성한 합성 원본이며 제3자 음원·사람 보컬을 포함하지 않음
- prototype peak를 full scale `0.50` 이하로 제한
- rights JSON과 SHA-256 checksum 생성

## 출시 상태

구조와 prototype 자산은 구현했지만 다음 전까지 미출시다.

- Flutter compile/analyze/test
- Android/iOS 실제 재생
- 낮은/중간 키 및 음량 전문가 검수
- 초보자 usability와 delayed retention/transfer 시험
- 최종 강사 가이드 master 승인
