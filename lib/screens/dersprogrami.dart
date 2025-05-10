import 'package:flutter/material.dart';
import 'package:izukbs/widgets/drawer.dart';
import 'package:izukbs/widgets/term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/course_schedule.dart';
import '../services/api_service.dart';

class DersProgrami extends StatefulWidget {
  const DersProgrami({super.key});

  @override
  State<DersProgrami> createState() => _DersProgramiState();
}

class _DersProgramiState extends State<DersProgrami> {
  final Map<String, int> termMap = {
    '2024-2025 Güz': 10,
    '2024-2025 Bahar': 11,
  };

  final List<String> gunSirasi = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
  ];

  String selectedTerm = '2024-2025 Bahar';

  final Map<String, Color> dayColors = {
    'Pazartesi': Color(0xFF8B2231),
    'Salı': Color(0xFF2E7D32),
    'Çarşamba': Color(0xFF1565C0),
    'Perşembe': Color(0xFF6A1B9A),
    'Cuma': Color(0xFFEF6C00),
    'Cumartesi': Color(0xFF00838F),
  };

  Map<String, List<Map<String, String>>> dersProgramiByGun = {};

  List<CourseSchedule> dersProgrami = [];

  @override
  void initState() {
    super.initState();
    _fetchProgram(termMap[selectedTerm]!);
  }

  void _fetchProgram(int termId) async {
    try {
      final data = await ApiService().getCourseSchedule(termId);
      final Map<String, List<Map<String, String>>> gunluk = {};
      for (var ders in data) {
        final gun = ders.gun;
        gunluk.putIfAbsent(gun, () => []).add({
          'ders': ders.dersAdi,
          'saat': "${ders.baslangicSaati.substring(0, 5)} - ${ders.bitisSaati.substring(0, 5)}",
          'derslik': "${ders.konum} / ${ders.bina}",
        });
      }

      setState(() {
        dersProgrami = data;
        dersProgramiByGun = gunluk;
      });
    } catch (e) {
      print("Hata: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ders programı yüklenemedi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Ders Programı"),
      drawer: drawer(),
      body: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/circles.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TermDropdown(
                  terms: termMap.keys.toList(),
                  selectedTerm: selectedTerm,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTerm = newValue;
                    });
                    _fetchProgram(termMap[newValue]!);
                  },
                ),

                const SizedBox(height: 18),
                ...gunSirasi
                    .where((gun) => dersProgramiByGun.containsKey(gun))
                    .map((day) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.white,
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                          title: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: dayColors[day]!.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    day.substring(0, 1),
                                    style: TextStyle(
                                      color: dayColors[day],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Text(
                                day,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_drop_down,
                            color: dayColors[day],
                            size: 30,
                          ),
                          children: [
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ...dersProgramiByGun[day]!.map((lesson) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: dayColors[day]!.withOpacity(0.2),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: dayColors[day]!.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    leading: Container(
                                      width: 64,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: dayColors[day]!.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        lesson['saat']!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: dayColors[day],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    title: Text(
                                      lesson['ders']!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              lesson['derslik']!,
                                              style: const TextStyle(fontSize: 15, color: Colors.grey),
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
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
