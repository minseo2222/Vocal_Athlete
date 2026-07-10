import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/timbre/tone_profile_curation.dart';

RecordingTake curationTake(String id) => RecordingTake(
      id: id,
      cardId: 'TONE-12',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: 'local://$id',
      createdEpochMs: DateTime(2026, 1, 1).millisecondsSinceEpoch,
      toneTags: const [ToneTag.clean],
      comfortRating: 5,
      sameConditionConfirmed: true,
    );

void main() {
  test('v17 curation updates tone tags without deleting the take', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(curationTake('take-1'));

    final updated = await ToneProfileCurationService(repo).updateToneTags(
      'take-1',
      const [ToneTag.warm, ToneTag.warm],
      editedEpochMs: 1234,
      memo: 'manual edit',
    );

    expect(updated, isNotNull);
    expect(updated!.toneTags, const [ToneTag.warm]);
    expect(updated.toneTagEditedEpochMs, 1234);
    expect(updated.toneTagEditMemo, 'manual edit');

    final stored = (await repo.listTakes()).single;
    expect(stored.id, 'take-1');
    expect(stored.toneTags, const [ToneTag.warm]);
    expect(stored.localPath, 'local://take-1');
  });

  test('v17 curation excludes and restores a take from tone profile aggregation', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(curationTake('take-1'));
    final service = ToneProfileCurationService(repo);

    final excluded = await service.setToneProfileExcluded(
      'take-1',
      true,
      editedEpochMs: 2000,
    );
    expect(excluded!.toneProfileExcluded, isTrue);
    expect(excluded.toneTagEditedEpochMs, 2000);

    final restored = await service.setToneProfileExcluded(
      'take-1',
      false,
      editedEpochMs: 3000,
    );
    expect(restored!.toneProfileExcluded, isFalse);
    expect(restored.toneTagEditedEpochMs, 3000);
  });

  test('v17 curation lists recent tone takes first', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(curationTake('old').copyWith(createdEpochMs: 1000));
    await repo.saveTake(curationTake('new').copyWith(createdEpochMs: 3000));
    // 태그가 0개인 toneAB take도 큐레이션 대상(사용자가 태그를 달 수 있어야 함).
    await repo.saveTake(
      curationTake('untagged').copyWith(toneTags: const [], createdEpochMs: 4000),
    );

    final takes = await ToneProfileCurationService(repo).listToneTaggedTakes();
    expect(takes.map((t) => t.id), ['untagged', 'new', 'old']);
  });
}
