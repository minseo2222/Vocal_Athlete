import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';
import 'package:vocal_athlete/assessment/learning_evidence.dart';
import 'package:vocal_athlete/assessment/review_queue.dart';

LearningEvidenceRecord _record({
  LearningEvidenceLevel level = LearningEvidenceLevel.e3,
  String track = 'repertoireApplication',
  bool recovery = false,
}) =>
    LearningEvidenceRecord(
      id: '${track}_1_12_RA-10_1000',
      track: track,
      cycle: 1,
      day: 12,
      cardId: track == 'repertoireApplication' ? 'RA-10' : 'UC-25',
      targetEvidence: level,
      completedEpochMs: 1000,
      voiceState: recovery ? 'hoarse' : 'ok',
      adaptationMode: recovery ? 'recovery' : 'normal',
      snapshot: const LessonPracticeSnapshot(
        attemptsUsed: 2,
        recordedTakeIds: <String>['take_a'],
        bestTakeSelected: true,
        bestTakeId: 'take_a',
      ),
      contentRevision: 'repertoireApplication:1:v10:day_12:RA-10:sha256_d527d8a1c3d',
    );

void main() {
  test('v13 scheduler creates retention and transfer tasks for practice evidence', () {
    final items = const ReviewQueueScheduler().itemsForEvidence(
      record: _record(),
      todayEpochDay: 100,
    );
    expect(items, hasLength(2));
    expect(items.first.kind, ReviewTaskKind.retention);
    expect(items.first.dueEpochDay, 101);
    expect(items.last.kind, ReviewTaskKind.transfer);
    expect(items.last.dueEpochDay, 103);
    expect(items.last.contentRevision, contains('RA-10'));
  });

  test('v13 scheduler does not schedule voiced reviews from recovery mode', () {
    final items = const ReviewQueueScheduler().itemsForEvidence(
      record: _record(recovery: true),
      todayEpochDay: 100,
    );
    expect(items, isEmpty);
  });

  test('v13 shared preferences review queue persists and completes local metadata', () async {
    final metadata = AppMetadataStore(
      primary: InMemoryMetadataBackend(),
      legacy: null,
    );
    final repository = SharedPreferencesReviewQueueRepository(
      metadataStore: metadata,
    );
    final items = const ReviewQueueScheduler().itemsForEvidence(
      record: _record(),
      todayEpochDay: 100,
    );
    await repository.saveItems(items);
    expect(await repository.dueItems(100), isEmpty);
    expect(await repository.dueItems(101), hasLength(1));
    expect(await repository.findById(items.first.id), isNotNull);
    await repository.postponeItem(
      items.first.id,
      dueEpochDay: 102,
      note: 'user_postponed_without_streak_loss',
    );
    expect(await repository.dueItems(101), isEmpty);
    expect(await repository.dueItems(102), hasLength(1));
    await repository.completeItem(items.first.id, completedEpochMs: 2000);
    final completed = await repository.listItems(status: ReviewTaskStatus.completed);
    expect(completed.single.completedEpochMs, 2000);
  });
}
