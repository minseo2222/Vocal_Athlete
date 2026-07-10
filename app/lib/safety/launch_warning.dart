/// F2 — 앱 실행 경고 화면 (ADR-0001/0008 · 유일한 안전 장치).
///
/// 앱 실행당 1회 1-탭 확인. 문진/입력/연령 게이트/계정 없음.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 캐노니컬 문구(CONTEXT.md `앱 실행 경고` · ADR-0001).
const List<String> kHardStopSigns = ['통증', '어지럼', '호흡곤란', '각혈'];
const String kAgeLine = '만 18세 이상·변성기 종료 대상';
const String kDisclaimer = '의료·진단 도구가 아닙니다';
const String kWarningSentence =
    '통증·어지럼·호흡곤란·각혈이 있으면 즉시 멈추고 의료기관을 방문하세요. '
    '본 앱은 만 18세 이상·변성기 종료 대상이며, 의료·진단 도구가 아닙니다.';

class LaunchWarning extends StatelessWidget {
  const LaunchWarning({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Sun.bg,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: Sun.bgWash),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                // 마이크가 위에서 내려오는 진입 애니메이션(장식 — 추가 탭/게이트 아님).
                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: -80, end: 0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, dy, child) =>
                        Transform.translate(offset: Offset(0, dy), child: child),
                    child: Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        gradient: Sun.gradient,
                        shape: BoxShape.circle,
                        boxShadow: Sun.softShadow(
                            color: Sun.coral, opacity: 0.34, blur: 30, dy: 14),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.mic_none_rounded,
                          key: Key('launch-mic'), color: Colors.white, size: 52),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Center(
                  child: Text('Vocal Athlete',
                      key: Key('launch-logo'),
                      style: TextStyle(
                          color: Sun.ink,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2)),
                ),
                const SizedBox(height: 6),
                const Center(
                  child: Text('매일 10–15분, 건강한 목소리 루틴',
                      style: TextStyle(color: Sun.inkMid, fontSize: 13)),
                ),
                const Spacer(flex: 2),
                // 안내 카드
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Sun.surface,
                    borderRadius: BorderRadius.circular(AppRadii.card),
                    boxShadow: Sun.softShadow(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                                color: Sun.amberSoft, shape: BoxShape.circle),
                            child: const Icon(Icons.favorite_rounded,
                                color: Sun.amber, size: 18),
                          ),
                          const SizedBox(width: 10),
                          const Text('시작 전 안내',
                              style: TextStyle(
                                  color: Sun.ink,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        kWarningSentence,
                        style: TextStyle(
                            color: Sun.inkMid, fontSize: 14.5, height: 1.7),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SunsetCta(label: '확인', onPressed: onConfirm, height: 56),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
