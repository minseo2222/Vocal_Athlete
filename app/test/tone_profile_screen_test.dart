import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/tone_profile_screen.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void _tallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1200, 3600);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('v18 tone profile screen shows day-weighted palette and disclaimer',
      (tester) async {
    final repository = InMemoryRecordingRepository();
    for (var i = 0; i < 3; i++) {
      await repository.saveTake(RecordingTake(
        id: 'take-$i',
        cardId: 'TONE-12',
        purpose: RecordingPurpose.toneAB,
        slot: RecordingSlot.values[3 + i],
        localPath: 'local://take-$i',
        createdEpochMs: DateTime(2026, 1, i + 1).millisecondsSinceEpoch,
        toneTags: [i < 2 ? ToneTag.clean : ToneTag.warm],
        comfortRating: i < 2 ? 5 : 2,
        sameConditionConfirmed: true,
        isBest: i == 0,
      ));
    }

    await tester.pumpWidget(MaterialApp(
      home: ToneProfileScreen(onBack: () {}, repository: repository),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('tone-profile-screen')), findsOneWidget);
    expect(find.byKey(const Key('tone-profile-disclaimer')), findsOneWidget);
    expect(find.byKey(const Key('tone-profile-refresh')), findsOneWidget);
    expect(find.byKey(const Key('tone-profile-not-enough-data')), findsNothing);
    expect(find.text('깨끗함'), findsWidgets);
    expect(find.text('따뜻함'), findsWidgets);
    expect(find.textContaining('서로 다른 학습일 3일'), findsOneWidget);

    await tester.tap(find.byKey(const Key('tone-profile-refresh')));
    await tester.pumpAndSettle();
    expect(find.textContaining('서로 다른 학습일 3일'), findsOneWidget);
  });


  testWidgets('v18 tone profile screen supports multi-tag edit and exclusion',
      (tester) async {
    _tallViewport(tester);
    final repository = InMemoryRecordingRepository();
    await repository.saveTake(RecordingTake(
      id: 'tone-row',
      cardId: 'TONE-07',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: 'local://tone-row',
      createdEpochMs: DateTime(2026, 2, 1).millisecondsSinceEpoch,
      toneTags: const [ToneTag.bright],
      comfortRating: 4,
      sameConditionConfirmed: true,
    ));

    await tester.pumpWidget(MaterialApp(
      home: ToneProfileScreen(onBack: () {}, repository: repository),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('tone-profile-curation-disclaimer')), findsOneWidget);
    expect(find.byKey(const Key('tone-profile-take-tone-row')), findsOneWidget);

    await tester.tap(find.byKey(const Key('tone-profile-edit-tone-row-warm')));
    await tester.pumpAndSettle();
    expect(
      (await repository.listTakes()).single.toneTags,
      const [ToneTag.bright, ToneTag.warm],
    );

    await tester.tap(find.byKey(const Key('tone-profile-edit-tone-row-bright')));
    await tester.pumpAndSettle();
    expect((await repository.listTakes()).single.toneTags, const [ToneTag.warm]);
    expect(find.textContaining('직접 정정 1개'), findsOneWidget);

    await tester.tap(find.byKey(const Key('tone-profile-exclude-tone-row')));
    await tester.pumpAndSettle();
    expect((await repository.listTakes()).single.toneProfileExcluded, isTrue);
    expect(find.textContaining('팔레트 제외 1개'), findsOneWidget);

    await tester.tap(find.byKey(const Key('tone-profile-clear-tags-tone-row')));
    await tester.pumpAndSettle();
    expect((await repository.listTakes()).single.toneTags, isEmpty);
  });

}
