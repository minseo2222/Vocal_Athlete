/// 홈 여정 미리보기 — 오늘 ±2 노드 윈도우(완료/오늘/미래) + 5블록 칩. 탭 불가(시각화).
/// 풀 경로 조망은 블록 칩(macro), 지역 맥락은 노드 윈도우(micro)로 분담.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class JourneyPreview extends StatelessWidget {
  const JourneyPreview(
      {super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _blockLabel(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  /// 오늘 중심 최대 5개 슬롯 인덱스 윈도우.
  List<int> _window(int today, int total) {
    if (total <= 0) return const [];
    var start = today - 2;
    if (start < 0) start = 0;
    var end = start + 5;
    if (end > total) {
      end = total;
      start = end - 5 < 0 ? 0 : end - 5;
    }
    return [for (var i = start; i < end; i++) i];
  }

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    final total = slots.length;
    final window = _window(today, total);

    final blocks = <int, List<int>>{};
    for (var i = 0; i < total; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 100,
          decoration: Sun.card(),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final i in window)
                _Node(
                  state: i < today
                      ? _NodeState.done
                      : i == today
                          ? _NodeState.today
                          : _NodeState.future,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var k = 0; k < orderedBlocks.length; k++) ...[
              if (k > 0) const SizedBox(width: 6),
              Expanded(
                child: _BlockChip(
                  label: _blockLabel(orderedBlocks[k]),
                  state: _blockStateOf(blocks[orderedBlocks[k]]!, today),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  _NodeState _blockStateOf(List<int> indices, int today) {
    if (indices.every((i) => i < today)) return _NodeState.done;
    if (indices.contains(today)) return _NodeState.today;
    return _NodeState.future;
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state});
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final today = state == _NodeState.today;
    final ({Color bg, Color border, Color glyphColor, Key key, double size})
        v = switch (state) {
      _NodeState.done => (
          bg: Sun.mintSoft, border: Sun.mint,
          glyphColor: Sun.mint, key: const Key('node-done'), size: 36),
      _NodeState.today => (
          bg: Sun.coral, border: Colors.white,
          glyphColor: Colors.white, key: const Key('node-today'), size: 50),
      _NodeState.future => (
          bg: Sun.lockBg, border: Sun.lockBg,
          glyphColor: Sun.lockInk, key: const Key('node-future'), size: 36),
    };
    final icon = switch (state) {
      _NodeState.done => Icons.check_rounded,
      _NodeState.today => Icons.play_arrow_rounded,
      _NodeState.future => Icons.lock_rounded,
    };
    return Container(
      key: v.key,
      width: v.size,
      height: v.size,
      decoration: BoxDecoration(
        color: today ? null : v.bg,
        gradient: today ? Sun.gradient : null,
        shape: BoxShape.circle,
        border: Border.all(color: v.border, width: today ? 3 : 2),
        boxShadow: today
            ? Sun.softShadow(color: Sun.coral, opacity: 0.45, blur: 14, dy: 4)
            : null,
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: v.glyphColor, size: today ? 26 : 18),
    );
  }
}

class _BlockChip extends StatelessWidget {
  const _BlockChip({required this.label, required this.state});
  final String label;
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, suffix) = switch (state) {
      _NodeState.done => (Sun.mintSoft, Sun.mint, ' ✓'),
      _NodeState.today => (Sun.surfaceSoft, Sun.coral, ''),
      _NodeState.future => (Sun.lockBg, Sun.lockInk, ''),
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: state == _NodeState.today
            ? Border.all(color: Sun.coral.withValues(alpha: 0.4))
            : null,
      ),
      alignment: Alignment.center,
      child: Text('$label$suffix',
          style: TextStyle(color: fg, fontSize: 10.5, fontWeight: FontWeight.w700)),
    );
  }
}
