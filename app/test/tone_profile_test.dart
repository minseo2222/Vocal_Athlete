import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/timbre/tone_profile.dart';

int epochDay(int day) => DateTime(2026, 1, day).millisecondsSinceEpoch;

RecordingTake take(
  String id,
  ToneTag tag,
  int comfort, {
  int day = 1,
  bool sameCondition = true,
  bool best = false,
  RecordingPurpose purpose = RecordingPurpose.toneAB,
  String createdLocalDateKey = '',
  int editedEpochMs = 0,
}) =>
    RecordingTake(
      id: id,
      cardId: 'TONE-12',
      purpose: purpose,
      slot: RecordingSlot.a,
      localPath: 'local://$id',
      createdEpochMs: day <= 0 ? 0 : epochDay(day),
      createdLocalDateKey: createdLocalDateKey,
      toneTags: [tag],
      comfortRating: comfort,
      sameConditionConfirmed: sameCondition,
      isBest: best,
      toneTagEditedEpochMs: editedEpochMs,
    );

void main() {
  test('v16 tone profile is derived from user tags across practice days', () {
    final profile = ToneProfile.fromTakes([
      take('clean-1', ToneTag.clean, 5, day: 1, best: true),
      take('clean-2', ToneTag.clean, 4, day: 2),
      take('warm-1', ToneTag.warm, 2, day: 3),
      take('effort-1', ToneTag.effortful, 3, day: 4),
    ]);

    expect(profile.observedTakeCount, 4);
    expect(profile.practiceDayCount, 4);
    expect(profile.dayTagContributionCount, 4);
    expect(profile.sameConditionTakeCount, 4);
    expect(profile.sameConditionPracticeDayCount, 4);
    expect(profile.referenceTakeCount, 1);
    expect(profile.frequentlySelected.first, ToneTag.clean);
    expect(profile.comfortableTags, contains(ToneTag.clean));
    expect(profile.lowComfortTags, containsAll([ToneTag.warm, ToneTag.effortful]));
    expect(profile.referenceTakeIds[ToneTag.clean], ['clean-1']);
    expect(profile.hasEnoughData, isTrue);
  });

  test('v16 repeated same-day takes do not dominate the tone palette', () {
    final profile = ToneProfile.fromTakes([
      for (var i = 0; i < 8; i++)
        take('clean-$i', ToneTag.clean, 5, day: 1),
      take('warm-1', ToneTag.warm, 4, day: 1),
    ]);

    expect(profile.observedTakeCount, 9);
    expect(profile.practiceDayCount, 1);
    expect(profile.tagCounts[ToneTag.clean], 1);
    expect(profile.tagCounts[ToneTag.warm], 1);
    expect(profile.dayTagContributionCount, 2);
    expect(profile.hasEnoughData, isFalse);
  });

  test('v16 low-comfort signal wins over same-day comfortable duplicate', () {
    final profile = ToneProfile.fromTakes([
      take('warm-high', ToneTag.warm, 5, day: 1),
      take('warm-low', ToneTag.warm, 2, day: 1),
      take('warm-next-day', ToneTag.warm, 5, day: 2),
    ]);

    expect(profile.tagCounts[ToneTag.warm], 2);
    expect(profile.lowComfortTagCounts[ToneTag.warm], 1);
    expect(profile.comfortableTagCounts[ToneTag.warm], 1);
  });

  test('v16 undated tagged takes stay visible but not in stable day counts', () {
    final profile = ToneProfile.fromTakes([
      take('legacy', ToneTag.clean, 5, day: 0, best: true),
    ]);

    expect(profile.observedTakeCount, 1);
    expect(profile.undatedTakeCount, 1);
    expect(profile.practiceDayCount, 0);
    expect(profile.tagCounts, isEmpty);
    expect(profile.referenceTakeIds[ToneTag.clean], ['legacy']);
    expect(profile.hasEnoughData, isFalse);
  });

  test('v16 profile ignores takes without user-selected tone tags', () {
    final profile = ToneProfile.fromTakes([
      RecordingTake(
        id: 'untagged',
        cardId: 'CARD-01',
        purpose: RecordingPurpose.standardSample,
        slot: RecordingSlot.baseline,
        localPath: 'local://untagged',
        createdEpochMs: epochDay(1),
      ),
    ]);
    expect(profile.observedTakeCount, 0);
    expect(profile.hasEnoughData, isFalse);
  });


  test('v17 excluded takes stay counted as raw observations but not palette signals', () {
    final profile = ToneProfile.fromTakes([
      take('clean', ToneTag.clean, 5, day: 1),
      take('excluded-warm', ToneTag.warm, 5, day: 2)
          .copyWith(toneProfileExcluded: true),
    ]);

    expect(profile.observedTakeCount, 2);
    expect(profile.excludedTakeCount, 1);
    expect(profile.practiceDayCount, 1);
    expect(profile.tagCounts[ToneTag.clean], 1);
    expect(profile.tagCounts.containsKey(ToneTag.warm), isFalse);
  });

  test('v18 stored local date key keeps practice-day grouping stable', () {
    final profile = ToneProfile.fromTakes([
      take('travel-a', ToneTag.clean, 5, day: 1, createdLocalDateKey: '2026-01-10'),
      take('travel-b', ToneTag.warm, 4, day: 1, createdLocalDateKey: '2026-01-11'),
    ]);

    expect(profile.practiceDayCount, 2);
    expect(profile.tagCounts[ToneTag.clean], 1);
    expect(profile.tagCounts[ToneTag.warm], 1);
  });

  test('v18 profile reports directly curated take count', () {
    final profile = ToneProfile.fromTakes([
      take('original', ToneTag.clean, 5, day: 1),
      take('edited', ToneTag.warm, 4, day: 2, editedEpochMs: 1234),
    ]);
    expect(profile.editedTakeCount, 1);
  });

}
