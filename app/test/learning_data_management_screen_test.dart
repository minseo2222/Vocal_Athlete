import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/learning_data_management_screen.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

void main() {
  testWidgets('v14 data screen shows migration inventory and clears metadata',
      (tester) async {
    final primary = InMemoryMetadataBackend(<String, Object>{
      'progression_v1': '{}',
    });
    final store = AppMetadataStore(primary: primary, legacy: null);
    await store.migrateKnownKeys();
    var cleared = false;

    await tester.pumpWidget(MaterialApp(
      home: LearningDataManagementScreen(
        metadataStore: store,
        onBack: () {},
        onCleared: () => cleared = true,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('learning-data-migration-status')), findsOneWidget);
    expect(find.textContaining('migration 완료'), findsOneWidget);
    expect(find.textContaining('저장된 학습 영역 1개'), findsOneWidget);

    await tester.tap(find.byKey(const Key('learning-data-clear')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('learning-data-clear-confirm')));
    await tester.pumpAndSettle();

    expect(cleared, isTrue);
    expect(find.textContaining('메타데이터 스키마: 0'), findsOneWidget);
  });
}
