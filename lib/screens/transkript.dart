import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class transkript extends StatefulWidget {
  const transkript({super.key});

  @override
  State<transkript> createState() => _TranskriptState();
}

class _TranskriptState extends State<transkript> {
  final Map<String, List<Map<String, String>>> semesters = {
    '1. Yarıyıl': [
      {'Veri Yapıları': 'AA'},
      {'Algoritmalar': 'BB'},
      {'Matematik': 'BA'},
    ],
    '2. Yarıyıl': [
      {'Olasılık Teorisi': 'CC'},
      {'Makine Öğrenmesi': 'BA'},
      {'Mobil Programlama': 'BB'},
    ],
    '3. Yarıyıl': [
      {'Veri Tabanı Yönetimi': 'AA'},
      {'Yapay Zeka': 'BB'},
      {'İnternet Programcılığı': 'BA'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Transkript", style: TextStyle(color: Colors.white)),
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
              children: semesters.keys.map((semester) {
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
                    title: Text(semester, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    children: semesters[semester]!.map((lesson) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          color: Color(0xFFF6F6F6).withOpacity(0.8),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(lesson.keys.first, style: TextStyle(fontSize: 16, color: Colors.black)),
                            trailing: Text(lesson.values.first, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
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