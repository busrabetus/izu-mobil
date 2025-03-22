import 'package:flutter/material.dart';
import 'package:izukbs/screens/acildurumtelno.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';
import 'package:izukbs/screens/dersmateryalleri.dart';
import 'package:izukbs/screens/dersprogrami.dart';
import 'package:izukbs/screens/devamsizlikdurumu.dart';
import 'package:izukbs/screens/formpage.dart';
import 'package:izukbs/screens/homepage.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
