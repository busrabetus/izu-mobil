import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:izukbs/screens/homepage.dart';
Future<void> login(String username, String password, BuildContext context) async {
  try {
    // API URL'nizi buraya girin
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
      // Giriş başarılı, token alındı veya başka bir veri döndü
      var data = json.decode(response.body);
      // Örneğin token'ı localStorage veya sessionStorage’a kaydedebilirsiniz
      // Sonra kullanıcıyı AnaSayfa'ya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AnaSayfa()),
      );
    } else {
      // Hata mesajı göster
      throw Exception('Giriş başarısız');
    }
  } catch (e) {
    print("Hata: $e");
    // Hata durumunda bir mesaj gösterilebilir
  }
}

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_Page> {
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
                color: Color(0xFF8B2231).withOpacity(0.7),
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
                color: Color(0xFF8B2231).withOpacity(0.7),
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
                            labelText: "kullaniciadi@std.izu.edu.tr",
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
                          final response = await http.post(
                            Uri.parse('http://10.0.2.2:3000/api/user/login'), // Android emülatör için IP böyle olmalı
                            headers: {'Content-Type': 'application/json'},
                            body: jsonEncode({
                              'email': usernamecontroller.text,
                              'password': passwordcontroller.text,
                            }),
                          );

                          if (response.statusCode == 200) {
                            // Giriş başarılı, yönlendirme yap
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnaSayfa()),
                            );
                          } else {
                            // Hata mesajını göster
                            var errorData = json.decode(response.body);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorData['message'] ?? 'Hatalı giriş')),
                            );
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B2231),
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Giriş - Sign In"),
                      ),
                    ],
                  ),
                ),
              ))
        ]));
  }
}