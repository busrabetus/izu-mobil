class Attendance {
  final String dersAdi;
  final double devamsizlikOrani;


  Attendance({required this.dersAdi, required this.devamsizlikOrani});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      dersAdi: json['ders_adi'],
      devamsizlikOrani: double.parse(json['devamsizlik_orani'].toString()),
    );
  }
}
