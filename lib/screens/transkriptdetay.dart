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
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: "Dönem Seçiniz ",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedTerm,
                  items: termMap.keys
                      .map((term) => DropdownMenuItem(
                    value: term,
                    child: Text(term),
                  ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedTerm = newValue!;
                      transcriptFuture =
                          apiService.getTranscript(termMap[selectedTerm]!);
                    });
                  },
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
                        child: Text("Bu döneme ait transkript bulunamadı."));
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
                            harfNotu:
                            modifiedGrades[index] ?? original.harfNotu,
                            donemAdi: original.donemAdi,
                          );
                        },
                      ));

                      return ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "AGNO: ${dynamicGpa.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B2231),
                              ),
                            ),
                          ),
                          ...courses.asMap().entries.map((entry) {
                            final index = entry.key;
                            final course = entry.value;

                            return Card(
                              color: Colors.white,
                              margin:
                              const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(course.dersAdi),
                                subtitle: Text("${course.akts} AKTS"),
                                trailing: DropdownButton<String>(
                                  value: modifiedGrades[index] ??
                                      course.harfNotu,
                                  items: const [
                                    'AA',
                                    'BA',
                                    'BB',
                                    'CB',
                                    'CC',
                                    'DC',
                                    'DD',
                                    'FD',
                                    'FF'
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
