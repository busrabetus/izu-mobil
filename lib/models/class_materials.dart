class ClassMaterial {
  final String dersKodu;
  final String dersAdi;
  final String hoca;
  final String donemAdi;

  ClassMaterial({
    required this.dersKodu,
    required this.dersAdi,
    required this.hoca,
    required this.donemAdi,
  });

  factory ClassMaterial.fromJson(Map<String, dynamic> json) {
    return ClassMaterial(
      dersKodu: json['ders_kodu'],
      dersAdi: json['ders_adi'],
      hoca: json['hoca'],
      donemAdi: json['donem_adi'],
    );
  }
}
