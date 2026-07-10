import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';

ReviewEvidenceRecord _record({
  String id = 'review_1',
  String adaptationMode = 'normal',
}) =>
    ReviewEvidenceRecord(
      id: id,
      reviewTaskId: 'task_1',
      sourceEvidenceId: 'source_1',
      track: 'universalCore',
      cycle: 1,
      day: 1,
      cardId: 'UC-01',
      kind: ReviewTaskKind.retention,
      targetEvidence: LearningEvidenceLevel.e2,
      completedEpochMs: 2000,
      voiceState: adaptationMode == 'recovery' ? 'hoarse' : 'ok',
      adaptationMode: adaptationMode,
      sourceContentRevision:
          'universalCore:1:v10:day_1:UC-01:sha256_b00bafa4a975',
      currentContentRevision:
          'universalCore:1:v10:day_1:UC-01:sha256_b00bafa4a975',
      snapshot: const ReviewPracticeSnapshot(
        attemptsUsed: 1,
        selfCheckIndexes: <int>[0, 2],
        selectedKey: 'mid',
        recordedTakeIds: <String>['review_take_1'],
        playedSourceTakeIds: <String>['source_take_1'],
        bestTakeId: 'review_take_1',
      ),
    );

void main() {
  test('v13 review evidence round-trips without quality scoring', () {
    final original = _record();
    final decoded = ReviewEvidenceRecord.fromJson(original.toJson());

    expect(decoded.id, original.id);
    expect(decoded.kind, ReviewTaskKind.retention);
    expect(decoded.targetEvidence, LearningEvidenceLevel.e2);
    expect(decoded.snapshot.attemptsUsed, 1);
    expect(decoded.snapshot.playedSourceTakeIds, <String>['source_take_1']);
    expect(decoded.snapshot.recordedTakeIds, <String>['review_take_1']);
    expect(decoded.revisionMatched, isTrue);
    expect(decoded.toJson().containsKey('score'), isFalse);
  });

  test('v13 in-memory repository lists newest first and clears locally',
      () async {
    final repository = InMemoryReviewEvidenceRepository();
    await repository.saveRecord(_record(id: 'old'));
    await repository.saveRecord(ReviewEvidenceRecord.fromJson(<String, dynamic>{
      ..._record(id: 'new').toJson(),
      'completedEpochMs': 3000,
    }));

    final records = await repository.listRecords();
    expect(records.map((record) => record.id), <String>['new', 'old']);
    expect(await repository.findByReviewTaskId('task_1'), isNotNull);
    await repository.clearAll();
    expect(await repository.listRecords(), isEmpty);
  });

  test('v13 recovery review is explicitly marked', () {
    final record = _record(adaptationMode: 'recovery');
    expect(record.isRecovery, isTrue);
  });
}
