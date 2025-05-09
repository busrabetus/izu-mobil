class StudentInfo {
  final int userId;
  final String ad;
  final String numara;
  final String fakulte;
  final String bolum;
  final String agno;
  final String level;

  StudentInfo({
    required this.userId,
    required this.ad,
    required this.numara,
    required this.fakulte,
    required this.bolum,
    required this.agno,
    required this.level,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      userId: json['user_id'] ?? 0,
      ad: json['student_name'] ?? '',
      numara: json['student_id']?.toString() ?? '',
      fakulte: json['fac_name'] ?? '',
      bolum: json['prog_name'] ?? '',
      agno: json['agno']?.toString() ?? '',
      level: json['level']?.toString() ?? '',
    );
  }
}
