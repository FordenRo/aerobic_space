enum Country { russia, region }

enum AssessmentCategoryType { artistic, execution }

class Referee {
  final int id;
  final String fio;
  final String region;
  final String city;

  Referee({
    required this.id,
    required this.fio,
    required this.region,
    required this.city,
  });
}

class Performance {
  final int id;
  final String region;
  final String city;
  final Country country; // competitionType
  final String title; // competition
  final String ageCategory;
  final String discipline;
  final double assessment;
  final Map<Referee, double> assessments;

  Performance({
    required this.id,
    required this.region,
    required this.city,
    required this.title,
    required this.ageCategory,
    required this.discipline,
    required this.country,
    required this.assessment,
    required this.assessments,
  });
}

class Assessment {
  final int id;
  final double value; // assessment
  final Referee referee;
  final Performance performance;
  final AssessmentCategory category; // type
  final int index;

  Assessment({
    required this.id,
    required this.value,
    required this.referee,
    required this.performance,
    required this.category,
    required this.index,
  }); // number
}

class AssessmentCategory {
  final double assessment;
  final AssessmentCategoryType type;
  final Performance performance;

  AssessmentCategory({
    required this.assessment,
    required this.type,
    required this.performance,
  });
}
