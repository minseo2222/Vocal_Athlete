# DATA-PRIVACY-SPEC — 오디오·피치 데이터 원칙

> 목적: 보컬 앱의 핵심 민감 데이터인 녹음·피치·진척 정보를 V1에서 어떻게 다룰지 고정한다. 본 문서는 법률 자문을 대체하지 않으며, 실제 출시 전 관할권별 검토가 필요하다.

## 1. 기본 원칙

- V1은 **로컬 우선**이다.
- 녹음 업로드는 기본값이 아니다.
- AI 모델 학습 사용은 기본값이 아니다.
- 사용자는 녹음과 표준샘플을 삭제할 수 있어야 한다.
- 마이크 권한 거부 시에도 레슨은 진행 가능해야 한다. 단 피치 피드백은 꺼진다.

## 2. 데이터 범주

| 데이터 | V1 저장 | 기본 위치 | 삭제 |
|---|---|---|---|
| 진행 상태 | 저장 | 로컬/선택 동기화 | 계정/앱 삭제 시 |
| streak | 저장 | 로컬/선택 동기화 | 가능 |
| 피치 reading | 세션 내 사용 | 기본 영구 저장 안 함 | 세션 종료 |
| 표준샘플 녹음 | 사용자 동의 후 저장 | 로컬 | 개별 삭제 가능 |
| self-imitation 녹음 | 세션 내 사용 | 기본 영구 저장 안 함 | 세션 종료 |
| 기기/오류 로그 | 최소 수집 | 익명/집계 | 정책 필요 |

## 3. 클라우드 업로드

V1 기본값은 업로드 없음. 후속 버전에서 클라우드 분석을 도입하려면 다음이 필요하다.

- 명시적 opt-in
- 업로드 전 설명
- 저장 기간 표시
- 삭제 요청 경로
- 모델 학습 사용 여부 별도 동의
- 미성년자/변성기 대상 제외 정책과 일치
- 한국 개인정보보호법 및 앱스토어/플레이스토어 정책 검토

## 4. 제품 카피 금지

- “AI가 성대 상태를 진단합니다” 금지.
- “성대 건강을 측정합니다” 금지.
- “발성 유형을 판정합니다” 금지.
- “당신의 목 상태를 추적합니다” 금지.

허용:

- “피치 곡선을 보여줍니다.”
- “같은 조건의 녹음을 비교합니다.”
- “저신뢰 구간은 표시하지 않습니다.”

## 5. MVP 체크리스트

- 마이크 권한 안내 문구
- 마이크 거부 시 fallback UX
- 표준샘플 저장/삭제 버튼
- 녹음 업로드 없음 명시
- 개인정보처리방침 초안
- 앱스토어/플레이스토어 data safety 입력 준비


## 6. R4 녹음 A/B 확장 시 추가 원칙

Repertoire Application, 음색 프로필, 포트폴리오 모드가 들어가면 녹음은 단순 임시 입력이 아니라 사용자 산출물이 된다. 따라서 다음을 추가 release blocker로 둔다.

- 원음 파일은 기본 로컬 저장.
- 사용자 삭제는 카드별/전체 삭제 모두 제공.
- 백업/동기화/전문가 리뷰/모델 학습은 각각 별도 opt-in.
- Google Play Data safety 입력과 실제 앱 동작이 일치해야 한다.
- speaker identification, voiceprint, 유명 가수 매칭, 성대 건강 판정 목적으로 음성을 사용하지 않는다.

## v6 Recording Storage Addendum

v6 introduces a real local-first recording path for Recording A/B and standard samples.

- Recordings are created only from explicit user action.
- Default storage is app-owned local support storage.
- Server upload is not implemented.
- Model training upload is not implemented.
- Public sharing is not implemented.
- User deletion must remove metadata and the local file.
- The app must not perform speaker identification, voiceprint matching, singer similarity scoring, or vocal-health diagnosis from these recordings.
- Android microphone permission copy and iOS `NSMicrophoneUsageDescription` must match actual recording behavior.
- Google Play Data safety declarations must describe audio recording behavior and storage accurately.
- Release remains blocked until real-device permission, capture, playback, and deletion QA pass.

## v11 Learning Evidence Addendum

v11은 원음과 별도로 레슨 수행 메타데이터를 로컬에 저장한다.

- 저장 항목: 트랙/날짜/카드, 시도 수, 자기점검 인덱스, 예시 청취 경로, 선택 키, 녹음 수, best 선택 여부, 목 상태·adaptation.
- 기본 저장 위치: local `AppMetadataStore` (`SharedPreferencesAsync` primary).
- 가창 품질 점수, 생체 식별, 성대 건강 판정은 저장하지 않는다.
- 서버 업로드와 모델 학습은 구현하지 않는다.
- 설정에서 학습 기록 전체 삭제를 제공한다.
- self-check 인덱스는 콘텐츠 개정 시 의미가 달라질 수 있으므로 후속 버전에서 content revision/hash를 함께 저장해야 한다.

## v13 Review Evidence Addendum

v13은 지연 재현·조건 전이 복습의 수행 메타데이터를 별도 로컬 저장소에 저장한다.

- 저장: review/source ID, track/day/card, 목 상태, 시도 수, 자기점검 인덱스, take ID, content revision
- 미저장: 원음 경로, 음성 생체 특징, 건강 판정, 가창 품질 점수
- 기본 업로드 없음
- 설정에서 복습 기록 전체 삭제 가능
- take ID는 로컬 녹음 메타데이터 연결자이며 서버 식별자로 사용하지 않음
- `AppMetadataStore` key-value 계층은 중요 원음이나 계정 비밀 저장소로 사용하지 않음


## v14 Metadata Migration Addendum

- progression/evidence/review metadata는 `AppMetadataStore` 뒤에서만 접근한다.
- 신규 primary는 `SharedPreferencesAsync`, legacy API는 migration source로만 사용한다.
- 손상 JSON은 사용자 모르게 폐기하지 않고 로컬 quarantine key로 격리한다.
- 학습 메타데이터 전체 초기화와 녹음 원음 전체 삭제는 분리한다.
- schema/migration 상태는 로컬 운영 정보이며 서버로 전송하지 않는다.

## v15 Tone Profile Addendum

- Tone Profile은 저장된 `RecordingTake`의 사용자 자기태그·편안함·Best/표준샘플 상태에서 매번 파생한다.
- 별도 음성 생체 프로필, speaker embedding, 성대 상태 추정값을 저장하지 않는다.
- 녹음 take가 삭제되면 남아 있는 take만으로 즉시 다시 계산한다.
- 서버 업로드, 모델 학습, 유명 가수 비교, 장르 적합성 판정은 구현하지 않는다.
- 낮은 편안함 tag는 의료 경고나 진단이 아니라 다음 연습에서 강도를 낮추기 위한 사용자 기록이다.
