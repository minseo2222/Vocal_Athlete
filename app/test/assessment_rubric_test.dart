import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/assessment/assessment_rubric.dart';

void main() {
  test('v5 portfolio readiness rubric covers core singer outcomes', () {
    final domains = {for (final c in kPortfolioReadinessRubric) c.domain};
    expect(domains.contains(AssessmentDomain.pitch), isTrue);
    expect(domains.contains(AssessmentDomain.rhythm), isTrue);
    expect(domains.contains(AssessmentDomain.timbre), isTrue);
    expect(domains.contains(AssessmentDomain.recording), isTrue);
    expect(criteriaForDomain(AssessmentDomain.safety), isNotEmpty);
  });
}
