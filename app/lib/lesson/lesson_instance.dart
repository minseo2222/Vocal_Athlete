/// LessonInstance — *오늘 학습자에게 보일* Card + 변주를 묶은 런타임 모델
/// (ADR-0015 LessonInstance = resolve(Card, PathSlot, day)).
///
/// Hybrid: `card` raw를 그대로 노출(escape hatch) + 파생 표면(`variationLabel`,
/// `hasVoicedMicroWin`)을 getter로. 라이브러리 lookup은 `resolveLessonInstance`가 흡수.
library;

import 'package:flutter/foundation.dart' show visibleForTesting;

import '../progression/path.dart';
import 'card.dart';
import 'card_library.dart';
import 'variation.dart';

class LessonInstance {
  const LessonInstance({
    required this.card,
    required this.slot,
    required this.day,
    required this.variation,
  });

  final Card card;
  final PathSlot slot;
  final int day;
  final Map<String, String> variation;

  /// "오늘: …" UI 라벨용. 빈 variation이면 빈 문자열.
  String get variationLabel =>
      variation.entries.map((e) => '${e.key}=${e.value}').join(' · ');

  bool get hasVoicedMicroWin => card.voicedMicroWin.isNotEmpty;
}

/// UI 단일 진입점 — PathSlot·day로 LessonInstance 도출. 내부에서 카드 lookup.
LessonInstance resolveLessonInstance(PathSlot slot, int day) =>
    buildLessonInstance(resolveCard(slot), slot, day);

/// 카드 주입 변형 — 테스트에서 가상 카드로 instance 구성할 때.
@visibleForTesting
LessonInstance buildLessonInstance(Card card, PathSlot slot, int day) =>
    LessonInstance(
      card: card,
      slot: slot,
      day: day,
      variation: selectVariation(card, slot, day),
    );
