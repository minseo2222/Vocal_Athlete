/// U1 — 레슨 화면 D 셸(채택안 D, 프로토 검증).
///
/// 본 슬라이스(U1) = 셸·완료 배선까지. cue/유성 콘텐츠 = U2(C2 후),
/// 시각 피치 = U4, 쿨다운 스킵 동작 = U3, "다시?" 넛지 = U5.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import 'card_library.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen(
      {this.progression,
      this.onComplete,
      this.onAdvanceDay,
      super.key = const Key('lesson-screen')});

  final Progression? progression;
  final VoidCallback? onComplete;

  /// dev 어포던스 — 실 캘린더 바인딩 슬라이스 전까지 다음날로 진행할 수단.
  /// null이면 버튼 미표시. 정식 출시 전 제거.
  final VoidCallback? onAdvanceDay;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p == null
                        ? ''
                        : '${p.todaysLesson.cardId} · ${p.currentIndex + 1}/${p.total}',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (p != null)
                        _Pill(
                            key: const Key('streak'),
                            text: '🔥 ${p.streak}'),
                      if (p != null &&
                          resolveCard(p.todaysLesson)
                              .voicedMicroWin
                              .isNotEmpty) ...[
                        const SizedBox(width: 6),
                        const _Pill(text: '● 유성'),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            // 3단 스테퍼(진입·본운동·쿨다운)
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
              child: Row(
                children: const [
                  _Step(label: '진입·워밍업', state: _StepState.done),
                  SizedBox(width: 8),
                  _Step(label: '본운동 7–11분', state: _StepState.now),
                  SizedBox(width: 8),
                  _Step(label: '쿨다운', state: _StepState.next),
                ],
              ),
            ),
            // cue 중앙 (C2: 실제 카드 cue로 배선)
            Expanded(
              child: Center(
                key: const Key('lesson-cue'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    p == null ? '' : resolveCard(p.todaysLesson).cue.join('\n'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 21, height: 1.5),
                  ),
                ),
              ),
            ),
            // 하단 시트
            Container(
              key: const Key('lesson-sheet'),
              decoration: const BoxDecoration(
                color: Color(0xFF171922),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3F55),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('본운동 · 7–11분',
                          style: TextStyle(color: Colors.white54)),
                      _Pill(text: '쿨다운 건너뛰기'), // placeholder, 동작 = U3
                    ],
                  ),
                  if (p != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '● ${resolveCard(p.todaysLesson).voicedMicroWin.first}',
                      style: const TextStyle(
                          color: Color(0xFF39D98A), fontSize: 13),
                    ),
                  ],
                  const SizedBox(height: 12),
                  // 시각 피치 영역 자리(실제 곡선 = U4)
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E0F13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key('complete-button'),
                      onPressed: onComplete,
                      child: const Text('완료'),
                    ),
                  ),
                  if (onAdvanceDay != null) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        key: const Key('dev-advance-day'),
                        onPressed: onAdvanceDay,
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white38),
                        child: const Text('다음날 (dev · 실 캘린더 슬라이스 전 임시)'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _StepState { done, now, next }

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.state});
  final String label;
  final _StepState state;
  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _StepState.done => const Color(0xFF39D98A),
      _StepState.now => const Color(0xFF6C8CFF),
      _StepState.next => const Color(0xFF3A3F55),
    };
    return Expanded(
      child: Column(
        children: [
          Container(
              height: 5,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  color: state == _StepState.now
                      ? Colors.white
                      : Colors.white38,
                  fontSize: 11,
                  fontWeight: state == _StepState.now
                      ? FontWeight.w700
                      : FontWeight.w400)),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF222637),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
      );
}
