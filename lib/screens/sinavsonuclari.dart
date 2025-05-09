import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import '../widgets/custom_appbar.dart';
import '../services/api_service.dart';
import '../models/exam_results.dart';

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
    "2023-2024 Bahar": "8",
    "2024-2025 Güz": "10",
    "2024-2025 Bahar": "11",
  };

  @override
  void initState() {
    super.initState();
    fetchExamResults();
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
      backgroundColor: Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dönem Seçiniz",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedTerm,
              isExpanded: true,
              items: termMap.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedTerm = newValue;
                  });
                  fetchExamResults();
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Sınav Sonuçları:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : groupedResults.isEmpty
                  ? const Center(child: Text("Sonuç bulunamadı."))
                  : ListView.builder(
                itemCount: groupedResults.length,
                itemBuilder: (context, index) {
                  String dersAdi = groupedResults.keys.elementAt(index);
                  List<ExamResult> sinavlar = groupedResults[dersAdi]!;

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dersAdi,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...sinavlar.map((sinav) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sınav: ${sinav.sinavTuru}"),
                                  Text("Puan: ${sinav.puan}  |  %${sinav.yuzdelik}"),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
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
