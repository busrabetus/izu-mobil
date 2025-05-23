import 'package:flutter/material.dart';
import 'package:izukbs/widgets/drawer.dart';
import 'package:izukbs/widgets/term_dropdownbutton.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../models/exam_schedule.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:izukbs/utils/chechtoken.dart';


class SinavTakvimi extends StatefulWidget {
  const SinavTakvimi({super.key});

  @override
  State<SinavTakvimi> createState() => _SinavTakvimiState();
}

class _SinavTakvimiState extends State<SinavTakvimi> {
  final ApiService apiService = ApiService();
  String selectedTerm = '2024-2025 Bahar';
  bool isLoading = false;

  final Map<String, int> termMap = {
    '2024-2025 Güz': 10,
    '2024-2025 Bahar': 11,
  };

  List<ExamSchedule> examList = [];

  String formatDate(String rawDate) {
    final DateTime parsedDate = DateTime.parse(rawDate);
    return DateFormat('dd.MM.yyyy').format(parsedDate);
  }

  String formatTime(String rawTime) {
    final DateTime parsedTime = DateFormat("HH:mm:ss").parse(rawTime);
    return DateFormat("HH:mm").format(parsedTime);
  }

  @override
  void initState() {
    super.initState();
    fetchExamSchedule(termMap[selectedTerm]!);
    checkTokenAndRedirect(context);

  }

  Future<void> fetchExamSchedule(int termId) async {
    setState(() => isLoading = true);
    try {
      final exams = await apiService.getExamScheduleList(termId);
      setState(() {
        examList = exams;
        isLoading = false;
      });
    } catch (e) {
      print("Sınav takvimi alınamadı: $e");
      setState(() => isLoading = false);
    }
  }

  Widget buildExamCard(ExamSchedule exam) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Text(
          exam.dersAdi,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 ${formatDate(exam.sinavTarihi)}"),
            Text("🕒 ${formatTime(exam.baslangicSaati)} - ${formatTime(exam.bitisSaati)}"),
            Text("📍 ${exam.sinavKonumu}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vizeler = examList.where((e) => e.sinavTuru.toLowerCase() == 'vize').toList();
    final finaller = examList.where((e) => e.sinavTuru.toLowerCase() == 'final').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Sınav Takvimi"),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TermDropdown(
                terms: termMap.keys.toList(),
                selectedTerm: selectedTerm,
                onChanged: (newTerm) {
                  setState(() {
                    selectedTerm = newTerm;
                  });
                  fetchExamSchedule(termMap[newTerm]!);
                },
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(child: CircularProgressIndicator()),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (vizeler.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 4),
                      child: Text("📘 Vizeler",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    ...vizeler.map(buildExamCard).toList(),
                  ],
                  if (finaller.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 4),
                      child: Text("📕 Finaller",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    ...finaller.map(buildExamCard).toList(),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
