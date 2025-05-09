import 'package:flutter/material.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import 'package:izukbs/drawer.dart';
import '../models/StudentInfo.dart';
import '../services/api_service.dart';
import 'package:izukbs/models/student_info.dart';

class ogrencibilgileri extends StatefulWidget {
  const ogrencibilgileri({super.key});

  @override
  State<ogrencibilgileri> createState() => _ogrencibilgileriState();
}

class _ogrencibilgileriState extends State<ogrencibilgileri> {
  final ApiService apiService = ApiService();
  late Future<Student_Info> futureStudent;

  @override
  void initState() {
    super.initState();
    futureStudent = apiService.get_StudentInfo();
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 160, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          const Text(": ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16)))
        ],
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 5),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(4, 4),
              )
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Öğrenci Bilgileri"),
      drawer: drawer(),
      body: FutureBuilder<Student_Info>(
        future: futureStudent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Veri bulunamadı."));
          }

          final student = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(radius: 60, child: Icon(Icons.person, size: 80)),
                const SizedBox(height: 10),
                buildCard("Öğrenci Bilgileri", [
                  buildRow("Ad", student.name),
                  buildRow("Soyad", student.surname),
                  buildRow("E-posta", student.email),
                  buildRow("Kullanıcı Adı", student.username),
                  buildRow("T.C. Kimlik No", student.tc),
                  buildRow("Kayıt Tarihi", student.registered),
                ]),
                buildCard("Program Bilgileri", [
                  buildRow("Fakülte / Enstitü", student.facName),
                  buildRow("Bölüm / Program", student.progName),
                  buildRow("Düzey", student.level),
                  buildRow("Kayıt Türü", student.regType),
                  buildRow("Burs Türü", student.sshipType),
                ]),
                buildCard("Danışman Bilgileri", [
                  buildRow("Ad Soyad", student.advisorName),
                  buildRow("Ofisi", student.office),
                  buildRow("Telefon", student.advTel),
                  buildRow("E-posta", student.advEmail),
                ]),
                buildCard("Başarı Sıralaması", [
                  buildRow("Sıralama", student.siralama),
                  buildRow("AGNO", student.agno.toStringAsFixed(2)),
                ]),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
