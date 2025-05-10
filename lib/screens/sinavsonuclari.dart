import 'package:flutter/material.dart';
import 'package:izukbs/widgets/drawer.dart';
import '../widgets/custom_appbar.dart';
import '../services/api_service.dart';
import '../models/exam_results.dart';
import '../widgets/term_dropdownbutton.dart';

class sinavsonuclari extends StatefulWidget {
  const sinavsonuclari({super.key});

  @override
  State<sinavsonuclari> createState() => _sinavsonuclariState();
}

class _sinavsonuclariState extends State<sinavsonuclari> {
  final ApiService apiService = ApiService();
  String selectedTerm = "10";
  bool isLoading = false;

  List<ExamResult> rawResults = [];
  Map<String, List<ExamResult>> groupedResults = {};

  final Map<String, String> termMap = {
    "2024-2025 Güz": "10",
    "2024-2025 Bahar": "11",
  };

  @override
  void initState() {
    super.initState();
    fetchExamResults();
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }


  Future<void> fetchExamResults() async {
    setState(() {
      isLoading = true;
    });

    try {
      rawResults = await apiService.getExamResults(selectedTerm);
      groupResultsByCourse();
    } catch (e) {
      print("Hata: $e");
      rawResults = [];
      groupedResults = {};
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void groupResultsByCourse() {
    groupedResults.clear();

    for (var result in rawResults) {
      String dersAdi = result.dersAdi;
      if (!groupedResults.containsKey(dersAdi)) {
        groupedResults[dersAdi] = [];
      }
      groupedResults[dersAdi]!.add(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Sınav Sonuçları"),
      drawer: drawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TermDropdown(
              terms: termMap.keys.toList(),
              selectedTerm: termMap.entries.firstWhere((e) => e.value == selectedTerm).key,
              onChanged: (newKey) {
                setState(() {
                  selectedTerm = termMap[newKey]!; // String -> int dönüşüm
                });
                fetchExamResults();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "📚 Ders Listesi",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 8),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : groupedResults.isEmpty
                  ? const Center(
                child: Text(
                  "🧐 Sonuç bulunamadı.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: groupedResults.length,
                itemBuilder: (context, index) {
                  String dersAdi =
                  groupedResults.keys.elementAt(index);
                  List<ExamResult> sinavlar =
                  groupedResults[dersAdi]!;

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ExpansionTile(
                      title: Text(
                        "📖 $dersAdi",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      children: sinavlar.map((sinav) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF0F0F0),
                            ),
                            child: ListTile(
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              title: Text(
                                "${capitalize(sinav.sinavTuru)}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              trailing: Text(
                                "🎯 ${sinav.puan} | %${sinav.yuzdelik}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
