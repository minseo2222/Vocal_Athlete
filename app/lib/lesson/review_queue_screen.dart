/// v13 — 지연 복습 큐 화면.
///
/// 큐는 정규 진도와 streak를 막지 않는다. due item은 별도 복습 수행 화면에서
/// 기록하며, 오늘 넘기기는 실패가 아니라 다음 날 재제안이다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assessment/review_queue.dart';
import '../theme/app_theme.dart';

class ReviewQueueScreen extends StatefulWidget {
  const ReviewQueueScreen({
    required this.repository,
    required this.onBack,
    required this.todayEpochDay,
    this.onStartReview,
    this.onChanged,
    this.dueOnly = false,
    super.key = const Key('review-queue-screen'),
  });

  final ReviewQueueRepository repository;
  final VoidCallback onBack;
  final int todayEpochDay;
  final ValueChanged<ReviewQueueItem>? onStartReview;
  final VoidCallback? onChanged;
  final bool dueOnly;

  @override
  State<ReviewQueueScreen> createState() => _ReviewQueueScreenState();
}

class _ReviewQueueScreenState extends State<ReviewQueueScreen> {
  late Future<List<ReviewQueueItem>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = widget.dueOnly
        ? widget.repository.dueItems(widget.todayEpochDay)
        : widget.repository.listItems(status: ReviewTaskStatus.pending);
  }

  Future<void> _legacyComplete(String id) async {
    await widget.repository.completeItem(
      id,
      completedEpochMs: DateTime.now().millisecondsSinceEpoch,
    );
    if (!mounted) return;
    setState(_reload);
    widget.onChanged?.call();
  }

  Future<void> _postpone(String id) async {
    await widget.repository.postponeItem(
      id,
      dueEpochDay: widget.todayEpochDay + 1,
      note: 'user_postponed_without_streak_loss',
    );
    if (!mounted) return;
    setState(_reload);
    widget.onChanged?.call();
  }

  String _trackLabel(String track) => switch (track) {
        'universalCore' => '중급 공통 보컬 코어',
        'repertoireApplication' => '곡 적용 훈련',
        _ => track,
      };

  String _kindLabel(ReviewTaskKind kind) => switch (kind) {
        ReviewTaskKind.retention => '지연 재현',
        ReviewTaskKind.transfer => '조건 전이',
      };

  String _dueLabel(ReviewQueueItem item) {
    final diff = item.dueEpochDay - widget.todayEpochDay;
    if (diff <= 0) return '오늘 가능';
    if (diff == 1) return '내일';
    return '$diff일 후';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('review-queue-back'),
            tooltip: '뒤로',
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: Text(
            widget.dueOnly ? '오늘의 선택 복습' : '복습 큐',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        body: Entrance(
          child: FutureBuilder<List<ReviewQueueItem>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SkeletonList();
            }
            final items = snapshot.data ?? const <ReviewQueueItem>[];
            if (items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.replay_rounded, color: Sun.inkLow, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        '아직 예약된 복습이 없습니다.\n복습은 정규 진도를 막지 않고, 시간이 지난 뒤 다시 확인하는 선택 과제입니다.',
                        key: Key('review-queue-empty'),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Sun.inkLow, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        key: const Key('review-queue-empty-back'),
                        onPressed: widget.onBack,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Sun.inkMid,
                          side: const BorderSide(color: Sun.hairline),
                        ),
                        child: const Text('돌아가기'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                final due = item.isDue(widget.todayEpochDay);
                return Container(
                  key: Key('review-task-${item.id}'),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: due ? Sun.surface : Sun.surfaceSoft,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: due ? Sun.coral : Sun.hairline,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${_trackLabel(item.track)} · Cycle ${item.cycle} Day ${item.day}',
                              style: const TextStyle(
                                color: Sun.ink,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                fontFeatures: Sun.tnum,
                              ),
                            ),
                          ),
                          Text(
                            _dueLabel(item),
                            key: Key('review-task-due-${item.id}'),
                            style: TextStyle(
                              color: due ? Sun.coral : Sun.inkLow,
                              fontSize: 11,
                              fontFeatures: Sun.tnum,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _kindLabel(item.kind),
                        style: const TextStyle(
                          color: Sun.inkLow,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '시험이 아닙니다. 먼저 기억에서 재현하고, 필요할 때만 이전 기록을 확인합니다.',
                        style: TextStyle(
                          color: Sun.inkMid,
                          fontSize: 11,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          OutlinedButton(
                            key: Key('review-task-skip-${item.id}'),
                            onPressed: due ? () => _postpone(item.id) : null,
                            child: const Text('오늘 넘기기'),
                          ),
                          FilledButton(
                            key: Key('review-task-complete-${item.id}'),
                            onPressed: due
                                ? () {
                                    HapticFeedback.lightImpact();
                                    final handler = widget.onStartReview;
                                    if (handler != null) {
                                      handler(item);
                                    } else {
                                      _legacyComplete(item.id);
                                    }
                                  }
                                : null,
                            child: const Text('복습 시작'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        ),
      );
}
