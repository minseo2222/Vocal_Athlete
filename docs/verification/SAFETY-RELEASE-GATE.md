# SAFETY-RELEASE-GATE — 고위험 카드 출시 게이트

> 목적: belt·트웽·패사지오 처리·cover·messa·run·레퍼토리 카드를 “문서상 안전”이 아니라 “제품상 안전”으로 공개하기 위한 출시 조건을 정의한다. 본 문서는 `HITL-SIGNOFF.md`, `safety_signoff.dart`, `verification-status.json`, `backlog-safety-enforcement.md`를 연결한다.

## 1. 결론

고위험 카드는 **전문가 사인오프 + 앱 강제 캡 구현 + 롤아웃 승인**이 모두 충족될 때만 공개한다.

텍스트 cue만으로는 부족하다. `kSafetySignoff`에 사람 이름이 들어가도 강제 캡이 구현되지 않으면 출시하지 않는다.

## 2. 상태 모델

| 상태 | 의미 | 사용자 노출 |
|---|---|---|
| `none` | 일반 카드 | 노출 가능 |
| `pending` | 안전 검토 필요 | 기본 잠금 |
| `signedOff` | 전문가 문서 승인 | 강제 캡 없으면 여전히 미출시 |
| `enforced` | 앱 캡 구현·테스트 완료 | canary 가능 |
| `released` | 사람 롤아웃 승인 | 사용자 노출 가능 |
| `revoked` | AE/문제 발생 | 즉시 잠금 |

현 코드의 `SafetyReview.pending`과 `kSafetySignoff`는 이 중 `pending`/`signedOff`를 다루는 최소 구조다. `enforced` 이후의 런타임 캡은 아직 백로그다.

## 3. 출시 전 필수 구현

카드별로 다음 필드를 제품 데이터 또는 별도 safety manifest에 가져야 한다.

- `maxRange`
- `maxRepsPerSession`
- `maxSustainSec`
- `maxSessionsPerWeek`
- `minRestHours`
- `requiresSwellingCheck`
- `stopSignals`
- `fallbackCardId`
- `reviewer`
- `reviewDate`
- `evidenceRef`
- `killSwitchId`

## 4. 고위험 카드 목록

- IM-02 구강 트웽
- IM-03 패사지오 처리
- IM-05 call-based belt 진입
- IM-12 레퍼토리 라이트 belt 구절
- CL-01 cover/voce chiusa 진입
- CL-08 messa di voce 기초
- GY-04 트웽/꽥
- GY-05 라이트 belt 진입
- GY-06 꺽기/run 기초
- GY-09 가요 레퍼토리
- k-keok 강한 성문어택: 영구 제외. 고급에서도 별도 재검토 전까지 도입 금지.

## 5. 런타임 동작

- 사용자가 고위험 카드에 도달해도 release gate 미충족이면 해당 슬롯을 숨기거나 fallback 카드로 대체한다.
- 숨김만으로 코스 길이가 비정상적으로 짧아지면 fallback 카드가 필수다.
- cap hit 시 “실패”가 아니라 “오늘은 여기까지”로 처리한다.
- stop signal 선택 시 해당 카드/유사 고위험 카드를 일정 기간 잠근다.
- AE/stop 이벤트가 증가하면 kill switch로 즉시 잠금 가능해야 한다.

## 6. QA 수용 기준

- 빈 `kSafetySignoff`면 pending 카드가 모두 잠긴다.
- 유효 사인오프가 있어도 cap manifest가 없으면 출시 상태가 아니다.
- cap 초과 시 재시도/반복이 차단된다.
- swelling check 실패 시 고위험 카드가 그날 잠긴다.
- stop signal 선택 시 해당 카드가 잠긴다.
- 롤아웃 config가 비어 있으면 모든 장르 중급은 유지 모드다.
- `verification-status.json`과 라이브 코드가 일치한다.

## 7. 관련 문서

- `docs/curriculum/HITL-SIGNOFF.md`
- `docs/verification/backlog-safety-enforcement.md`
- `docs/verification/SAFETY-EVIDENCE-DOSSIER.md`
- `app/lib/safety/safety_signoff.dart`
- `app/lib/progression/progression_state.dart`
- `docs/verification/verification-status.json`

