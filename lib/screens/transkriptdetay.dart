import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/transcript.dart';
import '../services/api_service.dart';

class transkriptdetay extends StatefulWidget {
  const transkriptdetay({super.key});

  @override
  State<transkriptdetay> createState() => _TranskriptPageState();
}

class _TranskriptPageState extends State<transkriptdetay> {
  final ApiService apiService = ApiService();

  final Map<String, int> termMap = {
    "2024-2025 - Güz": 10,
    "2024-2025 - Bahar": 11,
  };

  String selectedTerm = "2024-2025 - Bahar";
  late Future<List<TranscriptCourse>> transcriptFuture;

  @override
  void initState() {
    super.initState();
    transcriptFuture = apiService.getTranscript(termMap[selectedTerm]!);
  }

  double calculateGPA(List<TranscriptCourse> courses) {
    double totalPoints = 0;
    double totalCredits = 0;

    const gradePoints = {
      'AA': 4.0, 'BA': 3.5, 'BB': 3.0,
      'CB': 2.5, 'CC': 2.0, 'DC': 1.5,
      'DD': 1.0, 'FD': 0.5, 'FF': 0.0,
    };

    for (var course in courses) {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Transkript (Sanal)"),
      drawer: const drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "📅 Dönem Seçiniz",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: selectedTerm,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      items: termMap.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.key),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedTerm = newValue;
                            transcriptFuture = apiService.getTranscript(termMap[selectedTerm]!);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<TranscriptCourse>>(
                future: transcriptFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("📭 Bu döneme ait transkript bulunamadı."),
                    );
                  }

                  final courses = snapshot.data!;
                  final modifiedGrades = <int, String>{};

                  return StatefulBuilder(
                    builder: (context, setInnerState) {
                      double dynamicGpa = calculateGPA(List.generate(
                        courses.length,
                            (index) {
                          final original = courses[index];
                          return TranscriptCourse(
                            dersAdi: original.dersAdi,
                            akts: original.akts,
                            harfNotu: modifiedGrades[index] ?? original.harfNotu,
                            donemAdi: original.donemAdi,
                          );
                        },
                      ));

                      return ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDAD8D8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "AGNO: ${dynamicGpa.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                          ),
                          ...courses.asMap().entries.map((entry) {
                            final index = entry.key;
                            final course = entry.value;

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              color: Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                title: Text(
                                  "📘 ${course.dersAdi}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "${course.akts} AKTS",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: DropdownButton<String>(
                                  value: modifiedGrades[index] ?? course.harfNotu,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                  underline: Container(height: 1, color: Colors.grey),
                                  items: const [
                                    'AA', 'BA', 'BB', 'CB', 'CC',
                                    'DC', 'DD', 'FD', 'FF'
                                  ].map((grade) {
                                    return DropdownMenuItem(
                                      value: grade,
                                      child: Text(grade),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setInnerState(() {
                                      modifiedGrades[index] = newValue!;
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
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
