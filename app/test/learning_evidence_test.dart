import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';

LearningEvidenceRecord _record({int epoch = 1000}) => LearningEvidenceRecord(
      id: 'universalCore_1_12_UC-25_$epoch',
      track: 'universalCore',
      cycle: 1,
      day: 12,
      cardId: 'UC-25',
      targetEvidence: LearningEvidenceLevel.e2,
      completedEpochMs: epoch,
      voiceState: 'ok',
      adaptationMode: 'normal',
      snapshot: const LessonPracticeSnapshot(
        attemptsUsed: 2,
        selfCheckIndexes: <int>[0, 1],
        playedAudioPaths: <String>['assets/a.wav'],
        selectedKey: 'mid',
        recordedTakeCount: 1,
        bestTakeSelected: true,
        recordedTakeIds: <String>['take_a'],
        bestTakeId: 'take_a',
      ),
      contentRevision: 'universalCore:1:v10:day_12:UC-25',
    );

void main() {
  test('v11 learning evidence round-trips without quality score', () {
    final record = _record();
    final restored = LearningEvidenceRecord.fromJson(record.toJson());
    expect(restored.targetEvidence, LearningEvidenceLevel.e2);
    expect(restored.snapshot.attemptsUsed, 2);
    expect(restored.snapshot.selfCheckIndexes, <int>[0, 1]);
    expect(restored.snapshot.selectedKey, 'mid');
    expect(restored.snapshot.recordedTakeIds, <String>['take_a']);
    expect(restored.snapshot.bestTakeId, 'take_a');
    expect(restored.contentRevision, contains('UC-25'));
    expect(restored.hasPracticeTrace, isTrue);
  });

  test('v11 in-memory repository filters and sorts newest first', () async {
    final repository = InMemoryLearningEvidenceRepository();
    await repository.saveRecord(_record(epoch: 1000));
    await repository.saveRecord(LearningEvidenceRecord(
      id: 'repertoire_2000',
      track: 'repertoireApplication',
      cycle: 1,
      day: 1,
      cardId: 'RA-09',
      targetEvidence: LearningEvidenceLevel.e1,
      completedEpochMs: 2000,
      voiceState: 'tired',
      adaptationMode: 'reduced',
      snapshot: const LessonPracticeSnapshot(attemptsUsed: 1),
    ));
    final all = await repository.listRecords();
    expect(all.first.completedEpochMs, 2000);
    final core = await repository.listRecords(track: 'universalCore');
    expect(core.single.cardId, 'UC-25');
  });

  test('v11 SharedPreferences repository persists local metadata', () async {
    final metadata = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    final repository = SharedPreferencesLearningEvidenceRepository(
      metadataStore: metadata,
    );
    await repository.saveRecord(_record());
    final restored = await repository.listRecords();
    expect(restored.single.cardId, 'UC-25');
    await repository.clearAll();
    expect(await repository.listRecords(), isEmpty);
  });
}
