import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import '../models/attendance.dart';
import '../models/attendance_detail.dart';
import '../services/api_service.dart';
import 'devamsizlikdetay.dart';
import 'package:izukbs/widgets/custom_appbar.dart';

class DevamsizlikDurumu extends StatefulWidget {
  const DevamsizlikDurumu({super.key});

  @override
  State<DevamsizlikDurumu> createState() => _DevamsizlikDurumuState();
}

class _DevamsizlikDurumuState extends State<DevamsizlikDurumu> {
  final ApiService apiService = ApiService();
  late Future<List<Attendance>> attendanceFuture;

  final Map<String, int> termMap = {
    '2024-2025 Güz': 10,
    '2024-2025 Bahar': 11,
  };

  String selectedTerm = '2024-2025 Bahar';

  @override
  void initState() {
    super.initState();
    attendanceFuture = apiService.getAttendanceList(termMap[selectedTerm]!);
  }

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

  Color getCourseColor(String dersAdi) {
    final numericPart =
    dersAdi.runes.fold(0, (sum, char) => sum + char); // string -> sayı
    return _colorPalette[numericPart % _colorPalette.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                    horizontal: 16.0, vertical: 8.0),
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
                      terms: termMap.keys.toList(),
                      selectedTerm: selectedTerm,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTerm = newValue;
                          attendanceFuture = apiService.getAttendanceList(
                              termMap[selectedTerm]!);
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
              child: FutureBuilder<List<Attendance>>(
                future: attendanceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Devamsızlık kaydı bulunamadı"));
                  }

                  final dersler = snapshot.data!;

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dersler.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final ders = dersler[index];
                      final color = getCourseColor(ders.dersAdi);

                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          final detayList = await apiService.getAttendanceDetail(
                            className: ders.dersAdi,
                            termId: termMap[selectedTerm]!,
                          );

                          final Map<String, int> detayMap = {
                            for (var d in detayList)
                              d.tarih: d.toplamSaati - d.katilimSaati
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Devamsizlikdetay(
                                dersAdi: ders.dersAdi,
                                termId: termMap[selectedTerm]!,
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
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
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
                                    color: color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ders.dersAdi.substring(0, 3).toUpperCase(),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ders.dersAdi,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      LinearProgressIndicator(
                                        value: ders.devamsizlikOrani / 100,
                                        backgroundColor: color.withOpacity(0.2),
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
                                    color: color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${ders.devamsizlikOrani.toStringAsFixed(1)}%",
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
