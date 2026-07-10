/// v5 — 보컬 부하 예산 엔진.
///
/// 고급 장르 Lab을 반복 가능하게 만들되 무제한 vocal load를 허용하지 않기 위한
/// 순수 도메인 정책이다. 실제 영속화는 후속 ProgressionStore 확장에서 연결한다.
library;

import '../lesson/card.dart';
import '../lesson/voice_state.dart';

enum VocalLoadIntensity { silent, low, moderate, high, gated }

enum VocalLoadMode { normal, reduced, recovery, blocked }

/// 초급 1세션 누적 발성 시간 권고 상한(초). 초과 시 경감/중단 권고.
/// 근거: 초보자 과사용 예방 — 짧고 분산된 연습이 안전(보수적 상한).
/// 입력은 F0·발성시간 파생만 사용(SPL/distance dose/EGG 미사용).
const int kBeginnerSessionPhonationCapSeconds = 600;

/// 카드 메타에 sustain만 있을 때 가정하는 기본 반복 수(보수적).
const int _kDefaultEstimateReps = 5;

/// 카드 메타에 시간 단서가 전혀 없을 때의 보수적 기본 발성 시간(초).
const int kDefaultCardPhonationSeconds = 60;

/// 카드 1회 완료의 보수적 발성 시간(초) 추정. 마이크 의존 없이 카드 메타만 사용.
/// maxDurationSec(활성 상한)을 우선, 없으면 maxSustainSec×maxReps, 그것도 없으면
/// 기본값. 실제보다 약간 크게 잡아 휴식 권고가 늦어지지 않게 한다(안전 방향).
int estimatePhonationSeconds(Card card) {
  final dur = card.maxDurationSec;
  if (dur != null) return dur;
  final sustain = card.maxSustainSec;
  if (sustain != null) {
    final reps = card.maxReps ?? _kDefaultEstimateReps;
    return sustain * reps;
  }
  return kDefaultCardPhonationSeconds;
}

class VocalLoadDecision {
  const VocalLoadDecision({
    required this.allowed,
    required this.mode,
    required this.reason,
    this.fallbackCardId,
  });

  final bool allowed;
  final VocalLoadMode mode;
  final String reason;
  final String? fallbackCardId;
}

class VocalLoadLedger {
  const VocalLoadLedger({
    this.points = 0,
    this.highCount = 0,
    this.gatedCount = 0,
    this.fullTakeCount = 0,
    this.lastHighEpochDay,
    this.sessionPhonationSeconds = 0,
    this.continuousHighPitchSustainSecMax = 0,
    this.last7DaysPhonationSec = const [],
    this.f0WeightedTimeDoseMilli = 0,
  });

  final int points;
  final int highCount;
  final int gatedCount;
  final int fullTakeCount;
  final int? lastHighEpochDay;

  /// 현재 세션의 누적 발성 시간(초). 세션 경계 리셋은 호출부(스토어) 책임.
  final int sessionPhonationSeconds;

  /// 세션 내 최장 연속 고음 유지 시간(초) — A3 sustain 캡 집행용.
  final int continuousHighPitchSustainSecMax;

  /// 최근 7일 일별 발성 시간(초) 롤링 — A3 주간 빈도/누적 집행용.
  final List<int> last7DaysPhonationSec;

  /// F0 가중 시간 도즈(밀리 단위 누적). **approximate proxy** — SPL 부재라 근사값일 뿐
  /// 절대 생체역학 도즈 아님. 안전 판정에 단독 사용 금지(보수 보조 신호).
  final int f0WeightedTimeDoseMilli;

  VocalLoadLedger add({
    required VocalLoadIntensity intensity,
    bool fullTake = false,
    int? epochDay,
    int phonationSeconds = 0,
  }) {
    final cost = VocalLoadPolicy.costForIntensity(intensity);
    return VocalLoadLedger(
      points: points + cost,
      highCount: highCount +
          ((intensity == VocalLoadIntensity.high ||
                  intensity == VocalLoadIntensity.gated)
              ? 1
              : 0),
      gatedCount: gatedCount + (intensity == VocalLoadIntensity.gated ? 1 : 0),
      fullTakeCount: fullTakeCount + (fullTake ? 1 : 0),
      lastHighEpochDay: (intensity == VocalLoadIntensity.high ||
              intensity == VocalLoadIntensity.gated)
          ? epochDay
          : lastHighEpochDay,
      sessionPhonationSeconds: sessionPhonationSeconds + phonationSeconds,
      // Stage 0: 신규 필드는 add()에서 그대로 보존(누적 와이어링은 후속).
      continuousHighPitchSustainSecMax: continuousHighPitchSustainSecMax,
      last7DaysPhonationSec: last7DaysPhonationSec,
      f0WeightedTimeDoseMilli: f0WeightedTimeDoseMilli,
    );
  }

  Map<String, dynamic> toJson() => {
        'points': points,
        'highCount': highCount,
        'gatedCount': gatedCount,
        'fullTakeCount': fullTakeCount,
        'lastHighEpochDay': lastHighEpochDay,
        'sessionPhonationSeconds': sessionPhonationSeconds,
        'continuousHighPitchSustainSecMax': continuousHighPitchSustainSecMax,
        'last7DaysPhonationSec': last7DaysPhonationSec,
        'f0WeightedTimeDoseMilli': f0WeightedTimeDoseMilli,
      };

  static VocalLoadLedger fromJson(Map<String, dynamic> j) => VocalLoadLedger(
        points: (j['points'] as int?) ?? 0,
        highCount: (j['highCount'] as int?) ?? 0,
        gatedCount: (j['gatedCount'] as int?) ?? 0,
        fullTakeCount: (j['fullTakeCount'] as int?) ?? 0,
        lastHighEpochDay: j['lastHighEpochDay'] as int?,
        sessionPhonationSeconds: (j['sessionPhonationSeconds'] as int?) ?? 0,
        continuousHighPitchSustainSecMax:
            (j['continuousHighPitchSustainSecMax'] as int?) ?? 0,
        last7DaysPhonationSec: [
          for (final v in (j['last7DaysPhonationSec'] as List? ?? const []))
            v as int,
        ],
        f0WeightedTimeDoseMilli: (j['f0WeightedTimeDoseMilli'] as int?) ?? 0,
      );
}

/// A3 도즈 하드락 판정 결과.
enum LockAction { allow, lowerIntensity, forcedRestLock, weeklyCapLock, doseLock }

class VocalLoadPolicy {
  const VocalLoadPolicy({
    this.dailyPointBudget = 8,
    this.maxHighPerDay = 1,
    this.maxGatedPerDay = 0,
    this.maxFullTakesPerDay = 2,
  });

  final int dailyPointBudget;
  final int maxHighPerDay;
  final int maxGatedPerDay;
  final int maxFullTakesPerDay;

  static VocalLoadIntensity intensityForCard(Card card) =>
      switch (card.safetyIntensity) {
        'gated' => VocalLoadIntensity.gated,
        'high' => VocalLoadIntensity.high,
        'moderate' => VocalLoadIntensity.moderate,
        'low' => VocalLoadIntensity.low,
        _ => VocalLoadIntensity.low,
      };

  static int costForIntensity(VocalLoadIntensity intensity) => switch (intensity) {
        VocalLoadIntensity.silent => 0,
        VocalLoadIntensity.low => 1,
        VocalLoadIntensity.moderate => 2,
        VocalLoadIntensity.high => 4,
        VocalLoadIntensity.gated => 5,
      };

  VocalLoadDecision evaluate({
    required Card card,
    required VocalLoadLedger ledger,
    VoiceState? voiceState,
    bool fullTake = false,
  }) {
    if (voiceState == VoiceState.hoarse) {
      return VocalLoadDecision(
        allowed: true,
        mode: VocalLoadMode.recovery,
        reason: '쉰 느낌: 소리 과제 대신 회복/듣기 루틴으로 전환',
        fallbackCardId: card.fallbackCardId,
      );
    }

    final intensity = intensityForCard(card);
    final cost = costForIntensity(intensity);

    if (voiceState == VoiceState.tired &&
        (intensity == VocalLoadIntensity.high ||
            intensity == VocalLoadIntensity.gated)) {
      return VocalLoadDecision(
        allowed: true,
        mode: VocalLoadMode.recovery,
        reason: '조금 피곤함: 고강도 카드는 회복 루틴으로 대체',
        fallbackCardId: card.fallbackCardId,
      );
    }

    if (fullTake && ledger.fullTakeCount >= maxFullTakesPerDay) {
      return const VocalLoadDecision(
        allowed: false,
        mode: VocalLoadMode.blocked,
        reason: '오늘 full take 한도에 도달',
      );
    }

    if (intensity == VocalLoadIntensity.gated &&
        ledger.gatedCount >= maxGatedPerDay) {
      return VocalLoadDecision(
        allowed: false,
        mode: VocalLoadMode.blocked,
        reason: '오늘 gated 과제 한도에 도달',
        fallbackCardId: card.fallbackCardId,
      );
    }

    if ((intensity == VocalLoadIntensity.high ||
            intensity == VocalLoadIntensity.gated) &&
        ledger.highCount >= maxHighPerDay) {
      return VocalLoadDecision(
        allowed: false,
        mode: VocalLoadMode.blocked,
        reason: '오늘 고강도 과제 한도에 도달',
        fallbackCardId: card.fallbackCardId,
      );
    }

    if (ledger.points + cost > dailyPointBudget) {
      return VocalLoadDecision(
        allowed: true,
        mode: VocalLoadMode.reduced,
        reason: '오늘 부하 예산이 높아 라이트 모드 권장',
        fallbackCardId: card.fallbackCardId,
      );
    }

    if (voiceState == VoiceState.tired) {
      return const VocalLoadDecision(
        allowed: true,
        mode: VocalLoadMode.reduced,
        reason: '조금 피곤함: 반복 수를 줄여 진행',
      );
    }

    return const VocalLoadDecision(
      allowed: true,
      mode: VocalLoadMode.normal,
      reason: '정상 부하',
    );
  }

  /// 세션 누적 발성 시간이 상한을 넘으면 경감(reduce)/중단 권고.
  /// 점수가 아니라 안전 권고일 뿐 — allowed는 막지 않고 mode로만 신호한다.
  VocalLoadDecision evaluateSessionPhonation({
    required VocalLoadLedger ledger,
    int capSeconds = kBeginnerSessionPhonationCapSeconds,
  }) {
    if (ledger.sessionPhonationSeconds > capSeconds) {
      return const VocalLoadDecision(
        allowed: true,
        mode: VocalLoadMode.reduced,
        reason: '세션 누적 발성 시간이 권고 상한을 초과 — 휴식/경감 권장',
      );
    }
    return const VocalLoadDecision(
      allowed: true,
      mode: VocalLoadMode.normal,
      reason: '세션 발성 시간 정상',
    );
  }

  // ── A3 도즈 하드락(soft 권고가 아니라 차단) — 고위험 후보 카드용 ──────────
  // 캡 수치(card.max*/weeklyCap/requiredRestHours)는 SIGN-OFF REQUIRED placeholder.

  /// 세션 도즈 캡 도달 시 doseLock. 발성시간·연속고음·full-take 캡을 본다.
  LockAction evaluateDoseHardLock({
    required Card card,
    required VocalLoadLedger ledger,
  }) {
    final maxDur = card.maxDurationSec;
    final maxSus = card.maxSustainSec;
    final maxTakes = card.maxTakeCount;
    if (maxDur != null && ledger.sessionPhonationSeconds >= maxDur) {
      return LockAction.doseLock;
    }
    if (maxSus != null && ledger.continuousHighPitchSustainSecMax >= maxSus) {
      return LockAction.doseLock;
    }
    if (maxTakes != null && ledger.fullTakeCount >= maxTakes) {
      return LockAction.doseLock;
    }
    return LockAction.allow;
  }

  /// 최근 고부하 후 requiredRestHours 미경과면 forcedRestLock(일×24로 변환).
  LockAction evaluateForcedRest({
    required Card card,
    required VocalLoadLedger ledger,
    required int todayEpochDay,
  }) {
    final last = ledger.lastHighEpochDay;
    final restHours = card.requiredRestHours;
    if (last == null || restHours == null) return LockAction.allow;
    final elapsedHours = (todayEpochDay - last) * 24;
    return elapsedHours < restHours
        ? LockAction.forcedRestLock
        : LockAction.allow;
  }

  /// 최근 7일 발성한 일수가 weeklyCap 이상이면 weeklyCapLock.
  LockAction evaluateWeeklyCap({
    required Card card,
    required VocalLoadLedger ledger,
  }) {
    final cap = card.weeklyCap;
    if (cap == null) return LockAction.allow;
    final activeDays = ledger.last7DaysPhonationSec.where((s) => s > 0).length;
    return activeDays >= cap ? LockAction.weeklyCapLock : LockAction.allow;
  }
}
