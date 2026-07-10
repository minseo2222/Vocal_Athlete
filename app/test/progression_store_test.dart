library;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

void main() {
  test('v14 save then load restores progression through async metadata store',
      () async {
    final primary = InMemoryMetadataBackend();
    final metadata = AppMetadataStore(primary: primary, legacy: null);
    final store = ProgressionStore(metadataStore: metadata);

    expect(await store.load(), isNull);

    final progression = Progression.beginner();
    progression.completeLesson();
    progression.advanceDay();
    await store.save(progression);

    final loaded = await store.load();
    expect(loaded, isNotNull);
    expect(loaded!.currentIndex, progression.currentIndex);
    expect(loaded.streak, progression.streak);
    expect(loaded.day, progression.day);
  });

  test('v14 corrupt progression is quarantined and returns null', () async {
    final primary = InMemoryMetadataBackend(
      <String, Object>{ProgressionStore.storageKey: '{깨진 json'},
    );
    final metadata = AppMetadataStore(primary: primary, legacy: null);
    final store = ProgressionStore(metadataStore: metadata);

    expect(await store.load(), isNull);
    expect(primary.snapshot[ProgressionStore.storageKey], isNull);
    expect(
      primary.snapshot[metadata.corruptBackupKey(ProgressionStore.storageKey)],
      '{깨진 json',
    );
  });

  test('v14 legacy progression migrates once without data loss', () async {
    final progression = Progression.beginner()..advanceDay();
    final legacy = InMemoryMetadataBackend(<String, Object>{
      ProgressionStore.storageKey: jsonEncode(progression.toJson()),
    });
    final primary = InMemoryMetadataBackend();
    final metadata = AppMetadataStore(primary: primary, legacy: legacy);
    final store = ProgressionStore(metadataStore: metadata);

    final loaded = await store.load();
    expect(loaded?.day, progression.day);
    expect(primary.snapshot.containsKey(ProgressionStore.storageKey), isTrue);
    expect(legacy.snapshot.containsKey(ProgressionStore.storageKey), isFalse);

    final second = await store.load();
    expect(second?.day, progression.day);
  });
}
