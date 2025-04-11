import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'devamsizlikdurumu.dart';

class Devamsizlikdetay extends StatelessWidget {
  final String dersAdi;
  final Map<String, int> detaylar;

  const Devamsizlikdetay({
    super.key,
    required this.dersAdi,
    required this.detaylar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Devamsızlık Durumu", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: detaylar.length,
                    itemBuilder: (context, index) {
                      String tarih = detaylar.keys.elementAt(index);
                      int saat = detaylar[tarih]!;
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                              "Tarih: $tarih",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            "Ders Saati: $saat",
                            style: const TextStyle(fontSize:13,fontWeight: FontWeight.bold),
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
