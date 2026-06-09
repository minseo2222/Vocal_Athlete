/// 홈 오늘 히어로 — 오늘 한 레슨을 전면 카드로(라벨·제목·cue·칩·시작). 완료 시 초록·체크·비활성.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';

class TodayHero extends StatelessWidget {
  const TodayHero({super.key, required this.progression, required this.onStart});

  final Progression progression;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    final instance = resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance.card;
    final done = p.didToday;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: done
              ? const [Color(0xFF13251C), Color(0xFF101A15)]
              : const [Color(0xFF1B2030), AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: done ? AppColors.doneSurface : const Color(0xFF262B3B)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            done ? '오늘 완료' : '오늘의 레슨',
            key: done ? const Key('today-done') : null,
            style: TextStyle(
                color: done ? AppColors.done : AppColors.textLow,
                fontSize: 11,
                letterSpacing: 2),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              if (done) ...[
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.doneSurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.done, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text('✓',
                      style: TextStyle(color: AppColors.done, fontSize: 17)),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(card.anatomyMain,
                    style: const TextStyle(
                        color: AppColors.textHi,
                        fontSize: 26,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            done
                ? '오늘 레슨 끝 — 내일 또.'
                : (card.cue.isNotEmpty ? card.cue.first : ''),
            style: const TextStyle(color: AppColors.textMid, fontSize: 13),
          ),
          if (!done) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (instance.hasVoicedMicroWin)
                  _chip('● ${card.voicedMicroWin.first}', AppColors.done,
                      AppColors.doneSurface),
                if (instance.hasVoicedMicroWin) const SizedBox(width: 8),
                _chip('7–11분', AppColors.textMid, AppColors.surfaceAlt),
              ],
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: FilledButton(
              key: const Key('start-today'),
              onPressed: done ? null : onStart,
              style: FilledButton.styleFrom(
                  animationDuration: const Duration(milliseconds: 120)),
              child: Text(done ? '오늘 완료' : '오늘 시작 →',
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color fg, Color bg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
        child: Text(text,
            style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
      );
}
