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

// ===== 중급 코어 + 장르 분기 (I2) — D1 레슨 수 매핑 반영 =====
// 코어(블록1·2) + 분기(블록3·4). 변주: 코어 light→variable, 분기 variable(ADR-0006).
// 표준샘플 SOP(IC-12)는 각 블록 카드열 말미에 두어 주기적으로 등장(D2).

const _coreBlocks = <_Block>[
  _Block(1, 16, ['IC-01', 'IC-02', 'IC-03', 'IC-04', 'IC-05', 'IC-12'],
      0.20, VariationLevel.lightVariable),
  _Block(2, 32, ['IC-06', 'IC-07', 'IC-08', 'IC-09', 'IC-10', 'IC-11', 'IC-12'],
      0.15, VariationLevel.variable),
];

const _musicalBlocks = <_Block>[
  _Block(3, 48, ['IM-01', 'IM-02', 'IM-03', 'IM-04', 'IM-05', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 74,
      ['IM-06', 'IM-07', 'IM-08', 'IM-09', 'IM-10', 'IM-11', 'IM-12', 'IC-12'],
      0.10, VariationLevel.variable),
];

const _classicalBlocks = <_Block>[
  _Block(3, 47, ['CL-01', 'CL-02', 'CL-03', 'CL-04', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 68, ['CL-05', 'CL-06', 'CL-07', 'CL-08', 'CL-09', 'IC-12'],
      0.10, VariationLevel.variable),
];

const _gayoBlocks = <_Block>[
  _Block(3, 51,
      ['GY-01', 'GY-02', 'GY-03', 'GY-04', 'GY-05', 'GY-06', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 64, ['GY-07', 'GY-08', 'GY-09', 'IC-12'],
      0.10, VariationLevel.variable),
];

/// 블록열 → PathSlot 리스트(결정적 modulo 확장).
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
      ));
    }
    prevEnd = b.endSlot;
  }
  return slots;
}

/// 결정적 플레이스홀더 PathManifest 생성(초급 5블록).
List<PathSlot> buildPlaceholderManifest() => _expand(_blocks);

/// 중급 코어 manifest(블록1·2, genre-neutral). 분기 진입 전 공유.
List<PathSlot> buildCoreManifest() => _expand(_coreBlocks);

/// 장르 코스 = 코어(블록1·2) + 분기(블록3·4). I3의 genre→빌더 매핑이 사용.
List<PathSlot> buildMusicalManifest() => _expand([..._coreBlocks, ..._musicalBlocks]);
List<PathSlot> buildClassicalManifest() => _expand([..._coreBlocks, ..._classicalBlocks]);
List<PathSlot> buildGayoManifest() => _expand([..._coreBlocks, ..._gayoBlocks]);
