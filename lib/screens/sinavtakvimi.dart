import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class sinavtakvimi extends StatefulWidget {
  const sinavtakvimi({super.key});

  @override
  State<sinavtakvimi> createState() => _sinavtakvimiState();
}

class _sinavtakvimiState extends State<sinavtakvimi> {
  late String selectedTerm;

  final Map<String, List<Map<String, String>>> dummyResults = {
    "2023-2024 Bahar": [
      {"ders": "Algoritma Analizi", "sinavturu": "Vize", "tarih": "07.04.2025","saat": "11:30", "derslik": "	Eğitim Bilimleri - EGB01 - Molla Gürânî Konferans Salonu"},
      {"ders": "Web Tabanlı Programlama", "sinavturu": "Vize","tarih": "08.04.2025","saat": "13:30", "derslik": "Eğitim Bilimleri - EGC16 - Açık Kaynak ve Özgür Yazılım Laboratuvarı"},
      {"ders": "Grafik Programlama", "sinavturu": "Vize","tarih": "09.04.2025","saat": "09:30", "derslik": "Merkezi Derslikler - MD005"},
      {"ders": "Diferansiyel Denklemler", "sinavturu": "Vize","tarih": "10.04.2025","saat": "12:00", "derslik": "Merkezi Derslikler - MD008"},
    ],
    "2024-2025 Güz": [
      {"ders": "İşletim Sistemleri", "sinavturu": "Vize","tarih": "07.04.2025","saat": "11:30", "derslik": "Eğitim Bilimleri - EGC16 - Açık Kaynak ve Özgür Yazılım Laboratuvarı"},
      {"ders": "Linux Sistem Yönetimi", "sinavturu": "Vize","tarih": "08.04.2025","saat": "12:30", "derslik": "	Eğitim Bilimleri - EGB01 - Molla Gürânî Konferans Salonu"},
      {"ders": "Yazılım Mimarisi", "sinavturu": "Vize","tarih": "09.04.2025", "saat": "09:00","derslik": "Merkezi Derslikler - MD005	"},
    ],
    "2024-2025 Bahar": [
      {"ders": "Sistem Analizi ve Tasarımı", "sinavturu": "Vize", "tarih": "07.04.2025","saat": "11:30", "derslik": "Merkezi Derslikler - MD005	"},
      {"ders": "Görüntü İşleme", "sinavturu": "Vize","tarih": "08.04.2025","saat": "10:30", "derslik": "Eğitim Bilimleri - EGC16 - Açık Kaynak ve Özgür Yazılım Laboratuvarı"},
      {"ders": "3D Modelleme ve Animasyon", "sinavturu": "Vize","tarih": "09.04.2025","saat": "14:30", "derslik": "	Eğitim Bilimleri - EGB01 - Molla Gürânî Konferans Salonu"},
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
      backgroundColor:  Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Sınav Takvimi", style: TextStyle(color: Colors.white)),
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
                    Text("Dönem Seçiniz: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    DropdownButton<String>(
                        value: selectedTerm,
                        items: dummyResults.keys.map((String term){
                          return DropdownMenuItem<String>(
                          value: term,
                          child: Text(term),
                          );
                    }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null){
                            setState(() {
                              selectedTerm = newValue;
                            });
                          }
                        }
                    ),
                    SizedBox(height: 20,),
                    Text("Sınav Takvimi", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),),
                    Expanded(
                        child: ListView.builder(
                          itemCount: dummyResults[selectedTerm]?.length ?? 0,
                          itemBuilder: (context, index) {
                            var result = dummyResults[selectedTerm]![index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  result["ders"]!,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      result["sinavturu"]!,
                                      textAlign: TextAlign.center, // Ortalamak için
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Text(
                                        result["tarih"]!,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result["saat"]!,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        result["derslik"]!,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                          },
                        )
                    )
                  ],
                )
              )




            ]
        )
    );
  }
}
