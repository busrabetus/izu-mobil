import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class DevamsizlikDurumu extends StatefulWidget {
  const DevamsizlikDurumu({super.key});

  @override
  State<DevamsizlikDurumu> createState() => _DevamsizlikDurumuState();
}

class _DevamsizlikDurumuState extends State<DevamsizlikDurumu> {
  final List<Map<String, dynamic>> devamsizlikListesi = [
    {
      'ders': 'Algoritmaya Giriş',
      'devamsizlik': 30,
      'detaylar': {
        '15/03/2025': 0,
        '22/03/2025': 2,
        '29/03/2025': 2,
      }
    },
    {
      'ders': 'Yapay Zeka',
      'devamsizlik': 69.88,
      'detaylar': {
        '15/03/2025': 1,
        '22/03/2025': 0,
        '29/03/2025': 2,
      }
    },
    {
      'ders': 'Programlamaya Giriş',
      'devamsizlik': 76.33,
      'detaylar': {
        '15/03/2025': 2,
        '22/03/2025': 2,
        '29/03/2025': 0,
      }
    },
    {
      'ders': 'Üniversiteyi Anlamak',
      'devamsizlik': 65.33,
      'detaylar': {
        '15/03/2025': 0,
        '22/03/2025': 1,
        '29/03/2025': 1,
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Devamsızlık Durumu", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: drawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/circles.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ders Devamsızlık Bilgileri",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: devamsizlikListesi.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(devamsizlikListesi[index]['ders']),
                          trailing: Text(
                            "${devamsizlikListesi[index]['devamsizlik']} %",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DersDetaySayfasi(
                                  dersAdi: devamsizlikListesi[index]['ders'],
                                  detaylar: devamsizlikListesi[index]['detaylar'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DersDetaySayfasi extends StatelessWidget {
  final String dersAdi;
  final Map<String, int> detaylar;

  const DersDetaySayfasi({
    required this.dersAdi,
    required this.detaylar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        title: Text(dersAdi),
        backgroundColor: Color(0xFF8B2231),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/circles.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$dersAdi Dersine Katılım Detayları",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: detaylar.length,
                    itemBuilder: (context, index) {
                      String tarih = detaylar.keys.elementAt(index);
                      int saat = detaylar[tarih]!;
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text("Tarih: $tarih"),
                          trailing: Text(
                            "Ders Saati: $saat",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}