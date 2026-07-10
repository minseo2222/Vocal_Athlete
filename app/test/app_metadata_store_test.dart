import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

void main() {
  test('v14 known keys migrate idempotently and schema is recorded', () async {
    final primary = InMemoryMetadataBackend();
    final legacy = InMemoryMetadataBackend(<String, Object>{
      'learning_evidence_v1': '[{"id":"legacy"}]',
      'review_queue_v1': '[]',
    });
    final store = AppMetadataStore(primary: primary, legacy: legacy);

    final first = await store.migrateKnownKeys();
    expect(first.migratedKeys, containsAll(<String>[
      'learning_evidence_v1',
      'review_queue_v1',
    ]));
    expect(await store.schemaVersion(), AppMetadataStore.currentSchemaVersion);
    expect(legacy.snapshot.containsKey('learning_evidence_v1'), isFalse);

    final second = await store.migrateKnownKeys();
    expect(second.migratedKeys, isEmpty);
    expect(primary.snapshot['learning_evidence_v1'], '[{"id":"legacy"}]');
  });

  test('v14 inventory reports migration, present, and quarantined keys', () async {
    final primary = InMemoryMetadataBackend(<String, Object>{
      'progression_v1': '{}',
      'review_queue_v1_corrupt_backup_v14': '{broken',
    });
    final store = AppMetadataStore(primary: primary, legacy: null);
    await store.migrateKnownKeys();

    final inventory = await store.inventory();
    expect(inventory.schemaVersion, AppMetadataStore.currentSchemaVersion);
    expect(inventory.migrationCompleted, isTrue);
    expect(inventory.presentKeys, contains('progression_v1'));
    expect(inventory.quarantinedKeys, contains('review_queue_v1'));
  });

  test('v14 corrupt values can be quarantined then cleared', () async {
    final primary = InMemoryMetadataBackend(<String, Object>{
      'review_evidence_v1': '{broken',
    });
    final store = AppMetadataStore(primary: primary, legacy: null);

    await store.quarantineCorruptValue('review_evidence_v1', '{broken');
    expect(primary.snapshot['review_evidence_v1'], isNull);
    expect(
      primary.snapshot[store.corruptBackupKey('review_evidence_v1')],
      '{broken',
    );

    await store.clearAllLearningMetadata();
    expect(primary.snapshot, isEmpty);
  });
}
