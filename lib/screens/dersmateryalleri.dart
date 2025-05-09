import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/class_materials.dart';
import '../services/api_service.dart';
import 'ders_detay.dart';

class DersMateryalleri extends StatefulWidget {
  const DersMateryalleri({super.key});

  @override
  State<DersMateryalleri> createState() => _DersMateryalleriState();
}

class _DersMateryalleriState extends State<DersMateryalleri> {
  final ApiService apiService = ApiService();

  final Map<String, int> termMap = {
    '2024-2025 - Güz': 10,
    '2024-2025 - Bahar': 11,
  };

  String selectedTerm = '2024-2025 - Bahar';
  late Future<List<ClassMaterial>> materialsFuture;

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

  Color getCourseColor(String dersKodu) {
    final numericPart = dersKodu.runes.fold(0, (sum, char) => sum + char);
    return _colorPalette[numericPart % _colorPalette.length];
  }

  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  void _loadMaterials() {
    if (!termMap.containsKey(selectedTerm)) {
      debugPrint("❌ Seçilen term '$selectedTerm' termMap içinde bulunamadı.");
      return;
    }
    final termId = termMap[selectedTerm]!;
    debugPrint("📥 Term ID gönderiliyor: $termId");
    setState(() {
      materialsFuture = apiService.getClassesMaterial(termId);
    });
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dönem Seçiniz",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TermDropdown(
                      terms: termMap.keys.toList(),
                      selectedTerm: selectedTerm,
                      onChanged: (newValue) {
                        setState(() {
                          selectedTerm = newValue;
                          _loadMaterials();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ClassMaterial>>(
              future: materialsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Hata: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Materyal bulunamadı."));
                }

                final filteredCourses = snapshot.data!
                    .where((course) => course.donemAdi == selectedTerm)
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    final ders = filteredCourses[index];
                    final dersRengi = getCourseColor(ders.dersKodu);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DersDetaySayfasi(
                                dersAdi: ders.dersAdi,
                                dersKodu: ders.dersKodu,
                                akademisyen: ders.hoca,
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
                                    color: dersRengi.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ders.dersKodu,
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
                                        ders.dersAdi,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ders.hoca,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
