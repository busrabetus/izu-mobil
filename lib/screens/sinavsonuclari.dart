import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import '../term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';

class sinavsonuclari extends StatefulWidget {
  const sinavsonuclari({super.key});

  @override
  State<sinavsonuclari> createState() => _sinavsonuclariState();
}

class _sinavsonuclariState extends State<sinavsonuclari> {
  late String selectedTerm;

  final Map<String, List<Map<String, String>>> sinavSonuclari = {
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
      {"ders": "3D Modelleme ve Animasyon", "vize": "90","final": "100", "harf": "AA"},
    ],
  };

  @override
  void initState() {
    super.initState();
    selectedTerm = sinavSonuclari.keys.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: const CustomAppBar(title: "Sınav Sonuçları"),
      drawer: drawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dönem Seçiniz",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TermDropdown(
                  terms: sinavSonuclari.keys.toList(),
                  selectedTerm: selectedTerm,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTerm = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Sınav Sonuçları:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sinavSonuclari[selectedTerm]?.length ?? 0,
                    itemBuilder: (context, index) {
                      var result = sinavSonuclari[selectedTerm]![index];
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