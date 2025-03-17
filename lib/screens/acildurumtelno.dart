import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';

import 'dersmateryalleri.dart';
import 'dersprogrami.dart';
import 'devamsizlikdurumu.dart';
import 'formpage.dart';
import 'homepage.dart';
import 'ogrencibilgileri.dart';

class acildurumtelno extends StatefulWidget {
  const acildurumtelno({super.key});

  @override
  State<acildurumtelno> createState() => _acildurumtelnoState();
}

String? selectedRelation;
String? selectedGender;
TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController noController = TextEditingController();


class _acildurumtelnoState extends State<acildurumtelno> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Acil Durum İletişim Telefonu", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
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
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/circles.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.phone),
                        Text(" Acil Durum Telefon Numarası Ekle",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                          width: 0.01
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(4, 4),
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Yakınlık Derecesi: ",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: selectedRelation,
                              hint: Text("Seçiniz"),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRelation = newValue;
                                });
                              },
                              items: ["Anne", "Baba", "Kardeş"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Ad',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: surnameController,
                                decoration: InputDecoration(
                                  labelText: 'Soyad',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // Cinsiyet Dropdown
                            DropdownButton<String>(
                              value: selectedGender,
                              hint: Text("Cinsiyet"),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender = newValue;
                                });
                              },
                              items: ["Kadın", "Erkek"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("Acil durum kişisi cep telefon numarası",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: noController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  labelText: '(___) ___ ____ ',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
