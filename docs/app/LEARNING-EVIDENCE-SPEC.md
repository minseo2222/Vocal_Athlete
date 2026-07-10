# LEARNING-EVIDENCE-SPEC — completion과 학습 증거 분리

> v11 canonical. 이 기능은 노래 품질을 자동 채점하거나 자격을 인증하지 않는다. 레슨을 완료했다는 사실과, 어떤 수행 흔적을 남겼는지를 분리해 로컬에 기록한다.

## 1. 목적

현재 앱의 일일 진도는 completion 기반이다. 이 원칙은 유지한다. 다만 장기 커리큘럼에서는 다음을 구분해야 한다.

- **Completion:** 오늘 레슨을 마쳤다.
- **Practice trace:** 시도, 자기점검, 예시 청취, 키 선택, 녹음 등 수행 흔적이 있다.
- **Target evidence:** 해당 레슨이 E0~E5 중 어느 수준의 증거를 목표로 설계됐는가.
- **Achieved evidence:** 실제 유지·전이 수행이 확인됐는가. v11은 이를 자동 판정하지 않는다.

## 2. 저장 항목

`LessonPracticeSnapshot`

- 시도 횟수
- 선택한 자기점검 항목 인덱스
- 재생한 예시 음원 경로
- 곡 적용 훈련에서 선택한 낮은 키/중간 키
- 현재 세션에서 새로 저장한 녹음 수
- best take 선택 여부

`LearningEvidenceRecord`

- 트랙, cycle/project, day, card ID
- 커리큘럼의 목표 evidence level(E0~E5)
- 완료 시각
- 사용자 목 상태
- normal / reduced / recovery adaptation
- `LessonPracticeSnapshot`

## 3. 금지 해석

다음 해석은 금지한다.

- 시도 횟수가 많을수록 실력이 높다.
- 자기점검을 많이 선택하면 레슨을 잘했다.
- 목표 E3 레슨을 완료했으므로 사용자가 E3를 달성했다.
- 녹음이 존재하므로 음정·리듬·음색이 향상됐다.
- 학습 기록을 단일 가수 점수나 순위로 합산한다.

UI에서는 항상 **“목표 증거”**와 **“수행 메타데이터”**라고 표시한다.

## 4. 진행 정책

- 학습 기록이 비어 있어도 일일 completion을 막지 않는다.
- 메타데이터 저장 실패가 레슨 완료를 막지 않는다.
- 회복 모드는 발성 시도가 없어도 정상적인 학습 기록으로 인정한다.
- 레벨 인증과 포트폴리오 판정은 별도의 녹음 루브릭·사람 검토가 필요하다.

## 5. 개인정보·보존

- 기본 저장은 local-first `AppMetadataStore` 메타데이터다. 신규 primary는 `SharedPreferencesAsync`다.
- 원음 파일과는 별도 저장한다.
- 서버 업로드, 모델 학습, 공개 공유는 하지 않는다.
- 설정의 `학습 기록` 화면에서 전체 삭제할 수 있다.
- 콘텐츠 revision과 blueprint SHA suffix를 함께 저장해 개정 전후 조건을 구분한다.

## 6. v11 구현

- `app/lib/assessment/learning_evidence.dart`
- `app/lib/lesson/learning_evidence_review_screen.dart`
- `app/lib/lesson/lesson_blueprint_panel.dart`
- `app/lib/lesson/lesson_screen.dart`
- `app/integration_test/learning_evidence_flow_test.dart`

## 7. 현재 남은 검증

- 목표 evidence와 실제 달성을 자동 동일시하지 않는 사용자 이해도 검증
- checkpoint 결과와 사람/녹음 루브릭의 연결
- 여러 기기/계정 동기화 정책
- 기록 부담과 D+1/D+3 복습 수용성 사용자 연구
- v13 legacy metadata에서 v14 async 저장소로의 실기기 upgrade 검증

## v12 — 지연 복습과 revision 연결

v12부터 학습 기록에는 다음이 추가된다.

- `contentRevision`: 기록이 생성된 blueprint version/revision
- `recordedTakeIds`: 해당 레슨에서 저장된 녹음 take ID 목록
- `bestTakeId`: 사용자가 선택한 best take ID

레슨 완료 직후 `ReviewQueueScheduler`가 local-first 복습 과제를 예약한다. 복습은 E2/E3 확인을 돕는 선택 과제이며, 해금·streak·품질 점수와 분리된다.

- D+1 retention: 같은 과제를 시간이 지난 뒤 다시 확인
- D+3 transfer: Repertoire Application 또는 best take가 있는 레슨에서 한 조건만 바꿔 확인
- recovery mode: 유성 복습 예약 없음

## v13 — 복습 증거와 content hash

v13은 `ReviewEvidenceRecord`를 별도 계층으로 추가한다. 원 레슨의 completion 기록과 복습 수행 기록을 합쳐 자동 성취 판정을 만들지 않는다.

- Review task/source evidence 연결
- 목 상태와 adaptation 기록
- 복습 시도·자기점검·새 take·원 take 재생 기록
- 원 revision과 현재 revision 비교
- SHA-256 manifest 기반 content revision suffix
- revision mismatch 시 직접 전후 자동 점수 비교 금지

복습 기록은 설정에서 전체 삭제할 수 있으며 원음 경로를 포함하지 않는다.
