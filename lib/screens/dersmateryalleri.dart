import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';

class DersMateryalleri extends StatefulWidget {
  const DersMateryalleri({super.key});

  @override
  State<DersMateryalleri> createState() => _DersMateryalleriState();
}

class _DersMateryalleriState extends State<DersMateryalleri> {
  String selectedTerm = '2024-2025 Bahar';

  final Map<String, List<String>> dersler = {
    '2024-2025 Bahar': [
      'Veri Yapıları',
      'Algoritmalar',
      'Veritabanı Sistemleri',
      'İşletim Sistemleri',
    ],
    '2024-2025 Güz': [
      'Programlamaya Giriş',
      'Web Programlama',
      'Mobil Uygulama Geliştirme',
    ],
  };

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TermDropdown(
              terms: dersler.keys.toList(),
              selectedTerm: selectedTerm,
              onChanged: (newValue) {
                setState(() {
                  selectedTerm = newValue;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dersler[selectedTerm]!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(dersler[selectedTerm]![index]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DersDetaySayfasi(
                              dersAdi: dersler[selectedTerm]![index],
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
        backgroundColor: Color(0xFF8B2231),
        title: const Text("Ders Materyalleri", style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
