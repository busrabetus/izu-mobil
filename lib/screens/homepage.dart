import 'package:flutter/material.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';
import 'package:izukbs/screens/formpage.dart';

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
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF8B2231),
                ),
                child: Center(
                  child: Text(
                    'İstanbul Sabahattin Zaim Üniversitesi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_call),
              title: Text('Acil Durum İletişim Telefonu'),
              onTap: () {
                Navigator.pop(
                  context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Öğrenci Bilgileri'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ogrencibilgileri()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Haftalık Ders Programı'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Devamsızlık Durumu'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book_outlined),
              title: Text('Ders Materyalleri'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_turned_in_outlined),
              title: Text('Ödev Sistemi'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Sınav Sonuçları'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Transkript'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Sınav Takvimi'),
              onTap: () {
                Navigator.pop(
                    context
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.format_align_center),
              title: Text('Başvuru Formları'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => formpage()),
                );
              },
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                color: Color(0xFF8B2231),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Positioned(
            top: 5,
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
                    SizedBox(height: 17),
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
            top: 340,
            left: 20,
            right: 20,
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    menuButton(Icons.person, "Öğrenci Bilgileri", context, ogrencibilgileri()),
                    menuButton(Icons.calendar_today, "Ders Programı", context, null),
                    menuButton(Icons.receipt, "Transkript", context, null),
                    menuButton(Icons.bar_chart, "Devamsızlık Durumu", context, null),
                    menuButton(Icons.assignment, "Sınav Sonuçları", context, null),
                    menuButton(Icons.event, "Sınav Takvimi", context, null),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton(IconData icon, String title, BuildContext context, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: Colors.black54),
          SizedBox(height: 5),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}