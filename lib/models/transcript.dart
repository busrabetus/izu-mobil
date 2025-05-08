class TranscriptCourse {
  final String donemAdi;
  final String dersAdi;
  final double akts; // 🔁 String yerine double kullandık
  final String harfNotu;

  TranscriptCourse({
    required this.donemAdi,
    required this.dersAdi,
    required this.akts,
    required this.harfNotu,
  });

  factory TranscriptCourse.fromJson(Map<String, dynamic> json) {
    return TranscriptCourse(
      donemAdi: json['donem_adi'],
      dersAdi: json['ders_adi'],
      akts: double.parse(json['akts'].toString()), // 🔁 dönüşüm burada
      harfNotu: json['harf_notu'],
    );
  }
}
