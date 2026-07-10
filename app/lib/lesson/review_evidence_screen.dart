/// v13 — 지연 복습 수행 기록 목록.
library;

import 'package:flutter/material.dart';

import '../assessment/review_evidence.dart';
import '../assessment/review_queue.dart';
import '../theme/app_theme.dart';

class ReviewEvidenceScreen extends StatefulWidget {
  const ReviewEvidenceScreen({
    required this.repository,
    required this.onBack,
    super.key = const Key('review-evidence-screen'),
  });

  final ReviewEvidenceRepository repository;
  final VoidCallback onBack;

  @override
  State<ReviewEvidenceScreen> createState() => _ReviewEvidenceScreenState();
}

class _ReviewEvidenceScreenState extends State<ReviewEvidenceScreen> {
  late Future<List<ReviewEvidenceRecord>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = widget.repository.listRecords();
  }

  Future<void> _clearAll() async {
    final confirmed = await confirmDestructive(
      context,
      title: '복습 기록을 모두 삭제할까요?',
      message: '지금까지의 복습 수행 기록이 모두 삭제됩니다. 되돌릴 수 없습니다.',
      confirmLabel: '전체 삭제',
      confirmKey: const Key('review-evidence-clear-confirm'),
      cancelKey: const Key('review-evidence-clear-cancel'),
    );
    if (!confirmed || !mounted) return;
    await widget.repository.clearAll();
    if (!mounted) return;
    setState(_reload);
  }

  String _kindLabel(ReviewTaskKind kind) => switch (kind) {
        ReviewTaskKind.retention => '지연 재현',
        ReviewTaskKind.transfer => '조건 전이',
      };

  String _trackLabel(String track) => switch (track) {
        'universalCore' => '중급 공통 보컬 코어',
        'repertoireApplication' => '곡 적용 훈련',
        _ => track,
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('review-evidence-back'),
            tooltip: '뒤로',
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: const Text('복습 기록', style: TextStyle(fontSize: 18)),
          actions: [
            IconButton(
              key: const Key('review-evidence-clear'),
              tooltip: '복습 기록 전체 삭제',
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: Entrance(
          child: FutureBuilder<List<ReviewEvidenceRecord>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SkeletonList();
            }
            final records = snapshot.data ?? const <ReviewEvidenceRecord>[];
            if (records.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.replay_rounded, color: Sun.inkLow, size: 40),
                    const SizedBox(height: 12),
                    const Text(
                      '아직 복습 수행 기록이 없습니다.',
                      key: Key('review-evidence-empty'),
                      style: TextStyle(color: Sun.inkLow),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      key: const Key('review-evidence-empty-back'),
                      onPressed: widget.onBack,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Sun.inkMid,
                        side: const BorderSide(color: Sun.hairline),
                      ),
                      child: const Text('돌아가기'),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: records.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final record = records[index];
                return Container(
                  key: Key('review-evidence-${record.id}'),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Sun.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Sun.hairline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_trackLabel(record.track)} · ${_kindLabel(record.kind)}',
                        style: const TextStyle(
                          color: Sun.ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Cycle ${record.cycle} Day ${record.day} · ${record.cardId}',
                        style: const TextStyle(
                          color: Sun.inkLow,
                          fontSize: 11,
                          fontFeatures: Sun.tnum,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '시도 ${record.snapshot.attemptsUsed}회 · 자기점검 ${record.snapshot.selfCheckIndexes.length}개 · 새 녹음 ${record.snapshot.recordedTakeIds.length}개 · 이전 take 재생 ${record.snapshot.playedSourceTakeIds.length}개',
                        style: const TextStyle(
                          color: Sun.inkMid,
                          fontSize: 11,
                          fontFeatures: Sun.tnum,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.isRecovery
                            ? '목 상태 우선 · 무성 복습 후 재예약'
                            : (record.revisionMatched
                                ? '원래 배운 내용 그대로 복습했어요'
                                : '원래 배운 내용과 달라져 점수 비교는 하지 않아요'),
                        key: Key('review-evidence-revision-${record.id}'),
                        style: TextStyle(
                          color: record.revisionMatched
                              ? Sun.mint
                              : Sun.amber,
                          fontSize: 10,
                        ),
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
