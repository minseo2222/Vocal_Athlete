/// Task 4 — 설정 화면 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';
import 'package:vocal_athlete/lesson/home_screen.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/safety/range_boundary_store.dart';
import 'package:vocal_athlete/safety/vocal_fatigue_store.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

void _phoneViewport(WidgetTester tester) {
  // 설정 항목이 섹션 그룹핑으로 길어져, 전체 리스트가 한 번에 빌드되도록 뷰포트를 높인다.
  tester.view.physicalSize = const Size(1260, 6000);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _toHome(
  WidgetTester tester, {
  AppMetadataStore? metadataStore,
}) async {
  await tester.pumpWidget(
    DebugApp(
      appVersion: '1.18.0',
      metadataStore: metadataStore,
      evidenceRepository: InMemoryLearningEvidenceRepository(),
      reviewQueueRepository: InMemoryReviewQueueRepository(),
      reviewEvidenceRepository: InMemoryReviewEvidenceRepository(),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, '확인'));
  await tester.pumpAndSettle();
}

Future<void> _openSettings(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('home-settings')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('SET1 home gear → settings, back → home', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-screen')), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    await tester.tap(find.byKey(const Key('settings-back')));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets(
    'SET2 settings shows mic permission, version, and recording entries',
    (tester) async {
      _phoneViewport(tester);
      await _toHome(tester);
      await tester.tap(find.byKey(const Key('home-settings')));
      await tester.pumpAndSettle();
      expect(find.text('마이크 권한'), findsOneWidget);
      expect(find.textContaining('버전'), findsOneWidget);
      expect(find.textContaining('1.18.0'), findsOneWidget);
      expect(
        find.byKey(const Key('settings-standard-samples')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('settings-tone-profile')), findsOneWidget);
      expect(
        find.byKey(const Key('settings-recording-library')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('settings-repertoire-review')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('settings-learning-evidence')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('settings-review-queue')), findsOneWidget);
      expect(find.byKey(const Key('settings-review-evidence')), findsOneWidget);
      expect(
        find.byKey(const Key('settings-learning-data-management')),
        findsOneWidget,
      );
    },
  );

  testWidgets('R4 beginner settings has no advanced genre change entry', (
    tester,
  ) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-change-genre')), findsNothing);
  });

  testWidgets('R3 maintenance/advanced wait can reopen genre picker', (
    tester,
  ) async {
    _phoneViewport(tester);
    final p = Progression.from(
      buildRepertoireApplicationManifest(),
      currentIndex: repertoireApplicationLength - 1,
      graduated: true,
      stage: LearningStage.repertoireApplication,
    );
    p.chooseGenre(Genre.gayo); // not released → maintenance wait
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-change-genre')), findsOneWidget);
  });
  testWidgets('v11 settings opens local learning evidence review', (
    tester,
  ) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-learning-evidence')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('learning-evidence-review-screen')),
      findsOneWidget,
    );
  });

  testWidgets('v12 settings opens delayed review queue', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-review-queue')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('review-queue-screen')), findsOneWidget);
  });

  testWidgets('v13 settings opens linked review evidence', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-review-evidence')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('review-evidence-screen')), findsOneWidget);
  });

  testWidgets('v14 settings opens learning metadata management', (
    tester,
  ) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const Key('settings-learning-data-management')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('learning-data-management-screen')),
      findsOneWidget,
    );
  });

  testWidgets('v15 settings opens user-selected tone profile', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-tone-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('tone-profile-screen')), findsOneWidget);
    expect(find.byKey(const Key('tone-profile-disclaimer')), findsOneWidget);
  });

  testWidgets('F2 settings opens vocal fatigue self-check', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await _openSettings(tester);
    expect(
      find.byKey(const Key('settings-vocal-fatigue-check')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const Key('settings-vocal-fatigue-check')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('vocal-fatigue-screen')), findsOneWidget);
  });

  testWidgets('F2 settings opens range boundary check', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await _openSettings(tester);
    expect(
      find.byKey(const Key('settings-range-boundary-check')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const Key('settings-range-boundary-check')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('range-boundary-screen')), findsOneWidget);
  });

  testWidgets('S0 settings opens vocal screening', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await _openSettings(tester);
    expect(find.byKey(const Key('settings-vocal-screening')), findsOneWidget);
    await tester.tap(find.byKey(const Key('settings-vocal-screening')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('vocal-screening-screen')), findsOneWidget);
  });

  testWidgets('F2 저장된 VFI가 재진입 시 initial로 반영(load 방향)', (tester) async {
    _phoneViewport(tester);
    final meta = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    await VocalFatigueStore(metadataStore: meta).save(
      const VocalFatigueSelfCheck(
        tiredness: 10,
        discomfort: 0,
        poorRecovery: 0,
      ),
    );
    await _toHome(tester, metadataStore: meta);
    await _openSettings(tester);
    await tester.tap(find.byKey(const Key('settings-vocal-fatigue-check')));
    await tester.pumpAndSettle();
    // tiredness=10 → 슬라이더 값 라벨 '10'(초기값 반영). 나머지는 '0'.
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('F2 VFI 저장 시 store에 영속화(save 방향)', (tester) async {
    _phoneViewport(tester);
    final meta = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    await _toHome(tester, metadataStore: meta);
    await _openSettings(tester);
    await tester.tap(find.byKey(const Key('settings-vocal-fatigue-check')));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('vfi-tiredness')),
      const Offset(400, 0),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('vfi-save')));
    await tester.pumpAndSettle();
    final saved = await VocalFatigueStore(metadataStore: meta).load();
    expect(saved, isNotNull);
    expect(saved!.tiredness, greaterThan(0));
  });

  testWidgets('F2 저장된 음역 추적기가 재진입 시 반영(load 방향)', (tester) async {
    _phoneViewport(tester);
    final meta = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    const pass = BoundaryVerification(
      nextDayRecovered: true,
      qualityMaintained: true,
      f0StableNoFatigue: true,
    );
    await RangeBoundaryStore(
      metadataStore: meta,
    ).save(const RangeBoundaryTracker().record(pass).record(pass));
    await _toHome(tester, metadataStore: meta);
    await _openSettings(tester);
    await tester.tap(find.byKey(const Key('settings-range-boundary-check')));
    await tester.pumpAndSettle();
    expect(find.textContaining('사용 가능'), findsOneWidget); // usable 승격 상태
  });
}
