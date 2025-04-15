import 'package:flutter/material.dart';
import 'package:izukbs/screens/acildurumtelno.dart';
import 'package:izukbs/screens/login_page.dart';
import 'package:izukbs/screens/basvuruformlari.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';
import 'package:izukbs/screens/dersmateryalleri.dart';
import 'package:izukbs/screens/dersprogrami.dart';
import 'package:izukbs/screens/devamsizlikdurumu.dart';
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
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/dji_0199.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/izulogodr.png",
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ana Sayfa'),
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
                MaterialPageRoute(builder: (context) => DevamsizlikDurumu()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Ders Materyalleri'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DersMateryalleri()),
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
                MaterialPageRoute(builder: (context) => basvuruformlari()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Çıkış Yap'),
            onTap: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login_Page()),
              );
            },
          ),
        ],
      ),
    );
  }
}
