/// U4 — Visual pitch display (stub-fed; A1 swaps in real F0).
///
/// Visual only (ADR-0014 honesty): target line + current-pitch indicator.
/// Unvoiced / low-confidence readings (`f0Hz == null`) leave no indicator.
library;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import 'deviation.dart';
import 'pitch_source.dart';

const _kBufferLen = 8;
const _kNudgeCue = <DeviationDirection, String>{
  DeviationDirection.sharp: '⤵ 좀 더 낮게 — 다시?',
  DeviationDirection.flat: '⤴ 좀 더 높게 — 다시?',
};

class PitchDisplay extends StatefulWidget {
  const PitchDisplay({super.key, this.source, this.targetHz = 220.0});

  final PitchSource? source;
  final double targetHz;

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
    final cls =
        classifyDeviation(_recent, targetHz: widget.targetHz);
    final showNudge = cls.nudge && !_dismissed;
    return Container(
      key: const Key('pitch-display'),
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFF0E0F13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Target line — horizontal mid.
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              key: Key('pitch-target'),
              height: 2,
              width: double.infinity,
              child: ColoredBox(color: Color(0xFF6C8CFF)),
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
                  color: Color(0xFF39D98A),
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
                          color: Color(0xFFFFD166), fontSize: 12),
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

  /// −1 (top) ↔ +1 (bottom). Sharp = above target = upward = negative Y.
  double _yOffset(double hz) {
    final cents = centsFromTarget(hz, widget.targetHz);
    return (-cents / 50.0).clamp(-1.0, 1.0);
  }
}
