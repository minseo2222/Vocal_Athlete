# FEEDBACK UPDATE — v14 — 2026-06-21

## 반영 목표

v13 종료 점검의 우선순위였던 실행 검증 파이프라인, 저장소 migration, 콘텐츠 manifest 자동화, 카드별 복습 cue를 반영했다.

## 구현

- 앱 버전 `1.14.0+14`
- Flutter 3.44.2 pin 및 GitHub Actions workflow
- `AppMetadataStore`와 legacy → async migration
- schema version, migration 상태, 손상 JSON quarantine
- 학습 데이터 관리 화면
- 자동 생성 v14 content manifest와 freshness gate
- card-specific retention/transfer cue
- Repertoire Application 시작 함수 중복 호출 제거
- migration/manifest/review instruction regression tests

## 범위 제한

제작 컨테이너에는 Flutter/Dart가 없어 실제 analyze/test/build는 실행되지 않았다. CI workflow 역시 파일로 추가됐을 뿐 이 패키지 안에서 실행 성공을 주장하지 않는다.
