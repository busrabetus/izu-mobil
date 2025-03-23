import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izukbs/drawer.dart';

class acildurumtelno extends StatefulWidget {
  const acildurumtelno({super.key});

  @override
  State<acildurumtelno> createState() => _acildurumtelnoState();
}

String? selectedRelation;
String? selectedGender;
TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController noController = TextEditingController();


class _acildurumtelnoState extends State<acildurumtelno> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Acil Durum İletişim Telefonu", style: TextStyle(color: Colors.white)),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.phone),
                        SizedBox(width: 5,),
                        Text(" Acil Durum Telefon Numarası Ekle",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 400,
                  height: 261,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                          width: 0.01
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Yakınlık Derecesi: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 20,),
                            DropdownButton<String>(
                              value: selectedRelation,
                              hint: Text("Seçiniz"),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRelation = newValue;
                                });
                              },
                              items: ["Anne", "Baba", "Kardeş"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35, // Row'un yüksekliğini düşürdük
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Ad',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Padding'i azalttık
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: surnameController,
                                  decoration: InputDecoration(
                                    labelText: 'Soyad',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Padding'i azalttık
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              DropdownButton<String>(
                                value: selectedGender,
                                hint: Text("Cinsiyet"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedGender = newValue;
                                  });
                                },
                                items: ["Kadın", "Erkek"].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Acil durum kişisi cep telefon numarası",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          height: 35, // Yüksekliği sınırlandır
                          child: TextField(
                            controller: noController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              labelText: '(___) ___ ____ ',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Daha kompakt hale getirdik
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Center(
                        child: ElevatedButton(

                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Acil durum kişisi kaydedildi"),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating, // Ekranda yukarıda durması için
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B2231).withOpacity(0.3),
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Kaydet"),
                        )
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
