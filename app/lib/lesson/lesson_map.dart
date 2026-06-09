/// 홈 여정 맵 — 슬롯을 블록 섹션으로 묶어 세로 winding 경로로. 탭 불가(여정 시각화).
/// 완료=초록 ✓ / 오늘=파랑 ▶ / 미래=잠금 🔒. 상태는 currentIndex 기준.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class LessonMap extends StatelessWidget {
  const LessonMap(
      {super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  /// 초급 경로 블록 라벨(1..5). 분기 코스 등 그 외 블록은 '블록 N' 폴백.
  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _label(int block) => (block >= 1 && block <= _blockLabels.length)
      ? _blockLabels[block - 1]
      : '블록 $block';

  /// winding 경로 레인: 블록 내 위치를 좌→중→우→중(0,1,2,1) 삼각파로.
  int _lane(int posInBlock) {
    final m = posInBlock % 4;
    return m == 3 ? 1 : m;
  }

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            for (final i in blocks[b]!)
              _NodeRow(
                lane: _lane(i - blocks[b]!.first),
                state: i < today
                    ? _NodeState.done
                    : i == today
                        ? _NodeState.today
                        : _NodeState.future,
              ),
          ],
        ],
      ),
    );
  }
}

enum _NodeState { done, today, future }

/// 한 노드를 winding 레인(0=좌·1=중·2=우)에 배치하는 행.
class _NodeRow extends StatelessWidget {
  const _NodeRow({required this.state, required this.lane});
  final _NodeState state;
  final int lane;

  @override
  Widget build(BuildContext context) {
    final align = switch (lane) {
      0 => Alignment.centerLeft,
      2 => Alignment.centerRight,
      _ => Alignment.center,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Align(alignment: align, child: _Node(state: state)),
    );
  }
}

class _Node extends StatelessWidget {
  const _Node({required this.state});
  final _NodeState state;

  static const double _kTodayScaleIn = 0.85;

  @override
  Widget build(BuildContext context) {
    final ({Color bg, Color border, String glyph, Color glyphColor, Key key})
        v = switch (state) {
      _NodeState.done => (
          bg: AppColors.doneSurface,
          border: AppColors.done,
          glyph: '✓',
          glyphColor: AppColors.done,
          key: const Key('node-done'),
        ),
      _NodeState.today => (
          bg: AppColors.now,
          border: AppColors.now,
          glyph: '▶',
          glyphColor: Colors.white,
          key: const Key('node-today'),
        ),
      _NodeState.future => (
          bg: AppColors.surface,
          border: AppColors.lockedSurface,
          glyph: '🔒',
          glyphColor: AppColors.textLow,
          key: const Key('node-future'),
        ),
    };
    final node = Container(
      key: v.key,
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: v.bg,
        shape: BoxShape.circle,
        border: Border.all(color: v.border, width: 2),
        boxShadow: state == _NodeState.today
            ? [
                BoxShadow(
                    color: AppColors.now.withValues(alpha: 0.35),
                    blurRadius: 10,
                    spreadRadius: 2)
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(v.glyph, style: TextStyle(color: v.glyphColor, fontSize: 18)),
    );
    if (state != _NodeState.today) return node;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: _kTodayScaleIn, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
      child: node,
    );
  }
}
