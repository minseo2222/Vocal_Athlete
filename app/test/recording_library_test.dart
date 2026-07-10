import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/recording/recording_library.dart';

void main() {
  test('v7 recording library summarizes and exports redacted manifest', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(const RecordingTake(
      id: 'std1',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: '/local/std1.m4a',
      createdEpochMs: 1,
      fileSizeBytes: 100,
    ));
    await repo.saveTake(const RecordingTake(
      id: 'ra1',
      cardId: 'RA-01',
      purpose: RecordingPurpose.repertoirePhrase,
      slot: RecordingSlot.a,
      localPath: '/local/ra1.m4a',
      createdEpochMs: 2,
      fileSizeBytes: 300,
    ));

    final service = RecordingLibraryService(repo);
    final summary = await service.summarize();
    expect(summary.totalTakes, 2);
    expect(summary.totalBytes, 400);
    expect(summary.countFor(RecordingPurpose.standardSample), 1);
    expect(summary.countFor(RecordingPurpose.repertoirePhrase), 1);
    expect(formatRecordingBytes(1536), '1.5 KB');

    final jsonText = await service.exportManifestJson();
    final decoded = jsonDecode(jsonText) as Map<String, dynamic>;
    expect(decoded['schema'], 'vocal-athlete/recording-export@1');
    expect(decoded['includeLocalPaths'], isFalse);
    expect(decoded['containsAudioBytes'], isFalse);
    expect(jsonText.contains('/local/std1.m4a'), isFalse);
    expect(jsonText.contains('[local-only:redacted]'), isTrue);
  });

  test('v7 recording library can clear all takes', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(const RecordingTake(
      id: 'a',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: '/tmp/a.m4a',
      createdEpochMs: 1,
    ));
    final service = RecordingLibraryService(repo);
    await service.clearAll();
    expect(await repo.listTakes(), isEmpty);
  });
}
