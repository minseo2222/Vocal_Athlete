/// v18 — 생성 당시 학습일 기준 음색 팔레트와 다중 tag 정정/철회를 제공하는 화면.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/recording_ab.dart';
import '../theme/app_theme.dart';
import '../timbre/tone_profile.dart';
import '../timbre/tone_profile_curation.dart';

class ToneProfileScreen extends StatefulWidget {
  const ToneProfileScreen({
    required this.onBack,
    this.repository,
    super.key = const Key('tone-profile-screen'),
  });

  final VoidCallback onBack;
  final RecordingRepository? repository;

  @override
  State<ToneProfileScreen> createState() => _ToneProfileScreenState();
}

class _ToneProfileScreenState extends State<ToneProfileScreen> {
  ToneProfile? _profile;
  List<RecordingTake> _toneTakes = const [];
  final Set<String> _busyTakeIds = <String>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repository = widget.repository;
    final takes = repository == null
        ? const <RecordingTake>[]
        : await repository.listTakes();
    final toneTakes = repository == null
        ? const <RecordingTake>[]
        : await ToneProfileCurationService(repository).listToneTaggedTakes();
    if (!mounted) return;
    setState(() {
      _profile = ToneProfile.fromTakes(takes);
      _toneTakes = toneTakes.take(12).toList(growable: false);
    });
  }

  Widget _tagWrap(List<ToneTag> tags, {required String emptyText}) {
    if (tags.isEmpty) {
      return Text(emptyText,
          style: const TextStyle(color: Sun.inkLow, fontSize: 12));
    }
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final tag in tags)
          Chip(
            key: Key('tone-profile-tag-${tag.name}'),
            label: Text(tag.label),
            labelStyle: const TextStyle(color: Sun.ink, fontSize: 11),
            backgroundColor: Sun.surfaceSoft,
            side: BorderSide.none,
          ),
      ],
    );
  }


  Future<void> _runCuration(
    RecordingTake take,
    Future<RecordingTake?> Function() action,
    String successMessage,
  ) async {
    if (_busyTakeIds.contains(take.id)) return;
    setState(() => _busyTakeIds.add(take.id));
    try {
      final updated = await action();
      if (updated == null) throw StateError('take not found');
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(successMessage), duration: const Duration(seconds: 1)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('음색 기록을 수정하지 못했습니다. 다시 시도해 주세요.')),
      );
    } finally {
      if (mounted) setState(() => _busyTakeIds.remove(take.id));
    }
  }

  Future<void> _toggleExcluded(RecordingTake take) async {
    final repository = widget.repository;
    if (repository == null) return;
    final nextExcluded = !take.toneProfileExcluded;
    await _runCuration(
      take,
      () => ToneProfileCurationService(repository).setToneProfileExcluded(
        take.id,
        nextExcluded,
        memo: nextExcluded
            ? 'excluded_from_palette_screen'
            : 'restored_from_palette_screen',
      ),
      nextExcluded ? '이 take를 팔레트 집계에서 제외했습니다.' : '이 take를 팔레트 집계에 다시 포함했습니다.',
    );
  }

  Future<void> _setTags(RecordingTake take, List<ToneTag> tags) async {
    final repository = widget.repository;
    if (repository == null) return;
    await _runCuration(
      take,
      () => ToneProfileCurationService(repository).updateToneTags(
        take.id,
        tags,
        memo: 'edited_from_palette_screen',
      ),
      tags.isEmpty ? '이 take의 자기 태그를 모두 해제했습니다.' : '이 take의 자기 태그를 수정했습니다.',
    );
  }

  Widget _curationSection() => _section(
        '최근 tone take 정정 · 팔레트 제외',
        _toneTakes.isEmpty
            ? const Text('정정할 tone take가 없습니다.',
                style: TextStyle(color: Sun.inkLow, fontSize: 12))
            : Column(
                children: [
                  const Text(
                    '여기서 바꾸는 것은 자기 태그 메타데이터뿐입니다. 원음 파일은 삭제하지 않으며, 음색 점수나 성대 상태 판정으로 쓰지 않습니다.',
                    key: Key('tone-profile-curation-disclaimer'),
                    style: TextStyle(
                        color: Sun.inkLow, fontSize: 11, height: 1.35),
                  ),
                  const SizedBox(height: 8),
                  for (final take in _toneTakes) _ToneTakeCurationRow(
                    take: take,
                    busy: _busyTakeIds.contains(take.id),
                    onToggleExcluded: () => _toggleExcluded(take),
                    onSetTags: (tags) => _setTags(take, tags),
                  ),
                ],
              ),
      );

  Widget _section(String title, Widget child) => Container(
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
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final profile = _profile;
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('tone-profile-back'),
          tooltip: '뒤로',
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('내 음색 팔레트'),
        actions: [
          IconButton(
            key: const Key('tone-profile-refresh'),
            tooltip: '다시 계산',
            onPressed: () {
              HapticFeedback.lightImpact();
              _load();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Entrance(
        child: profile == null
          ? const SkeletonList()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              children: [
                const Text(
                  '내가 직접 선택한 tone tag와 편안함 기록만 요약합니다. 녹음 생성 당시의 로컬 날짜에서 같은 tag는 하루 한 번만 집계하며, AI 음색 판정이나 성대 상태 진단이 아닙니다.',
                  key: Key('tone-profile-disclaimer'),
                  style: TextStyle(
                      color: Sun.inkMid, fontSize: 12, height: 1.45),
                ),
                const SizedBox(height: 12),
                if (!profile.hasEnoughData)
                  Container(
                    key: const Key('tone-profile-not-enough-data'),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Sun.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Sun.hairline),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.palette_outlined,
                            color: Sun.inkLow, size: 40),
                        SizedBox(height: 12),
                        Text(
                          '아직 기록이 적습니다. 서로 다른 학습일 3일 이상에 tone tag가 쌓이면 팔레트를 더 안정적으로 볼 수 있습니다.',
                          style: TextStyle(
                              color: Sun.inkLow, fontSize: 12, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                _section(
                  '내가 자주 고른 톤 · 학습일 기준',
                  _tagWrap(profile.frequentlySelected,
                      emptyText: '선택된 tone tag가 없습니다.'),
                ),
                const SizedBox(height: 10),
                _section(
                  '편안함 4–5가 반복된 톤 · 학습일 기준',
                  _tagWrap(profile.comfortableTags,
                      emptyText: '아직 편안함 기록이 없습니다.'),
                ),
                const SizedBox(height: 10),
                _section(
                  '다음 시도에서 강도를 낮춰 볼 자기기록',
                  _tagWrap(profile.lowComfortTags,
                      emptyText: '낮은 편안함 신호가 기록되지 않았습니다.'),
                ),
                const SizedBox(height: 10),
                _section(
                  '기록 요약',
                  Text(
                    'tag take ${profile.observedTakeCount}개 · 서로 다른 학습일 ${profile.practiceDayCount}일 · 일×tag 기여 ${profile.dayTagContributionCount}개 · 같은 조건 확인 ${profile.sameConditionPracticeDayCount}일 · 기준/Best take ${profile.referenceTakeCount}개${profile.editedTakeCount > 0 ? ' · 직접 정정 ${profile.editedTakeCount}개' : ''}${profile.excludedTakeCount > 0 ? ' · 팔레트 제외 ${profile.excludedTakeCount}개' : ''}${profile.undatedTakeCount > 0 ? ' · 날짜 미상 ${profile.undatedTakeCount}개는 안정 집계 제외' : ''}',
                    key: const Key('tone-profile-summary'),
                    style: const TextStyle(
                        color: Sun.inkMid,
                        fontSize: 12,
                        height: 1.4,
                        fontFeatures: Sun.tnum),
                  ),
                ),
                const SizedBox(height: 10),
                _curationSection(),
              ],
            ),
      ),
    );
  }
}

class _ToneTakeCurationRow extends StatelessWidget {
  const _ToneTakeCurationRow({
    required this.take,
    required this.busy,
    required this.onToggleExcluded,
    required this.onSetTags,
  });

  static const editableTags = <ToneTag>[
    ToneTag.clean,
    ToneTag.bright,
    ToneTag.warm,
    ToneTag.clear,
    ToneTag.soft,
    ToneTag.speechLike,
    ToneTag.round,
    ToneTag.micFriendly,
    ToneTag.airyFeeling,
    ToneTag.comfortable,
    ToneTag.effortful,
    ToneTag.tired,
  ];

  final RecordingTake take;
  final bool busy;
  final VoidCallback onToggleExcluded;
  final ValueChanged<List<ToneTag>> onSetTags;

  void _toggleTag(ToneTag tag, bool selected) {
    final next = <ToneTag>[...take.toneTags];
    if (selected) {
      if (!next.contains(tag)) next.add(tag);
    } else {
      next.remove(tag);
    }
    onSetTags(next);
  }

  @override
  Widget build(BuildContext context) => Container(
        key: Key('tone-profile-take-${take.id}'),
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Sun.bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: take.toneProfileExcluded
                ? Sun.coral.withValues(alpha: 0.6)
                : Sun.hairline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${take.cardId} · ${take.slot.name} · 편안함 ${take.comfortRating}/5${take.toneProfileExcluded ? ' · 제외됨' : ''}${take.toneTagEditedEpochMs > 0 ? ' · 직접 정정됨' : ''}',
              style: const TextStyle(
                  color: Sun.ink, fontSize: 11, fontFeatures: Sun.tnum),
            ),
            if (take.createdLocalDateKey.isNotEmpty) ...[
              const SizedBox(height: 3),
              Text(
                '기록일 ${take.createdLocalDateKey}',
                style: const TextStyle(
                    color: Sun.inkLow, fontSize: 10, fontFeatures: Sun.tnum),
              ),
            ],
            const SizedBox(height: 6),
            Wrap(
              spacing: 5,
              runSpacing: 4,
              children: [
                for (final tag in editableTags)
                  ChoiceChip(
                    key: Key('tone-profile-edit-${take.id}-${tag.name}'),
                    selected: take.toneTags.contains(tag),
                    onSelected: busy
                        ? null
                        : (selected) {
                            HapticFeedback.selectionClick();
                            _toggleTag(tag, selected);
                          },
                    label: Text(tag.label),
                    labelStyle: const TextStyle(fontSize: 10),
                    selectedColor: Sun.surfaceSoft,
                    backgroundColor: Sun.surface,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (busy)
                  const SizedBox(
                    key: Key('tone-profile-curation-busy'),
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                if (take.toneTags.isNotEmpty)
                  TextButton(
                    key: Key('tone-profile-clear-tags-${take.id}'),
                    onPressed: busy
                        ? null
                        : () {
                            HapticFeedback.selectionClick();
                            onSetTags(const []);
                          },
                    child: const Text('태그 모두 해제'),
                  ),
                TextButton(
                  key: Key('tone-profile-exclude-${take.id}'),
                  onPressed: busy
                      ? null
                      : () {
                          HapticFeedback.selectionClick();
                          onToggleExcluded();
                        },
                  child: Text(take.toneProfileExcluded ? '팔레트에 다시 포함' : '팔레트에서 제외'),
                ),
              ],
            ),
          ],
        ),
      );
}
