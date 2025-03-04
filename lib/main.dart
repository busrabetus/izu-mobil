import 'package:flutter/material.dart';
import 'login_page.dart';

void main(){
  runApp(izukbs());
}
class izukbs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug yazısını kaldırır
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema rengi
      ),
      home: login_page(), // İlk açılacak sayfa
    );
  }
}