# TRAINING-AUDIO-ASSET-SPEC — v16

## 목적

훈련 음원은 노래 감상·제작 콘텐츠가 아니라, 보컬 과제의 기준음·박·선율 모양·모음 전이·반주 맥락을 제공하는 교육 자산이다.

## 현재 구현 범위

### Universal Core Cycle 1

`assets/training/universal_core_cycle_01/`의 11개 mono 24 kHz/16-bit PCM cue를 사용한다. 낮은 예시와 중간 예시 중 편한 쪽만 선택하며 둘 다 불편하면 듣기·방향 표시로 대체한다.

### Beginner Timbre v16

```text
assets/training/timbre_v16/
- hum_to_vowel_low.wav
- hum_to_vowel_mid.wav
- vowel_color_low.wav
- vowel_color_mid.wav
- rights.json
```

용도:

- Day 37 Hum-to-Vowel 순서와 low/mid 선택 UX 검증
- Day 38 같은 음에서 모음만 바꾸는 순서 검증
- asset routing, rights inventory, content revision 검증

경계:

- deterministic synthetic prototype이며 사람 보컬 master가 아니다.
- 정상/비정상 후두 설정, 정답 음색, 임상 샘플이 아니다.
- 사용자는 불편하면 듣기만 하고 발성을 건너뛴다.

### Repertoire Project 1

`assets/repertoire/neutral_001/`의 guide hum, piano, slow guide, backing, click 9개를 사용한다. 낮은 키/중간 키를 선택하며 원곡 키나 최대 음역 도전이 목적이 아니다.

## 음량 정책

- 모든 현재 prototype은 mono, 24 kHz, 16-bit PCM이다.
- Universal/Repertoire 생성 peak 정책은 full scale `0.50`이다.
- Timbre v16 생성 peak 정책은 full scale `0.38`이다.
- 이 수치는 임상적 안전 음량이나 모든 휴대폰의 적정 재생 음량을 뜻하지 않는다.
- 앱은 사용자가 기기 볼륨을 편한 수준으로 낮추도록 안내한다.
- 출시 전 실제 기기·이어폰·스피커별 체감 음량과 clipping을 점검한다.

## 자산 원칙

- 현재 파일은 프로젝트 내부 스크립트가 생성한 원본 합성 prototype이다.
- 제3자 음원·유명곡·사람 보컬 녹음을 포함하지 않는다.
- 출시 전 강사 master로 교체하거나 prototype 사용을 명시적으로 승인해야 한다.
- 강사 master에는 권리 동의, 음역·음량·모음·프레이즈 전문가 검수와 기기 QA가 필요하다.
- 가이드는 학습이 진행되면 줄어들어야 하며 모델과 동시에 계속 따라 부르게 하지 않는다.

## 앱 연결

- `TrainingAudioPlaybackAdapter`가 bundle asset만 재생한다.
- 사용자 녹음 재생용 player와 훈련 음원 player를 분리한다.
- `LessonBlueprintPanel`은 Beginner Timbre와 Core의 짧은 cue를 재생한다.
- `RepertoirePracticePanel`은 키 선택, 가사, 호흡 표시, guide/backing/click을 제공한다.
- 실제 재생 실패 시 레슨 completion을 차단하지 않는다.

Flutter asset은 `pubspec.yaml`에 명시된 경로를 기준으로 bundle에 포함되므로, curriculum, Core, Timbre, 각 repertoire 디렉터리를 각각 등록한다.

## 출시 차단 조건

1. `dart analyze`, `flutter test`, Android/iOS build 통과
2. Android/iOS 실제 기기 재생 QA
3. low/mid cue가 목표 사용자에게 편한지 전문가·사용자 검수
4. 최종 강사 master 교체 또는 prototype 사용 승인
5. rights record와 checksum 검증
6. 기기·이어폰별 볼륨 안전·명료도 시험
7. 쉰 상태 no-voice 대체와 audio stop 동작 검증
