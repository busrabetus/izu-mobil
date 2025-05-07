class ExamResult {
  final String dersAdi;
  final String sinavTuru;
  final String puan;
  final String yuzdelik;

  ExamResult({
    required this.dersAdi,
    required this.sinavTuru,
    required this.puan,
    required this.yuzdelik,
  });

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      dersAdi: json['ders_adi'],
      sinavTuru: json['sinav_turu'],
      puan: json['puan'],
      yuzdelik: json['yuzdelik'],
    );
  }
}
