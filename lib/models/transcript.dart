class TranscriptCourse {
  final String donemAdi;
  final String dersAdi;
  final double akts;
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
      akts: double.tryParse(json['akts'].toString()) ?? 0,
      harfNotu: json['harf_notu'],
    );
  }
}
