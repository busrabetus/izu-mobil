import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class DersMateryalleri extends StatefulWidget {
  const DersMateryalleri({super.key});

  @override
  State<DersMateryalleri> createState() => _DersMateryalleriState();
}

class _DersMateryalleriState extends State<DersMateryalleri> {
  // Örnek ders listesi
  final List<String> dersler = [
    "Veri Yapıları",
    "Algoritmalar",
    "Veritabanı Sistemleri",
    "İşletim Sistemleri"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: const Text("Ders Materyalleri", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const drawer(),
      body: ListView.builder(
        itemCount: dersler.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(dersler[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DersDetaySayfasi(dersAdi: dersler[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DersDetaySayfasi extends StatelessWidget {
  final String dersAdi;

  const DersDetaySayfasi({super.key, required this.dersAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dersAdi),
        backgroundColor: Color(0xFF8B2231),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          "Bu ders için henüz materyal bulunmamaktadır.",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
