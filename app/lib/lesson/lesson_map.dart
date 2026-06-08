/// 홈 여정 맵 — 슬롯을 블록 섹션으로 묶어 세로로. 탭 불가(여정 시각화).
/// 완료=초록 ✓ / 오늘=파랑 ▶ / 미래=잠금 🔒. 상태는 currentIndex 기준.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class LessonMap extends StatelessWidget {
  const LessonMap({super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _label(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    final blocks = <int, List<int>>{};
    for (var i = 0; i < slots.length; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final b in orderedBlocks) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
              child: Text(
                _label(b),
                style: const TextStyle(
                    color: AppColors.textMid, fontSize: 12, letterSpacing: 1),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final i in blocks[b]!)
                  _Node(
                    state: i < today
                        ? _NodeState.done
                        : i == today
                            ? _NodeState.today
                            : _NodeState.future,
                    offset: (i - blocks[b]!.first).isEven ? 0 : 28,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state, required this.offset});
  final _NodeState state;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final (bg, border, glyph, glyphColor, key) = switch (state) {
      _NodeState.done => (
          const Color(0xFF1D3A2C),
          AppColors.done,
          '✓',
          AppColors.done,
          const Key('node-done')
        ),
      _NodeState.today => (
          AppColors.now,
          AppColors.now,
          '▶',
          Colors.white,
          const Key('node-today')
        ),
      _NodeState.future => (
          AppColors.surface,
          AppColors.lockedSurface,
          '🔒',
          AppColors.locked,
          const Key('node-future')
        ),
    };
    return Padding(
      padding: EdgeInsets.only(left: offset),
      child: Container(
        key: key,
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 2),
          boxShadow: state == _NodeState.today
              ? [BoxShadow(color: AppColors.now.withValues(alpha: 0.35), blurRadius: 10, spreadRadius: 2)]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(glyph, style: TextStyle(color: glyphColor, fontSize: 18)),
      ),
    );
  }
}
