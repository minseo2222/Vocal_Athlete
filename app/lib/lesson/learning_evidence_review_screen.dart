/// v11 — completion과 학습 증거 메타데이터를 분리해 보여주는 로컬 리뷰 화면.
library;

import 'package:flutter/material.dart';

import '../assessment/learning_evidence.dart';
import '../theme/app_theme.dart';

class LearningEvidenceReviewScreen extends StatefulWidget {
  const LearningEvidenceReviewScreen({
    required this.repository,
    required this.onBack,
    super.key = const Key('learning-evidence-review-screen'),
  });

  final LearningEvidenceRepository repository;
  final VoidCallback onBack;

  @override
  State<LearningEvidenceReviewScreen> createState() =>
      _LearningEvidenceReviewScreenState();
}

class _LearningEvidenceReviewScreenState
    extends State<LearningEvidenceReviewScreen> {
  late Future<List<LearningEvidenceRecord>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.listRecords();
  }

  void _reload() {
    setState(() {
      _future = widget.repository.listRecords();
    });
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('학습 기록을 삭제할까요?'),
        content: const Text(
          '시도·자기점검 메타데이터만 삭제합니다. 저장된 녹음 파일은 녹음 관리에서 별도로 삭제합니다.',
        ),
        actions: [
          TextButton(
            key: const Key('learning-evidence-clear-cancel'),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            key: const Key('learning-evidence-clear-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await widget.repository.clearAll();
    if (!mounted) return;
    _reload();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('학습 기록을 삭제했습니다.')),
    );
  }

  String _trackLabel(String track) => switch (track) {
        'universalCore' => '중급 공통 보컬 코어',
        'repertoireApplication' => '곡 적용 훈련',
        _ => track,
      };

  String _modeLabel(String mode) => switch (mode) {
        'recovery' => '회복',
        'reduced' => '라이트',
        _ => '일반',
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('learning-evidence-back'),
            tooltip: '뒤로',
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('학습 기록', style: TextStyle(fontSize: 18)),
          actions: [
            IconButton(
              key: const Key('learning-evidence-clear'),
              tooltip: '학습 기록 삭제',
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: Entrance(
          child: FutureBuilder<List<LearningEvidenceRecord>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SkeletonList();
            }
            final records = snapshot.data ?? const <LearningEvidenceRecord>[];
            if (records.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.insights_rounded, color: Sun.inkLow, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        '아직 저장된 학습 기록이 없습니다.\n시도 수와 자기점검은 점수가 아니라 다음 복습을 위한 흔적입니다.',
                        key: Key('learning-evidence-empty'),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Sun.inkLow, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        key: const Key('learning-evidence-empty-back'),
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
              itemCount: records.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final record = records[index];
                final s = record.snapshot;
                return Container(
                  key: Key('learning-evidence-${record.id}'),
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
                        '${_trackLabel(record.track)} · Cycle ${record.cycle} Day ${record.day}',
                        style: const TextStyle(
                          color: Sun.ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          fontFeatures: Sun.tnum,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${record.cardId} · ${_modeLabel(record.adaptationMode)} 모드',
                        style: const TextStyle(
                            color: Sun.inkLow, fontSize: 11),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '시도 ${s.attemptsUsed}회 · 자기점검 ${s.selfCheckIndexes.length}개 · 예시 청취 ${s.playedAudioPaths.length}개 · 녹음 ${s.recordedTakeIds.isEmpty ? s.recordedTakeCount : s.recordedTakeIds.length}개',
                        style: const TextStyle(
                            color: Sun.inkMid,
                            fontSize: 11,
                            height: 1.4,
                            fontFeatures: Sun.tnum),
                      ),
                      if (s.bestTakeId != null)
                        Text(
                          'Best take · ${s.bestTakeId}',
                          key: const Key('learning-evidence-best-take'),
                          style: const TextStyle(
                              color: Sun.mint, fontSize: 11),
                        ),
                      if (s.selectedKey != null)
                        Text(
                          '선택 키 · ${s.selectedKey == 'low' ? '낮은 키' : '중간 키'}',
                          style: const TextStyle(
                              color: Sun.coral, fontSize: 11),
                        ),
                      const SizedBox(height: 5),
                      const Text(
                        '이 기록은 수행 메타데이터이며 가창 품질 인증이 아닙니다.',
                        style:
                            TextStyle(color: Sun.inkLow, fontSize: 9),
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
