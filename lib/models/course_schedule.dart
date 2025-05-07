class CourseSchedule {
  final String dersAdi;
  final String dersKodu;
  final String gun;
  final String baslangicSaati;
  final String bitisSaati;
  final String konum;
  final String bina;

  CourseSchedule({
    required this.dersAdi,
    required this.dersKodu,
    required this.gun,
    required this.baslangicSaati,
    required this.bitisSaati,
    required this.konum,
    required this.bina,
  });

  factory CourseSchedule.fromJson(Map<String, dynamic> json) {
    return CourseSchedule(
      dersAdi: json['ders_adi'] ?? '',
      dersKodu: json['ders_kodu'] ?? '',
      gun: json['gun'] ?? '',
      baslangicSaati: json['baslangic_saati'] ?? '',
      bitisSaati: json['bitis_saati'] ?? '',
      konum: json['konum'] ?? '',
      bina: json['bina'] ?? '',
    );
  }
}
