import 'package:flutter/material.dart';
import '../drawer.dart';
import '../widgets/custom_appbar.dart';

class basvuruformlari extends StatefulWidget {
  const basvuruformlari({super.key});

  @override
  State<basvuruformlari> createState() => _basvuruformlariState();
}

class _basvuruformlariState extends State<basvuruformlari> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> formList = [
      {
        "title": "Doktora Yeterlilik",
        "description": "Doktora Yeterlilik Başvuruları",
        "startDate": "10.03.2025",
        "endDate": "14.03.2025",
      },
      {
        "title": "Tezli Programa Geçiş Başvuru Sistemi",
        "description": "Tezli Programa Geçiş Başvuru Sistemi",
        "startDate": "23.01.2025",
        "endDate": "26.01.2025",
      },
      {
        "title": "Muafiyet Sınav Başvuruları",
        "description": "Ortak Zorunlu YÖK Dersleri (5-ı) Muafiyet Sınavı Başvuruları",
        "startDate": "09.09.2024",
        "endDate": "11.09.2024",
      },
      {
        "title": "Yandal Programı Başvuru Sistemi",
        "description": "Yandal Programına başvuru şartlarını ve tarihlerini Üniversitemiz web sayfasından takip ediniz.",
        "startDate": "06.01.2025",
        "endDate": "20.01.2025",
      },
      {
        "title": "Çift Anadal Programı Başvuru Sistemi",
        "description": "Çift Anadal Programına başvuru şartlarını ve tarihlerini Üniversitemiz web sayfasından takip ediniz.",
        "startDate": "06.01.2025",
        "endDate": "20.01.2025",
      },
      {
        "title": "Kurum İçi (Programlar Arası) Yatay Geçiş Başvuru Sistemi",
        "description": "Kurum İçi Yatay Geçiş (Programlar Arası Geçiş) başvuru tarihlerini Akademik Takvimde görebilirsiniz.",
        "startDate": "06.01.2025",
        "endDate": "20.01.2025",
      },
      {
        "title": "Spor Eğitimi ve Kursları",
        "description": "Spor Eğitimi ve Kursları",
        "startDate": "01.02.2025",
        "endDate": "01.04.2025",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Başvuru Formları"),
      drawer: drawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                for (var form in formList)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: FormCard(
                      title: form["title"]!,
                      description: form["description"]!,
                      startDate: form["startDate"]!,
                      endDate: form["endDate"]!,
                      onApply: () {},
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
class FormCard extends StatelessWidget {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final VoidCallback onApply;

  const FormCard({
    super.key,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.black.withOpacity(0.4),
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Text(description,textAlign: TextAlign.center,),
            Divider(
              color: Colors.black.withOpacity(0.4),
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Başlangıç:", textAlign: TextAlign.left),
                  Text(startDate, textAlign: TextAlign.right),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Bitiş:", textAlign: TextAlign.left),
                  Text(endDate, textAlign: TextAlign.right),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
