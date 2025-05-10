import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'services/token_service.dart';

void main() {
  runApp(const Izukbs());
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
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  Future<bool> checkLoginStatus() async {
    return await AuthService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snapshot.data == true) {
            return const AnaSayfa();
          } else {
            return const Login_Page();
          }
        }
      },
    );
  }
}
