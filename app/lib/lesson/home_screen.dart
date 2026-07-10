/// 홈 화면 — 오늘 정규 레슨 + 선택 복습 진입점.
///
/// 복습은 정규 진도·streak와 분리된다. due task가 있을 때만 짧은 카드로
/// 노출하고, 건너뛰어도 불이익이 없음을 명시한다.
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
    this.dueReviewCount = 0,
    this.onOpenReviews,
  });

  final Progression progression;
  final VoidCallback onStart;
  final VoidCallback? onSettings;
  final int dueReviewCount;
  final VoidCallback? onOpenReviews;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    return Scaffold(
      backgroundColor: Sun.bg,
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: Sun.bgWash),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.streak > 0 ? '🔥 ${p.streak}일' : '오늘 첫 훈련을 시작해요',
                        key: const Key('home-streak'),
                        style: const TextStyle(
                          color: Sun.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFeatures: Sun.tnum,
                          letterSpacing: 0.2,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Sun.surface,
                            shape: BoxShape.circle,
                            border: Border.all(color: Sun.hairline)),
                        child: IconButton(
                          key: const Key('home-settings'),
                          tooltip: '설정',
                          onPressed: onSettings,
                          icon: const Icon(Icons.settings_rounded,
                              color: Sun.inkMid, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Entrance(child: TodayHero(progression: p, onStart: onStart)),
                  if (dueReviewCount > 0 && onOpenReviews != null) ...[
                    const SizedBox(height: 12),
                    Entrance(
                      delay: 0.12,
                      child: _TodayReviewCard(
                        count: dueReviewCount,
                        onOpen: onOpenReviews!,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Entrance(
                    delay: 0.22,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '여정',
                          style: TextStyle(
                            color: Sun.inkMid,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                        Text(
                          '${p.currentIndex + 1} / ${p.total} · 졸업까지 ${p.total - p.currentIndex - 1}',
                          style: const TextStyle(
                            color: Sun.inkLow,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            fontFeatures: Sun.tnum,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                  const SizedBox(height: 12),
                  Entrance(delay: 0.3, child: JourneyPreview(progression: p)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodayReviewCard extends StatelessWidget {
  const _TodayReviewCard({required this.count, required this.onOpen});

  final int count;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('today-review-card'),
        padding: const EdgeInsets.all(14),
        decoration: Sun.card(),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Sun.surfaceSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Sun.hairline),
              ),
              child: const Icon(Icons.replay_rounded, color: Sun.coral, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '오늘의 선택 복습 $count개',
                    key: const Key('today-review-count'),
                    style: const TextStyle(
                      color: Sun.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    '3–5분 · 건너뛰어도 진도와 streak에 영향 없음',
                    style: TextStyle(
                      color: Sun.inkLow,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              key: const Key('today-review-open'),
              onPressed: onOpen,
              style: TextButton.styleFrom(foregroundColor: Sun.pink),
              child: const Text('복습 보기',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}
