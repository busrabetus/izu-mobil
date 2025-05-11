import 'package:flutter/material.dart';
import 'package:izukbs/widgets/drawer.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/transcript.dart';
import '../services/api_service.dart';
import '../utils/calculategpa.dart';
import '../widgets/term_dropdownbutton.dart';
import 'package:izukbs/utils/chechtoken.dart';

class Transkript extends StatefulWidget {
  const Transkript({super.key});

  @override
  State<Transkript> createState() => _TranskriptPageState();
}

class _TranskriptPageState extends State<Transkript> {
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
    checkTokenAndRedirect(context);
  }

  void updateTranscript(String newTerm) {
    setState(() {
      selectedTerm = newTerm;
      transcriptFuture = apiService.getTranscript(termMap[selectedTerm]!);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Transkript"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TermDropdown(
              terms: termMap.keys.toList(),
              selectedTerm: selectedTerm,
              onChanged: updateTranscript,
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
                    return const Center(child: Text("Bu döneme ait transkript bulunamadı."));
                  }

                  final courses = snapshot.data!;
                  final gpa = calculateGPA(courses);

                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "AGNO: ${gpa.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B2231),
                          ),
                        ),
                      ),
                      ...courses.map((course) => Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(course.dersAdi),
                          subtitle: Text("${course.akts} AKTS"),
                          trailing: Text(
                            course.harfNotu,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )),
                    ],
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
