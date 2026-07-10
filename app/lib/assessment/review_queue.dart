/// v13 — 지연 재현(E2)·조건 전이(E3) 복습 큐.
///
/// 이 계층은 학습 증거를 자동 채점하지 않는다. completion 직후 생성된
/// 메타데이터 기록을 기준으로, 시간이 지난 뒤 다시 확인할 과제를 local-first로
/// 예약한다. 복습을 건너뛰어도 streak나 정규 진도는 손상되지 않는다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';

import 'learning_evidence.dart';

enum ReviewTaskKind { retention, transfer }

enum ReviewTaskStatus { pending, completed, dismissed }

ReviewTaskKind reviewTaskKindFromLabel(String value) {
  final normalized = value.trim().toLowerCase();
  return ReviewTaskKind.values.firstWhere(
    (kind) => kind.name == normalized,
    orElse: () => ReviewTaskKind.retention,
  );
}

ReviewTaskStatus reviewTaskStatusFromLabel(String value) {
  final normalized = value.trim().toLowerCase();
  return ReviewTaskStatus.values.firstWhere(
    (status) => status.name == normalized,
    orElse: () => ReviewTaskStatus.pending,
  );
}

class ReviewQueueItem {
  const ReviewQueueItem({
    required this.id,
    required this.sourceEvidenceId,
    required this.track,
    required this.cycle,
    required this.day,
    required this.cardId,
    required this.kind,
    required this.targetEvidence,
    required this.dueEpochDay,
    required this.createdEpochMs,
    required this.contentRevision,
    this.status = ReviewTaskStatus.pending,
    this.completedEpochMs,
    this.note = '',
  });

  final String id;
  final String sourceEvidenceId;
  final String track;
  final int cycle;
  final int day;
  final String cardId;
  final ReviewTaskKind kind;
  final LearningEvidenceLevel targetEvidence;
  final int dueEpochDay;
  final int createdEpochMs;
  final String contentRevision;
  final ReviewTaskStatus status;
  final int? completedEpochMs;
  final String note;

  bool isDue(int todayEpochDay) =>
      status == ReviewTaskStatus.pending && dueEpochDay <= todayEpochDay;

  ReviewQueueItem copyWith({
    ReviewTaskStatus? status,
    int? completedEpochMs,
    bool clearCompletedEpochMs = false,
    String? note,
  }) =>
      ReviewQueueItem(
        id: id,
        sourceEvidenceId: sourceEvidenceId,
        track: track,
        cycle: cycle,
        day: day,
        cardId: cardId,
        kind: kind,
        targetEvidence: targetEvidence,
        dueEpochDay: dueEpochDay,
        createdEpochMs: createdEpochMs,
        contentRevision: contentRevision,
        status: status ?? this.status,
        completedEpochMs:
            clearCompletedEpochMs ? null : (completedEpochMs ?? this.completedEpochMs),
        note: note ?? this.note,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'sourceEvidenceId': sourceEvidenceId,
        'track': track,
        'cycle': cycle,
        'day': day,
        'cardId': cardId,
        'kind': kind.name,
        'targetEvidence': targetEvidence.name,
        'dueEpochDay': dueEpochDay,
        'createdEpochMs': createdEpochMs,
        'contentRevision': contentRevision,
        'status': status.name,
        'completedEpochMs': completedEpochMs,
        'note': note,
      };

  factory ReviewQueueItem.fromJson(Map<String, dynamic> json) =>
      ReviewQueueItem(
        id: json['id'] as String,
        sourceEvidenceId: json['sourceEvidenceId'] as String,
        track: json['track'] as String,
        cycle: (json['cycle'] as int?) ?? 0,
        day: (json['day'] as int?) ?? 0,
        cardId: json['cardId'] as String,
        kind: reviewTaskKindFromLabel((json['kind'] as String?) ?? 'retention'),
        targetEvidence:
            evidenceLevelFromLabel((json['targetEvidence'] as String?) ?? 'e2'),
        dueEpochDay: (json['dueEpochDay'] as int?) ?? 0,
        createdEpochMs: (json['createdEpochMs'] as int?) ?? 0,
        contentRevision: (json['contentRevision'] as String?) ?? 'unknown',
        status:
            reviewTaskStatusFromLabel((json['status'] as String?) ?? 'pending'),
        completedEpochMs: json['completedEpochMs'] as int?,
        note: (json['note'] as String?) ?? '',
      );
}

abstract class ReviewQueueRepository {
  Future<void> saveItems(List<ReviewQueueItem> items);
  Future<void> saveItem(ReviewQueueItem item);
  Future<List<ReviewQueueItem>> listItems({ReviewTaskStatus? status});
  Future<List<ReviewQueueItem>> dueItems(int todayEpochDay);
  Future<ReviewQueueItem?> findById(String id);
  Future<void> completeItem(String id, {required int completedEpochMs});
  Future<void> postponeItem(
    String id, {
    required int dueEpochDay,
    String note = '',
  });
  Future<void> dismissItem(String id, {String note = ''});
  Future<void> clearAll();
}

class InMemoryReviewQueueRepository implements ReviewQueueRepository {
  final Map<String, ReviewQueueItem> _items = <String, ReviewQueueItem>{};

  @override
  Future<void> saveItems(List<ReviewQueueItem> items) async {
    for (final item in items) {
      _items[item.id] = item;
    }
  }

  @override
  Future<void> saveItem(ReviewQueueItem item) async => _items[item.id] = item;

  @override
  Future<List<ReviewQueueItem>> listItems({ReviewTaskStatus? status}) async {
    final result = _items.values
        .where((item) => status == null || item.status == status)
        .toList(growable: false)
      ..sort((a, b) {
        final due = a.dueEpochDay.compareTo(b.dueEpochDay);
        if (due != 0) return due;
        return b.createdEpochMs.compareTo(a.createdEpochMs);
      });
    return result;
  }

  @override
  Future<List<ReviewQueueItem>> dueItems(int todayEpochDay) async {
    final result = _items.values
        .where((item) => item.isDue(todayEpochDay))
        .toList(growable: false)
      ..sort((a, b) => a.dueEpochDay.compareTo(b.dueEpochDay));
    return result;
  }

  @override
  Future<ReviewQueueItem?> findById(String id) async => _items[id];

  @override
  Future<void> completeItem(String id, {required int completedEpochMs}) async {
    final item = _items[id];
    if (item == null) return;
    _items[id] = item.copyWith(
      status: ReviewTaskStatus.completed,
      completedEpochMs: completedEpochMs,
    );
  }

  @override
  Future<void> postponeItem(
    String id, {
    required int dueEpochDay,
    String note = '',
  }) async {
    final item = _items[id];
    if (item == null) return;
    _items[id] = ReviewQueueItem(
      id: item.id,
      sourceEvidenceId: item.sourceEvidenceId,
      track: item.track,
      cycle: item.cycle,
      day: item.day,
      cardId: item.cardId,
      kind: item.kind,
      targetEvidence: item.targetEvidence,
      dueEpochDay: dueEpochDay,
      createdEpochMs: item.createdEpochMs,
      contentRevision: item.contentRevision,
      status: ReviewTaskStatus.pending,
      note: note,
    );
  }

  @override
  Future<void> dismissItem(String id, {String note = ''}) async {
    final item = _items[id];
    if (item == null) return;
    _items[id] = item.copyWith(status: ReviewTaskStatus.dismissed, note: note);
  }

  @override
  Future<void> clearAll() async => _items.clear();
}

class SharedPreferencesReviewQueueRepository implements ReviewQueueRepository {
  SharedPreferencesReviewQueueRepository({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'review_queue_v1';
  final AppMetadataStore _metadataStore;

  Future<List<ReviewQueueItem>> _read() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return <ReviewQueueItem>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const FormatException('review queue is not a list');
      }
      return decoded
          .map((item) => ReviewQueueItem.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(growable: true);
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return <ReviewQueueItem>[];
    }
  }

  Future<void> _write(List<ReviewQueueItem> items) =>
      _metadataStore.writeString(
        storageKey,
        jsonEncode(items.map((item) => item.toJson()).toList()),
      );

  @override
  Future<void> saveItems(List<ReviewQueueItem> items) async {
    final existing = await _read();
    final byId = <String, ReviewQueueItem>{
      for (final item in existing) item.id: item,
    };
    for (final item in items) {
      byId[item.id] = item;
    }
    final out = byId.values.toList(growable: true)
      ..sort((a, b) => a.dueEpochDay.compareTo(b.dueEpochDay));
    await _write(out);
  }

  @override
  Future<void> saveItem(ReviewQueueItem item) async =>
      saveItems(<ReviewQueueItem>[item]);

  @override
  Future<List<ReviewQueueItem>> listItems({ReviewTaskStatus? status}) async {
    final items = await _read();
    final filtered = items
        .where((item) => status == null || item.status == status)
        .toList(growable: false)
      ..sort((a, b) {
        final due = a.dueEpochDay.compareTo(b.dueEpochDay);
        if (due != 0) return due;
        return b.createdEpochMs.compareTo(a.createdEpochMs);
      });
    return filtered;
  }

  @override
  Future<List<ReviewQueueItem>> dueItems(int todayEpochDay) async {
    final items = await _read();
    return items
        .where((item) => item.isDue(todayEpochDay))
        .toList(growable: false)
      ..sort((a, b) => a.dueEpochDay.compareTo(b.dueEpochDay));
  }

  @override
  Future<ReviewQueueItem?> findById(String id) async {
    final items = await _read();
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<void> completeItem(String id, {required int completedEpochMs}) async {
    final items = await _read();
    await _write(<ReviewQueueItem>[
      for (final item in items)
        item.id == id
            ? item.copyWith(
                status: ReviewTaskStatus.completed,
                completedEpochMs: completedEpochMs,
              )
            : item,
    ]);
  }

  @override
  Future<void> postponeItem(
    String id, {
    required int dueEpochDay,
    String note = '',
  }) async {
    final items = await _read();
    await _write(<ReviewQueueItem>[
      for (final item in items)
        item.id == id
            ? ReviewQueueItem(
                id: item.id,
                sourceEvidenceId: item.sourceEvidenceId,
                track: item.track,
                cycle: item.cycle,
                day: item.day,
                cardId: item.cardId,
                kind: item.kind,
                targetEvidence: item.targetEvidence,
                dueEpochDay: dueEpochDay,
                createdEpochMs: item.createdEpochMs,
                contentRevision: item.contentRevision,
                status: ReviewTaskStatus.pending,
                note: note,
              )
            : item,
    ]);
  }

  @override
  Future<void> dismissItem(String id, {String note = ''}) async {
    final items = await _read();
    await _write(<ReviewQueueItem>[
      for (final item in items)
        item.id == id
            ? item.copyWith(status: ReviewTaskStatus.dismissed, note: note)
            : item,
    ]);
  }

  @override
  Future<void> clearAll() => _metadataStore.remove(storageKey);
}

class ReviewQueueScheduler {
  const ReviewQueueScheduler();

  List<ReviewQueueItem> itemsForEvidence({
    required LearningEvidenceRecord record,
    required int todayEpochDay,
  }) {
    if (record.isRecovery || record.targetEvidence == LearningEvidenceLevel.e0) {
      return const <ReviewQueueItem>[];
    }
    final created = record.completedEpochMs;
    final items = <ReviewQueueItem>[
      ReviewQueueItem(
        id: '${record.id}_retention_d1',
        sourceEvidenceId: record.id,
        track: record.track,
        cycle: record.cycle,
        day: record.day,
        cardId: record.cardId,
        kind: ReviewTaskKind.retention,
        targetEvidence: LearningEvidenceLevel.e2,
        dueEpochDay: todayEpochDay + 1,
        createdEpochMs: created,
        contentRevision: record.contentRevision,
      ),
    ];
    final shouldScheduleTransfer =
        record.targetEvidence.index >= LearningEvidenceLevel.e3.index ||
            record.track == 'repertoireApplication' ||
            record.snapshot.bestTakeSelected;
    if (shouldScheduleTransfer) {
      items.add(ReviewQueueItem(
        id: '${record.id}_transfer_d3',
        sourceEvidenceId: record.id,
        track: record.track,
        cycle: record.cycle,
        day: record.day,
        cardId: record.cardId,
        kind: ReviewTaskKind.transfer,
        targetEvidence: LearningEvidenceLevel.e3,
        dueEpochDay: todayEpochDay + 3,
        createdEpochMs: created,
        contentRevision: record.contentRevision,
      ));
    }
    return items;
  }
}
