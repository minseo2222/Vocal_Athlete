/// P1 — 단일 고정 선형 경로 (ADR-0015 PathManifest / PathSlot).
///
/// 순수: Flutter import 없음. 잠긴 결정 인코딩 —
/// 단일 고정 선형(배열 순서), 5블록(ADR-0006), bodyVoicedRatio 70:30→20:80,
/// blocked→variable variationLevel 내부 상승. 카드는 *플레이스홀더*(실배선 = C2).
library;

/// 변주 강도(경로 따라 내부 상승, 사용자 비노출).
enum VariationLevel { blocked, lightVariable, variable }

/// ADR-0015 PathSlot. LessonInstance는 런타임 도출(C2/C3) — 여기선 슬롯만.
class PathSlot {
  final int index; // 0-based 경로 위치
  final String cardId; // 플레이스홀더 카드 참조 (CARD-01..CARD-13)
  final int block; // 1..5 (설계 전용, 사용자 비노출)
  final double bodyVoicedRatio; // 신체·호흡 비중(0.70 → 0.20)
  final VariationLevel variationLevel;

  const PathSlot({
    required this.index,
    required this.cardId,
    required this.block,
    required this.bodyVoicedRatio,
    required this.variationLevel,
  });
}

/// 5블록 매크로(ADR-0006). (블록, 끝슬롯index, 카드집합, 비중, 변주).
const _blocks = <_Block>[
  _Block(1, 8, ['CARD-01', 'CARD-02', 'CARD-03', 'CARD-04', 'CARD-05', 'CARD-13'],
      0.70, VariationLevel.blocked),
  _Block(2, 20, ['CARD-06', 'CARD-07'], 0.50, VariationLevel.blocked),
  _Block(3, 30, ['CARD-08', 'CARD-09', 'CARD-13'], 0.40,
      VariationLevel.lightVariable),
  _Block(4, 40, ['CARD-05', 'CARD-10'], 0.30, VariationLevel.lightVariable),
  _Block(5, 48, ['CARD-11', 'CARD-12', 'CARD-13'], 0.20,
      VariationLevel.variable),
];

class _Block {
  final int id;
  final int endSlot; // 1-based 마지막 레슨 번호
  final List<String> cards;
  final double ratio;
  final VariationLevel variation;
  const _Block(this.id, this.endSlot, this.cards, this.ratio, this.variation);
}

const int pathLength = 48;

/// 결정적 플레이스홀더 PathManifest 생성(실제 배선·내용은 C2/C1).
List<PathSlot> buildPlaceholderManifest() {
  final slots = <PathSlot>[];
  var prevEnd = 0;
  for (final b in _blocks) {
    for (var lesson = prevEnd + 1; lesson <= b.endSlot; lesson++) {
      final within = lesson - prevEnd - 1;
      slots.add(PathSlot(
        index: lesson - 1,
        cardId: b.cards[within % b.cards.length],
        block: b.id,
        bodyVoicedRatio: b.ratio,
        variationLevel: b.variation,
      ));
    }
    prevEnd = b.endSlot;
  }
  return slots;
}
