import 'package:flutter/material.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import 'package:izukbs/screens/ders_detay.dart';
import 'package:izukbs/drawer.dart';

class DersMateryalleri extends StatefulWidget {
  const DersMateryalleri({super.key});

  @override
  State<DersMateryalleri> createState() => _DersMateryalleriState();
}

class _DersMateryalleriState extends State<DersMateryalleri> {
  String selectedTerm = '2024-2025 Bahar';

  final List<Color> _colorPalette = const [
    Color(0xFF8B2231),
    Color(0xFF2E7D32),
    Color(0xFF1565C0),
    Color(0xFF6A1B9A),
    Color(0xFFEF6C00),
    Color(0xFF00838F),
    Color(0xFFC2185B),
    Color(0xFF5D4037),
    Color(0xFF455A64),
    Color(0xFF7B1FA2),
  ];

  Color getCourseColor(String courseCode) {
    final numericPart =
        int.tryParse(courseCode.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return _colorPalette[numericPart % _colorPalette.length];
  }

  final Map<String, List<Map<String, String>>> dersler = {
    '2024-2025 Bahar': [
      {
        'ad': 'Veri Yapıları',
        'kod': 'BIL101',
        'Akademisyen': 'Volkan Çetin',
      },
      {
        'ad': 'Algoritmalar',
        'kod': 'BIL102',
        'Akademisyen': 'Volkan Çetin',
      },
      {
        'ad': 'Veritabanı Sistemleri',
        'kod': 'BIL103',
        'Akademisyen': 'Volkan Çetin',
      },
      {
        'ad': 'İşletim Sistemleri',
        'kod': 'BIL104',
        'Akademisyen': 'Volkan Çetin',
      },
    ],
    '2024-2025 Güz': [
      {
        'ad': 'Programlamaya Giriş',
        'kod': 'BIL201',
        'Akademisyen': 'Volkan Çetin',
      },
      {
        'ad': 'Web Programlama',
        'kod': 'BIL202',
        'Akademisyen': 'Volkan Çetin',
      },
      {
        'ad': 'Mobil Uygulama Geliştirme',
        'kod': 'BIL203',
        'Akademisyen': 'Volkan Çetin',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Ders Materyalleri"),
      drawer: const drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dönem Seçiniz",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TermDropdown(
                      terms: dersler.keys.toList(),
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
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const BouncingScrollPhysics(),
              itemCount: dersler[selectedTerm]!.length,
              itemBuilder: (context, index) {
                final ders = dersler[selectedTerm]![index];
                final dersRengi = getCourseColor(ders['kod']!);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DersDetaySayfasi(
                            dersAdi: ders['ad']!,
                            dersKodu: ders['kod']!,
                            akademisyen: ders['Akademisyen']!,
                            dersRengi: dersRengi,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: dersRengi.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  ders['kod']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: dersRengi,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ders['ad']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    ders['Akademisyen']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: dersRengi,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}