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
    final progress = p.total > 0 ? (p.currentIndex + (done ? 1 : 0)) / p.total : 0.0;
    return Container(
      decoration: Sun.card(focal: !done),
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 시그니처 — 진행 링(여정 진행도) + 제목
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      done ? '오늘 완료' : '오늘의 레슨',
                      key: done ? const Key('today-done') : null,
                      style: TextStyle(
                          color: done ? Sun.mint : Sun.inkMid,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.5),
                    ),
                    const SizedBox(height: 12),
                    Text(card.anatomyMain,
                        style: const TextStyle(
                            color: Sun.ink,
                            fontSize: 24,
                            height: 1.18,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              ProgressRing(
                progress: progress.toDouble(),
                size: 76,
                stroke: 7,
                label: '${p.currentIndex + 1}',
                sub: '/ ${p.total}',
                color: done ? Sun.mint : Sun.coral,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            done
                ? '오늘 레슨 끝 — 내일 또.'
                : (card.cue.isNotEmpty ? card.cue.first : ''),
            style: const TextStyle(color: Sun.inkMid, fontSize: 14, height: 1.4),
          ),
          if (!done) ...[
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (instance.hasVoicedMicroWin)
                  _chip(card.voicedMicroWin.first),
                _chip('7–11분'),
              ],
            ),
          ],
          const SizedBox(height: 22),
          SunsetCta(
            buttonKey: const Key('start-today'),
            label: done ? '오늘 완료' : '오늘 시작',
            onPressed: done ? null : onStart,
            disabled: done,
            height: 54,
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Sun.surfaceSoft,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Sun.hairline),
        ),
        child: Text(text,
            style: const TextStyle(
                color: Sun.inkMid, fontSize: 11.5, fontWeight: FontWeight.w600)),
      );
}
