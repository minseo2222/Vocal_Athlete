# AUDIO-SESSION-INTEGRITY-SPEC — 가이드·녹음·앱 생명주기 중단 정책

> v11 canonical. 훈련 음원, 사용자 녹음 재생, 마이크 캡처가 동시에 실행되거나 앱이 백그라운드로 간 뒤 남는 것을 방지한다.

## 1. 오디오 역할

- `TrainingAudioPlaybackAdapter`: 앱 bundle의 가이드·반주·클릭
- `AudioPlaybackAdapter`: 사용자가 저장한 녹음 take 재생
- `AudioCaptureAdapter`: 사용자 마이크 녹음

세 역할은 어댑터와 player를 분리하되 한 시점에 충돌하지 않도록 상위 레슨 셸에서 중재한다.

## 2. 인터록 규칙

| 새 동작 | 먼저 중단할 것 |
|---|---|
| 가이드/반주 재생 | 녹음 take 재생, 진행 중 마이크 캡처 취소 |
| 마이크 녹음 시작 | 가이드/반주, 녹음 take 재생 |
| 녹음 take 재생 | 가이드/반주 |
| 본운동 → 쿨다운 | 모든 재생, 진행 중 캡처 |
| 레슨 완료 | 모든 재생, 진행 중 캡처 |
| 앱 inactive/paused/hidden/detached | 모든 재생, 진행 중 캡처 |
| 관련 패널 dispose | 해당 재생 또는 캡처 중단 |

## 3. 데이터 정책

- 중단된 캡처는 저장 take로 간주하지 않는다.
- 캡처 취소 시 임시 파일을 삭제한다.
- 생명주기 중단 후 자동으로 녹음을 재시작하지 않는다.
- 사용자가 명시적으로 다시 녹음 버튼을 눌러야 한다.

## 4. best take

v11부터 best take 선택은 UI 상태에만 남지 않고 `RecordingTake.isBest`에 저장한다. 같은 카드/목적의 다른 take는 `isBest=false`로 다시 저장한다.

## 5. 구현 위치

- `app/lib/recording/audio_session_coordinator.dart`: adapter 중단을 패널 UI에 전달하는 중앙 event
- `app/lib/main.dart`: 앱 lifecycle observer
- `app/lib/lesson/lesson_screen.dart`: 역할 간 interlock
- `app/lib/lesson/lesson_blueprint_panel.dart`: panel dispose stop
- `app/lib/lesson/repertoire_practice_panel.dart`: panel dispose stop
- `app/lib/lesson/recording_ab_panel.dart`: capture/playback interlock 및 dispose cancel
- `app/lib/recording/audio_io.dart`: adapter seam

## 6. 남은 release blocker

- Android audio focus loss/duck/call interruption 실기기 QA
- iOS interruption/route change 실기기 QA
- Bluetooth·유선 이어폰·스피커 전환
- 권한 거부 중간 전환
- 앱 강제 종료 중 임시 파일 정리
- 실제 녹음 중 화면 잠금·전화 수신
- UI 재생 아이콘과 외부 focus 중단 상태 동기화
