import 'package:flutter/material.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';
import 'package:izukbs/screens/formpage.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';

import 'acildurumtelno.dart';
import 'dersmateryalleri.dart';
import 'dersprogrami.dart';
import 'devamsizlikdurumu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Öğrenci Profili"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF8B2231)),
                child: Center(
                  child: Text(
                    'İstanbul Sabahattin Zaim Üniversitesi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Anasayfa'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Acil Durum İletişim Telefonu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => acildurumtelno()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dersprogrami()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Devamsızlık Durumu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => devamsizlikdurumu()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Ders Materyalleri'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dersmateryalleri()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Sınav Sonuçları'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sinavsonuclari()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Transkript'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => transkript()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Sınav Takvimi'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sinavtakvimi()),
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
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 7,
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
                    SizedBox(height: 25),
                    Text("Ayşe Yılmaz",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("030722000",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    Text("Mühendislik ve Doğa Bilimleri Fakültesi",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text("Yazılım Mühendisliği",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("3. Sınıf",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("AGNO: 3.31",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuButton(Icons.person, "Öğrenci Bilgileri", context, ogrencibilgileri()),
                SizedBox(width: 8),
                menuButton(Icons.calendar_today, "Ders Programı", context, null),
                SizedBox(width: 8),
                menuButton(Icons.assignment, "Sınav Sonuçları", context, null),
              ],
            ),
          ),
          Positioned(
            top: 380,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuButton(Icons.note, "Transkript Belgesi", context, null),
                SizedBox(width: 8),
                menuButton(Icons.auto_graph, "Devam Durumu", context, null),
                SizedBox(width: 8),
                menuButton(Icons.assignment, "Sınav Tarihleri", context, null),
              ],
            ),
          ),
          Positioned(
            top: 480,
            left: 20,
            right: 20,
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(5, (index) => _buildCard(index))
                ),
              )
            )
          )
        ],
      ),
    );
  }

  Widget _buildCard(int index) {
    return Container(
      width: 200,
      height: 300,
      margin: EdgeInsets.only(right: 10, top: 5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: index == 0
            ? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
              'assets/images/hosgeldin_1.jpg', // Görselin yolu
              width: 200,
              height: 60,
              fit: BoxFit.contain,
              ),
            ),
          ),
            SizedBox(height: 10),
            // Yazı ekleme
            Text(
              'Özel Yazı ve Görsel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
            : Container(),
      ),
    );
  }

  Widget menuButton(IconData icon, String title, BuildContext context, Widget? page) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 40),
            SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

