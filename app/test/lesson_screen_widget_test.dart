/// U1 — 레슨 화면 D 셸 위젯 테스트.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/safety/vocal_load_budget.dart';
import 'package:vocal_athlete/safety/vocal_load_store.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

/// 단계 전이·완료까지 가는 흐름 테스트용. 실제 audioplayers/path_provider는
/// 위젯 테스트에서 멈추므로(플러그인 미연결) fake 어댑터와 in-memory 저장소를
/// 모두 주입해 `_initRecordingStack`이 path_provider를 호출하지 않게 한다.
DebugApp _flowApp({
  Progression? progression,
  PitchSource? pitchSource,
  AppMetadataStore? metadataStore,
  int? todayEpochDay,
}) =>
    DebugApp(
      initialProgression: progression,
      startInLesson: true,
      pitchSource: pitchSource,
      metadataStore: metadataStore,
      todayEpochDay: todayEpochDay,
      trainingAudioPlaybackAdapter: FakeTrainingAudioPlaybackAdapter(),
      recordingCaptureAdapter: FakeAudioCaptureAdapter(),
      recordingPlaybackAdapter: FakeAudioPlaybackAdapter(),
      recordingRepository: InMemoryRecordingRepository(),
      recordingPathResolver: RecordingFilePathResolver(Directory.systemTemp),
      evidenceRepository: InMemoryLearningEvidenceRepository(),
      reviewQueueRepository: InMemoryReviewQueueRepository(),
    );

/// 유한한 ringRaw 시퀀스를 내보내는 소스 — 공명 추세 통합 테스트용(주기 타이머
/// 없이 fromIterable이라 pumpAndSettle이 정상 종료).
class _FiniteRingSource implements PitchSource {
  @override
  Stream<PitchReading> get readings => Stream<PitchReading>.fromIterable([
        for (var i = 0; i < 8; i++)
          PitchReading(f0Hz: 220, timestampSec: i * 0.01, ringRaw: 0.3 + i * 0.05),
      ]);
  @override
  Future<bool> start() async => true;
  @override
  Future<void> stop() async {}
  @override
  void dispose() {}
}

class _SpyPitchSource implements PitchSource {
  int startCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;
  bool grant = true;
  @override
  Stream<PitchReading> get readings => const Stream<PitchReading>.empty();
  @override
  Future<bool> start() async {
    startCalls++;
    return grant;
  }
  @override
  Future<void> stop() async => stopCalls++;
  @override
  void dispose() => disposeCalls++;
}

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 5400);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('U1.1 launch → confirm → LessonScreen shown',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
  });

  testWidgets('U1.2 header shows current slot cardId + idx/total',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-13'), findsOneWidget); // R2 manifest slot 0 = baseline sample
    expect(find.textContaining('1/48'), findsOneWidget);
  });

  testWidgets('U1.3 entry 완료 불가, main 쿨다운 스킵 → returns home (오늘 완료, 캡 구조화)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-13'), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsNothing);
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('complete-button')), findsNothing);
    expect(find.byKey(const Key('skip-cooldown')), findsOneWidget);
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀 + 오늘 완료(슬롯 전진은 progression 내부, 별도 검증)
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U1.4 D structural elements present (stepper, cue, sheet)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-stepper')), findsOneWidget);
    expect(find.byKey(const Key('lesson-cue')), findsOneWidget);
    expect(find.byKey(const Key('lesson-sheet')), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsNothing);
  });

  testWidgets('C2.2 cue area renders resolved card cue (CARD-13 baseline)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 본운동 단계에서 본 cue 렌더(진입은 워밍업만 — 단계 분리)
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    // CARD-13 cue 일부
    expect(find.textContaining('조용한 곳에서'), findsOneWidget);
    expect(find.textContaining('/a/ /i/ /u/ 각 3초'), findsOneWidget);
    // placeholder 사라짐
    expect(find.textContaining('운동 cue 자리'), findsNothing);
  });

  testWidgets('U2.2 sheet shows voicedMicroWin body (CARD-13)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // CARD-13 voicedMicroWin
    expect(find.textContaining('짧은 모음 3종'), findsOneWidget);
  });

  testWidgets('v16 Beginner Day 37 loads the timbre blueprint and recovery copy',
      (tester) async {
    _phoneViewport(tester);
    final p = Progression.from(
      buildPlaceholderManifest(),
      currentIndex: 36,
      stage: LearningStage.beginnerFoundation,
    );
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('TONE-02'), findsOneWidget);
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-blueprint-panel')), findsOneWidget);
    expect(find.text('허밍의 편안함을 모음으로'), findsOneWidget);
    expect(find.textContaining('두 take 이내'), findsOneWidget);
  });

  testWidgets('v16 Beginner Day 37 hoarse state uses no-voice timbre alternative',
      (tester) async {
    _phoneViewport(tester);
    final p = Progression.from(
      buildPlaceholderManifest(),
      currentIndex: 36,
      stage: LearningStage.beginnerFoundation,
    );
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('voice-state-hoarse')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '회복 루틴으로 가기'));
    await tester.pumpAndSettle();
    expect(find.textContaining('오늘은 발성하지 않는다'), findsOneWidget);
    expect(find.byKey(const Key('recording-ab-panel')), findsNothing);
  });

  testWidgets('U6.1 header shows streak (starts at 0)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    final streak = find.byKey(const Key('streak'));
    expect(streak, findsOneWidget);
    expect(find.descendant(of: streak, matching: find.text('🔥 0')),
        findsOneWidget);
  });

  testWidgets('U6.2 streak updates 0→1 after main cooldown-skip (홈에 반영)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀, 홈 스트릭이 1
    final streak =
        tester.widget<Text>(find.byKey(const Key('home-streak')));
    expect(streak.data, contains('1'));
  });

  testWidgets('U3.0 entry 단계는 완료 버튼을 노출하지 않는다', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('complete-button')), findsNothing);
    expect(find.widgetWithText(FilledButton, '본운동으로 가기'), findsOneWidget);
  });

  testWidgets('U3.1 initial step is entry — shows 워밍업 + 다음 button',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget);
    expect(find.text('본운동으로 가기'), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsNothing);
  });

  testWidgets('R2.1 entry shows non-diagnostic voice-state micro-check',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('voice-state-check')), findsOneWidget);
    expect(find.byKey(const Key('voice-state-ok')), findsOneWidget);
    expect(find.byKey(const Key('voice-state-tired')), findsOneWidget);
    expect(find.byKey(const Key('voice-state-hoarse')), findsOneWidget);
    await tester.tap(find.byKey(const Key('voice-state-hoarse')));
    await tester.pumpAndSettle();
    final chip = tester.widget<ChoiceChip>(
      find.byKey(const Key('voice-state-hoarse')),
    );
    expect(chip.selected, isTrue);
    expect(find.byKey(const Key('complete-button')), findsNothing);
  });

  testWidgets('R4.1 hoarse voice state switches main step to recovery mode',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp(
      pitchSource: StubPitchSource(interval: const Duration(milliseconds: 10)),
    ));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('voice-state-hoarse')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('recovery-mode-notice')), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, '회복 루틴으로 가기'));
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.textContaining('회복 모드'), findsWidgets);
    expect(find.byKey(const Key('recovery-mode-notice')), findsOneWidget);
    expect(find.byKey(const Key('pitch-display')), findsNothing);
    expect(find.byKey(const Key('skip-cooldown')), findsNothing);
  });

  testWidgets('R4.2 tired voice state uses light mode and requires cooldown',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('voice-state-tired')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('light-mode-notice')), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, '라이트 모드로 가기'));
    await tester.pumpAndSettle();
    expect(find.textContaining('라이트 모드'), findsWidgets);
    expect(find.byKey(const Key('skip-cooldown')), findsNothing);
    expect(find.widgetWithText(FilledButton, '쿨다운으로 가기'), findsOneWidget);
  });

  testWidgets('L4 _AppShell teardown → source.stop() + dispose() called',
      (tester) async {
    final spy = _SpyPitchSource();
    await tester.pumpWidget(_flowApp(pitchSource: spy));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(spy.stopCalls, 0);
    expect(spy.disposeCalls, 0);
    // 앱 트리에서 제거 = State.dispose
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    expect(spy.stopCalls, 1);
    expect(spy.disposeCalls, 1);
  });

  testWidgets('PD1 mic denied → main step shows mic-off notice',
      (tester) async {
    _phoneViewport(tester);
    final spy = _SpyPitchSource()..grant = false;
    await tester.pumpWidget(_flowApp(pitchSource: spy));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('mic-off-notice')), findsOneWidget);
  });

  testWidgets('L3 start() denied → LessonScreen gets null pitchSource',
      (tester) async {
    _phoneViewport(tester);
    final spy = _SpyPitchSource()..grant = false;
    await tester.pumpWidget(_flowApp(pitchSource: spy));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    // UI3: pitchSource == null → 마이크 자리표시 컨테이너(PitchDisplay 미렌더)
    expect(find.byKey(const Key('mic-off-notice')), findsOneWidget);
    expect(find.byKey(const Key('pitch-display')), findsNothing);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
  });

  testWidgets('L2 _AppShell calls pitchSource.start() once after ack',
      (tester) async {
    final spy = _SpyPitchSource();
    await tester.pumpWidget(_flowApp(pitchSource: spy));
    expect(spy.startCalls, 0); // ack 전 미호출
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(spy.startCalls, 1);
  });

  testWidgets('P6 pitch-display gated on main step (entry/cooldown hidden)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp(
      pitchSource: StubPitchSource(
        interval: const Duration(milliseconds: 10),
      ),
    ));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // entry: hidden
    expect(find.byKey(const Key('pitch-display')), findsNothing);
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pump(const Duration(milliseconds: 30));
    // main: visible
    expect(find.byKey(const Key('pitch-display')), findsOneWidget);
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pump(const Duration(milliseconds: 30));
    // cooldown: hidden again
    expect(find.byKey(const Key('pitch-display')), findsNothing);
  });

  testWidgets('G3 pick unreleased advanced genre → LessonScreen with maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    final p = Progression.from(
      buildRepertoireApplicationManifest(),
      currentIndex: repertoireApplicationLength - 1,
      stage: LearningStage.repertoireApplication,
      graduated: true,
    );
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(p.maintenance, isTrue);
    expect(p.stage, LearningStage.maintenance);
  });

  testWidgets('G4 pick released advanced genre → LessonScreen, no maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    final p = Progression.from(
      buildRepertoireApplicationManifest(),
      currentIndex: repertoireApplicationLength - 1,
      stage: LearningStage.repertoireApplication,
      graduated: true,
    );
    p.toggleRelease(Genre.musical); // 고급 Lab 출시 토글
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(p.stage, LearningStage.advancedGenre);
    expect(p.maintenance, isFalse);
  });

  testWidgets('M3 last slot complete → graduated SnackBar', (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot]);
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('outcome-snack')), findsOneWidget);
    expect(
      find.descendant(
          of: find.byKey(const Key('outcome-snack')),
          matching: find.textContaining('완주')),
      findsOneWidget,
    );
  });

  testWidgets('M2 first complete (advanced) → no SnackBar', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('outcome-snack')), findsNothing);
  });

  // M1(같은 날 2차 완료 → capped SnackBar) 삭제:
  // 완료 시 홈 복귀 + 시작 비활성으로 1일1레슨 캡이 UI에서 구조화됨(H4).
  // capped outcome 분류는 R3(outcome_resolver) + progression_test가 커버.

  testWidgets('C3.5 main step shows today-variation; entry/cooldown hide it',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 1,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot]);
    await tester.pumpWidget(_flowApp(progression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // entry: 미표시
    expect(find.byKey(const Key('today-variation')), findsNothing);
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('today-variation')), findsOneWidget);
    // CARD-01 sessionPos:[워밍업,본] / blocked → 워밍업
    final t = tester.widget<Text>(find.byKey(const Key('today-variation')));
    expect(t.data, contains('워밍업'));
    await tester.tap(find.byKey(const Key('next-button'))); // → cooldown
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('today-variation')), findsNothing);
  });

  testWidgets('U3.5 main 쿨다운 스킵 chip 탭 → 오늘 완료, 홈 복귀',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U3.4 cooldown 완료 → 오늘 완료, 홈 복귀',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main→cooldown
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U3.3 tap 다음 at main → step=cooldown (쿨다운 텍스트 + 다음 버튼 사라짐)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry → main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main → cooldown
    await tester.pumpAndSettle();
    expect(find.textContaining('쿨다운:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsNothing);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('U3.2 tap 다음 at entry → step=main (워밍업 사라지고 cue 유지)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsNothing);
    expect(find.textContaining('조용한 곳에서'), findsOneWidget);
  });

  testWidgets('A1 진입엔 본 cue 미표시·본운동엔 표시 (단계 분리)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 진입: 워밍업만 — 본 cue(CARD-13) 미표시
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.textContaining('조용한 곳에서'), findsNothing);
    // 본운동으로 이동 → 본 cue 표시
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('조용한 곳에서'), findsOneWidget);
  });

  testWidgets('a11y lesson-help·skip-cooldown이 button 시맨틱으로 노출', (tester) async {
    _phoneViewport(tester);
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_flowApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 진입 헤더의 용어 도움말 버튼.
    expect(
      tester.getSemantics(find.byKey(const Key('lesson-help'))),
      isSemantics(isButton: true, label: '용어 도움말'),
    );
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(find.byKey(const Key('skip-cooldown'))),
      isSemantics(isButton: true),
    );
    handle.dispose();
  });

  testWidgets('LP1 진입 단계에서 진입 스테퍼가 now 상태(볼드)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    final entry = tester.widget<Text>(find.text('진입·워밍업'));
    expect(entry.style?.fontWeight, FontWeight.w700);
  });

  testWidgets('F2 레슨 완료 시 부하 ledger가 누적·영속화된다', (tester) async {
    _phoneViewport(tester);
    final meta =
        AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);
    await tester.pumpWidget(_flowApp(metadataStore: meta, todayEpochDay: 1000));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown'))); // 완료
    await tester.pumpAndSettle();
    final ledger =
        await VocalLoadStore(metadataStore: meta).load(todayEpochDay: 1000);
    expect(ledger.points, greaterThan(0));
    expect(ledger.sessionPhonationSeconds, greaterThan(0));
  });

  testWidgets('F2 최근 고부하(회복 윈도우 내) → 회복 경감 배너', (tester) async {
    _phoneViewport(tester);
    final today = DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day)
            .millisecondsSinceEpoch ~/
        Duration.millisecondsPerDay;
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(
      progression: Progression.beginner(),
      ledger: VocalLoadLedger(lastHighEpochDay: today), // 오늘 고부하 → 회복 중
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('recovery-window-notice')), findsOneWidget);
  });

  testWidgets('F2 완전 회복(≥3일) 또는 고부하 없음 → 회복 배너 없음', (tester) async {
    _phoneViewport(tester);
    final old = (DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .millisecondsSinceEpoch ~/
            Duration.millisecondsPerDay) -
        3; // 3일 전 → 완전 회복
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(
      progression: Progression.beginner(),
      ledger: VocalLoadLedger(lastHighEpochDay: old),
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('recovery-window-notice')), findsNothing);
  });

  testWidgets('F3 쿨다운: ring 샘플 없으면 공명 추세 미표시', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp()); // pitchSource 없음 → ringRaw 없음
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // →main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // →cooldown
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('resonance-trend')), findsNothing);
  });

  testWidgets('F2 VFI escalation → 피로 경감 배너 표시', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(
      progression: Progression.beginner(),
      fatigueEscalation: true,
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('fatigue-escalation-notice')), findsOneWidget);
  });

  testWidgets('F2 escalation 없으면 피로 배너 없음(하위호환)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('fatigue-escalation-notice')), findsNothing);
  });

  testWidgets('S0 적신호 상담 권고 → 비차단 의뢰 배너(연습은 계속)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(
      progression: Progression.beginner(),
      screeningReferral: true,
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('screening-referral-notice')), findsOneWidget);
    // 비차단: 진행 버튼은 그대로 존재.
    expect(find.byKey(const Key('next-button')), findsOneWidget);
  });

  testWidgets('S0 상담 권고 없으면 의뢰 배너 없음', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('screening-referral-notice')), findsNothing);
  });

  testWidgets('F2 세션 누적 발성시간 초과 → 발성시간 권고 배너', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(
      progression: Progression.beginner(),
      ledger: const VocalLoadLedger(sessionPhonationSeconds: 700),
    )));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('session-phonation-notice')), findsOneWidget);
  });

  testWidgets('F2 발성시간 정상이면 발성시간 배너 없음', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('session-phonation-notice')), findsNothing);
  });

  testWidgets('F3 쿨다운: ring 소스 있으면 공명 추세 표시', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(_flowApp(pitchSource: _FiniteRingSource()));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // →main(샘플 수집)
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // →cooldown
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('resonance-trend')), findsOneWidget);
  });
}
