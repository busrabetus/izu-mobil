import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class dersprogrami extends StatefulWidget {
  const dersprogrami({super.key});

  @override
  State<dersprogrami> createState() => _dersprogramiState();
}

class _dersprogramiState extends State<dersprogrami> {
  final Map<String, List<String>> schedule = {
    'Pazartesi': ['09:00 - Matematik', '11:00 - Fizik'],
    'Salı': ['10:00 - Kimya', '14:00 - Biyoloji'],
    'Çarşamba': ['09:00 - Tarih', '13:00 - Coğrafya'],
    'Perşembe': ['08:30 - İngilizce', '15:00 - Edebiyat'],
    'Cuma': ['10:00 - Beden Eğitimi', '12:00 - Müzik'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Haftalık Ders Programı", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: drawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/circles.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: schedule.keys.map((day) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    title: Text(day, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    children: schedule[day]!.map((lesson) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: Color(0xFF8B2231).withOpacity(0.3),
                          margin: EdgeInsets.symmetric(vertical: 14),
                          child: ListTile(
                            title: Text(lesson, style: TextStyle(fontSize: 16,color: Colors.white)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}