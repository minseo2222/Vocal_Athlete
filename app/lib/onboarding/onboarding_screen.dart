/// 최초 1회 온보딩 — "이 앱이 뭐고, 왜, 어떻게"를 한 화면으로 친절히 소개.
///
/// 안전 경고(LaunchWarning) 다음, 홈 진입 전에 1회만 노출된다. 본 적이 있으면
/// 다시 뜨지 않는다(메타데이터 플래그). 위젯 테스트는 startWithOnboarding=false라
/// 이 화면을 건너뛴다.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key = const Key('onboarding-screen'),
    required this.onDone,
  });

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Sun.bg,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: Sun.bgWash),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                Entrance(
                  child: Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        gradient: Sun.gradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.mic_rounded,
                          color: Sun.onAccent, size: 44),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Entrance(
                  delay: 0.1,
                  child: const Text(
                    'Vocal Athlete에\n오신 걸 환영해요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Sun.ink,
                      fontSize: 26,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Entrance(
                  delay: 0.16,
                  child: const Text(
                    '매일 7~11분, 목에 무리 없이\n소리를 키우는 기초 훈련이에요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Sun.inkMid, fontSize: 14, height: 1.4),
                  ),
                ),
                const Spacer(flex: 1),
                Entrance(
                  delay: 0.24,
                  child: const _Point(
                    icon: Icons.graphic_eq_rounded,
                    text: '마이크로 내 목소리를 녹음해 변화를 직접 들어봐요.',
                  ),
                ),
                const SizedBox(height: 14),
                Entrance(
                  delay: 0.3,
                  child: const _Point(
                    icon: Icons.trending_up_rounded,
                    text: "점수가 아니라 '오늘보다 나아짐'을 차곡차곡 쌓아요.",
                  ),
                ),
                const SizedBox(height: 14),
                Entrance(
                  delay: 0.36,
                  child: const _Point(
                    icon: Icons.nightlight_round,
                    text: '컨디션이 안 좋은 날은 강도를 자동으로 낮춰드려요.',
                  ),
                ),
                const Spacer(flex: 2),
                Entrance(
                  delay: 0.44,
                  child: SunsetCta(
                    buttonKey: const Key('onboarding-done'),
                    label: '시작하기',
                    onPressed: onDone,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Sun.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Sun.hairline),
            ),
            child: Icon(icon, color: Sun.coral, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: Sun.ink, fontSize: 13.5, height: 1.35),
            ),
          ),
        ],
      );
}
