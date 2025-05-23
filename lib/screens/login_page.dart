import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:izukbs/screens/homepage.dart';
import 'package:izukbs/services/token_service.dart';

Future<void> login(String username, String password, BuildContext context) async {
  try {
    final url = Uri.parse("http://10.0.2.2:3000/api/user/login");
    final response = await http.post(
      url,
      body: json.encode({
        'email': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final token = data['token'];

      if (token != null) {
        await AuthService.saveToken(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AnaSayfa()),
        );
      } else {
        throw Exception('Token sunucudan alınamadı.');
      }
    } else {
      final errorData = json.decode(response.body);
      final message = errorData['message'] ?? 'Giriş başarısız';
      throw Exception(message);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: Stack(children: [
          Positioned(
            top: -20,
            left: -60,
            child: Container(
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                color: const Color(0xFF8B2231).withAlpha((255 * 0.7).round()),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -60,
            left: 0,
            child: Container(
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                color: const Color(0xFF8B2231).withAlpha((255 * 0.7).round()),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        "assets/images/izulogo.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text("Giriş bilgilerinizi giriniz",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(
                            labelText: "kullaniciadi@gmail.com",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          labelText: "Şifre - Password",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final username = usernamecontroller.text.trim();
                          final password = passwordcontroller.text.trim();

                          if (username.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Lütfen tüm alanları doldurun.")),
                            );
                            return;
                          }

                          await login(username, password, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B2231),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Giriş - Sign In"),
                      )

                    ],
                  ),
                ),
              ))
        ]));
  }
}