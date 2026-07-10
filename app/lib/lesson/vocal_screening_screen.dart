/// Stage 0 — A2 적신호 자가 스크리닝 화면.
///
/// 진단이 아니라 적신호 자가점검. 예/아니오로 답하면 통과/주의/상담권고를 안내한다.
/// 질병명·진단 표현 없음. 상담권고는 비진단 카피로만. 점수·등급 없음.
library;

import 'package:flutter/material.dart';

import '../safety/safety_params.dart';
import '../safety/vocal_screening.dart';
import '../theme/app_theme.dart';

const Map<String, String> _kPrompts = {
  'hoarse2w': '쉰 목소리/목소리 변화가 2주 이상 지속되나요?',
  'dysphagia': '삼킬 때 어렵거나 아픈가요?',
  'neck_mass': '목에 만져지는 멍울/혹이 있나요?',
  'hemoptysis': '피가 섞인 기침을 한 적 있나요?',
  'otalgia': '목소리 변화와 함께 한쪽 귀가 계속 아픈가요?',
  'stridor_breath': '숨쉬기 힘들거나 쌕쌕거리는 소리가 나나요?',
  'recent_surg_intub':
      '최근 $kScreenSurgeryLookbackWeeks주 이내 머리·목·가슴 수술이나 기관삽관을 했나요?',
  'known_lesion': '성대 결절·폴립·마비 등을 진단받은 적 있나요?',
  'pain_phonation': '지금 말하거나 노래할 때 통증이 있나요?',
  'lpr_reflux': '역류/인후두 역류 증상이나 진단이 있나요?',
  'tobacco': '현재 흡연하시나요?',
  'prof_voice': '직업적으로 목을 많이 쓰시나요(교사·가수 등)?',
};

class VocalScreeningScreen extends StatefulWidget {
  const VocalScreeningScreen({
    super.key = const Key('vocal-screening-screen'),
    required this.onBack,
    required this.onSubmit,
    required this.todayEpochDay,
  });

  final VoidCallback onBack;
  final ValueChanged<ScreeningResult> onSubmit;
  final int todayEpochDay;

  @override
  State<VocalScreeningScreen> createState() => _VocalScreeningScreenState();
}

class _VocalScreeningScreenState extends State<VocalScreeningScreen> {
  final Map<String, bool> _answers = {
    for (final i in kRedFlagScreening) i.id: false,
  };
  ScreeningResult? _result;

  void _submit() {
    final result = evaluateScreening(
      answers: {for (final e in _answers.entries) e.key: e.value},
      todayEpochDay: widget.todayEpochDay,
    );
    widget.onSubmit(result);
    setState(() => _result = result);
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
          key: const Key('screen-back'),
          tooltip: '뒤로',
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('목 건강 적신호 자가점검', style: TextStyle(fontSize: 18)),
      ),
      body: Entrance(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            const Text(
              '진단이 아닌 자가점검입니다. 해당되면 켜 주세요. 일부 항목은 전문가 상담을 권할 수 있어요.',
              style: TextStyle(color: Sun.inkLow, fontSize: 12, height: 1.45),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: Sun.card(),
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    for (final item in kRedFlagScreening)
                      SwitchListTile(
                        key: Key('screen-item-${item.id}'),
                        value: _answers[item.id]!,
                        onChanged: (v) => setState(() => _answers[item.id] = v),
                        title: Text(
                          _kPrompts[item.id] ?? item.id,
                          style: const TextStyle(color: Sun.ink, fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SunsetCta(
              buttonKey: const Key('screen-submit'),
              label: '점검하기',
              onPressed: _submit,
            ),
            if (result != null) ...[
              const SizedBox(height: 16),
              Container(
                key: const Key('screen-result'),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: result.outcome == ScreeningOutcome.hardBlock
                      ? Sun.surfaceSoft
                      : Sun.mintSoft,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(color: Sun.hairline),
                ),
                child: Text(
                  switch (result.outcome) {
                    ScreeningOutcome.hardBlock =>
                      '⚠️ 응답에 전문가 상담이 필요한 항목이 있어요. 계속하기 전에 의사 또는 이비인후과(후두) 진료를 권합니다.',
                    ScreeningOutcome.softCaution =>
                      '주의할 항목이 있어요. 무리하지 말고 편하게 진행하세요.',
                    ScreeningOutcome.pass => '특이 적신호가 없어요. 무리하지 않게 진행하세요.',
                  },
                  style: TextStyle(
                    color: result.outcome == ScreeningOutcome.hardBlock
                        ? Sun.danger
                        : Sun.mint,
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
