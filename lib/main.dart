import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main(){
  runApp(Izukbs());
}
class Izukbs extends StatelessWidget {
  const Izukbs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login_page(),
    );
  }
}