/// U1 — 레슨 화면 D 셸(채택안 D, 프로토 검증).
///
/// U3 — 단계 머신(진입/본운동/쿨다운) 도입. 시각 피치 = U4, "다시?" 넛지 = U5.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';
import 'pitch/pitch_display.dart';
import 'pitch/pitch_source.dart';

/// U3 — 레슨 단계 머신(진입→본운동→쿨다운).
enum LessonStep { entry, main, cooldown }

class LessonScreen extends StatefulWidget {
  const LessonScreen(
      {this.progression,
      this.onComplete,
      this.pitchSource,
      super.key = const Key('lesson-screen')});

  final Progression? progression;
  final VoidCallback? onComplete;
  final PitchSource? pitchSource;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  LessonStep _step = LessonStep.entry;
  // _p가 변이형이라 widget.progression 참조 비교가 무용 — 카드ID 자체를 추적.
  String? _lastCardId;

  _StepState _stepStateFor(LessonStep s) {
    if (s.index < _step.index) return _StepState.done;
    if (s.index == _step.index) return _StepState.now;
    return _StepState.next;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.progression;
    final instance =
        p == null ? null : resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance?.card;
    final id = card?.id;
    if (id != null && _lastCardId != null && id != _lastCardId) {
      _step = LessonStep.entry;
    }
    _lastCardId = id;
    return Scaffold(
      backgroundColor: AppColors.bg,
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
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (p != null)
                          _Pill(
                              key: const Key('streak'),
                              text: '🔥 ${p.streak}'),
                        if (p != null && p.maintenance)
                          const _Pill(
                              key: Key('maintenance-badge'), text: '유지 모드'),
                        if (instance != null && instance.hasVoicedMicroWin)
                          const _Pill(text: '● 유성'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 3단 스테퍼(진입·본운동·쿨다운) — 현재 단계 강조
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
              child: Row(
                children: [
                  _Step(label: '진입·워밍업', state: _stepStateFor(LessonStep.entry)),
                  const SizedBox(width: 8),
                  _Step(label: '본운동 7–11분', state: _stepStateFor(LessonStep.main)),
                  const SizedBox(width: 8),
                  _Step(label: '쿨다운', state: _stepStateFor(LessonStep.cooldown)),
                ],
              ),
            ),
            // cue 중앙 (C2: 실제 카드 cue로 배선)
            Expanded(
              child: Center(
                key: const Key('lesson-cue'),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: KeyedSubtree(
                    key: ValueKey(_step),
                    // 단계별 단일 콘텐츠 — 진입=워밍업만, 본=본 cue, 쿨다운=쿨다운(중첩 없음).
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: card == null
                          ? const SizedBox.shrink()
                          : Text(
                              switch (_step) {
                                LessonStep.entry => '워밍업: ${card.anatomyEntry}',
                                LessonStep.main => card.cue.join('\n'),
                                LessonStep.cooldown =>
                                  '쿨다운: ${card.anatomyCooldown}',
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _step == LessonStep.entry
                                    ? Colors.white70
                                    : Colors.white,
                                fontSize: _step == LessonStep.entry ? 18 : 21,
                                height: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            // 하단 시트
            Container(
              key: const Key('lesson-sheet'),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheet)),
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
                        color: AppColors.locked,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('본운동 · 7–11분',
                          style: TextStyle(color: Colors.white54)),
                      if (_step == LessonStep.main)
                        InkWell(
                          key: const Key('skip-cooldown'),
                          onTap: widget.onComplete,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                          child: const _Pill(text: '쿨다운 건너뛰기'),
                        ),
                    ],
                  ),
                  if (card != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '● ${card.voicedMicroWin.first}',
                      style: const TextStyle(
                          color: AppColors.done, fontSize: 13),
                    ),
                  ],
                  if (_step == LessonStep.main &&
                      instance != null &&
                      instance.variation.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '오늘: ${instance.variationLabel}',
                        key: const Key('today-variation'),
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 12),
                  // U4 — main 단계에서만 시각 피치 표시. 마이크 없으면 안내 한 줄.
                  if (_step == LessonStep.main) ...[
                    if (widget.pitchSource == null)
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.lockedSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '🎤\n마이크 꺼짐 — 피치 표시 안 됨',
                          key: Key('mic-off-notice'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      )
                    else
                      PitchDisplay(source: widget.pitchSource),
                  ] else
                    const SizedBox(height: 110),
                  const SizedBox(height: 12),
                  if (_step != LessonStep.cooldown) ...[
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        key: const Key('next-button'),
                        onPressed: () => setState(() {
                          _step = _step == LessonStep.entry
                              ? LessonStep.main
                              : LessonStep.cooldown;
                        }),
                        child: const Text('다음'),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key('complete-button'),
                      onPressed: widget.onComplete,
                      child: const Text('완료'),
                    ),
                  ),
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
      _StepState.done => AppColors.done,
      _StepState.now => AppColors.now,
      _StepState.next => AppColors.locked,
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
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
      );
}
