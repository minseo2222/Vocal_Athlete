import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/recording/recording_store.dart';

void main() {
  test('v6 file recording repository saves, filters, and deletes metadata', () async {
    final dir = await Directory.systemTemp.createTemp('vocal_store_test_');
    addTearDown(() async {
      if (await dir.exists()) await dir.delete(recursive: true);
    });
    final audio = File('${dir.path}/take.m4a');
    await audio.writeAsBytes([1, 2, 3]);
    final repo = FileRecordingRepository(File('${dir.path}/recording_index.json'));
    final take = RecordingTake(
      id: 'CARD-13_take_01',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: audio.path,
      createdEpochMs: 1,
      durationMs: 1200,
      fileSizeBytes: 3,
    );
    await repo.saveTake(take);
    expect((await repo.listTakes(purpose: RecordingPurpose.standardSample)).single.id, take.id);
    await repo.deleteTake(take.id);
    expect(await repo.listTakes(), isEmpty);
    expect(await audio.exists(), isFalse);
  });
}
