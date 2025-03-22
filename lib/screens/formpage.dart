import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';

class formpage extends StatefulWidget {
  const formpage({super.key});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Başvuru Formları", style: TextStyle(color: Colors.white)),
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
      ), SingleChildScrollView(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 400,
                height: 198,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Doktora Yeterlilik",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "Doktora Yeterlilik"
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "BAŞLANGIÇ TARIHI                              10.03.2025\nBITIŞ TARIHI                                          14.03.2025"
                    ),
                    ElevatedButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Uyarı"),
                                  content: Text("Sadece Doktora öğrencileri başvuru yapabilir."),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Tamam"),
                                    )
                                  ],
                                );
                              },
                              );
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                        child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 198,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tezli Programa Geçiş Başvuru Sistemi",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Tezli Programa Geçiş Başvuru Sistemi"
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              23.01.2025\nBITIŞ TARIHI                                          26.01.2025"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Başvuru sistemi aktif değildir."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 216,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Muafiyet Sınav Başvuruları",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Ortak Zorunlu YÖK Dersleri (5-ı) Muafiyet Sınavı Başvuruları",
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              09.09.2024\nBITIŞ TARIHI                                          11.09.2024"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Başvuru sistemi aktif değildir."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 216,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Yandal Programı Başvuru Sistemi",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Yandal Programına başvuru şartlarını ve tarihlerini Üniversitemiz web sayfasından takip ediniz.",
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              06.01.2025\nBITIŞ TARIHI                                          20.01.2025"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Başvuru sistemi aktif değildir."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 216,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Çift Anadal Programı Başvuru Sistemi",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Çift Anadal Programına başvuru şartlarını ve tarihlerini Üniversitemiz web sayfasından takip ediniz.",
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              06.01.2025\nBITIŞ TARIHI                                          20.01.2025"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Başvuru sistemi aktif değildir."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 239,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Kurum İçi (Programlar Arası)\n Yatay Geçiş Başvuru Sistemi",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Kurum İçi Yatay Geçiş (Programlar Arası Geçiş) başvuru tarihlerini Akademik Takvimde görebilirsiniz.",
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              06.01.2025\nBITIŞ TARIHI                                          20.01.2025"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Başvuru sistemi aktif değildir."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 400,
                height: 216,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Spor Eğitimi ve Kursları",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "Spor Eğitimi ve Kursları"
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.4),
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                        "BAŞLANGIÇ TARIHI                              01.02.2025\nBITIŞ TARIHI                                          01.04.2025"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Uyarı"),
                              content: Text("Burayı yazıp yazmayacağımdan emin değilim."),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Tamam"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Başvur"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

          ],
        )
      )
        ]
      )
    );
  }
}
