import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';


class dersprogrami extends StatefulWidget {
  const dersprogrami({super.key});

  @override
  State<dersprogrami> createState() => _dersprogramiState();
}

class _dersprogramiState extends State<dersprogrami> {
  String selectedTerm = '2024-2025 Bahar';

  final Map<String, Map<String, List<Map<String, String>>>> dersProgrami = {
    '2024-2025 Bahar': {
      'Pazartesi': [
        {'saat': '09:00', 'ders': 'Matematik'},
        {'saat': '11:00', 'ders': 'Fizik'},
      ],
      'Salı': [
        {'saat': '10:00', 'ders': 'Kimya'},
        {'saat': '14:00', 'ders': 'Biyoloji'},
      ],
      'Çarşamba': [
        {'saat': '09:00', 'ders': 'Tarih'},
        {'saat': '13:00', 'ders': 'Coğrafya'},
      ],
      'Perşembe': [
        {'saat': '08:30', 'ders': 'İngilizce'},
        {'saat': '15:00', 'ders': 'Edebiyat'},
      ],
      'Cuma': [
        {'saat': '10:00', 'ders': 'Beden Eğitimi'},
        {'saat': '12:00', 'ders': 'Müzik'},
      ],
    },
    '2024-2025 Güz': {
      'Pazartesi': [
        {'saat': '10:00', 'ders': 'Veri Yapıları'},
      ],
      'Çarşamba': [
        {'saat': '14:00', 'ders': 'Programlamaya Giriş'},
      ],
    },
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Haftalık Ders Programı", style: TextStyle(color: Colors.white)),
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
            padding: EdgeInsets.all(9.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dönem Seçiniz",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TermDropdown(
                        terms: dersProgrami.keys.toList(),
                        selectedTerm: selectedTerm,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTerm = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ...dersProgrami[selectedTerm]!.keys.map((day) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      children: dersProgrami[selectedTerm]![day]!.map((lesson) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.0),
                          child: Card(
                            color: Color(0xFFF6F6F6).withOpacity(0.6),
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              title: Text("${lesson['saat']} - ${lesson['ders']}",
                                  style: TextStyle(fontSize: 16, color: Colors.black)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),

    );
  }
}