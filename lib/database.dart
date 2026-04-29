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
  final String country; // competitionType
  final String title; // competition
  final String ageCategory;
  final String discipline;

  Performance({
    required this.id,
    required this.region,
    required this.city,
    required this.title,
    required this.ageCategory,
    required this.discipline,
    required this.country,
  });
}

class Assessment {
  final int id;
  final double value; // assessment
  final int refereeId;
  final int performanceId;
  final String category; // type
  final int index;

  Assessment({
    required this.id,
    required this.value,
    required this.refereeId,
    required this.performanceId,
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

Iterable<Referee> loadReferees(String data) => data.split('\n').map((e) {
  final [id, fio, region, city] = e.split(',');
  return Referee(id: int.parse(id), fio: fio, region: region, city: city);
});

Iterable<Performance> loadPerformances(String data) =>
    data.split('\n').map((e) {
      final [id, region, city, country, title, ageCategory, discipline] = e
          .split(',');
      return Performance(
        id: int.parse(id),
        region: region,
        city: city,
        title: title,
        ageCategory: ageCategory,
        discipline: discipline,
        country: country,
      );
    });

Iterable<Assessment> loadAssessments(String data) => data.split('\n').map((e) {
  final [
    id,
    refereeId,
    performanceId,
    category,
    index,
    value,
    categoryResult,
    performanceResult,
  ] = e.split(
    ',',
  );
  return Assessment(
    id: int.parse(id),
    value: double.parse(value),
    refereeId: int.parse(refereeId),
    performanceId: int.parse(performanceId),
    category: category,
    index: int.parse(index),
  );
});
