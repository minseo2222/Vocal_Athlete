import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

void main() {
  test('v5 RecordingTake serializes local-first A/B metadata', () {
    const take = RecordingTake(
      id: 'CARD-13_take_01',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: 'local://sample/card13/1.wav',
      createdEpochMs: 100,
      toneTags: [ToneTag.clear, ToneTag.comfortable],
      comfortRating: 4,
      sameConditionConfirmed: true,
      durationMs: 5000,
      fileSizeBytes: 2048,
      memo: 'baseline',
      isBest: true,
    );
    final restored = RecordingTake.fromJson(take.toJson());
    expect(restored.id, take.id);
    expect(restored.purpose, RecordingPurpose.standardSample);
    expect(restored.toneTags, contains(ToneTag.clear));
    expect(restored.sameConditionConfirmed, isTrue);
    expect(restored.durationMs, 5000);
    expect(restored.fileSizeBytes, 2048);
    expect(restored.durationLabel, '5초');
    expect(restored.isBest, isTrue);
  });

  test('v5 RecordingAbSession enforces max take count and best take', () {
    final session = RecordingAbSession(
      cardId: 'TONE-12',
      purpose: RecordingPurpose.toneAB,
      maxTakes: 2,
    );
    final a = RecordingTake(
      id: nextTakeId('TONE-12', 1),
      cardId: 'TONE-12',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: 'local://a',
      createdEpochMs: 1,
    );
    final b = a.copyWith(
      id: nextTakeId('TONE-12', 2),
      slot: RecordingSlot.b,
      localPath: 'local://b',
      createdEpochMs: 2,
    );
    final c = a.copyWith(
      id: nextTakeId('TONE-12', 3),
      slot: RecordingSlot.c,
      localPath: 'local://c',
      createdEpochMs: 3,
    );
    final filled = session.addTake(a).addTake(b).addTake(c).markBest(b.id);
    expect(filled.takes.length, 2);
    expect(filled.bestTakeId, b.id);
    expect(filled.bestTake!.slot, RecordingSlot.b);
  });

  test('v5 in-memory recording repository filters and deletes takes', () async {
    final repo = InMemoryRecordingRepository();
    await repo.saveTake(RecordingTake(
      id: 'a',
      cardId: 'RA-01',
      purpose: RecordingPurpose.repertoirePhrase,
      slot: RecordingSlot.a,
      localPath: 'local://a',
      createdEpochMs: 2,
    ));
    await repo.saveTake(RecordingTake(
      id: 'b',
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      localPath: 'local://b',
      createdEpochMs: 1,
    ));
    expect((await repo.listTakes()).map((t) => t.id), ['b', 'a']);
    expect((await repo.listTakes(cardId: 'RA-01')).single.id, 'a');
    await repo.deleteTake('a');
    expect(await repo.listTakes(cardId: 'RA-01'), isEmpty);
  });

  test('v15 standard sample milestones use independent slots and IDs', () {
    expect(standardSampleSlotForBeginnerIndex(0), RecordingSlot.baseline);
    expect(standardSampleSlotForBeginnerIndex(23), RecordingSlot.midpoint);
    expect(standardSampleSlotForBeginnerIndex(47), RecordingSlot.graduation);
    expect(standardSampleSlotForBeginnerIndex(1), isNull);
    expect(
      nextTakeId('CARD-13', 1, slot: RecordingSlot.baseline),
      'CARD-13_baseline_take_01',
    );
    expect(
      nextTakeId('CARD-13', 1, slot: RecordingSlot.midpoint),
      'CARD-13_midpoint_take_01',
    );
  });


  test('v15 card metadata tone names map only to approved self tags', () {
    expect(toneTagFromName('speech_like'), ToneTag.speechLike);
    expect(toneTagFromName('mic-friendly'), ToneTag.micFriendly);
    expect(toneTagFromName('airyFeeling'), ToneTag.airyFeeling);
    expect(toneTagFromName('effortful-feeling'), ToneTag.effortful);
    expect(toneTagFromName('vocal_fold_closure'), isNull);
  });



  test('v17 RecordingTake preserves tone profile curation metadata', () {
    const take = RecordingTake(
      id: 'tone-edit',
      cardId: 'TONE-07',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: 'local://tone-edit',
      createdEpochMs: 10,
      toneTags: [ToneTag.bright],
      toneProfileExcluded: true,
      toneTagEditedEpochMs: 20,
      toneTagEditMemo: 'wrong tag',
    );
    final restored = RecordingTake.fromJson(take.toJson());
    expect(restored.toneProfileExcluded, isTrue);
    expect(restored.toneTagEditedEpochMs, 20);
    expect(restored.toneTagEditMemo, 'wrong tag');
  });


  test('v18 recording take preserves creation local date key', () {
    const take = RecordingTake(
      id: 'date-key',
      cardId: 'TONE-02',
      purpose: RecordingPurpose.toneAB,
      slot: RecordingSlot.a,
      localPath: 'local://date-key',
      createdEpochMs: 1000,
      createdLocalDateKey: '2026-06-22',
    );
    final restored = RecordingTake.fromJson(take.toJson());
    expect(restored.createdLocalDateKey, '2026-06-22');
    expect(localDateOrdinalFromKey(restored.createdLocalDateKey), 20260622);
  });

}
