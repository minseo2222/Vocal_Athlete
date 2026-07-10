/// v7 — 곡 적용 훈련 take 리뷰 화면.
///
/// 이 화면은 노래 제작 도구가 아니다. Universal Vocal Core에서 배운 기술을
/// 짧은 프레이즈/곡 구간에 적용한 녹음 take를 다시 듣고 비교하는 화면이다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/audio_io.dart';
import '../recording/recording_ab.dart';
import '../recording/recording_library.dart';
import '../theme/app_theme.dart';

class RepertoireApplicationReviewScreen extends StatefulWidget {
  const RepertoireApplicationReviewScreen({
    required this.onBack,
    this.repository,
    this.playbackAdapter,
    super.key = const Key('repertoire-review-screen'),
  });

  final VoidCallback onBack;
  final RecordingRepository? repository;
  final AudioPlaybackAdapter? playbackAdapter;

  @override
  State<RepertoireApplicationReviewScreen> createState() =>
      _RepertoireApplicationReviewScreenState();
}

class _RepertoireApplicationReviewScreenState
    extends State<RepertoireApplicationReviewScreen> {
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
        : await repo.listTakes(purpose: RecordingPurpose.repertoirePhrase);
    takes.sort((a, b) => a.createdEpochMs.compareTo(b.createdEpochMs));
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

  Map<String, List<RecordingTake>> _byCard() {
    final grouped = <String, List<RecordingTake>>{};
    for (final take in _takes) {
      grouped.putIfAbsent(take.cardId, () => []).add(take);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('repertoire-review-back'),
            tooltip: '뒤로',
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: const Text('곡 적용 훈련 리뷰', style: TextStyle(fontSize: 18)),
        ),
        body: Entrance(
          child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const Text(
              '발성·호흡·음정·리듬·음색·딕션을 짧은 프레이즈에 적용한 take를 다시 듣습니다. 곡 제작 기능이 아닙니다.',
              style: TextStyle(color: Sun.inkMid, fontSize: 13, height: 1.35),
            ),
            const SizedBox(height: 16),
            if (!_loaded)
              const SkeletonList(rows: 3, shrinkWrap: true)
            else if (_takes.isEmpty)
              Container(
                key: const Key('repertoire-review-empty'),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Sun.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Sun.hairline),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.library_music_outlined,
                        color: Sun.inkLow, size: 40),
                    const SizedBox(height: 12),
                    const Text(
                      '아직 저장된 곡 적용 훈련 take가 없습니다. Repertoire Application 카드에서 녹음을 남기면 표시됩니다.',
                      style: TextStyle(color: Sun.inkMid, fontSize: 12, height: 1.35),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      key: const Key('repertoire-review-empty-back'),
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
            else
              for (final entry in _byCard().entries)
                _RepertoireSection(
                  cardId: entry.key,
                  takes: entry.value,
                  onPlay: _play,
                  onDelete: _delete,
                ),
          ],
        ),
        ),
      );
}

class _RepertoireSection extends StatelessWidget {
  const _RepertoireSection({
    required this.cardId,
    required this.takes,
    required this.onPlay,
    required this.onDelete,
  });

  final String cardId;
  final List<RecordingTake> takes;
  final Future<void> Function(RecordingTake) onPlay;
  final Future<void> Function(String) onDelete;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          key: Key('repertoire-section-$cardId'),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Sun.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Sun.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardId,
                  style: const TextStyle(
                      color: Sun.inkMid,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0)),
              const SizedBox(height: 8),
              for (final take in takes)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${take.isBest ? 'BEST · ' : ''}${take.slot.name.toUpperCase()} · ${take.toneTags.isEmpty ? '태그 없음' : take.toneTags.map((t) => t.label).join(', ')} · 편안함 ${take.comfortRating}/5 · ${take.durationLabel} · ${formatRecordingBytes(take.fileSizeBytes)}',
                        key: Key('repertoire-take-${take.id}'),
                        style: const TextStyle(
                            color: Sun.inkMid,
                            fontSize: 12,
                            fontFeatures: Sun.tnum),
                      ),
                    ),
                    TextButton(
                      key: Key('repertoire-play-${take.id}'),
                      onPressed: take.hasPlayableLocalFile
                          ? () {
                              HapticFeedback.lightImpact();
                              onPlay(take);
                            }
                          : null,
                      child: const Text('재생'),
                    ),
                    IconButton(
                      key: Key('repertoire-delete-${take.id}'),
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
