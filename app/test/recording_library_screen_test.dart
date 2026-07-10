import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/recording_library_screen.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void main() {
  testWidgets('v7 recording library shows summary, export preview, and clear all',
      (tester) async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(const RecordingTake(
      id: 'std1',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: '/tmp/std1.m4a',
      createdEpochMs: 1,
      fileSizeBytes: 200,
    ));

    await tester.pumpWidget(MaterialApp(
      home: RecordingLibraryScreen(repository: repo, onBack: () {}),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('recording-library-summary')), findsOneWidget);
    expect(find.textContaining('총 1개'), findsOneWidget);
    expect(find.byKey(const Key('recording-library-purpose-standardSample')), findsOneWidget);

    await tester.tap(find.byKey(const Key('recording-library-export-preview')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('recording-library-export-json')), findsOneWidget);
    expect(find.textContaining('recording-export'), findsOneWidget);

    await tester.tap(find.byKey(const Key('recording-library-clear-all')));
    await tester.pumpAndSettle();
    // 파괴적 동작 — 확인 다이얼로그를 거친다.
    await tester.tap(find.byKey(const Key('recording-library-clear-confirm')));
    await tester.pumpAndSettle();
    expect(find.textContaining('총 0개'), findsOneWidget);
  });
}
