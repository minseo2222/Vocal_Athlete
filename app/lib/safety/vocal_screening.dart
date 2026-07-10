/// Stage 0 — A2 사전 스크리닝(적신호 문진) 순수 도메인 (Flutter import 없음).
///
/// AAO-HNS Hoarseness CPG(Stachler 2018) + 표준 ENT 적신호에서 직접 구현(저작 도구 아님).
/// hardBlock 1+ 양성 → 고위험 카드 잠금 유지 + 비진단 의료 의뢰. 자가 해제 불가.
/// **미응답 hardBlock 항목은 긍정으로 처리(보수적 잠금).** 항목 확정·지속일수는
/// safety_params.dart placeholder(SIGN-OFF REQUIRED). 근거: ENFORCED-...SPEC §A2.
library;

import 'safety_params.dart';

enum ScreeningBlockType { hardBlock, softCaution }

enum ScreeningOutcome { pass, softCaution, hardBlock }

class ScreeningItem {
  const ScreeningItem({required this.id, required this.blockType});
  final String id;
  final ScreeningBlockType blockType;
}

/// 적신호 항목 집합. 문항 wording은 UI에서 작성(여기선 식별자·차단유형만).
const List<ScreeningItem> kRedFlagScreening = [
  ScreeningItem(id: 'hoarse2w', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'dysphagia', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'neck_mass', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'hemoptysis', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'otalgia', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'stridor_breath', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'recent_surg_intub', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'known_lesion', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'pain_phonation', blockType: ScreeningBlockType.hardBlock),
  ScreeningItem(id: 'lpr_reflux', blockType: ScreeningBlockType.softCaution),
  ScreeningItem(id: 'tobacco', blockType: ScreeningBlockType.softCaution),
  ScreeningItem(id: 'prof_voice', blockType: ScreeningBlockType.softCaution),
];

class ScreeningResult {
  const ScreeningResult({
    required this.outcome,
    required this.triggeredItemIds,
    required this.screenedAtEpochDay,
    required this.validUntilEpochDay,
    required this.referralAdvised,
  });

  final ScreeningOutcome outcome;
  final List<String> triggeredItemIds;
  final int screenedAtEpochDay;
  final int validUntilEpochDay;
  final bool referralAdvised;

  bool isValidAt(int todayEpochDay) => todayEpochDay < validUntilEpochDay;

  Map<String, dynamic> toJson() => {
        'outcome': outcome.name,
        'triggeredItemIds': triggeredItemIds,
        'screenedAtEpochDay': screenedAtEpochDay,
        'validUntilEpochDay': validUntilEpochDay,
        'referralAdvised': referralAdvised,
      };

  static ScreeningResult fromJson(Map<String, dynamic> j) => ScreeningResult(
        outcome: ScreeningOutcome.values.firstWhere(
          (o) => o.name == j['outcome'],
          orElse: () => ScreeningOutcome.hardBlock, // 모호 → 보수적 잠금
        ),
        triggeredItemIds: [
          for (final id in (j['triggeredItemIds'] as List? ?? const []))
            id as String,
        ],
        screenedAtEpochDay: (j['screenedAtEpochDay'] as int?) ?? 0,
        validUntilEpochDay: (j['validUntilEpochDay'] as int?) ?? 0,
        referralAdvised: (j['referralAdvised'] as bool?) ?? true,
      );
}

/// 응답(itemId→예/아니오/null=미응답)으로 스크리닝 판정.
/// 미응답 hardBlock = 긍정(잠금). 미응답 soft = 음성.
ScreeningResult evaluateScreening({
  required Map<String, bool?> answers,
  required int todayEpochDay,
}) {
  final triggered = <String>[];
  var hasHardBlock = false;
  var hasSoft = false;
  for (final item in kRedFlagScreening) {
    final ans = answers[item.id];
    final affirmative = item.blockType == ScreeningBlockType.hardBlock
        ? (ans ?? true) // 미응답 hardBlock → 긍정(보수적)
        : (ans ?? false);
    if (affirmative) {
      triggered.add(item.id);
      if (item.blockType == ScreeningBlockType.hardBlock) {
        hasHardBlock = true;
      } else {
        hasSoft = true;
      }
    }
  }
  final outcome = hasHardBlock
      ? ScreeningOutcome.hardBlock
      : (hasSoft ? ScreeningOutcome.softCaution : ScreeningOutcome.pass);
  return ScreeningResult(
    outcome: outcome,
    triggeredItemIds: triggered,
    screenedAtEpochDay: todayEpochDay,
    validUntilEpochDay: todayEpochDay + kScreenRescreenDays,
    referralAdvised: hasHardBlock,
  );
}
