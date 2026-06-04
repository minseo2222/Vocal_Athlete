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
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
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
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
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
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
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
    variableAxes: {
      'range': ['편한 중음', '약간 낮게'],
      'sessionPos': ['워밍업', '본'],
    },
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
    variableAxes: {
      'range': ['중음', '약간 높/낮'],
      'vowel': ['a', 'i', 'u'],
    },
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
    variableAxes: {
      'range': ['중음', '±2도'],
      'vowel': ['u', 'a'],
    },
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
    variableAxes: {
      'range': ['중음', '±2도'],
      'glide': ['sustain', '작은 5도 글라이드'],
    },
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
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['m', 'ŋ'],
      'glide': ['sustain', '글라이드'],
    },
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
    variableAxes: {
      'range': ['중음'],
      'glide': ['sustain'],
    },
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
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['a', 'i', 'u'],
    },
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
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['a', 'u'],
    },
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
    variableAxes: {
      'range': ['중음', '±3도', '약간 확장'],
      'vowel': ['a', 'i', 'u'],
      'glide': ['고정음', '작은 글라이드'],
    },
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

  // ===== 중급 코어 (intermediate-core, IC) =====
  'IC-01': Card(
    id: 'IC-01',
    cue: ['짜내지도 새지도 않게.', '그 사이 편한 지점에서 5초.', '화면 곡선으로 확인.'],
    voicedMicroWin: ['균형 지점 sustain 5초 × 4'],
    anatomyEntry: '가벼운 onset',
    anatomyMain: '과기식↔균형↔과압착 탐색',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
      'vowel': ['a', 'i', 'u'],
    },
  ),
  'IC-02': Card(
    id: 'IC-02',
    cue: ['빨대로 /u/ 또는 립 트릴 5초.', '이로 물지 마세요.', '일정한 굵기 유지.', '어지러우면 즉시 멈추세요.'],
    voicedMicroWin: ['SOVT sustain 5초 × 3'],
    anatomyEntry: '무음 호기 1회',
    anatomyMain: 'SOVT sustain·가벼운 글라이드',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
    variableAxes: {
      'range': ['중음', '±3도'],
      'glide': ['sustain', '작은 글라이드'],
    },
  ),
  'IC-03': Card(
    id: 'IC-03',
    cue: ['① 가장 편한 음 최대한 길게.', '② /o/로 저→고 부드럽게.', '③ 고→저 부드럽게.', '④ 음별 최대 지속 — 짜내지 않게.'],
    voicedMicroWin: ['VFE 4과제 각 1회(저충격)'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'knoll→글라이드→지속 4과제',
    anatomyCooldown: '가벼운 /m/',
    variableAxes: {
      'range': ['편한 중음', '약간 확장'],
    },
  ),
  'IC-04': Card(
    id: 'IC-04',
    cue: ['/h/로 숨 흘려보내듯 시작.', '/h/에 가볍게 소리 얹기.', '치지 말고 — 균형 onset이 유일 정답은 아님(편하게 탐색).'],
    voicedMicroWin: ['easy onset 5회'],
    anatomyEntry: '무성 호기 3회',
    anatomyMain: 'hard/balanced/breathy 대조',
    anatomyCooldown: '가벼운 /m/ 하행',
    variableAxes: {
      'onset': ['balanced', 'breathy'],
      'range': ['중음'],
    },
  ),
  'IC-05': Card(
    id: 'IC-05',
    cue: ['들숨 자세(흉곽 확장)를 노래하는 동안 유지.', '내쉴 때 한꺼번에 무너뜨리지 않기.'],
    voicedMicroWin: ['흡기자세 유지 발성 5초 × 3'],
    anatomyEntry: '늑골 확장 인지',
    anatomyMain: '흡기자세 유지 호기 antagonism',
    anatomyCooldown: '느린 날숨 연장',
    variableAxes: {
      'range': ['중음', '±2도'],
    },
  ),
  'IC-06': Card(
    id: 'IC-06',
    cue: ['빨대 /u/ 5초.', '빨대 빼고 같은 음 개모음(/a/)으로 이어가기.', '느낌 유지(carryover).'],
    voicedMicroWin: ['SOVT→개모음 carryover 5회'],
    anatomyEntry: '빨대 /u/ 1회',
    anatomyMain: 'SOVT→개모음 전이 반복',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a', 'o', 'e'],
      'range': ['중음', '±2도'],
    },
  ),
  'IC-07': Card(
    id: 'IC-07',
    cue: ['같은 음에서 모음을 /i/↔/a/↔/u/로 천천히 바꾸기.', '밝기·울림 변화를 화면으로 관찰.', '(고소프라노 조정·belt 방향은 여기서 안 함).'],
    voicedMicroWin: ['모음 전환 sustain 5회'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'R1:f0 관계 기초 관찰',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'vowel': ['i', 'a', 'u'],
      'range': ['중음', '±2도'],
    },
  ),
  'IC-08': Card(
    id: 'IC-08',
    cue: ['같은 문장을 또렷하게 vs 편하게 두 번.', '차이를 화면·감각으로 관찰.', '정답은 장르·증폭에 따라 다름 — 지금은 관찰만.'],
    voicedMicroWin: ['명료/효율 대조 발성 각 3회'],
    anatomyEntry: '편한 발성',
    anatomyMain: '명료도↔효율 대조 관찰',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'IC-09': Card(
    id: 'IC-09',
    cue: ['삼킬 때(후두↑)와 하품 시작(후두↓) 느낌 비교.', '노래는 그 사이 편한 높이.', '(클래식 저·CCM 고 타깃은 분기에서).'],
    voicedMicroWin: ['중립 후두높이 sustain 5초 × 3'],
    anatomyEntry: '후두 높이 인지',
    anatomyMain: '중립 높이 통제변수 관찰',
    anatomyCooldown: '느린 호흡',
    variableAxes: {
      'range': ['중음'],
    },
  ),
  'IC-10': Card(
    id: 'IC-10',
    cue: ['/m/ 후 /a/로 — 비음이 빠지는지 관찰.', '트웽 = 입 안 좁힘(밝게), 콧소리 ❌.', '의도 nasality와 비의도 nasalization 구분.'],
    voicedMicroWin: ['/m/→/a/ 비음 분리 5회'],
    anatomyEntry: '가벼운 /m/',
    anatomyMain: '비음 ↔ 비비음 대조',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['m', 'a', 'i'],
      'range': ['중음'],
    },
  ),
  'IC-11': Card(
    id: 'IC-11',
    cue: ['저음→고음 사이렌으로 천천히.', '소리 질감이 바뀌는 구간을 관찰(없애려 하지 않기).', '(믹스·belt·cover 처리는 분기에서).'],
    voicedMicroWin: ['사이렌 글라이드 3회'],
    anatomyEntry: '가벼운 글라이드',
    anatomyMain: 'primo/secondo passaggio 존재·관찰',
    anatomyCooldown: '하행 사이렌 1회',
    variableAxes: {
      'range': ['중음', '±3도', '약간 확장'],
      'glide': ['사이렌', '작은 글라이드'],
    },
  ),
  'IC-12': Card(
    id: 'IC-12',
    cue: ['조용한 곳에서 같은 조건으로.', '/a/ /i/ /u/ 각 5초 + 표준 문장 1줄 + 저→고→저 글라이드.', '녹음 후 시각 곡선을 직전 회차와 비교(듣고 판단 ❌).'],
    voicedMicroWin: ['고정 과제 녹음 1세트(전체 유성)'],
    anatomyEntry: '환경·자세 확인',
    anatomyMain: '고정 과제 녹음→직전 회차 시각 A/B',
    anatomyCooldown: '가벼운 허밍',
  ),

  // ===== 중급 뮤지컬 분기 (intermediate-musical, IM) =====
  'IM-01': Card(
    id: 'IM-01',
    cue: ['이 음에서 이 느낌으로(흉성/두성 비율 설명 없이).', '저→고 한 호흡으로 부드럽게.', '갑자기 두꺼워지거나 얇아지지 않게.'],
    voicedMicroWin: ['믹스 글라이드 5회'],
    anatomyEntry: '가벼운 사이렌',
    anatomyMain: 'M1↔M2 연결(경험으로)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
      'style': ['M1기반', 'M2기반'],
    },
  ),
  'IM-02': Card(
    id: 'IM-02',
    cue: ['오리·마녀 소리처럼 입 안을 좁혀 밝게.', '콧소리 ❌(트웽 = 입 안, 비음 아님).', '짧게 시작.'],
    voicedMicroWin: ['구강 트웽 발성 5회'],
    anatomyEntry: '가벼운 /a/',
    anatomyMain: '구강 AES 협착(밝게)',
    anatomyCooldown: '중립 모음 1회',
    variableAxes: {
      'vowel': ['a', 'e'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-03': Card(
    id: 'IM-03',
    cue: ['코어에서 관찰한 전이 구간을 사이렌으로 통과.', '없애려 하지 말고 부드럽게 관리.', '고음으로 밀어붙이지 않기.'],
    voicedMicroWin: ['전이 구간 사이렌 통과 5회'],
    anatomyEntry: '중음 사이렌',
    anatomyMain: 'primo/secondo 전이 관리',
    anatomyCooldown: '하행 사이렌',
    variableAxes: {
      'range': ['중음', '±4도'],
      'glide': ['사이렌', '작은 글라이드'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-04': Card(
    id: 'IM-04',
    cue: ['올라가며 모음을 살짝 어둡게 돌리기(turning the vowel).', '특정 음에서 울림이 바뀌는 지점 관찰.', '억지로 누르지 않기.'],
    voicedMicroWin: ['모음 전환 글라이드 5회'],
    anatomyEntry: '편한 모음 1회',
    anatomyMain: 'H2가 R1 통과 지점 모음 조정',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a→ɔ', 'e→ø'],
      'range': ['중고음'],
    },
  ),
  'IM-05': Card(
    id: 'IM-05',
    cue: ["'Hey!' 부르듯 짧게.", '밝게 — 크게 아님.', '짧게 끊어서, 지속하지 않기.', '조금이라도 아프면 즉시 멈춤.'],
    voicedMicroWin: ["call-based 'Hey!' 진입 3회(짧게)"],
    anatomyEntry: '가벼운 call',
    anatomyMain: 'call-based belt 진입만(보수적)',
    anatomyCooldown: '하행 글라이드·가벼운 SOVT',
    variableAxes: {
      'range': ['진입 음역 한정'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-06': Card(
    id: 'IM-06',
    cue: ['문장을 보통/뭉갬/정밀 3가지로.', '정밀 버전 채택.', '말하듯(chant) → 노래로 이어가기.'],
    voicedMicroWin: ['chant→sing 전이 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: '3조건 대조→정밀 채택→chant→sing',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'IM-07': Card(
    id: 'IM-07',
    cue: ['테크닉 1분 미만.', '새 호흡.', '텍스트를 말로 전달.', '같은 텍스트를 음정과 함께.', '3회 반복.'],
    voicedMicroWin: ['텍스트 말→노래 루프 3회'],
    anatomyEntry: '짧은 테크닉',
    anatomyMain: '말 전달→음정 전달 루프',
    anatomyCooldown: '느린 호흡',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-08': Card(
    id: 'IM-08',
    cue: ['녹음 후 가사가 또렷한지 화면·구조로 확인.', '듣고 판단하지 말고 시각/체크로.'],
    voicedMicroWin: ['명료도 점검 발성 3회'],
    anatomyEntry: '문장 1회',
    anatomyMain: '명료도 시각/구조 피드백',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-09': Card(
    id: 'IM-09',
    cue: ['평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).', '종성 7대표음 또렷이.', '연음·비음화 자연스럽게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['딕션 적용 구절 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: 'VOT·종성·연음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-10': Card(
    id: 'IM-10',
    cue: ['짧은 구절을 느리게 → 점점 빠르게.', '또렷함 유지되는 최대 템포까지만.', '무너지면 한 단계 늦춤.'],
    voicedMicroWin: ['패터 템포 램프 3단계'],
    anatomyEntry: '느린 구절',
    anatomyMain: '조음 템포 램프',
    anatomyCooldown: '턱 풀기',
    variableAxes: {
      'tempo': ['느림', '중간', '빠름'],
    },
  ),
  'IM-11': Card(
    id: 'IM-11',
    cue: ['이중모음은 첫 모음 길게·끝 모음 짧게.', 'r은 곡 스타일대로(미·영).', '또렷하되 과하지 않게.'],
    voicedMicroWin: ['영어 구절 딕션 3회'],
    anatomyEntry: '구절 말하기',
    anatomyMain: '이중모음/r 정책 적용',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-12': Card(
    id: 'IM-12',
    cue: ['legit 구절은 맑게.', 'belt-진입 구절은 짧고 밝게(크게 아님).', '풀 벨트로 끌지 않기(고급).'],
    voicedMicroWin: ['곡 구절 적용 1회(legit 또는 라이트 belt-진입)'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: 'legit→라이트 belt-진입 구절',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['legit', '라이트 belt-진입'],
    },
    safetyReview: SafetyReview.pending,
  ),

  // ===== 중급 성악 분기 (intermediate-classical, CL) =====
  'CL-01': Card(
    id: 'CL-01',
    cue: ['올라가며 모음을 살짝 어둡게·둥글게.', '후두 누르기 ❌(모음·공간 조정만).', '진입까지만 — 고음 무리하지 않기.'],
    voicedMicroWin: ['cover 진입 글라이드 5회'],
    anatomyEntry: '중음 사이렌',
    anatomyMain: '패사지오 위 모음 둥글게(진입)',
    anatomyCooldown: '하행 사이렌·SOVT',
    variableAxes: {
      'range': ['중고음(진입 한정)'],
      'glide': ['사이렌'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'CL-02': Card(
    id: 'CL-02',
    cue: ['올라갈수록 /a/를 /ɔ/ 쪽으로 살짝.', '모음 고정한 채 비명 ❌.', '저음에선 과한 조정 ❌.'],
    voicedMicroWin: ['모음 조정 글라이드 5회'],
    anatomyEntry: '편한 모음 1회',
    anatomyMain: 'f0 상승 시 모음 중립화',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'vowel': ['a→ɔ', 'e→ø'],
      'range': ['중고음'],
    },
  ),
  'CL-03': Card(
    id: 'CL-03',
    cue: ['밝되 먹먹하지 않게.', '둥글되 날카롭지 않게.', '두 느낌을 동시에.'],
    voicedMicroWin: ['chiaroscuro 균형 sustain 5초 × 3'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'ring+공간 동시 균형 탐색',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a', 'o', 'e'],
      'range': ['중음', '±2도'],
    },
  ),
  'CL-04': Card(
    id: 'CL-04',
    cue: ['울림이 모이는 지점을 화면으로 관찰.', '2.8–3.2kHz ring 맛보기.', 'placement(어디에 둔다) 식 은유 ❌.'],
    voicedMicroWin: ['ring 인지 sustain 5초 × 3'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: "singer's formant 인지·맛보기",
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
    },
  ),
  'CL-05': Card(
    id: 'CL-05',
    cue: ['음과 음 사이 끊김 없이.', '자음으로 라인 끊지 않기.', '한 호흡 안에서 흐르게.'],
    voicedMicroWin: ['legato 라인 구절 3회'],
    anatomyEntry: '5음 글라이드',
    anatomyMain: '끊김 없는 라인(자음 흐름)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
    },
  ),
  'CL-06': Card(
    id: 'CL-06',
    cue: ['순수 5모음(a·e·i·o·u) 또렷이.', '이중자음 길게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['이탈리아어 구절 딕션 3회'],
    anatomyEntry: '모음 말하기',
    anatomyMain: '순수모음·이중자음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'CL-07': Card(
    id: 'CL-07',
    cue: ['움라우트(ü·ö) 입모양 정확히.', '자음군·종성 또렷이.', '곡과 함께.'],
    voicedMicroWin: ['독일어 구절 딕션 3회'],
    anatomyEntry: '모음 말하기',
    anatomyMain: '움라우트·자음군 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'CL-08': Card(
    id: 'CL-08',
    cue: ['한 음에서 천천히 부풀렸다(약→강) 줄이기(강→약).', '기초만 — 무리한 강세 ❌.', '편한 중음역에서.'],
    voicedMicroWin: ['messa di voce 기초 곡선 3회'],
    anatomyEntry: '편한 음 sustain',
    anatomyMain: '약→강→약 다이내믹 기초',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['편한 중음(기초 한정)'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'CL-09': Card(
    id: 'CL-09',
    cue: ['legit 클래식 구절 맑게·둥글게.', 'legato 유지.', '풀 covered 고음·풀 messa 구절 ❌(고급).'],
    voicedMicroWin: ['아리아/리트 구절 적용 1회'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: 'legit 클래식 구절 적용',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['리트 구절', '쉬운 아리아 구절'],
    },
  ),

  // ===== 중급 가요 분기 (intermediate-gayo, GY) =====
  'GY-01': Card(
    id: 'GY-01',
    cue: ['말하듯 편한 위치에서 시작.', '그대로 노래로 이어가기.', '지르지 않기(마이크가 음량 보완).'],
    voicedMicroWin: ['말→노래 전이 5회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: '말소리 위치→노래 carryover',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'GY-02': Card(
    id: 'GY-02',
    cue: ['이 음에서 이 느낌으로(비율 설명 없이).', '저→고 부드럽게.', '갑자기 두꺼워지거나 얇아지지 않게.'],
    voicedMicroWin: ['믹스 글라이드 5회'],
    anatomyEntry: '가벼운 사이렌',
    anatomyMain: 'M1↔M2 연결(경험으로)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
      'style': ['M1기반', 'M2기반'],
    },
  ),
  'GY-03': Card(
    id: 'GY-03',
    cue: ['립버블(=립 트릴) 일정한 굵기로 5초.', '사이렌(글라이드) 저→고→저 부드럽게.', 'kkook = 짧고 단단하되 짜내지 않기(균형).'],
    voicedMicroWin: ['립버블·사이렌 각 3회'],
    anatomyEntry: '무음 호기 1회',
    anatomyMain: '산업명↔SOVT 워밍업(같은 운동)',
    anatomyCooldown: '빨대 빼고 /u/',
    variableAxes: {
      'range': ['중음', '±3도'],
      'glide': ['사이렌', 'sustain'],
    },
  ),
  'GY-04': Card(
    id: 'GY-04',
    cue: ['마녀 웃음·오리 소리처럼 입 안을 좁혀 밝게.', '콧소리 ❌(구강, 비음 아님).', '짧게 — 고음 지속 ❌.'],
    voicedMicroWin: ['구강 트웽 발성 5회'],
    anatomyEntry: '가벼운 /a/',
    anatomyMain: '구강 AES 협착(밝게)',
    anatomyCooldown: '중립 모음 1회',
    variableAxes: {
      'vowel': ['a', 'e'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-05': Card(
    id: 'GY-05',
    cue: ['부르듯 짧게(call-based).', '밝게 — 크게 아님.', '끊어서, 지속하지 않기.', '조금이라도 아프면 즉시 멈춤.'],
    voicedMicroWin: ['call-based 진입 3회(짧게)'],
    anatomyEntry: '가벼운 call',
    anatomyMain: '라이트 belt 진입만(보수적)',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'range': ['진입 음역 한정'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-06': Card(
    id: 'GY-06',
    cue: ['음을 느리게 정확히 굴리기.', '정확도 먼저, 속도는 나중.', '고음역 무리 런 ❌.'],
    voicedMicroWin: ['느린 런 패턴 3회'],
    anatomyEntry: '느린 3음 패턴',
    anatomyMain: '런 기초 정확도→템포',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'tempo': ['느림', '중간'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-07': Card(
    id: 'GY-07',
    cue: ['평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).', '종성 7대표음 또렷이.', '연음·비음화 자연스럽게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['딕션 적용 구절 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: 'VOT·종성·연음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'GY-08': Card(
    id: 'GY-08',
    cue: ['마이크가 음량 보완 — 과한 자음 타격 불필요.', '또렷하되 편하게.', '모니터·컴프레션 환경 인지.'],
    voicedMicroWin: ['증폭 전제 발성 3회'],
    anatomyEntry: '편한 발성',
    anatomyMain: '증폭 전제 명료도↔효율',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'GY-09': Card(
    id: 'GY-09',
    cue: ['스피치라이크 구절 편하게.', 'belt-진입 구절은 짧고 밝게(크게 ❌).', '풀 belt·고난도 런·고음 지속 구절 ❌(고급).'],
    voicedMicroWin: ['가요 구절 적용 1회(스피치라이크 또는 라이트 belt)'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: '스피치라이크→라이트 belt 구절',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['스피치라이크', '라이트 belt-진입'],
    },
    safetyReview: SafetyReview.pending,
  ),
};

/// I5 — 안전 게이트 대상(safetyReview:pending) 카드 ID 집합.
/// 미사인오프(safetyApproved=false) 시 코스 manifest에서 제외(belt/cover 등 비활성).
Set<String> safetyGatedCardIds() => {
      for (final e in kCardLibrary.entries)
        if (e.value.safetyReview == SafetyReview.pending) e.key,
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
