/// 앱 공통 색·라운드 토큰. 화면 전역 하드코딩 색을 1곳으로.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 모션 토큰 — 모든 애니메이션은 유한·짧게(<300ms 권장, 진입만 더 길게).
class Motion {
  const Motion._();
  static const fast = Duration(milliseconds: 140);
  static const press = Duration(milliseconds: 90);
  static const enter = Duration(milliseconds: 520);
  static const ring = Duration(milliseconds: 800);
  static const curve = Curves.easeOutCubic;

  /// 접근성: 시스템 "모션 줄이기"가 켜지면 진입 애니메이션을 생략한다.
  static bool reduced(BuildContext context) =>
      MediaQuery.maybeOf(context)?.disableAnimations ?? false;
}

/// 스태거드 진입 — 페이드 + 살짝 위로. delay(0~1)로 순차 등장. 1-shot(테스트 안전).
class Entrance extends StatelessWidget {
  const Entrance({
    super.key,
    required this.child,
    this.delay = 0.0,
    this.dy = 16,
  });

  final Widget child;
  final double delay;
  final double dy;

  @override
  Widget build(BuildContext context) {
    if (Motion.reduced(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Motion.enter,
      curve: Interval(delay.clamp(0.0, 0.9), 1.0, curve: Motion.curve),
      builder: (context, t, c) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        child: Transform.translate(offset: Offset(0, (1 - t) * dy), child: c),
      ),
      child: child,
    );
  }
}

/// 파괴적 동작(영구 삭제·초기화) 확인 다이얼로그. 확인 시 true.
/// 위험을 명확히 알리기 위해 확인 버튼은 머트 레드(Sun.danger)로 강조한다.
Future<bool> confirmDestructive(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = '삭제',
  String cancelLabel = '취소',
  Key? confirmKey,
  Key? cancelKey,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Sun.elevated,
      title: Text(title, style: const TextStyle(color: Sun.ink, fontSize: 17)),
      content: Text(message,
          style: const TextStyle(color: Sun.inkMid, fontSize: 14, height: 1.45)),
      actions: [
        TextButton(
          key: cancelKey,
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel, style: const TextStyle(color: Sun.inkMid)),
        ),
        FilledButton(
          key: confirmKey,
          style: FilledButton.styleFrom(
            backgroundColor: Sun.danger,
            foregroundColor: Sun.ink,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

class AppRadii {
  const AppRadii._();
  static const sheet = 22.0;
  static const pill = 999.0;
  static const card = 24.0;
}

/// 차콜 다크 + 절제된 단일 액센트(머트 골드) 디자인 시스템.
/// 리디자인된 화면(진입/홈/레슨)이 사용. 토큰 값만 바꾸면 전 화면이 함께 바뀐다.
/// 토큰 이름은 호환을 위해 유지(coral/orange/pink/mint/amber)하되 값은 절제된 톤.
class Sun {
  const Sun._();

  // 다크-퍼스트 명도 ramp(그림자 대신 명도로 입체감, 단계마다 ~6% 상승).
  static const bg = Color(0xFF0F1012);          // L0 base(가장 어두움)
  static const bgTop = Color(0xFF121316);
  static const bgBottom = Color(0xFF0C0D0F);
  static const surface = Color(0xFF181A1E);     // L1 카드
  static const elevated = Color(0xFF202329);    // L2 중첩/활성
  static const surfaceSoft = Color(0xFF22252B);  // 칩/필(L2)
  static const surfacePink = Color(0xFF1E2026);  // 보조 카드 틴트

  // 하이라이트 보더(상단 lit edge) — 다크에서 그림자 대신 입체감.
  static const hairline = Color(0x12FFFFFF);     // white ~7%
  static const hairlineStrong = Color(0x1FFFFFFF); // white ~12%

  // 텍스트(어두운 배경 위)
  static const ink = Color(0xFFECEAE4);   // 강조(따뜻한 오프화이트)
  static const inkMid = Color(0xFF9A978E); // 보조
  static const inkLow = Color(0xFF64625C); // 흐림

  // 단일 액센트 = 연한 샴페인 골드. coral/orange/pink/amber 모두 골드 계열로 통일.
  static const coral = Color(0xFFD9BE86);  // 주 액센트
  static const orange = Color(0xFFD9BE86);
  static const pink = Color(0xFFD9BE86);
  static const peach = Color(0xFFC8AE7C);
  static const onAccent = Color(0xFF17181C); // 골드 위 텍스트(짙은 차콜)
  static const coralOverlay = Color(0x33D9BE86); // 액센트 ~20% halo(슬라이더 overlay 등)

  // 시맨틱(완료=절제된 세이지, 경고/스트릭=골드)
  static const mint = Color(0xFF8FA98D);      // 완료(머트 세이지)
  static const mintSoft = Color(0xFF222923);   // 완료 칩 배경(다크)
  static const amber = Color(0xFFD9BE86);      // 스트릭/경고(골드)
  static const amberSoft = Color(0xFF2A2620);  // 골드 칩 배경(다크)
  static const lockBg = Color(0xFF23242A);
  static const lockInk = Color(0xFF54535A);
  static const line = Color(0xFF2D2E34);       // 약한 경계선
  static const danger = Color(0xFFB35A4E);     // 파괴적 동작(절제된 머트 레드)

  // 골드 토널 그라데이션(저대비·절제, 연한 샴페인)
  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE6CF9C), Color(0xFFCFB06F)],
  );
  static const gradientSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF24252B), Color(0xFF1C1D22)],
  );
  static const bgWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgTop, bg, bgBottom],
  );

  // 다크-퍼스트: 그림자는 거의 안 쓴다(다크에선 무의미·싸구려). 호출부 호환을 위해
  // 시그니처는 유지하되, 색 틴트를 무시하고 아주 은은한 깊이감만 준다.
  static List<BoxShadow> softShadow({
    Color color = const Color(0xFF000000),
    double opacity = 0.35,
    double blur = 26,
    double dy = 12,
  }) =>
      const [
        BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(0, 8)),
      ];

  /// 카드 입체감 = 명도 단계 + 1px 상단 하이라이트 보더(그림자 X).
  static BoxDecoration card({
    Color color = surface,
    double radius = AppRadii.card,
    bool focal = false, // 화면당 단 하나의 강조 요소
  }) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
            color: focal ? coral.withValues(alpha: 0.35) : hairline, width: 1),
        boxShadow: focal
            ? [BoxShadow(color: coral.withValues(alpha: 0.10), blurRadius: 24, spreadRadius: -4)]
            : null,
      );

  /// 고정폭 숫자(tabular figures) — 숫자를 디자인 요소로.
  static const List<FontFeature> tnum = [FontFeature.tabularFigures()];
}

/// 시그니처 모티프 — 진행 링(Oura/Whoop 결). 골드 아크로 진행도(0~1)를 표시하고
/// 가운데에 큰 숫자(label)와 작은 보조 텍스트(sub)를 둔다.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.label,
    this.sub,
    this.size = 88,
    this.stroke = 7,
    this.color = Sun.coral,
  });

  final double progress; // 0~1
  final String? label;
  final String? sub;
  final double size;
  final double stroke;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final target = progress.clamp(0.0, 1.0);
    final begin = Motion.reduced(context) ? target : 0.0;
    return SizedBox(
        width: size,
        height: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: begin, end: target),
          duration: Motion.ring,
          curve: Motion.curve,
          builder: (context, value, child) => CustomPaint(
            painter: _RingPainter(progress: value, stroke: stroke, color: color),
            child: child,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null)
                  Text(label!,
                      style: TextStyle(
                          color: Sun.ink,
                          fontSize: size * 0.30,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          fontFeatures: Sun.tnum)),
                if (sub != null)
                  Text(sub!,
                      style: TextStyle(
                          color: Sun.inkLow,
                          fontSize: size * 0.13,
                          fontWeight: FontWeight.w600,
                          fontFeatures: Sun.tnum)),
              ],
            ),
          ),
        ),
      );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.stroke, required this.color});
  final double progress;
  final double stroke;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = (size.shortestSide - stroke) / 2;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color.withValues(alpha: 0.18);
    canvas.drawCircle(c, r, track);
    // 12시 시작 닻(진행 0이어도 링이 살아 있게).
    final start = Offset(c.dx, c.dy - r);
    canvas.drawCircle(
        start, stroke * 0.62, Paint()..color = const Color(0xFFE6CF9C));
    if (progress > 0) {
      final arc = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          startAngle: -1.5708,
          endAngle: 4.7124,
          colors: const [Color(0xFFCFB06F), Color(0xFFE6CF9C)],
          transform: const GradientRotation(-1.5708),
        ).createShader(Rect.fromCircle(center: c, radius: r));
      canvas.drawArc(Rect.fromCircle(center: c, radius: r), -1.5708,
          6.2832 * progress, false, arc);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}

/// 시그니처 모티프 — 보컬/사운드 웨이브폼. 진행도(0~1)에 따라 골드로 채워지고
/// 나머지는 뉴트럴. 정적이지만 제품 정체성을 준다(앱 전역 재사용).
class VoiceWave extends StatelessWidget {
  const VoiceWave({
    super.key,
    this.height = 38,
    this.progress = 1.0,
    this.active = Sun.coral,
    this.idle = Sun.lockInk,
    this.barWidth = 3.0,
    this.gap = 4.0,
  });

  final double height;
  final double progress; // 0~1, 골드로 채워지는 비율
  final Color active;
  final Color idle;
  final double barWidth;
  final double gap;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _WavePainter(progress: progress, active: active, idle: idle, barWidth: barWidth, gap: gap),
        ),
      );
}

class _WavePainter extends CustomPainter {
  _WavePainter({required this.progress, required this.active, required this.idle, required this.barWidth, required this.gap});
  final double progress;
  final Color active;
  final Color idle;
  final double barWidth;
  final double gap;

  // 자연스러운 음성 파형 느낌의 고정 envelope(0~1).
  static const _env = <double>[
    0.22, 0.4, 0.32, 0.62, 0.5, 0.78, 0.58, 0.9, 0.7, 1.0, 0.82, 0.66,
    0.92, 0.74, 0.86, 0.6, 0.72, 0.48, 0.64, 0.42, 0.56, 0.34, 0.46, 0.28,
    0.38, 0.24, 0.3, 0.2,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final step = barWidth + gap;
    final count = (size.width / step).floor().clamp(1, _env.length);
    final totalW = count * step - gap;
    var x = (size.width - totalW) / 2;
    final cy = size.height / 2;
    final filled = (count * progress).round();
    for (var i = 0; i < count; i++) {
      final h = (_env[i % _env.length]) * size.height;
      final paint = Paint()
        ..color = i < filled ? active : idle.withValues(alpha: 0.28)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = barWidth;
      canvas.drawLine(Offset(x + barWidth / 2, cy - h / 2),
          Offset(x + barWidth / 2, cy + h / 2), paint);
      x += step;
    }
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.progress != progress || old.active != active || old.idle != idle;
}

/// 레슨 완료 축하 — 절제된 1-shot 링 펄스 + 체크 + 라벨. 끝나면 onDone 호출.
/// 무한 루프 없이 단일 TweenAnimationBuilder로만 구성(테스트 안전). "모션 줄이기"가
/// 켜지면 즉시 최종 상태로 건너뛴다.
class LessonCelebration extends StatelessWidget {
  const LessonCelebration({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final reduced = Motion.reduced(context);
    return Scaffold(
      backgroundColor: Sun.bg,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: Sun.bgWash),
        child: Center(
          child: TweenAnimationBuilder<double>(
            key: const Key('lesson-celebration'),
            tween: Tween(begin: reduced ? 1.0 : 0.0, end: 1.0),
            duration: reduced ? Duration.zero : const Duration(milliseconds: 1150),
            curve: Curves.easeOutCubic,
            onEnd: onDone,
            builder: (context, t, _) {
              final ringT = (t / 0.7).clamp(0.0, 1.0);
              final checkT = ((t - 0.5) / 0.5).clamp(0.0, 1.0);
              final textT = ((t - 0.65) / 0.35).clamp(0.0, 1.0);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 132,
                    height: 132,
                    child: CustomPaint(
                      painter: _RingPainter(
                          progress: ringT, stroke: 9, color: Sun.coral),
                      child: Center(
                        child: Opacity(
                          opacity: checkT,
                          child: Transform.scale(
                            scale: 0.6 + 0.4 * checkT,
                            child: const Icon(Icons.check_rounded,
                                color: Sun.coral, size: 52),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Opacity(
                    opacity: textT,
                    child: Transform.translate(
                      offset: Offset(0, (1 - textT) * 8),
                      child: const Column(
                        children: [
                          Text('오늘 완료',
                              style: TextStyle(
                                  color: Sun.ink,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.3)),
                          SizedBox(height: 6),
                          Text('기록을 저장했어요',
                              style: TextStyle(
                                  color: Sun.inkMid,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 정적 스켈레톤 로딩. 무한 shimmer는 테스트(pumpAndSettle)를 막으므로 쓰지 않고,
/// 명도 placeholder 박스만 1회 페이드인(Entrance)으로 보여준다. 로딩 자리표시용.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.rows = 4, this.shrinkWrap = false});

  final int rows;

  /// 부모가 이미 스크롤(ListView 등)일 때 true — 자체 스크롤을 끄고 내용 높이만 차지.
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) => Entrance(
        child: ListView.builder(
          key: const Key('skeleton-list'),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          shrinkWrap: shrinkWrap,
          physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          itemCount: rows,
          itemBuilder: (_, _) => const _SkeletonCard(),
        ),
      );
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: Sun.card(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SkeletonBar(widthFactor: 0.55, height: 14),
            SizedBox(height: 12),
            _SkeletonBar(widthFactor: 0.9, height: 10),
            SizedBox(height: 8),
            _SkeletonBar(widthFactor: 0.45, height: 10),
          ],
        ),
      );
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({required this.widthFactor, required this.height});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: widthFactor,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Sun.surfaceSoft,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      );
}

/// 선셋 그라데이션 CTA. 위젯 테스트가 키/타입(FilledButton)·텍스트를 직접
/// 검사하므로 key는 FilledButton에 그대로 두고, 내부 Ink로 그라데이션을 칠한다.
/// disabled=true면 onPressed=null + 잠금 색(테스트의 onPressed==null 검증 호환).
class SunsetCta extends StatefulWidget {
  const SunsetCta({
    super.key,
    this.buttonKey,
    required this.label,
    this.onPressed,
    this.disabled = false,
    this.height = 54,
    this.fontSize = 16,
  });

  /// 위젯 테스트가 `find.byKey(...)`로 찾는 FilledButton에 직접 다는 key.
  final Key? buttonKey;
  final String label;
  final VoidCallback? onPressed;
  final bool disabled;
  final double height;
  final double fontSize;

  @override
  State<SunsetCta> createState() => _SunsetCtaState();
}

class _SunsetCtaState extends State<SunsetCta> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final off = widget.disabled || widget.onPressed == null;
    void set(bool v) {
      if (!off && _down != v) setState(() => _down = v);
    }

    return Listener(
      onPointerDown: (_) => set(true),
      onPointerUp: (_) => set(false),
      onPointerCancel: (_) => set(false),
      child: AnimatedScale(
        scale: _down ? 0.975 : 1.0,
        duration: Motion.press,
        curve: Curves.easeOut,
        child: FilledButton(
          key: widget.buttonKey,
          onPressed: off
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  widget.onPressed!();
                },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const StadiumBorder(),
            animationDuration: Motion.fast,
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: off ? null : Sun.gradient,
              color: off ? Sun.lockBg : null,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              boxShadow: off
                  ? null
                  : Sun.softShadow(
                      color: Sun.pink, opacity: 0.30, blur: 18, dy: 8),
            ),
            child: Container(
              height: widget.height,
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w800,
                  color: off ? Sun.inkLow : Sun.onAccent,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
