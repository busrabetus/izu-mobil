import 'package:flutter/material.dart';
import 'package:izukbs/screens/dersprogrami.dart';
import 'package:izukbs/screens/devamsizlikdurumu.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';
import 'package:izukbs/services/api_service.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../widgets/drawer.dart';
import 'package:izukbs/models/StudentInfo.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final ApiService _apiService = ApiService();
  StudentInfo? student;
  bool _loading = true;


  @override
  void initState() {
    super.initState();
    _fetchOgrenciBilgileri();
  }

  Future<void> _fetchOgrenciBilgileri() async {
    try {
      final studentInfo = await _apiService.getHomepageData();
      setState(() {
        student = studentInfo;
        _loading = false;
      });
    } catch (e) {
      print('Hata: $e');
      setState(() {
        _loading = false; // hata da olsa yükleme bitiyor
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Öğrenci bilgileri alınamadı: $e')),
      );
    }
  }


  final List<Map<String, String>> duyurular = [
    {
      'baslik': 'Yaz Dönemi Kayıtları Başladı',
      'icerik': '2023-2024 eğitim öğretim yılı yaz dönemi kayıtları başlamıştır. Son başvuru tarihi 15 Haziran 2024\'tür. Ders seçimlerinizi akademik danışmanınızla görüşerek yapınız.',
      'resim': 'https://picsum.photos/250/150?random=1',
    },
    {
      'baslik': 'Mezuniyet Töreni Duyurusu',
      'icerik': '2024 yılı mezuniyet töreni 30 Haziran 2024 tarihinde kampüs amfisinde yapılacaktır. Tüm mezun adaylarının saat 10:00\'da hazır bulunmaları gerekmektedir.',
      'resim': 'https://picsum.photos/250/150?random=2',
    },
    {
      'baslik': 'Kütüphane Yaz Çalışma Saatleri',
      'icerik': 'Yaz dönemi boyunca kütüphane çalışma saatleri hafta içi 08:00-18:00, hafta sonu 10:00-16:00 olarak belirlenmiştir.',
      'resim': 'https://picsum.photos/250/150?random=3',
    },
    {
      'baslik': 'Staj Başvuru Son Tarihi',
      'icerik': 'Yaz stajı için son başvuru tarihi 31 Mayıs 2024 olarak belirlenmiştir. Staj dosyalarınızı eksiksiz doldurarak bölüm sekreterliğine teslim ediniz.',
      'resim': 'https://picsum.photos/250/150?random=4',
    },
    {
      'baslik': 'Staj Başvuru Son Tarihi',
      'icerik': 'Yaz stajı için son başvuru tarihi 31 Mayıs 2024 olarak belirlenmiştir. Staj dosyalarınızı eksiksiz doldurarak bölüm sekreterliğine teslim ediniz.',
      'resim': 'https://picsum.photos/250/150?random=4',
    },
    {
      'baslik': 'Staj Başvuru Son Tarihi',
      'icerik': 'Yaz stajı için son başvuru tarihi 31 Mayıs 2024 olarak belirlenmiştir. Staj dosyalarınızı eksiksiz doldurarak bölüm sekreterliğine teslim ediniz.',
      'resim': 'https://picsum.photos/250/150?random=4',
    },
    {
      'baslik': 'Staj Başvuru Son Tarihi',
      'icerik': 'Yaz stajı için son başvuru tarihi 31 Mayıs 2024 olarak belirlenmiştir. Staj dosyalarınızı eksiksiz doldurarak bölüm sekreterliğine teslim ediniz.',
      'resim': 'https://picsum.photos/250/150?random=4',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const CustomAppBar(title: "Ana Sayfa"),
      drawer: drawer(),
      body:  _loading
          ? const Center(child: CircularProgressIndicator())
          : student == null
          ? const Center(child: Text("Öğrenci verisi bulunamadı"))
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage("assets/images/avatar/${student!.userId}.png"),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        student!.ad,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student!.numara,
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        student!.fakulte,
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        student!.bolum,
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      const Divider(thickness: 1, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${student!.level}. Sınıf",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "AGNO: ${student!.agno}",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hızlı Menü",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildMenuButton(Icons.person, "Öğrenci\nBilgileri", context, ogrencibilgileri()),
                      const SizedBox(width: 10),
                      _buildMenuButton(Icons.calendar_today, "Ders\nProgramı", context, DersProgrami()),
                      const SizedBox(width: 10),
                      _buildMenuButton(Icons.assignment, "Sınav\nSonuçları", context, sinavsonuclari()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildMenuButton(Icons.note, "Transkript\nBelgesi", context, transkript()),
                      const SizedBox(width: 10),
                      _buildMenuButton(Icons.auto_graph, "Devamsızlık\nDurumu", context, DevamsizlikDurumu()),
                      const SizedBox(width: 10),
                      _buildMenuButton(Icons.calendar_month, "Sınav\nTakvimi", context, sinavtakvimi()),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Duyurular",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 10),
                itemCount: duyurular.length,
                itemBuilder: (context, index) {
                  return _buildDuyuruCard(
                    duyurular[index]['baslik']!,
                    duyurular[index]['icerik']!,
                    duyurular[index]['resim']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String text, BuildContext context, Widget page) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: Container(
          height: 100,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF8B2231)),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuyuruCard(String baslik, String icerik, String resimUrl) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Duyuru Detayı"),
              content: const Text("Bu özellik yakında eklenecek."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Tamam"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                resimUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baslik,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    icerik,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
