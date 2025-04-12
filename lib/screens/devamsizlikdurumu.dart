import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import 'devamsizlikdetay.dart';

class DevamsizlikDurumu extends StatefulWidget {
  const DevamsizlikDurumu({super.key});

  @override
  State<DevamsizlikDurumu> createState() => _DevamsizlikDurumuState();
}

class _DevamsizlikDurumuState extends State<DevamsizlikDurumu> {
  String selectedTerm = '2024-2025 Bahar';

  final Map<String, List<Map<String, dynamic>>> devamsizlikListesi = {
    '2024-2025 Bahar': [
      {
        'ders': 'Algoritmaya Giriş',
        'devamsizlik': 30.33,
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
    ],
    '2024-2025 Güz': [
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
    ],
  };

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
                TermDropdown(
                  terms: devamsizlikListesi.keys.toList(),
                  selectedTerm: selectedTerm,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTerm = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  "Ders Devamsızlık Bilgileri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: devamsizlikListesi[selectedTerm]!.length,
                    itemBuilder: (context, index) {
                      final ders = devamsizlikListesi[selectedTerm]![index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            ders['ders'],
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            "${ders['devamsizlik']} %",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Devamsizlikdetay(
                                  dersAdi: ders['ders'],
                                  detaylar: ders['detaylar'],
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
