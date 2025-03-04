import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({Key? key}) : super(key: key); // Burada da aynı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('assets/images/Ekran Resmi 2025-03-04 20.59.57.png', width: double.infinity, fit: BoxFit.cover, height: 200),
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 40, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text("Ayşe Yılmaz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("030722000", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    Text("Mühendislik ve Doğa Bilimleri Fakültesi", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text("Yazılım Mühendisliği", style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("3. Sınıf", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("AGNO: 3.31", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: Column(
              children: [
                //Image.asset('assets/images/Ekran Resmi 2025-03-04 21.03.00.png', width: 200, height: 120),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    menuButton(Icons.person, "Öğrenci Bilgileri"),
                    menuButton(Icons.calendar_today, "Ders Programı"),
                    menuButton(Icons.receipt, "Transkript"),
                    menuButton(Icons.bar_chart, "Devamsızlık Durumu"),
                    menuButton(Icons.assignment, "Sınav Sonuçları"),
                    menuButton(Icons.event, "Sınav Takvimi"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 40, color: Colors.black54),
        SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}