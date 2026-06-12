# 기기 마이크 검증 — 자족·재현 체크리스트 (W3)

> 목적: 실 마이크 → 시각 피치 곡선이 기기에서 동작함을 *대화 맥락 없이* 누구나
> 동일하게 재현·기록할 수 있게 한다. `RecordingPitchSource`는 device-bound glue라
> 단위 테스트 대상이 아니므로(코드 주석 명시), 이 육안 검증이 유일한 확인 경로다.
>
> 이 문서만 읽고 그대로 따라 하면 된다. 사전 지식·이전 세션 불요.
> 결과는 아래 §4 템플릿을 복사해 `device-results.md`에 append 한다(git 영속).

---

## 0. 전제 (한 번만)

| 항목 | 값 / 확인법 |
|---|---|
| Flutter | `C:/src/flutter/bin/flutter.bat --version` (3.44+) |
| 기기 | Android 에뮬레이터(`emulator-5554`) 또는 실 기기 USB 디버깅 |
| 기기 목록 | `C:/src/flutter/bin/flutter.bat devices` 에 대상이 보일 것 |
| 작업 폴더 | repository `app/` directory |
| 마이크 | 에뮬레이터: 확장 컨트롤(…) → Microphone → "Virtual microphone uses host audio input" ON. 실 기기: 권한 허용. |

> ⚠️ 에뮬레이터 가상 마이크가 호스트 입력을 쓰도록 켜져 있어야 곡선이 움직인다.
> 호스트 마이크가 음소거면 곡선이 안 움직여 *기기 결함이 아님* → 입력부터 확인.

---

## 1. 빌드 & 실행

```
cd app
flutter run -d emulator-5554
```

- 빌드 해시 기록용: repository root에서 `git rev-parse --short HEAD` 를 실행 직전에 찍어 둔다.
- `flutter run` 콘솔에 "Syncing files to device…" 후 앱 화면이 떠야 한다.

---

## 2. 단계별 절차 + 기대 관측

각 단계의 *기대 관측*을 실제로 눈으로 확인하고 §4에 pass/fail 기록.

| # | 조작 | 기대 관측 |
|---|---|---|
| S1 | 앱 실행 | **실행 경고 화면**(LaunchWarning) 표시. 확인 버튼 존재. |
| S2 | 확인 버튼 탭 | (최초 실행) **OS 마이크 권한 다이얼로그** 표시. |
| S3 | 권한 **허용** | 홈 화면 표시(오늘 카드/스트릭/시작 버튼). |
| S4 | "오늘 시작" 탭 | **레슨 화면**(`lesson-screen`) 진입. |
| S5 | 본 운동(main) 단계까지 진행 | **피치 디스플레이**(`pitch-display`) + 가로 **파란 타깃선**(`pitch-target`) 표시. |
| S6 | 220Hz 부근(약 A3) 지속음 허밍 | **초록 점**(`pitch-current`)이 나타나 음높이에 따라 **상하로 이동**. (높으면 위, 낮으면 아래) |
| S7 | 타깃보다 일관되게 높/낮게 지속 | (편차 충분 시) **"⤴ 좀 더 높게 — 다시?" / "⤵ 좀 더 낮게 — 다시?"** 넛지(`retry-nudge`) 노출 가능. |
| S8 | 발성 멈춤(무음) | 초록 점 **사라짐**(무성/저신뢰 → 표시 없음). |

### 2b. 권한 거부 경로(별도 1회)

| # | 조작 | 기대 관측 |
|---|---|---|
| D1 | 앱 재설치 후 S2에서 권한 **거부** | 레슨 본 단계에 **"마이크 꺼짐 — 피치 표시 안 됨"** 문구, 초록 점 영영 안 뜸. 크래시 없음. |

---

## 3. 합격 기준

- **PASS** = S1~S8 전부 기대대로 + D1(거부 경로) 정상. 특히 **S6(소리에 반응해 점이 상하 이동)**가 핵심.
- **FAIL** = 어느 단계든 기대와 다름(점이 안 뜸/안 움직임/크래시/문구 누락 등).
- **BLOCKED** = 빌드 실패·기기 없음·마이크 입력 자체 부재 등 검증 불가.

> 정직 원칙: 한 단계라도 미확인이면 전체를 PASS로 적지 않는다. 미수행/불가는
> 그대로 UNVERIFIED/BLOCKED로 기록한다(통과 위장 ❌).

---

## 4. 결과 기록 템플릿 (복사 → `device-results.md`에 append)

```
### 검증 런 — <YYYY-MM-DD>
- 커밋(빌드): <git short hash>
- 기기: <emulator-5554 / 모델명·OS>
- 관측자: <이름>
- 종합: <PASS | FAIL | BLOCKED | UNVERIFIED>
- 단계별:
  - S1 경고화면: <pass/fail/-> 
  - S2 권한요청: <pass/fail/->
  - S3 허용→홈: <pass/fail/->
  - S4 레슨진입: <pass/fail/->
  - S5 피치UI/타깃선: <pass/fail/->
  - S6 소리→점 상하이동(핵심): <pass/fail/->
  - S7 넛지: <pass/fail/n-a>
  - S8 무음→점 사라짐: <pass/fail/->
  - D1 권한거부 경로: <pass/fail/->
- 비고: <관측 메모, 입력장치 상태 등>
```

> 기록 후 `verification-status.json`의 `device.status`를 동일 결과로 갱신하고
> (W4 단일 소스 동기화), 커밋·푸시한다. W5 하네스가 두 산출물의 정합을 강제한다.
