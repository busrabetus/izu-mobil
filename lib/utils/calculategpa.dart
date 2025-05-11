import '../models/transcript.dart';

double calculateGPA(List<TranscriptCourse> courses) {
  double totalPoints = 0;
  double totalCredits = 0;


  const gradePoints = {
    'AA': 4.0, 'BA': 3.5, 'BB': 3.0,
    'CB': 2.5, 'CC': 2.0, 'DC': 1.5,
    'DD': 1.0, 'FD': 0.5, 'FF': 0.0,
  };

  for (var course in courses) {
    final point = gradePoints[course.harfNotu];
    if (point != null) {
      totalPoints += point * course.akts;
      totalCredits += course.akts;
    }
  }


  return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
}