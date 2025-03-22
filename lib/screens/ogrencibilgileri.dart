import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class ogrencibilgileri extends StatefulWidget {
  const ogrencibilgileri({super.key});

  @override
  State<ogrencibilgileri> createState() => _ogrencibilgileriState();
}

class _ogrencibilgileriState extends State<ogrencibilgileri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Öğrenci Bilgileri", style: TextStyle(color: Colors.white)),
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
    SingleChildScrollView(
      child :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 80, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
          child: Text(
            "   Öğrenci Bilgileri",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ),
          SizedBox(height: 5,),
          Container(
            width: 400,
            height: 205,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.01,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("E-posta", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 100),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("030722000@std.izu.edu.tr", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("TC Kimlik No", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 60),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("030722000", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Ad", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 136),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("Ayşe", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Soyad", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 111),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("Yılmaz", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Öğrenci Numarası", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 23),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("030722000", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("Öğrencilik Statüsü", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                              SizedBox(width: 20),
                              Text(":", style: TextStyle(fontSize: 16)),
                              SizedBox(width: 10),
                              Text("Aktif Öğrenci", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      )

                    ],
                  )
              )
          ),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "   Program Bilgileri",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: 400,
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 0.01,
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
                    children: [
                      Text("Fakülte / Enstütü", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 11),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("Mühendislik ve Doğa Bilimleri", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Bölüm / Program", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 11),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("Yazılım Mühendisliği", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Öğretim Türü", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 39),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("Normal Eğitim", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Kayıt Türü", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 61),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("ÖSS", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Burs Türü", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 64),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("ÖSYM - %50 İndirimli", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Sınıf", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 102),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("3.Sınıf", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Kayıt Tarihi", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                      SizedBox(width: 53),
                      Text(":", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 10),
                      Text("07.09.2021", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              )
            )
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "   Danışman Bilgileri",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: 400,
            height: 240,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.01,
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
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Ad Soyad", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 42),
                          Text(":", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text("Doktor Öğretim Üyesi\nVolkan Çetin", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Ofisi", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 77),
                          Text(":", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text("Halkalı Kampüs -> Nükleer\nAlgılayıcılar ve Robotik\nUygulama ve Araştırma Merkezi\nPG011", style: TextStyle(fontSize: 16),softWrap: true,),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Ofis Telefonu", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 14),
                          Text(":", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text("02126928990", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("E-posta Adresi", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Text(":", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text("volkan.cetin@izu.edu.tr", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  )

              )
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "   Başarı Sıralaması",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.01,
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
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("2024-2025 YY", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 20),
                          Text(":", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10),
                          Text("9/67 (%13)", style: TextStyle(fontSize: 16),softWrap: true,),
                        ],
                      ),
                    ],
                  )

              )
          ),
          SizedBox(height: 50,)
        ],
      ),
    ),
  ]
      )
    );
  }
}
