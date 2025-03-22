import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class dersprogrami extends StatefulWidget {
  const dersprogrami({super.key});

  @override
  State<dersprogrami> createState() => _dersprogramiState();
}

class _dersprogramiState extends State<dersprogrami> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF0F0F0),
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



              // SAYFA İCERİGİ BURADA OLACAK




            ]
        )
    );
  }
}
