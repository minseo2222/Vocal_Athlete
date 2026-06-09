/// 홈 화면 — 매일 진입점(R4). 오늘 히어로 + 여정 미리보기. 탭바 없음.
///
/// ADR-0002 무납득: 설명·동기 카피 없음. ADR-0015: 사용자는 오늘 레슨을 고르지 않음.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_map.dart';
import 'today_hero.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key = const Key('home-screen'),
    required this.progression,
    required this.onStart,
    this.onSettings,
  });

  final Progression progression;
  final VoidCallback onStart;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 헤더 — 스트릭 / 설정
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('🔥 ${p.streak}일',
                        key: const Key('home-streak'),
                        style: const TextStyle(
                            color: AppColors.streak,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    IconButton(
                      key: const Key('home-settings'),
                      onPressed: onSettings,
                      icon: const Icon(Icons.settings, color: AppColors.textLow),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TodayHero(progression: p, onStart: onStart),
                const SizedBox(height: 22),
                // 여정 라벨
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('여정',
                          style: TextStyle(
                              color: AppColors.textMid,
                              fontSize: 11,
                              letterSpacing: 1)),
                      Text(
                          '${p.currentIndex + 1} / ${p.total} · 졸업까지 ${p.total - p.currentIndex - 1}',
                          style: const TextStyle(
                              color: AppColors.textMid, fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                JourneyPreview(progression: p),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
