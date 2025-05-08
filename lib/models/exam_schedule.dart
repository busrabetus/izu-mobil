class ExamSchedule {
  final String dersAdi;
  final String sinavTuru;
  final String sinavTarihi;
  final String baslangicSaati;
  final String bitisSaati;
  final String sinavKonumu;

  ExamSchedule({
    required this.dersAdi,
    required this.sinavTuru,
    required this.sinavTarihi,
    required this.baslangicSaati,
    required this.bitisSaati,
    required this.sinavKonumu,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      dersAdi: json['ders_adi'],
      sinavTuru: json['sinav_turu'],
      sinavTarihi: json['sinav_tarihi'],
      baslangicSaati: json['baslangic_saati'],
      bitisSaati: json['bitis_saati'],
      sinavKonumu: json['sinav_konumu'],
    );
  }
}
