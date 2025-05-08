import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/transcript.dart';
import '../services/api_service.dart';

class transkript extends StatefulWidget {
  const transkript({super.key});

  @override
  State<transkript> createState() => _TranskriptState();
}

class _TranskriptState extends State<transkript> {
  final ApiService apiService = ApiService();
  bool isLoading = false;

  String selectedTerm = "10"; // Başlangıçta 2024-2025 Güz
  List<TranscriptCourse> transcriptCourses = [];

  // term_id → donem_adi eşleşmesini sağlayacak
  final Map<String, String> termMap = {
    "2024-2025 - Güz": "10",
    "2024-2025 - Bahar": "11",
  };

  @override
  void initState() {
    super.initState();
    fetchTranscript(selectedTerm);
  }

  Future<void> fetchTranscript(String termId) async {
    setState(() {
      isLoading = true;
    });

    try {
      transcriptCourses = await apiService.getTranscript(termId);
    } catch (e) {
      print("Transkript verisi alınamadı: $e");
      transcriptCourses = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculateGPA(List<TranscriptCourse> filteredCourses) {
    double totalPoints = 0;
    double totalCredits = 0;

    const gradePoints = {
      'AA': 4.0,
      'BA': 3.5,
      'BB': 3.0,
      'CB': 2.5,
      'CC': 2.0,
      'DC': 1.5,
      'DD': 1.0,
      'FD': 0.5,
      'FF': 0.0,
    };

    for (var course in filteredCourses) {
      final point = gradePoints[course.harfNotu];
      if (point != null) {
        totalPoints += point * course.akts;
        totalCredits += course.akts;
      }
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    // term_id'ye karşılık gelen dönem adını bul
    String selectedDonemAdi = termMap.entries
        .firstWhere((entry) => entry.value == selectedTerm)
        .key;

    // Sadece seçilen dönemin derslerini filtrele
    final filteredCourses = transcriptCourses
        .where((course) => course.donemAdi == selectedDonemAdi)
        .toList();

    final gpa = calculateGPA(filteredCourses);

    return Scaffold(
      appBar: const CustomAppBar(title: "Transkript"),
      drawer: drawer(),
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              value: selectedTerm,
              decoration: const InputDecoration(
                labelText: "Dönem Seçiniz",
                border: OutlineInputBorder(),
              ),
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
                  fetchTranscript(newValue);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AGNO:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B2231),
                  ),
                ),
                Text(
                  gpa.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B2231),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredCourses.isEmpty
                ? const Center(child: Text("Bu döneme ait ders yok."))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(course.dersAdi),
                    subtitle: Text('${course.akts} AKTS'),
                    trailing: Text(
                      course.harfNotu,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
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