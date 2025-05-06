class StudentInfo {
  final String studentId;
  final String classId;
  final String ad;
  final String fakulte;
  final String bolum;
  final String sinif;
  final String agno;

  StudentInfo({
    required this.studentId,
    required this.classId,
    required this.ad,
    required this.fakulte,
    required this.bolum,
    required this.sinif,
    required this.agno,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      studentId: json['student_id']?.toString() ?? '',
      classId: json['class_id']?.toString() ?? '',
      ad: json['student_name'] ?? '',
      fakulte: json['fac_name'] ?? '',
      bolum: json['prog_name'] ?? '',
      sinif: json['sinif']?.toString() ?? '',
      agno: json['agno']?.toString() ?? '',
    );
  }
}
