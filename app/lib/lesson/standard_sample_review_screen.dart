/// v6 — 표준샘플 리뷰 화면.
///
/// Day 1/24/48 표준샘플을 녹음 산출물로 다시 듣고 비교하는 화면이다.
/// 점수화하지 않고 before/mid/graduation take를 local-first로 보여준다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/audio_io.dart';
import '../recording/recording_ab.dart';
import '../theme/app_theme.dart';

class StandardSampleReviewScreen extends StatefulWidget {
  const StandardSampleReviewScreen({
    required this.onBack,
    this.repository,
    this.playbackAdapter,
    super.key = const Key('standard-sample-review-screen'),
  });

  final VoidCallback onBack;
  final RecordingRepository? repository;
  final AudioPlaybackAdapter? playbackAdapter;

  @override
  State<StandardSampleReviewScreen> createState() =>
      _StandardSampleReviewScreenState();
}

class _StandardSampleReviewScreenState
    extends State<StandardSampleReviewScreen> {
  List<RecordingTake> _takes = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = widget.repository;
    final takes = repo == null
        ? <RecordingTake>[]
        : await repo.listTakes(purpose: RecordingPurpose.standardSample);
    if (!mounted) return;
    setState(() {
      _takes = takes;
      _loaded = true;
    });
  }

  Future<void> _delete(String id) async {
    final repo = widget.repository;
    if (repo == null) return;
    await repo.deleteTake(id);
    await _load();
  }

  Future<void> _play(RecordingTake take) async {
    if (widget.playbackAdapter == null || !take.hasPlayableLocalFile) return;
    await widget.playbackAdapter!.play(take.localPath);
  }

  List<RecordingTake> _forSlot(RecordingSlot slot) =>
      _takes.where((take) => take.slot == slot).toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('standard-review-back'),
            tooltip: '뒤로',
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: const Text('표준샘플 리뷰', style: TextStyle(fontSize: 18)),
        ),
        body: Entrance(
          child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const Text(
              'Day 1 / Day 24 / Day 48 녹음을 다시 듣습니다. 점수가 아니라 변화와 편안함을 확인합니다.',
              style: TextStyle(color: Sun.inkMid, fontSize: 13, height: 1.35),
            ),
            const SizedBox(height: 16),
            if (!_loaded)
              const SkeletonList(rows: 3, shrinkWrap: true)
            else if (_takes.isEmpty)
              Container(
                key: const Key('standard-review-empty'),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Sun.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Sun.hairline),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.graphic_eq_rounded, color: Sun.inkLow, size: 40),
                    const SizedBox(height: 12),
                    const Text(
                      '아직 저장된 표준샘플이 없습니다. CARD-13 레슨에서 녹음을 남기면 여기에 표시됩니다.',
                      style: TextStyle(color: Sun.inkMid, fontSize: 12, height: 1.35),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      key: const Key('standard-review-empty-back'),
                      onPressed: widget.onBack,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Sun.inkMid,
                        side: const BorderSide(color: Sun.hairline),
                      ),
                      child: const Text('돌아가기'),
                    ),
                  ],
                ),
              )
            else ...[
              _Section(title: 'Baseline · Day 1', takes: _forSlot(RecordingSlot.baseline), onPlay: _play, onDelete: _delete),
              _Section(title: 'Midpoint · Day 24', takes: _forSlot(RecordingSlot.midpoint), onPlay: _play, onDelete: _delete),
              _Section(title: 'Graduation · Day 48', takes: _forSlot(RecordingSlot.graduation), onPlay: _play, onDelete: _delete),
            ],
          ],
        ),
        ),
      );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.takes,
    required this.onPlay,
    required this.onDelete,
  });

  final String title;
  final List<RecordingTake> takes;
  final Future<void> Function(RecordingTake) onPlay;
  final Future<void> Function(String) onDelete;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Sun.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Sun.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Sun.inkMid,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                      fontFeatures: Sun.tnum)),
              const SizedBox(height: 8),
              if (takes.isEmpty)
                const Text('아직 없음',
                    style: TextStyle(color: Sun.inkLow, fontSize: 12))
              else
                for (final take in takes)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${take.isBest ? 'BEST · ' : ''}${take.toneTags.isEmpty ? '태그 없음' : take.toneTags.map((tag) => tag.label).join(' · ')} · 편안함 ${take.comfortRating}/5 · ${take.durationLabel}',
                          key: Key('standard-take-${take.id}'),
                          style: const TextStyle(
                              color: Sun.inkMid,
                              fontSize: 12,
                              fontFeatures: Sun.tnum),
                        ),
                      ),
                      TextButton(
                        key: Key('standard-play-${take.id}'),
                        onPressed: take.hasPlayableLocalFile
                            ? () {
                                HapticFeedback.lightImpact();
                                onPlay(take);
                              }
                            : null,
                        child: const Text('재생'),
                      ),
                      IconButton(
                        key: Key('standard-delete-${take.id}'),
                        tooltip: '삭제',
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          onDelete(take.id);
                        },
                        icon: const Icon(Icons.delete_outline, color: Sun.inkLow, size: 18),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      );
}
