/// P1 — 단일 고정 선형 경로 (ADR-0015 PathManifest / PathSlot).
///
/// v9 canonical: 초급 Foundation(48) → Universal Vocal Core(144) →
/// Repertoire Application(72) → Advanced Genre Labs(40-slot 반복 cycle).
/// Universal Core는 12일 microcycle 12개, Repertoire Application은
/// 12일 phrase project 6개로 운용한다. 정상 진도에는 recovery 전용 카드를
/// 배치하지 않고 목 상태에 따라 런타임에서 대체한다(ADR-0027).
library;

/// 변주 강도(경로 따라 내부 상승, 사용자 비노출).
enum VariationLevel { blocked, lightVariable, variable }

/// 수업의 학습 의도. 당일 성공과 장기 학습을 구분하기 위한 비노출 메타데이터.
enum LearningIntent { acquire, stabilize, vary, retrieve, transfer, checkpoint }

/// ADR-0015 PathSlot. LessonInstance는 런타임 도출(C2/C3) — 여기선 슬롯만.
class PathSlot {
  final int index; // 0-based 경로 위치
  final String cardId; // 카드 참조
  final int block; // 설계 phase, 사용자 비노출
  final int cycle; // 1-based microcycle/project; 0이면 미사용
  final double bodyVoicedRatio; // 신체·호흡 비중
  final VariationLevel variationLevel;
  final LearningIntent learningIntent;

  const PathSlot({
    required this.index,
    required this.cardId,
    required this.block,
    required this.bodyVoicedRatio,
    required this.variationLevel,
    this.cycle = 0,
    this.learningIntent = LearningIntent.acquire,
  });
}

/// v9: CARD-18은 매일 목 상태에 따른 동적 recovery fallback으로만 사용한다.
/// 정상 48일 경로에서는 청음·내적 상상 빈도를 보강한다.
// R5 — 신·구 카드를 6블록 흐름으로 엮어 고유 카드 35종/반복 ~1.4배.
// 고정 앵커 보존: 표준샘플 CARD-13 = index 0·23·47, 음색 브릿지 TONE-02/03 = index 36·37
// (index 0~29 TONE 금지), 전이 카드 CARD-14/15/16/17 각 ≥3회.
const _beginnerCards = <String>[
  // 셋업·호흡 강화 (1–8) — 호흡 4카드 전면 배치
  'CARD-13', 'CARD-01', 'CARD-02', 'CARD-41',
  'CARD-19', 'CARD-20', 'CARD-42', 'CARD-04',
  // SOVT 기초 + 호흡 (9–16)
  'CARD-06', 'CARD-07', 'CARD-43', 'CARD-08',
  'CARD-22', 'CARD-23', 'CARD-10', 'CARD-14',
  // 이지 온셋·단일음 (17–24, index23=CARD-13 체크포인트)
  'CARD-03', 'CARD-24', 'CARD-38', 'CARD-14',
  'CARD-40', 'CARD-21', 'CARD-25', 'CARD-13',
  // 컨투어·리듬 (25–32)
  'CARD-16', 'CARD-27', 'CARD-15', 'CARD-28',
  'CARD-12', 'CARD-16', 'CARD-15', 'CARD-30',
  // 곡 조각 전이 (33–40, index36/37=TONE-02/03 음색 브릿지)
  'CARD-17', 'CARD-31', 'CARD-37', 'CARD-16',
  'TONE-02', 'TONE-03', 'CARD-17', 'CARD-32',
  // 일관성·졸업 산출물 (41–48, index47=CARD-13 체크포인트)
  'CARD-15', 'CARD-33', 'CARD-17', 'CARD-34',
  'CARD-14', 'CARD-36', 'CARD-35', 'CARD-13',
];

int _beginnerBlockForLesson(int lesson) {
  if (lesson <= 8) return 1;
  if (lesson <= 20) return 2;
  if (lesson <= 30) return 3;
  if (lesson <= 40) return 4;
  return 5;
}

double _beginnerRatioForBlock(int block) => switch (block) {
      1 => 0.70,
      2 => 0.50,
      3 => 0.40,
      4 => 0.30,
      _ => 0.20,
    };

VariationLevel _beginnerVariationForBlock(int block) => switch (block) {
      1 || 2 => VariationLevel.blocked,
      3 || 4 => VariationLevel.lightVariable,
      _ => VariationLevel.variable,
    };

LearningIntent _beginnerIntentForLesson(int lesson) {
  if (lesson == 1 || lesson == 24 || lesson == 48) {
    return LearningIntent.checkpoint;
  }
  if (lesson >= 41) return LearningIntent.transfer;
  if (lesson >= 21) return LearningIntent.vary;
  if (lesson >= 9) return LearningIntent.stabilize;
  return LearningIntent.acquire;
}

class _Block {
  final int id;
  final int endSlot; // 1-based 마지막 레슨 번호
  final List<String> cards;
  final double ratio;
  final VariationLevel variation;
  const _Block(this.id, this.endSlot, this.cards, this.ratio, this.variation);
}

class _Cycle {
  final int phase;
  final int cycle;
  final List<String> cards; // 정확히 12개
  final double ratio;
  final VariationLevel variation;
  const _Cycle(this.phase, this.cycle, this.cards, this.ratio, this.variation);
}

const int pathLength = 48;
const int universalCoreLength = 144;
const int repertoireApplicationLength = 72;
const int advancedCycleLength = 40;
const int universalCoreCycleLength = 12;
const int universalCoreCycleCount = 12;
const int repertoireProjectLength = 12;
const int repertoireProjectCount = 6;

LearningIntent _intentForCyclePosition({
  required int phase,
  required int position,
  required String cardId,
}) {
  if (cardId == 'UC-17' || cardId == 'RA-10') {
    return LearningIntent.checkpoint;
  }
  if (cardId == 'UC-25' || cardId == 'RA-08') {
    return LearningIntent.retrieve;
  }
  if (cardId == 'UC-16' || cardId == 'UC-23' || cardId == 'RA-09') {
    return LearningIntent.transfer;
  }
  if (position >= 10) return LearningIntent.retrieve;
  return switch (phase) {
    1 => position <= 5 ? LearningIntent.acquire : LearningIntent.stabilize,
    2 => position <= 5 ? LearningIntent.stabilize : LearningIntent.vary,
    3 => position <= 5 ? LearningIntent.vary : LearningIntent.retrieve,
    _ => LearningIntent.transfer,
  };
}

/// Universal Vocal Core — 12일 microcycle × 12.
/// 각 cycle은 호흡/발성, SOVT 전이, pitch, rhythm, 음색, range,
/// diction, phrase integration, self-review를 모두 다시 호출한다.
/// 공식 UC-17 checkpoint는 36/72/108/144일에만 배치한다.
const _universalCoreCycles = <_Cycle>[
  // R5d 신규 중급 카드(UC-12·26~41)를 1~6사이클에 분산해 반복을 낮춤.
  // 각 사이클: pitch·rhythm·phrase·review 카테고리 ≥1, UC-17은 3·6사이클 끝.
  _Cycle(1, 1, [
    'UC-01', 'UC-03', 'UC-05', 'CARD-14', 'CARD-15', 'TONE-02',
    'UC-13', 'CARD-17', 'UC-18', 'UC-16', 'UC-24', 'UC-25',
  ], 0.14, VariationLevel.lightVariable),
  _Cycle(1, 2, [
    'UC-27', 'TONE-05', 'UC-28', 'UC-06', 'UC-08', 'TONE-03',
    'UC-14', 'UC-12', 'UC-18', 'UC-23', 'UC-19', 'UC-25',
  ], 0.14, VariationLevel.lightVariable),
  _Cycle(1, 3, [
    'UC-40', 'TONE-04', 'UC-24', 'UC-06', 'UC-20', 'TONE-06',
    'UC-30', 'UC-15', 'UC-18', 'UC-16', 'UC-34', 'UC-17',
  ], 0.14, VariationLevel.lightVariable),

  _Cycle(2, 4, [
    'UC-38', 'TONE-05', 'UC-31', 'CARD-12', 'UC-09', 'TONE-07',
    'UC-39', 'UC-26', 'UC-18', 'UC-23', 'UC-19', 'UC-25',
  ], 0.10, VariationLevel.variable),
  _Cycle(2, 5, [
    'UC-32', 'UC-35', 'UC-24', 'UC-07', 'UC-20', 'UC-10',
    'UC-14', 'UC-37', 'UC-18', 'UC-16', 'UC-22', 'UC-25',
  ], 0.10, VariationLevel.variable),
  _Cycle(2, 6, [
    'UC-33', 'TONE-04', 'UC-36', 'UC-06', 'UC-08', 'TONE-06',
    'UC-41', 'UC-29', 'UC-18', 'UC-23', 'UC-25', 'UC-17',
  ], 0.10, VariationLevel.variable),

  // R5f 후반 사이클 7~12에 신규/심화 카드 분산(레지스터·passaggio·믹스·도약·구간전환).
  _Cycle(3, 7, [
    'UC-18', 'UC-31', 'UC-24', 'UC-19', 'UC-20', 'TONE-08',
    'UC-14', 'UC-42', 'UC-15', 'UC-23', 'UC-16', 'UC-25',
  ], 0.08, VariationLevel.variable),
  _Cycle(3, 8, [
    'UC-02', 'TONE-05', 'UC-32', 'UC-06', 'UC-09', 'TONE-09',
    'UC-43', 'TONE-10', 'UC-18', 'UC-16', 'UC-19', 'UC-25',
  ], 0.08, VariationLevel.variable),
  _Cycle(3, 9, [
    'UC-03', 'TONE-04', 'UC-24', 'UC-07', 'UC-20', 'TONE-07',
    'UC-33', 'UC-35', 'UC-15', 'UC-23', 'UC-44', 'UC-17',
  ], 0.08, VariationLevel.variable),

  _Cycle(4, 10, [
    'UC-18', 'UC-36', 'UC-30', 'UC-19', 'UC-20', 'UC-41',
    'UC-22', 'UC-15', 'UC-23', 'UC-16', 'TONE-12', 'UC-25',
  ], 0.06, VariationLevel.variable),
  _Cycle(4, 11, [
    'UC-02', 'TONE-05', 'UC-24', 'UC-07', 'UC-09', 'TONE-06',
    'UC-14', 'UC-34', 'UC-18', 'UC-23', 'UC-16', 'UC-25',
  ], 0.06, VariationLevel.variable),
  _Cycle(4, 12, [
    'UC-03', 'UC-37', 'UC-38', 'UC-19', 'UC-20', 'TONE-12',
    'UC-39', 'UC-15', 'UC-18', 'UC-23', 'UC-25', 'UC-17',
  ], 0.06, VariationLevel.variable),
];

/// Repertoire Application — 12일 phrase project × 6.
/// 각 project 내부에서 Global → Local → Global을 완결하고, 마지막 날에는
/// guide를 줄인 지연 재현/전이 take를 남긴다.
const _repertoireApplicationCycles = <_Cycle>[
  _Cycle(1, 1, [
    'RA-09', 'RA-01', 'RA-02', 'RA-03', 'RA-04', 'CARD-15',
    'RA-07', 'RA-05', 'RA-06', 'CARD-17', 'RA-08', 'RA-10',
  ], 0.06, VariationLevel.lightVariable),
  // R5g 프로젝트 2~6 다양화 — 단계별 주제로 신규 RA 카드 분산(프로젝트1=블루프린트 불변).
  // 앵커 보존: 매 프로젝트 첫=RA-09·끝=RA-10·RA-07/08 포함, p5=TONE-11·p6=TONE-12.
  _Cycle(1, 2, [
    'RA-09', 'RA-11', 'RA-12', 'RA-13', 'RA-14', 'RA-07',
    'RA-03', 'RA-04', 'RA-08', 'RA-02', 'RA-27', 'RA-10',
  ], 0.06, VariationLevel.lightVariable),
  _Cycle(2, 3, [
    'RA-09', 'RA-15', 'RA-16', 'RA-17', 'RA-18', 'RA-07',
    'RA-19', 'RA-05', 'RA-08', 'RA-06', 'RA-26', 'RA-10',
  ], 0.05, VariationLevel.variable),
  _Cycle(2, 4, [
    'RA-09', 'RA-20', 'RA-21', 'RA-22', 'RA-07', 'RA-23',
    'RA-17', 'RA-03', 'RA-08', 'RA-19', 'RA-28', 'RA-10',
  ], 0.05, VariationLevel.variable),
  _Cycle(3, 5, [
    'RA-09', 'RA-20', 'RA-21', 'RA-22', 'RA-23', 'RA-07',
    'TONE-11', 'RA-24', 'RA-08', 'RA-25', 'RA-26', 'RA-10',
  ], 0.05, VariationLevel.variable),
  _Cycle(4, 6, [
    'RA-09', 'RA-24', 'RA-25', 'RA-07', 'RA-27', 'TONE-12',
    'RA-28', 'RA-22', 'RA-08', 'RA-20', 'RA-26', 'RA-10',
  ], 0.04, VariationLevel.variable),
];

const _advancedGayoBlocks = <_Block>[
  _Block(1, 10, ['GY-01', 'GY-02', 'TONE-07', 'TONE-10', 'RA-09'],
      0.04, VariationLevel.variable),
  _Block(2, 20,
      ['GY-03', 'GY-04', 'GY-05', 'GY-11', 'GY-12', 'GY-16', 'TONE-13', 'TONE-11'],
      0.04, VariationLevel.variable),
  _Block(3, 30,
      ['GY-06', 'GY-07', 'GY-08', 'GY-10', 'GY-13', 'GY-14', 'TONE-12', 'RA-07'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['GY-09', 'GY-15', 'TONE-12', 'RA-10', 'UC-25'],
      0.04, VariationLevel.variable),
];

const _advancedMusicalBlocks = <_Block>[
  _Block(1, 10, ['IM-06', 'IM-07', 'TONE-12', 'IM-08', 'RA-09'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['IM-01', 'IM-02', 'IM-03', 'IM-04', 'TONE-13'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['IM-05', 'IM-09', 'IM-10', 'IM-11', 'IM-13', 'IM-14', 'TONE-11'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['IM-12', 'TONE-12', 'RA-10', 'UC-25'],
      0.04, VariationLevel.variable),
];

const _advancedClassicalBlocks = <_Block>[
  _Block(1, 10, ['CL-02', 'CL-03', 'TONE-06', 'CL-04', 'RA-09'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['CL-01', 'CL-05', 'TONE-09', 'CL-06', 'CL-12', 'TONE-12'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['CL-07', 'CL-08', 'CL-10', 'CL-11', 'TONE-08', 'TONE-11', 'RA-07'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['CL-09', 'TONE-12', 'RA-10', 'UC-25'],
      0.04, VariationLevel.variable),
];

/// v9: R&B/Soul은 가요 카드 조합이 아니라 전용 저위험 카드로 시작한다.
const _advancedRbSoulBlocks = <_Block>[
  _Block(1, 10, ['RB-01', 'RB-02', 'TONE-07', 'RA-09', 'RB-05'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['RB-03', 'RB-04', 'RA-07', 'TONE-08', 'RB-01'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['RB-02', 'RB-04', 'RB-06', 'TONE-11', 'RA-05'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['RB-06', 'TONE-12', 'RA-08', 'RA-10'],
      0.04, VariationLevel.variable),
];

/// v9: clean rock/mic/load 전용 저위험 카드. rasp/growl/scream은 포함하지 않는다.
const _advancedRockBlocks = <_Block>[
  _Block(1, 10, ['RK-01', 'RK-02', 'RA-09', 'TONE-07', 'RK-03'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['RK-03', 'RK-04', 'RA-04', 'TONE-11', 'RK-01'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['RK-02', 'RK-05', 'RA-07', 'TONE-12', 'RK-04'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['RK-06', 'TONE-12', 'RA-08', 'RA-10'],
      0.04, VariationLevel.variable),
];

/// v9: Worship/Christian CCM 전용 저위험 카드.
const _advancedCcmBlocks = <_Block>[
  _Block(1, 10, ['WC-01', 'WC-02', 'RA-09', 'TONE-07', 'WC-04'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['WC-02', 'WC-03', 'RA-04', 'TONE-06', 'WC-01'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['WC-04', 'WC-05', 'RA-07', 'TONE-12', 'WC-03'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['WC-06', 'TONE-12', 'RA-08', 'RA-10'],
      0.04, VariationLevel.variable),
];

const _advancedUserSongBlocks = <_Block>[
  _Block(1, 10, ['RA-09', 'RA-01', 'RA-02', 'TONE-11'],
      0.04, VariationLevel.variable),
  _Block(2, 20, ['RA-03', 'RA-04', 'TONE-12', 'CARD-16'],
      0.04, VariationLevel.variable),
  _Block(3, 30, ['RA-05', 'RA-06', 'TONE-10', 'TONE-07'],
      0.04, VariationLevel.variable),
  _Block(4, 40, ['RA-07', 'RA-08', 'TONE-12', 'RA-10'],
      0.04, VariationLevel.variable),
];

List<PathSlot> _expand(List<_Block> blocks) {
  final slots = <PathSlot>[];
  var prevEnd = 0;
  for (final b in blocks) {
    for (var lesson = prevEnd + 1; lesson <= b.endSlot; lesson++) {
      final within = lesson - prevEnd - 1;
      slots.add(PathSlot(
        index: lesson - 1,
        cardId: b.cards[within % b.cards.length],
        block: b.id,
        bodyVoicedRatio: b.ratio,
        variationLevel: b.variation,
        learningIntent: LearningIntent.transfer,
      ));
    }
    prevEnd = b.endSlot;
  }
  return slots;
}

List<PathSlot> _expandCycles(List<_Cycle> cycles) {
  final slots = <PathSlot>[];
  for (final cycle in cycles) {
    assert(cycle.cards.length == 12);
    for (var i = 0; i < cycle.cards.length; i++) {
      final cardId = cycle.cards[i];
      slots.add(PathSlot(
        index: slots.length,
        cardId: cardId,
        block: cycle.phase,
        cycle: cycle.cycle,
        bodyVoicedRatio: cycle.ratio,
        variationLevel: cycle.variation,
        learningIntent: _intentForCyclePosition(
          phase: cycle.phase,
          position: i,
          cardId: cardId,
        ),
      ));
    }
  }
  return slots;
}

List<PathSlot> buildPlaceholderManifest() => [
      for (var i = 0; i < _beginnerCards.length; i++)
        PathSlot(
          index: i,
          cardId: _beginnerCards[i],
          block: _beginnerBlockForLesson(i + 1),
          bodyVoicedRatio:
              _beginnerRatioForBlock(_beginnerBlockForLesson(i + 1)),
          variationLevel:
              _beginnerVariationForBlock(_beginnerBlockForLesson(i + 1)),
          learningIntent: _beginnerIntentForLesson(i + 1),
        ),
    ];

List<PathSlot> buildUniversalCoreManifest() => _expandCycles(_universalCoreCycles);
List<PathSlot> buildCoreManifest() => buildUniversalCoreManifest();

List<PathSlot> buildRepertoireApplicationManifest() =>
    _expandCycles(_repertoireApplicationCycles);

/// R4 migration alias: R3 tools/tests may still call buildSongBuilderManifest().
List<PathSlot> buildSongBuilderManifest() => buildRepertoireApplicationManifest();

/// R4 migration alias: R3 tools/tests may still read songBuilderLength.
const int songBuilderLength = repertoireApplicationLength;

List<PathSlot> buildAdvancedGayoManifest() => _expand(_advancedGayoBlocks);
List<PathSlot> buildAdvancedMusicalManifest() => _expand(_advancedMusicalBlocks);
List<PathSlot> buildAdvancedClassicalManifest() => _expand(_advancedClassicalBlocks);
List<PathSlot> buildAdvancedRbSoulManifest() => _expand(_advancedRbSoulBlocks);
List<PathSlot> buildAdvancedRockManifest() => _expand(_advancedRockBlocks);
List<PathSlot> buildAdvancedCcmManifest() => _expand(_advancedCcmBlocks);
List<PathSlot> buildAdvancedUserSongManifest() => _expand(_advancedUserSongBlocks);

// 하위 호환 alias. R3부터 장르 manifest는 고급 Lab cycle이다.
List<PathSlot> buildGayoManifest() => buildAdvancedGayoManifest();
List<PathSlot> buildMusicalManifest() => buildAdvancedMusicalManifest();
List<PathSlot> buildClassicalManifest() => buildAdvancedClassicalManifest();
