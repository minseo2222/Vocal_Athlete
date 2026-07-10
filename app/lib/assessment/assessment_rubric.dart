/// v5 — 레벨 인증/포트폴리오용 평가 루브릭.
///
/// 매일 진행은 계속 completion 기반이다. 이 루브릭은 “실력이 늘었다”를
/// 녹음 산출물로 확인하는 선택형 체크포인트에만 사용한다.
library;

enum AssessmentDomain {
  pitch,
  rhythm,
  breath,
  phonation,
  timbre,
  diction,
  phrase,
  expression,
  recording,
  safety,
}

class AssessmentCriterion {
  const AssessmentCriterion({
    required this.domain,
    required this.label,
    required this.evidence,
  });

  final AssessmentDomain domain;
  final String label;
  final String evidence;
}

const kPortfolioReadinessRubric = <AssessmentCriterion>[
  AssessmentCriterion(
    domain: AssessmentDomain.pitch,
    label: '짧은 프레이즈 음정 유지',
    evidence: '4마디 녹음에서 시작음·도착음이 크게 흔들리지 않는다.',
  ),
  AssessmentCriterion(
    domain: AssessmentDomain.rhythm,
    label: '반주 안 타이밍',
    evidence: '쉼표 뒤 진입과 자음 timing이 반주에서 크게 벗어나지 않는다.',
  ),
  AssessmentCriterion(
    domain: AssessmentDomain.timbre,
    label: '목표 음색 재현',
    evidence: 'clean/warm/speech-like 중 선택한 tone tag를 같은 구절에서 반복한다.',
  ),
  AssessmentCriterion(
    domain: AssessmentDomain.phrase,
    label: '호흡·프레이즈 연결',
    evidence: 'phrase 끝을 밀어내지 않고 남기고 끝낸다.',
  ),
  AssessmentCriterion(
    domain: AssessmentDomain.recording,
    label: 'A/B 자기 수정',
    evidence: '두 take를 듣고 best take와 다음 cue를 스스로 선택한다.',
  ),
  AssessmentCriterion(
    domain: AssessmentDomain.safety,
    label: '목 상태 기반 조절',
    evidence: '피곤/쉰 느낌일 때 light/recovery mode를 선택한다.',
  ),
];

List<AssessmentCriterion> criteriaForDomain(AssessmentDomain domain) => [
      for (final c in kPortfolioReadinessRubric)
        if (c.domain == domain) c,
    ];
