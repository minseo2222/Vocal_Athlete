/// F2 — 회복 윈도우 · VFI 자기보고 · 음역 경계 승격 순수 도메인 (Flutter import 없음).
///
/// 모든 입력은 F0·발성시간 파생값과 구조화 자기보고뿐이다(SPL/distance dose/EGG 등
/// 폰 비신뢰 절대지표 미사용). 어떤 값도 사용자에게 점수로 노출하지 않으며,
/// 경감/회복 전환·승격 게이트 신호로만 쓴다.
library;

import 'safety_params.dart';

// ── 회복 윈도우 ────────────────────────────────────────────────────────────
/// 고부하 후 최소 회복 시간(시간). 이 이전엔 회복 중으로 보고 경감 권고.
/// 근거: 성대 조직 회복은 대략 24시간~3일 소요(연구 합치).
const int kMinRecoveryHours = 24;

/// 고부하 후 완전 회복 권장 시간(시간). 이 이후 정상 복귀.
const int kFullRecoveryHours = 72;

enum RecoveryStatus { recovering, partiallyRecovered, recovered }

const int kHoursPerDay = 24;

/// 일 단위 경과(ledger의 lastHighEpochDay 호환)로 회복 상태 판정. days×24h.
RecoveryStatus recoveryStatusAfterHighLoadDays(int daysSinceLastHighLoad) =>
    recoveryStatusAfterHighLoad(daysSinceLastHighLoad * kHoursPerDay);

/// 마지막 고부하 이후 경과 시간(시간) → 회복 상태.
RecoveryStatus recoveryStatusAfterHighLoad(int hoursSinceLastHighLoad) {
  if (hoursSinceLastHighLoad < kMinRecoveryHours) {
    return RecoveryStatus.recovering;
  }
  if (hoursSinceLastHighLoad < kFullRecoveryHours) {
    return RecoveryStatus.partiallyRecovered;
  }
  return RecoveryStatus.recovered;
}

// ── VFI(Vocal Fatigue Index) 자기보고 ─────────────────────────────────────
// 검증 컷오프. 근거: Nanjundeswaran et al. (2015) VFI 3요인.
// F1=목소리 피로/회피(↑ 나쁨), F2=신체 불편(↑ 나쁨),
// F3=휴식 시 회복(↓ 나쁨 — 회복이 잘 안 됨을 뜻하므로 역방향).
const int kVfiFactor1Cutoff = 24;
const int kVfiFactor2Cutoff = 7;
const int kVfiFactor3RestCutoff = 7;

class VocalFatigueReport {
  const VocalFatigueReport({
    required this.factor1Tiredness,
    required this.factor2Discomfort,
    required this.factor3RestRecovery,
    this.epochDay,
  });

  final int factor1Tiredness;
  final int factor2Discomfort;
  final int factor3RestRecovery;
  final int? epochDay;

  bool get factor1Elevated => factor1Tiredness >= kVfiFactor1Cutoff;
  bool get factor2Elevated => factor2Discomfort >= kVfiFactor2Cutoff;
  bool get factor3PoorRecovery => factor3RestRecovery <= kVfiFactor3RestCutoff;

  /// 어느 한 요인이라도 컷오프를 넘으면 escalation 필요(경감/회복 전환).
  bool get needsEscalation =>
      factor1Elevated || factor2Elevated || factor3PoorRecovery;

  Map<String, dynamic> toJson() => {
        'factor1Tiredness': factor1Tiredness,
        'factor2Discomfort': factor2Discomfort,
        'factor3RestRecovery': factor3RestRecovery,
        'epochDay': epochDay,
      };

  static VocalFatigueReport fromJson(Map<String, dynamic> j) =>
      VocalFatigueReport(
        factor1Tiredness: (j['factor1Tiredness'] as int?) ?? 0,
        factor2Discomfort: (j['factor2Discomfort'] as int?) ?? 0,
        factor3RestRecovery: (j['factor3RestRecovery'] as int?) ?? 0,
        epochDay: j['epochDay'] as int?,
      );
}

// ── 경량 자가 체크(소프트 신호) ────────────────────────────────────────────
// 임상 VFI 도구가 아니다. 0~kSelfCheckMax 단일 리커트 3문항으로, 점수를 진단으로
// 쓰지 않고 경감/회복 권고의 소프트 신호로만 쓴다. 모든 문항은 "높을수록 나쁨"으로
// 통일(회복 항목은 '쉬어도 회복이 더딤'으로 표현해 역방향 혼동을 없앤다).
// 정식 임상 도구를 도입할 경우 [VocalFatigueReport]의 검증 컷오프를 사용한다.
const int kSelfCheckMax = 10;
const int kSelfCheckConcernThreshold = 7;

class VocalFatigueSelfCheck {
  const VocalFatigueSelfCheck({
    required this.tiredness,
    required this.discomfort,
    required this.poorRecovery,
    this.epochDay,
  });

  /// 목소리가 쉽게 지치는 정도(0~10, 높을수록 나쁨).
  final int tiredness;

  /// 목 불편/이물감 정도(0~10, 높을수록 나쁨).
  final int discomfort;

  /// 쉬어도 회복이 더딘 정도(0~10, 높을수록 나쁨).
  final int poorRecovery;
  final int? epochDay;

  /// 어느 한 문항이라도 우려 임계 이상이면 경감/회복 권고(소프트 신호).
  bool get needsEscalation =>
      tiredness >= kSelfCheckConcernThreshold ||
      discomfort >= kSelfCheckConcernThreshold ||
      poorRecovery >= kSelfCheckConcernThreshold;

  Map<String, dynamic> toJson() => {
        'tiredness': tiredness,
        'discomfort': discomfort,
        'poorRecovery': poorRecovery,
        'epochDay': epochDay,
      };

  static VocalFatigueSelfCheck fromJson(Map<String, dynamic> j) =>
      VocalFatigueSelfCheck(
        tiredness: (j['tiredness'] as int?) ?? 0,
        discomfort: (j['discomfort'] as int?) ?? 0,
        poorRecovery: (j['poorRecovery'] as int?) ?? 0,
        epochDay: j['epochDay'] as int?,
      );
}

// ── 증상 기반 하드락 (Stage 0) ─────────────────────────────────────────────
// 경량 자가체크/검증도구 신호를 "강도↓"에서 "하드 잠금"으로 승격. 컷오프·잠금시간은
// safety_params.dart의 placeholder(SIGN-OFF REQUIRED). 근거: ENFORCED-...SPEC §A5.

enum SymptomLock { none, softReduce, hardLockout, referral }

/// 증상 신호 → 잠금 강도. 반복 트리거가 누적되면 referral(의료 의뢰)로 escalate.
/// vfcScore = 경량 자가체크 3문항 중 최댓값(0~10). vfiCutoffCrossed = 임상 VFI 컷오프
/// 교차 여부(VocalFatigueReport.needsEscalation 등에서 산출). 모두 자가보고 파생.
SymptomLock evaluateSymptomLock({
  required int vfcScore,
  bool painReported = false,
  int hoarsenessDays = 0,
  bool vfiCutoffCrossed = false,
  int recentTriggerCount = 0,
}) {
  if (recentTriggerCount >= kSymptomReferralCount) return SymptomLock.referral;
  if (vfcScore >= kSymptomVfcHard ||
      painReported ||
      hoarsenessDays >= kSymptomHoarseDays ||
      vfiCutoffCrossed) {
    return SymptomLock.hardLockout;
  }
  if (vfcScore > kSymptomVfcSoft) return SymptomLock.softReduce;
  return SymptomLock.none;
}

/// 증상 잠금 종료일과 회복 윈도우 종료일 중 더 늦은 쪽(max) — 둘 중 보수적으로.
int lockoutUntilEpochDay({
  required int triggeredEpochDay,
  int lockoutHours = kSymptomLockoutHours,
  int? lastHighEpochDay,
}) {
  final symptomEnd =
      triggeredEpochDay + (lockoutHours / kHoursPerDay).ceil();
  if (lastHighEpochDay == null) return symptomEnd;
  final recoveryEnd =
      lastHighEpochDay + (kFullRecoveryHours / kHoursPerDay).ceil();
  return symptomEnd > recoveryEnd ? symptomEnd : recoveryEnd;
}

/// 증상 잠금 상태(영속화용). 잠금 종료일·반복 트리거 카운트 보존.
class SymptomState {
  const SymptomState({
    this.lockoutUntilEpochDay,
    this.triggerCount = 0,
    this.lastTriggerEpochDay,
  });

  final int? lockoutUntilEpochDay;
  final int triggerCount;
  final int? lastTriggerEpochDay;

  bool isLockedAt(int todayEpochDay) =>
      lockoutUntilEpochDay != null && todayEpochDay < lockoutUntilEpochDay!;

  Map<String, dynamic> toJson() => {
        'lockoutUntilEpochDay': lockoutUntilEpochDay,
        'triggerCount': triggerCount,
        'lastTriggerEpochDay': lastTriggerEpochDay,
      };

  static SymptomState fromJson(Map<String, dynamic> j) => SymptomState(
        lockoutUntilEpochDay: j['lockoutUntilEpochDay'] as int?,
        triggerCount: (j['triggerCount'] as int?) ?? 0,
        lastTriggerEpochDay: j['lastTriggerEpochDay'] as int?,
      );
}

// ── 음역 경계 승격 추적기 ──────────────────────────────────────────────────
/// trial→usable 승격에 필요한 연속 충족 세션 수(2~3 중 보수값).
const int kPromotionStreak = 2;

/// 같은 부위 통증 누적 한계. 이 횟수에 도달하면 확장 중단.
const int kPainRecurrenceStop = 2;

/// 확장 중단 시 권고 경감 시간(시간).
const int kBoundaryDeloadHours = 48;

enum BoundaryStatus { trial, usable, stopped }

/// 한 세션의 새 경계음 3중 검증 결과.
/// ① 다음날 통증/이물감 없음 ② 음질 유지 ③ F0 안정·무피로.
/// painArea가 있으면 통증 부위로 재발 카운트에 반영.
class BoundaryVerification {
  const BoundaryVerification({
    required this.nextDayRecovered,
    required this.qualityMaintained,
    required this.f0StableNoFatigue,
    this.painArea,
  });

  final bool nextDayRecovered;
  final bool qualityMaintained;
  final bool f0StableNoFatigue;
  final String? painArea;

  bool get allPassed =>
      nextDayRecovered && qualityMaintained && f0StableNoFatigue;
}

class RangeBoundaryTracker {
  const RangeBoundaryTracker({
    this.status = BoundaryStatus.trial,
    this.passStreak = 0,
    this.painArea,
    this.painCount = 0,
  });

  final BoundaryStatus status;
  final int passStreak;

  /// 마지막으로 통증이 보고된 부위(없으면 null).
  final String? painArea;

  /// 해당 부위 누적 통증 횟수.
  final int painCount;

  /// 확장이 중단된 경우 권고 경감 시간(시간), 아니면 0.
  int get recommendedDeloadHours =>
      status == BoundaryStatus.stopped ? kBoundaryDeloadHours : 0;

  RangeBoundaryTracker record(BoundaryVerification v) {
    if (status == BoundaryStatus.stopped) return this; // 중단 상태 유지

    // 통증 처리 — 같은 부위 재발만 누적, 다른 부위면 새로 카운트 시작.
    var areaNext = painArea;
    var painNext = painCount;
    if (v.painArea != null) {
      if (v.painArea == painArea) {
        painNext = painCount + 1;
      } else {
        areaNext = v.painArea;
        painNext = 1;
      }
      if (painNext >= kPainRecurrenceStop) {
        return RangeBoundaryTracker(
          status: BoundaryStatus.stopped,
          passStreak: 0,
          painArea: areaNext,
          painCount: painNext,
        );
      }
    }

    if (v.allPassed) {
      final streak = passStreak + 1;
      return RangeBoundaryTracker(
        status:
            streak >= kPromotionStreak ? BoundaryStatus.usable : status,
        passStreak: streak,
        painArea: areaNext,
        painCount: painNext,
      );
    }
    // 한 항목이라도 실패 → 연속 streak 리셋(상태는 유지).
    return RangeBoundaryTracker(
      status: status,
      passStreak: 0,
      painArea: areaNext,
      painCount: painNext,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status.name,
        'passStreak': passStreak,
        'painArea': painArea,
        'painCount': painCount,
      };

  static RangeBoundaryTracker fromJson(Map<String, dynamic> j) =>
      RangeBoundaryTracker(
        status: BoundaryStatus.values.firstWhere(
          (s) => s.name == j['status'],
          orElse: () => BoundaryStatus.trial,
        ),
        passStreak: (j['passStreak'] as int?) ?? 0,
        painArea: j['painArea'] as String?,
        painCount: (j['painCount'] as int?) ?? 0,
      );
}
