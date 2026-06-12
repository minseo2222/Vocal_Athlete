/// U1 — 레슨 화면 D 셸 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

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
  Future<void> dispose() async {
    disposeCalls++;
    await stop();
  }
}

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('U1.1 launch → confirm → LessonScreen shown',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
  });

  testWidgets('U1.2 header shows current slot cardId + idx/total',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget); // P1 manifest slot 0
    expect(find.textContaining('1/48'), findsOneWidget);
  });

  testWidgets('U1.3 tap 완료 → returns home (오늘 완료, 캡 구조화)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget);
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀 + 오늘 완료(슬롯 전진은 progression 내부, 별도 검증)
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U1.4 D structural elements present (stepper, cue, sheet)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-stepper')), findsOneWidget);
    expect(find.byKey(const Key('lesson-cue')), findsOneWidget);
    expect(find.byKey(const Key('lesson-sheet')), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('C2.2 cue area renders resolved card cue (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 본운동 단계에서 본 cue 렌더(진입은 워밍업만 — 단계 분리)
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    // CARD-01 cue 일부
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
    expect(find.textContaining('턱·어깨 힘 빼기'), findsOneWidget);
    // placeholder 사라짐
    expect(find.textContaining('운동 cue 자리'), findsNothing);
  });

  testWidgets('U2.2 sheet shows voicedMicroWin body (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // CARD-01 voicedMicroWin: "끝에 편한 /m/ 3회(각 2–3초)"
    expect(find.textContaining('/m/ 3회'), findsOneWidget);
  });

  testWidgets('U6.1 header shows streak (starts at 0)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    final streak = find.byKey(const Key('streak'));
    expect(streak, findsOneWidget);
    expect(find.descendant(of: streak, matching: find.text('🔥 0')),
        findsOneWidget);
  });

  testWidgets('U6.2 streak updates 0→1 after complete (홈에 반영)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀, 홈 스트릭이 1
    final streak =
        tester.widget<Text>(find.byKey(const Key('home-streak')));
    expect(streak.data, contains('1'));
  });

  testWidgets('U3.1 initial step is entry — shows 워밍업 + 다음 button',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget);
  });

  testWidgets('L4 _AppShell teardown → source.stop() + dispose() called',
      (tester) async {
    final spy = _SpyPitchSource();
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
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
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
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
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
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
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
    expect(spy.startCalls, 0); // ack 전 미호출
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(spy.startCalls, 1);
  });

  testWidgets('P6 pitch-display gated on main step (entry/cooldown hidden)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(DebugApp(
      startInLesson: true,
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

  testWidgets('P8 target-bearing card passes targetHz to PitchDisplay',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-12',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    final p = Progression.from([slot]);
    await tester.pumpWidget(MaterialApp(
      home: LessonScreen(
        progression: p,
        pitchSource: StubPitchSource(
          interval: const Duration(milliseconds: 10),
        ),
      ),
    ));
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-display')), findsOneWidget);
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
  });

  testWidgets('G3 pick unreleased genre → LessonScreen with maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
    expect(find.byKey(const Key('maintenance-badge')), findsOneWidget);
  });

  testWidgets('G4 pick released genre → LessonScreen, no maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    p.toggleRelease(Genre.musical); // P10: 출시 토글
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
    expect(find.byKey(const Key('maintenance-badge')), findsNothing);
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
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
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
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsNothing);
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
  });

  testWidgets('A1 진입엔 본 cue 미표시·본운동엔 표시 (단계 분리)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 진입: 워밍업만 — 본 cue(CARD-01) 미표시
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.textContaining('바닥/의자에 편하게'), findsNothing);
    // 본운동으로 이동 → 본 cue 표시
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
  });

  testWidgets('LP1 진입 단계에서 진입 스테퍼가 now 상태(볼드)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    final entry = tester.widget<Text>(find.text('진입·워밍업'));
    expect(entry.style?.fontWeight, FontWeight.w700);
  });
}
