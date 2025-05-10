import 'package:flutter/material.dart';
import 'package:izukbs/widgets/drawer.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/transcript.dart';
import '../services/api_service.dart';
import '../widgets/calculategpa.dart';
import '../widgets/term_dropdownbutton.dart';

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
            TermDropdown(
              terms: termMap.keys.toList(),
              selectedTerm: selectedTerm,
              onChanged: (newTerm) {
                setState(() {
                  selectedTerm = newTerm;
                  transcriptFuture = apiService.getTranscript(termMap[selectedTerm]!);
                });
              },
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
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              color: Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                title: Text(
                                  "${course.dersAdi}",
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
