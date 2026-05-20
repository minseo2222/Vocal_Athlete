/// C2 — 13 IN 카드 라이브러리 + 리졸버.
///
/// 소스: docs/curriculum/beginner/cards.md (C1 산출물, 발성안전 사인오프).
/// 변주 엔진(C3)은 본 슬라이스 밖 — 여기는 단순 lookup.
library;

import 'card.dart';
import '../progression/path.dart';

const Map<String, Card> kCardLibrary = {
  'CARD-01': Card(
    id: 'CARD-01',
    cue: [
      '바닥/의자에 편하게.',
      '턱·어깨 힘 빼기.',
      '6점 균형 의식만 — 움직이지 않기.',
    ],
    voicedMicroWin: ['끝에 편한 /m/ 3회(각 2–3초)'],
    anatomyEntry: '가벼운 신체 스캔',
    anatomyMain: '6점 정렬 관찰',
    anatomyCooldown: '느린 호흡 3회',
  ),
  'CARD-02': Card(
    id: 'CARD-02',
    cue: [
      '코로 천천히 들이쉬고 늑골·배가 같이 부풀게.',
      '배만으로 ❌, 늑골도.',
      '내쉴 때 어깨 ❌.',
    ],
    voicedMicroWin: ['voiced 한숨 /h→a/ 3회(음정 안 정함)'],
    anatomyEntry: '무음 호흡 관찰',
    anatomyMain: '늑골-복부 결합 호흡',
    anatomyCooldown: '느린 날숨 연장',
  ),
  'CARD-03': Card(
    id: 'CARD-03',
    cue: [
      '턱을 무겁게 떨어뜨리기.',
      '혀 뿌리 내려놓기.',
      'silent ah 후 가벼운 voiced ah.',
    ],
    voicedMicroWin: ['가벼운 /a/ 3회(편한 중음)'],
    anatomyEntry: '턱·혀 풀기',
    anatomyMain: 'silent ah → voiced ah',
    anatomyCooldown: '하품-한숨 1회',
  ),
  'CARD-04': Card(
    id: 'CARD-04',
    cue: [
      '치지 말고 숨을 흘려보내듯 /h/.',
      '/h/에 가볍게 소리 얹기 → /m/.',
      '크게 ❌, 편하게.',
    ],
    voicedMicroWin: ['/h/-led 부드러운 onset 5회'],
    anatomyEntry: '무성 호기 3회',
    anatomyMain: '/h/→/m/ easy onset',
    anatomyCooldown: '가벼운 /m/ 하행',
  ),
  'CARD-05': Card(
    id: 'CARD-05',
    cue: [
      '짧게 소리 내고 멈춰 듣기.',
      '내 느낌 말고 화면 곡선을 보기.',
      '(블록4) 균형/과기식/과압착 중 어디로 보이는지 표시.',
    ],
    voicedMicroWin: ['편한 음 2–3초 발성 후 시각 곡선 확인 3회'],
    anatomyEntry: '짧은 발성',
    anatomyMain: '발성→시각 곡선 대조',
    anatomyCooldown: '가벼운 허밍',
  ),
  'CARD-06': Card(
    id: 'CARD-06',
    cue: [
      '5–6mm 빨대를 입술 안에 부드럽게.',
      '이로 물지 마세요.',
      '빨대로 /u/ 5초, 편한 중음.',
      '어지러우면 즉시 멈추세요.',
    ],
    voicedMicroWin: ['빨대 /u/ sustain 5초 × 3'],
    anatomyEntry: '무음 빨대 호기 1회',
    anatomyMain: '빨대 /u/ sustain 반복',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
  ),
  'CARD-07': Card(
    id: 'CARD-07',
    cue: [
      '입술 힘 빼고 부르르 떨기.',
      '일정하게 유지.',
      '편한 음으로 5초.',
    ],
    voicedMicroWin: ['립 트릴 sustain 5초 × 3, 가벼운 글라이드 1회'],
    anatomyEntry: '무성 입술 트릴',
    anatomyMain: '유성 트릴 sustain·글라이드',
    anatomyCooldown: '가벼운 허밍',
  ),
  'CARD-08': Card(
    id: 'CARD-08',
    cue: [
      '입 다물고 /m/ 콧대 진동 느끼기.',
      '짜내지 말기.',
      '/ŋ/로 바꿔 같은 느낌.',
    ],
    voicedMicroWin: ['/m/ 5초 × 2, /ŋ/ 5초 × 2'],
    anatomyEntry: '가벼운 /m/',
    anatomyMain: '/m/·/ŋ/ sustain·작은 글라이드',
    anatomyCooldown: '하행 허밍',
  ),
  'CARD-09': Card(
    id: 'CARD-09',
    cue: [
      '컵 물에 빨대 1–2cm 담그기.',
      '버블 일정하게.',
      '약한 강도로 5초.',
    ],
    voicedMicroWin: ['물 버블 발성 5초 × 3'],
    anatomyEntry: '무음 버블 1회',
    anatomyMain: '유성 물 버블 반복',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
  ),
  'CARD-10': Card(
    id: 'CARD-10',
    cue: [
      '숨 너무 새지도(과기식) 꽉 막지도(과압착) 않게.',
      '그 사이 편한 지점에서 5초.',
      '짜내지 말기.',
    ],
    voicedMicroWin: ['편한 음 sustain 5초 × 4'],
    anatomyEntry: '가벼운 onset',
    anatomyMain: '균형 지점 탐색 sustain',
    anatomyCooldown: '가벼운 허밍',
  ),
  'CARD-11': Card(
    id: 'CARD-11',
    cue: [
      '편한 음 2초 녹음.',
      '재생을 듣기.',
      '방금 그 소리를 다시 따라하기.',
      '5회 반복.',
    ],
    voicedMicroWin: ['자기 녹음 모방 발성 5회'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: '녹음→재생→재모방→시각 비교 5회',
    anatomyCooldown: '가벼운 /m/',
  ),
  'CARD-12': Card(
    id: 'CARD-12',
    cue: [
      '목표선을 보며 그 높이로 소리내기.',
      '곡선을 목표선에 붙이기.',
      '빗나가도 계속 — 다음에 가까이.',
    ],
    voicedMicroWin: ['목표음 매칭 발성 5회(각 3–5초)'],
    anatomyEntry: '가벼운 글라이드',
    anatomyMain: '피아노롤 목표선 매칭',
    anatomyCooldown: '하행 글라이드 1회',
  ),
  'CARD-13': Card(
    id: 'CARD-13',
    cue: [
      '조용한 곳에서.',
      '/a/ /i/ /u/ 각 5초.',
      '표준 문장 1줄 읽기.',
      '/a/로 저→고→저 한 호흡.',
    ],
    voicedMicroWin: ['지속 모음 3종 + 글라이드 녹음(전체가 유성)'],
    anatomyEntry: '환경 확인',
    anatomyMain: '고정 과제 녹음',
    anatomyCooldown: '가벼운 허밍',
  ),
};

/// PathSlot → Card 해석. V1 = 라이브러리 lookup.
/// 카드 미등록 시 ArgumentError(전수 가드 테스트 C2.3가 강제).
Card resolveCard(PathSlot slot) {
  final c = kCardLibrary[slot.cardId];
  if (c == null) {
    throw ArgumentError('Card not in library: ${slot.cardId}');
  }
  return c;
}
