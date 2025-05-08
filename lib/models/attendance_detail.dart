class AttendanceDetail {
  final String tarih;
  final int katilimSaati;
  final int toplamSaati;

  AttendanceDetail({
    required this.tarih,
    required this.katilimSaati,
    required this.toplamSaati,
  });

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) {
    return AttendanceDetail(
      tarih: json['devamsizlik_tarihi'],
      katilimSaati: json['katilim_saati'],
      toplamSaati: json['toplam_saati'],
    );
  }
}
