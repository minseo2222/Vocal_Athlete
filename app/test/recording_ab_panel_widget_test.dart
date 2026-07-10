import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/recording_ab_panel.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void main() {
  testWidgets('v11 recording A/B panel persists best take metadata', (tester) async {
    final repository = InMemoryRecordingRepository();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecordingAbPanel(
          cardId: 'TONE-12',
          maxTakes: 2,
          purpose: RecordingPurpose.toneAB,
          repository: repository,
        ),
      ),
    ));
    expect(find.byKey(const Key('recording-ab-panel')), findsOneWidget);
    expect(find.byKey(const Key('preview-capture-mode')), findsOneWidget);
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pump();
    expect(find.text('오늘 take 제한'), findsOneWidget);
    await tester.tap(find.byKey(const Key('mark-best-TONE-12_take_01')));
    await tester.pumpAndSettle();
    expect(find.text('Best'), findsOneWidget);
    final takes = await repository.listTakes(cardId: 'TONE-12');
    expect(takes.where((take) => take.isBest).single.id, 'TONE-12_take_01');
  });

  testWidgets('v15 standard sample slots do not consume one another',
      (tester) async {
    final repository = InMemoryRecordingRepository();

    Future<void> pumpSlot(RecordingSlot slot) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RecordingAbPanel(
            cardId: 'CARD-13',
            maxTakes: 1,
            purpose: RecordingPurpose.standardSample,
            fixedSlot: slot,
            repository: repository,
          ),
        ),
      ));
      await tester.pumpAndSettle();
    }

    await pumpSlot(RecordingSlot.baseline);
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pumpAndSettle();
    expect(find.text('오늘 take 제한'), findsOneWidget);

    await pumpSlot(RecordingSlot.midpoint);
    expect(find.text('Take 기록'), findsOneWidget);
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pumpAndSettle();

    final takes = await repository.listTakes(
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
    );
    expect(takes.map((take) => take.id), containsAll(<String>[
      'CARD-13_baseline_take_01',
      'CARD-13_midpoint_take_01',
    ]));
    expect(takes.map((take) => take.slot),
        containsAll(<RecordingSlot>[RecordingSlot.baseline, RecordingSlot.midpoint]));
  });


  testWidgets('v15 A-B-C panel advances its proposed user tone tag',
      (tester) async {
    final repository = InMemoryRecordingRepository();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecordingAbPanel(
          cardId: 'TONE-12',
          maxTakes: 3,
          purpose: RecordingPurpose.toneAB,
          repository: repository,
          availableToneTags: const [
            ToneTag.clean,
            ToneTag.warm,
            ToneTag.speechLike,
          ],
          takeToneSequence: const [
            ToneTag.clean,
            ToneTag.warm,
            ToneTag.speechLike,
          ],
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.text('이번 take 목표: 깨끗함'), findsOneWidget);
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pumpAndSettle();
    expect(find.text('이번 take 목표: 따뜻함'), findsOneWidget);
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pumpAndSettle();
    expect(find.text('이번 take 목표: 말하듯'), findsOneWidget);
  });

}
