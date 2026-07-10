/// 용어 도움말 — 훈련에 나오는 전문용어를 일반인 언어로 풀이.
///
/// 카드 콘텐츠를 바꾸지 않고, 처음 보는 용어(SOVT·글라이드·A/B 등)의 뜻을
/// 한곳에서 찾아볼 수 있게 한다. 레슨·설정에서 진입한다.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 용어 1개 — 표제어 + 한 줄 풀이.
class GlossaryTerm {
  const GlossaryTerm(this.term, this.plain);
  final String term;
  final String plain;
}

const List<GlossaryTerm> kGlossary = [
  GlossaryTerm('SOVT (반쯤 막은 발성)',
      '빨대 불기나 입술 떨기처럼 입을 살짝 좁혀, 목에 무리 없이 소리를 내는 방법이에요.'),
  GlossaryTerm('글라이드 (glide)',
      '사이렌 소리처럼 음을 끊지 않고 미끄러지듯 올렸다 내리는 거예요.'),
  GlossaryTerm('립 트릴 / 입술 떨기',
      "입술을 가볍게 '부르르' 떨면서 소리내는 워밍업이에요. 목 긴장을 풀어줘요."),
  GlossaryTerm('허밍',
      "입을 다물고 'ㅁ' 소리로 흥얼거리는 거예요. 부담 없이 소리를 깨우기 좋아요."),
  GlossaryTerm('easy onset (부드러운 시작)',
      '목에 힘을 주지 않고 숨과 함께 소리를 부드럽게 시작하는 거예요.'),
  GlossaryTerm('sustain (지속)',
      '한 음을 흔들리지 않게 일정하게 길게 끄는 거예요.'),
  GlossaryTerm('녹음 A/B',
      '같은 과제를 두세 번 녹음해 나란히 들어보며 비교하는 거예요. 점수를 매기는 게 아니라 차이를 느껴보는 용도예요.'),
  GlossaryTerm('기준 take / 기준선',
      '나중에 변화를 비교할 기준이 되는 첫 녹음이에요.'),
  GlossaryTerm('tone tag (음색 태그)',
      "내 소리가 어떻게 들렸는지 고르는 짧은 표현이에요(밝게·따뜻하게·말하듯 등). 정답은 없어요."),
  GlossaryTerm('지연 재현 복습',
      '며칠 지난 뒤 배운 걸 기억에서 다시 떠올려 보는 복습이에요. 이렇게 하면 더 오래 남아요.'),
  GlossaryTerm('컨디션(목 상태)',
      '오늘 목이 어떤지 고르면, 그에 맞춰 훈련 강도를 자동으로 조절해줘요.'),
];

class GlossaryScreen extends StatelessWidget {
  const GlossaryScreen({
    super.key = const Key('glossary-screen'),
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Sun.bg,
        appBar: AppBar(
          backgroundColor: Sun.bg,
          foregroundColor: Sun.ink,
          elevation: 0,
          leading: IconButton(
            key: const Key('glossary-back'),
            tooltip: '뒤로',
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
          title: const Text('용어 도움말', style: TextStyle(fontSize: 18)),
        ),
        body: Entrance(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            itemCount: kGlossary.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              if (i == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    '훈련에 나오는 용어를 쉽게 풀어 설명해요. 외울 필요 없어요 — 궁금할 때만 보면 돼요.',
                    style: TextStyle(
                        color: Sun.inkMid, fontSize: 13, height: 1.4),
                  ),
                );
              }
              final t = kGlossary[i - 1];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: Sun.card(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.term,
                        style: const TextStyle(
                            color: Sun.ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(t.plain,
                        style: const TextStyle(
                            color: Sun.inkMid, fontSize: 12.5, height: 1.4)),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
