import 'package:flutter/material.dart';
import 'package:izukbs/screens/homepage.dart';

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
                color: Color(0xFF8B2231).withValues(),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AnaSayfa()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8B2231),
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text("Giriş - Sign In")),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ))
        ]));
  }
}