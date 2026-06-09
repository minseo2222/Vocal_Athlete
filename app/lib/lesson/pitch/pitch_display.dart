/// U4 — Visual pitch display (stub-fed; A1 swaps in real F0).
///
/// Visual only (ADR-0014 honesty): target line + current-pitch indicator.
/// Unvoiced / low-confidence readings (`f0Hz == null`) leave no indicator.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'deviation.dart';
import 'pitch_source.dart';

const _kBufferLen = 8;
const _kNudgeCue = <DeviationDirection, String>{
  DeviationDirection.sharp: '⤵ 좀 더 낮게 — 다시?',
  DeviationDirection.flat: '⤴ 좀 더 높게 — 다시?',
};

class PitchDisplay extends StatefulWidget {
  const PitchDisplay({super.key, this.source, this.targetHz});

  final PitchSource? source;
  /// 카드별 목표음(Hz). null이면 타깃선·넛지 미표시(점은 절대피치로 표시).
  final double? targetHz;

  @override
  State<PitchDisplay> createState() => _PitchDisplayState();
}

class _PitchDisplayState extends State<PitchDisplay> {
  StreamSubscription<PitchReading>? _sub;
  final Queue<PitchReading> _recent = ListQueue<PitchReading>(_kBufferLen);
  PitchReading? _latest;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant PitchDisplay old) {
    super.didUpdateWidget(old);
    if (old.source != widget.source) {
      _sub?.cancel();
      _latest = null;
      _recent.clear();
      _dismissed = false;
      _subscribe();
    }
  }

  void _subscribe() {
    final src = widget.source;
    if (src == null) return;
    _sub = src.readings.listen((r) {
      if (!mounted) return;
      setState(() {
        _latest = r;
        if (_recent.length >= _kBufferLen) _recent.removeFirst();
        _recent.add(r);
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reading = _latest;
    final target = widget.targetHz;
    // 넛지·타깃선은 목표음이 있을 때만(목표 없으면 편차 기준이 없음).
    final cls = target == null
        ? (nudge: false, direction: DeviationDirection.none)
        : classifyDeviation(_recent, targetHz: target);
    final showNudge = cls.nudge && !_dismissed;
    return Container(
      key: const Key('pitch-display'),
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Target line — 목표음이 있을 때만(없으면 220 같은 가짜 기준선 ❌).
          if (target != null)
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                key: Key('pitch-target'),
                height: 2,
                width: double.infinity,
                child: ColoredBox(color: AppColors.now),
              ),
            ),
          if (reading?.f0Hz != null)
            Align(
              alignment: Alignment(0, _yOffset(reading!.f0Hz!)),
              child: Container(
                key: const Key('pitch-current'),
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppColors.done,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (showNudge)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _kNudgeCue[cls.direction] ?? '',
                      key: const Key('retry-nudge'),
                      style: const TextStyle(
                          color: AppColors.warn, fontSize: 12),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      key: const Key('nudge-dismiss'),
                      onTap: () => setState(() => _dismissed = true),
                      child: const Icon(Icons.close,
                          size: 14, color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// −1 (top) ↔ +1 (bottom). 목표 있으면 편차(cents) 기준, 없으면 절대피치(로그) 기준.
  double _yOffset(double hz) {
    final target = widget.targetHz;
    if (target != null) {
      // Sharp = above target = upward = negative Y.
      final cents = centsFromTarget(hz, target);
      return (-cents / 50.0).clamp(-1.0, 1.0);
    }
    // 목표 없음: 80–800Hz 로그 매핑(저음=아래, 고음=위).
    const lo = 80.0, hi = 800.0;
    final frac = (math.log(hz / lo) / math.log(hi / lo)).clamp(0.0, 1.0);
    return (1 - 2 * frac);
  }
}
