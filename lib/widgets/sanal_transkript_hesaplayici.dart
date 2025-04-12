import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transkript Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TranskriptSayfasi(),
    );
  }
}

class Ders {
  String ad;
  String not; // Harf notu
  int krediler; // AKTS kredisi

  Ders({
    required this.ad,
    required this.not,
    required this.krediler,
  });
}

double notuPuanlaDonustur(String not) {
  switch (not) {
    case 'AA':
      return 4.0;
    case 'BA':
      return 3.5;
    case 'BB':
      return 3.0;
    case 'CB':
      return 2.5;
    case 'CC':
      return 2.0;
    default:
      return 0.0; // geçerli bir not değilse sıfır
  }
}

double notOrtalamasiHesapla(List<Ders> dersler) {
  double toplamPuanlar = 0.0;
  int toplamKrediler = 0;

  for (var ders in dersler) {
    toplamPuanlar += notuPuanlaDonustur(ders.not) * ders.krediler; // Puan * AKTS
    toplamKrediler += ders.krediler; // Toplam AKTS
  }

  return toplamKrediler == 0 ? 0.0 : toplamPuanlar / toplamKrediler; // Ortalamayı döndür
}

class TranskriptSayfasi extends StatelessWidget {
  final List<Ders> dersler = [
    Ders(ad: 'a', not: 'AA', krediler: 5),
    Ders(ad: 'b', not: 'BA', krediler: 4),
    Ders(ad: 'c', not: 'BB', krediler: 3),
    Ders(ad: 'd', not: 'CB', krediler: 2),
    Ders(ad: 'e', not: 'CC', krediler: 2),
  ];

  @override
  Widget build(BuildContext context) {
    double gpa = notOrtalamasiHesapla(dersler);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transkript Bilgi Sistemi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dersler ve Notlar:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...dersler.map((ders) {
              return Text(
                '${ders.ad}: ${ders.not} (${ders.krediler} AKTS)',
                style: TextStyle(fontSize: 16),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Ağırlıklı Not Ortalamanız: ${gpa.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
