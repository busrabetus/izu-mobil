import 'package:flutter/material.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';
import 'package:izukbs/screens/formpage.dart';

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
            top: 310,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuButton(Icons.person, "Öğrenci Bilgileri", context, ogrencibilgileri()),
                menuButton(Icons.calendar_today, "Ders Programı", context, null),
                menuButton(Icons.assignment, "Sınav Sonuçları", context, null),
              ],
            ),
          ),
        ],
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
