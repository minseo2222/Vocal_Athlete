/// F2 — 경량 음성 피로 자가체크 화면.
///
/// 임상 진단이 아니다. 3개 문항(0~10)으로 오늘의 컨디션을 스스로 점검하고,
/// 우려 신호가 있으면 경감/회복을 권고한다(점수 노출·등급 없음).
library;

import 'package:flutter/material.dart';

import '../safety/vocal_recovery.dart';
import '../theme/app_theme.dart';

class VocalFatigueCheckScreen extends StatefulWidget {
  const VocalFatigueCheckScreen({
    super.key = const Key('vocal-fatigue-screen'),
    required this.onBack,
    required this.onSubmit,
    this.initial,
  });

  final VoidCallback onBack;
  final ValueChanged<VocalFatigueSelfCheck> onSubmit;
  final VocalFatigueSelfCheck? initial;

  @override
  State<VocalFatigueCheckScreen> createState() =>
      _VocalFatigueCheckScreenState();
}

class _VocalFatigueCheckScreenState extends State<VocalFatigueCheckScreen> {
  late double _tiredness = (widget.initial?.tiredness ?? 0).toDouble();
  late double _discomfort = (widget.initial?.discomfort ?? 0).toDouble();
  late double _recovery = (widget.initial?.poorRecovery ?? 0).toDouble();
  VocalFatigueSelfCheck? _result;

  VocalFatigueSelfCheck _current() => VocalFatigueSelfCheck(
    tiredness: _tiredness.round(),
    discomfort: _discomfort.round(),
    poorRecovery: _recovery.round(),
  );

  void _save() {
    final check = _current();
    widget.onSubmit(check);
    setState(() => _result = check);
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('vfi-back'),
          tooltip: '뒤로',
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('음성 컨디션 자가점검', style: TextStyle(fontSize: 18)),
      ),
      body: Entrance(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            const Text(
              '임상 진단이 아닌 자가 점검입니다. 점수가 아니라 오늘 강도를 조절하기 위한 신호로만 씁니다.',
              style: TextStyle(color: Sun.inkLow, fontSize: 12, height: 1.45),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: Sun.card(),
              child: Column(
                children: [
                  _Slider(
                    sliderKey: const Key('vfi-tiredness'),
                    label: '목소리가 쉽게 지치나요?',
                    value: _tiredness,
                    onChanged: (v) => setState(() => _tiredness = v),
                  ),
                  _Slider(
                    sliderKey: const Key('vfi-discomfort'),
                    label: '목에 불편함·이물감이 있나요?',
                    value: _discomfort,
                    onChanged: (v) => setState(() => _discomfort = v),
                  ),
                  _Slider(
                    sliderKey: const Key('vfi-recovery'),
                    label: '쉬어도 회복이 더딘가요?',
                    value: _recovery,
                    onChanged: (v) => setState(() => _recovery = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SunsetCta(
              buttonKey: const Key('vfi-save'),
              label: '저장',
              onPressed: _save,
            ),
            if (result != null) ...[
              const SizedBox(height: 16),
              Container(
                key: const Key('vfi-guidance'),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: result.needsEscalation
                      ? Sun.surfaceSoft
                      : Sun.mintSoft,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(color: Sun.hairline),
                ),
                child: Text(
                  result.needsEscalation
                      ? '🌿 오늘은 강도를 낮추고 회복·듣기 루틴을 권장합니다. 통증·쉰 느낌이 지속되면 충분히 쉬세요.'
                      : '오늘 컨디션은 양호합니다. 무리하지 않게 진행하세요.',
                  style: TextStyle(
                    color: result.needsEscalation ? Sun.danger : Sun.mint,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.sliderKey,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final Key sliderKey;
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Sun.ink, fontSize: 14),
              ),
            ),
            Text(
              '${value.round()}',
              style: const TextStyle(
                color: Sun.inkMid,
                fontFeatures: Sun.tnum,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Slider(
          key: sliderKey,
          value: value,
          min: 0,
          max: kSelfCheckMax.toDouble(),
          divisions: kSelfCheckMax,
          label: '${value.round()}',
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
