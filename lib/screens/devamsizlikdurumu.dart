import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import 'devamsizlikdetay.dart';
import 'package:izukbs/widgets/custom_appbar.dart';

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
        'kod': 'BIL101',
        'devamsizlik': 30.33,
        'detaylar': {
          '31/03/2025': 2,
        }
      },
      {
        'ders': 'Diferansiyel Denklemler',
        'kod': 'Mat202',
        'devamsizlik': 100,
        'detaylar': {
          '31/03/2025': 2,
        }
      },
      {
        'ders': 'Yapay Zeka',
        'kod': 'BIL102',
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
        'kod': 'BIL103',
        'devamsizlik': 76.33,
        'detaylar': {
          '15/03/2025': 2,
          '22/03/2025': 2,
          '29/03/2025': 0,
        }
      },
      {
        'ders': 'Üniversiteyi Anlamak',
        'kod': 'BIL104',
        'devamsizlik': 65.33,
        'detaylar': {
          '15/03/2025': 0,
          '22/03/2025': 1,
          '29/03/2025': 1,
        }
      },
    ],
  };

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: const CustomAppBar(title: "Devamsızlık Durumu"),
      drawer: const drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
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
                    const Text(
                      "Dönem Seçiniz",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TermDropdown(
                      terms: devamsizlikListesi.keys.toList(),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Ders Devamsızlık Oranları",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: devamsizlikListesi[selectedTerm]!.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ders = devamsizlikListesi[selectedTerm]![index];
                  final percentage = ders['devamsizlik'];
                  final color = getCourseColor(ders['kod']);

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
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
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  ders['kod'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: color,
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
                                    ders['ders'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: percentage / 100,
                                    backgroundColor: color.withValues(alpha: 0.2),
                                    color: color,
                                    minHeight: 6,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${percentage.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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