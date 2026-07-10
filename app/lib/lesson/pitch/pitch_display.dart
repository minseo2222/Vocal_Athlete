/// U4 — Visual pitch display (stub-fed; A1 swaps in real F0).
///
/// Visual only (ADR-0014 honesty): target line + current-pitch indicator.
/// Unvoiced / low-confidence readings (`f0Hz == null`) leave no indicator.
/// R2: CARD-12 can use a session-relative target and delayed reveal.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'deviation.dart';
import 'pitch_source.dart';
import 'pitch_tolerance.dart';

const _kBufferLen = 24; // 스크롤 곡선용 trail(넛지는 windowN=5라 영향 없음)
const _kNudgeCue = <DeviationDirection, String>{
  DeviationDirection.sharp: '⤵ 좀 더 낮게 — 다시?',
  DeviationDirection.flat: '⤴ 좀 더 높게 — 다시?',
};

class PitchDisplay extends StatefulWidget {
  const PitchDisplay({
    super.key,
    this.source,
    this.targetHz,
    this.relativeTargetMode = false,
    this.deferredFeedback = false,
    this.toleranceIntervalSemitones,
    this.toleranceLevel,
    this.onRingSample,
  });

  final PitchSource? source;
  /// 카드별 절대 목표음(Hz). null이면 절대 타깃 없음.
  final double? targetHz;
  /// true면 초반 voiced F0 median을 오늘의 편한 상대 기준선으로 잡는다.
  final bool relativeTargetMode;
  /// true면 수행 중 그래프 노출을 줄이고 사용자가 시도 후 열어본다.
  final bool deferredFeedback;
  /// 카드가 훈련하는 음정 간격(반음). level과 함께 있을 때만 음정별 허용오차 적용.
  final int? toleranceIntervalSemitones;
  /// 숙련 단계. interval과 함께 있을 때만 음정별 허용오차 적용(없으면 기존 기본값).
  final ToleranceLevel? toleranceLevel;

  /// voiced 프레임의 상대 밴드 에너지(ringRaw)를 상위로 보고한다(세션 내 추세용).
  /// 실 마이크 소스만 ringRaw를 채우므로 stub/합성 소스에선 호출되지 않는다.
  final void Function(double ringRaw, double? f0Hz)? onRingSample;

  @override
  State<PitchDisplay> createState() => _PitchDisplayState();
}

class _PitchDisplayState extends State<PitchDisplay> {
  StreamSubscription<PitchReading>? _sub;
  final Queue<PitchReading> _recent = ListQueue<PitchReading>(_kBufferLen);
  PitchReading? _latest;
  bool _dismissed = false;
  bool _revealed = false;
  final List<double> _targetSeed = <double>[];
  double? _relativeTargetHz;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant PitchDisplay old) {
    super.didUpdateWidget(old);
    if (old.source != widget.source ||
        old.targetHz != widget.targetHz ||
        old.relativeTargetMode != widget.relativeTargetMode ||
        old.deferredFeedback != widget.deferredFeedback) {
      _sub?.cancel();
      _latest = null;
      _recent.clear();
      _targetSeed.clear();
      _relativeTargetHz = null;
      _dismissed = false;
      _revealed = false;
      _subscribe();
    }
  }

  void _subscribe() {
    final src = widget.source;
    if (src == null) return;
    _sub = src.readings.listen((r) {
      if (!mounted) return;
      // voiced 프레임의 상대 공명 raw를 상위로 보고(세션 내 추세 누적용).
      final ring = r.ringRaw;
      if (ring != null && r.f0Hz != null) {
        widget.onRingSample?.call(ring, r.f0Hz);
      }
      setState(() {
        _latest = r;
        if (_recent.length >= _kBufferLen) _recent.removeFirst();
        _recent.add(r);
        final hz = r.f0Hz;
        if (widget.relativeTargetMode &&
            widget.targetHz == null &&
            _relativeTargetHz == null &&
            hz != null) {
          _targetSeed.add(hz);
          if (_targetSeed.length >= 5) {
            final sorted = List<double>.from(_targetSeed)..sort();
            _relativeTargetHz = sorted[sorted.length ~/ 2];
          }
        }
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
    final target = widget.targetHz ?? _relativeTargetHz;
    if (widget.deferredFeedback && !_revealed) {
      return Container(
        key: const Key('pitch-display'),
        height: 110,
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              target == null
                  ? '먼저 편하게 소리내세요. 저신뢰 구간은 숨깁니다.'
                  : '기준선 준비됨 — 끝난 뒤 확인하세요.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Sun.inkMid, fontSize: 12),
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('reveal-pitch-feedback'),
              onPressed: () => setState(() => _revealed = true),
              child: const Text('곡선 보기'),
            ),
          ],
        ),
      );
    }
    // 넛지·타깃선은 목표음이 있을 때만(목표 없으면 편차 기준이 없음).
    final cls = target == null
        ? (nudge: false, direction: DeviationDirection.none)
        : classifyDeviation(
            _recent,
            targetHz: target,
            // 음정 간격·레벨이 모두 있을 때만 음정별 허용오차를 쓰고, 없으면 기본값.
            tolerance: (widget.toleranceIntervalSemitones != null &&
                    widget.toleranceLevel != null)
                ? (
                    intervalSemitones: widget.toleranceIntervalSemitones!,
                    level: widget.toleranceLevel!,
                  )
                : null,
          );
    final showNudge = cls.nudge && !_dismissed;
    return Container(
      key: const Key('pitch-display'),
      height: 110,
      decoration: BoxDecoration(
        color: Sun.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // 스크롤 곡선 — 최근 voiced 피치 trail(무성 구간 끊김). 점은 우측 끝(최신).
          if (_recent.where((r) => r.f0Hz != null).length >= 2)
            Positioned.fill(
              child: CustomPaint(
                key: const Key('pitch-curve'),
                painter: _CurvePainter([
                  for (final r in _recent)
                    r.f0Hz == null ? null : _yOffset(r.f0Hz!)
                ]),
              ),
            ),
          // Target line — 목표음이 있을 때만(없으면 220 같은 가짜 기준선 ❌).
          if (target != null)
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                key: Key('pitch-target'),
                height: 2,
                width: double.infinity,
                child: ColoredBox(color: Sun.coral),
              ),
            ),
          if (reading?.f0Hz != null)
            Align(
              alignment: Alignment(1, _yOffset(reading!.f0Hz!)), // 최신=우측 끝
              child: Container(
                key: const Key('pitch-current'),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Sun.coral,
                  shape: BoxShape.circle,
                  boxShadow: Sun.softShadow(color: Sun.coral, opacity: 0.5, blur: 8, dy: 0),
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
                          color: Sun.amber, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(width: 6),
                    Semantics(
                      button: true,
                      label: '닫기',
                      child: InkWell(
                        key: const Key('nudge-dismiss'),
                        onTap: () => setState(() => _dismissed = true),
                        child: const Padding(
                          // 탭 타깃 ≥48dp: 17*2 + 아이콘 14 = 48.
                          padding: EdgeInsets.all(17),
                          child: Icon(Icons.close,
                              size: 14, color: Sun.inkLow),
                        ),
                      ),
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
    final target = widget.targetHz ?? _relativeTargetHz;
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

/// 최근 피치 trail 폴리라인. ys: -1(상)..+1(하), null=무성(구간 끊김).
class _CurvePainter extends CustomPainter {
  _CurvePainter(this.ys);
  final List<double?> ys;

  @override
  void paint(Canvas canvas, Size size) {
    final n = ys.length;
    if (n < 2) return;
    final paint = Paint()
      ..color = Sun.coral.withValues(alpha: 0.85)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double x(int i) => size.width * i / (n - 1);
    double y(double v) => (v + 1) / 2 * size.height;
    for (var i = 1; i < n; i++) {
      final a = ys[i - 1], b = ys[i];
      if (a == null || b == null) continue; // 무성 구간 끊김
      canvas.drawLine(Offset(x(i - 1), y(a)), Offset(x(i), y(b)), paint);
    }
  }

  @override
  bool shouldRepaint(_CurvePainter old) => true;
}
