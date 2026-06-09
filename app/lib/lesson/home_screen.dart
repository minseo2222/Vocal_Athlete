/// 홈 화면 — 매일 진입점. 오늘 레슨 프리뷰 + 스트릭 + 5블록 진행도 + 시작.
///
/// ADR-0002 무납득: 설명·동기 카피 없음. 카드 *지시* 한 줄만 프리뷰.
/// 사용자는 오늘 레슨을 고르지 않음(ADR-0015) — 시작 버튼 하나.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';
import 'lesson_map.dart';

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
    final instance = resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance.card;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 헤더 — 스트릭 + 설정
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('🔥 ${p.streak}일',
                      key: const Key('home-streak'),
                      style: const TextStyle(
                          color: AppColors.textHi, fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  IconButton(
                    key: const Key('home-settings'),
                    onPressed: onSettings,
                    icon: const Icon(Icons.settings, color: AppColors.textLow),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 오늘 레슨 프리뷰 카드
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('오늘의 레슨',
                        style: TextStyle(
                            color: AppColors.textMid, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text(card.anatomyMain,
                        style: const TextStyle(
                            color: AppColors.textHi, fontSize: 22,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(card.cue.isNotEmpty ? card.cue.first : '',
                        style: const TextStyle(
                            color: AppColors.textMid, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 여정 맵
              Expanded(child: LessonMap(progression: p)),
              const SizedBox(height: 12),
              if (p.didToday)
                const Padding(
                  key: Key('today-done'),
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text('오늘 완료 — 내일 또',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.done, fontSize: 14)),
                ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  key: const Key('start-today'),
                  onPressed: p.didToday ? null : onStart,
                  style: FilledButton.styleFrom(
                      animationDuration: const Duration(milliseconds: 120)),
                  child: Text(p.didToday ? '오늘 완료' : '오늘 시작',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
