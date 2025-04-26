import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';

class sinavtakvimi extends StatefulWidget {
  const sinavtakvimi({super.key});

  @override
  State<sinavtakvimi> createState() => _sinavtakvimiState();
}

class _sinavtakvimiState extends State<sinavtakvimi> {
  late String selectedTerm;

  final Map<String, List<Map<String, String>>> sinavTakvimi = {
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
    selectedTerm = sinavTakvimi.keys.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Color(0xFFF0F0F0),
        appBar: const CustomAppBar(title: "Sınav Takvimi"),
        drawer: drawer(),
        body: Stack(
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
                        terms: sinavTakvimi.keys.toList(),
                        selectedTerm: selectedTerm,
                        onChanged: (newValue) {
                          setState(() {
                            selectedTerm = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 20,),
                      Text("Sınav Takvimi", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),),
                      Expanded(
                          child: ListView.builder(
                            itemCount: sinavTakvimi[selectedTerm]?.length ?? 0,
                            itemBuilder: (context, index) {
                              var result = sinavTakvimi[selectedTerm]![index];
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
                                        textAlign: TextAlign.center,
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