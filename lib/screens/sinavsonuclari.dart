import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class sinavsonuclari extends StatefulWidget {
  const sinavsonuclari({super.key});

  @override
  State<sinavsonuclari> createState() => _sinavsonuclariState();
}

class _sinavsonuclariState extends State<sinavsonuclari> {
   late String selectedTerm;

  final Map<String, List<Map<String, String>>> dummyResults = {
    "2023-2024 Bahar": [
      {"ders": "Algoritma Analizi", "vize": "70", "final": "50", "harf": "CC"},
      {"ders": "Web Tabanlı Programlama", "vize": "95","final": "100", "harf": "AA"},
      {"ders": "Grafik Programlama", "vize": "80","final": "100", "harf": "AA"},
      {"ders": "Diferansiyel Denklemler", "vize": "87","final": "73", "harf": "BA"},
    ],
    "2024-2025 Güz": [
      {"ders": "İşletim Sistemleri", "vize": "88","final": "100", "harf": "AA"},
      {"ders": "Linux Sistem Yönetimi", "vize": "92","final": "90", "harf": "AA"},
      {"ders": "Yazılım Mimarisi", "vize": "80","final": "90", "harf": "BA"},
    ],
    "2024-2025 Bahar": [
      {"ders": "Sistem Analizi ve Tasarımı", "vize": "85", "final": "90", "harf": "BA"},
      {"ders": "Görüntü İşleme", "vize": "78","final": "80", "harf": "CB"},
      {"ders": "3D Modelleme ve Animasyon", "vize": "90","final": "100", "harf": "AA"},
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedTerm = dummyResults.keys.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Sınav Sonuçları", style: TextStyle(color: Colors.white)),
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
                  "Dönem Seçiniz:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedTerm,
                  items: dummyResults.keys.map((String term) {
                    return DropdownMenuItem<String>(
                      value: term,
                      child: Text(term),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedTerm = newValue;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Sınav Sonuçları:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dummyResults[selectedTerm]?.length ?? 0,
                    itemBuilder: (context, index) {
                      var result = dummyResults[selectedTerm]![index];
                      return Card(
                        child: ListTile(
                          title: Text(result["ders"]!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vize: ${result["vize"]}"),
                              Text("Final: ${result["final"]}"),
                            ],
                          ),
                          trailing: Text(
                            result["harf"]!,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
