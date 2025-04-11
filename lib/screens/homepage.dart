import 'package:flutter/material.dart';
import 'package:izukbs/screens/dersprogrami.dart';
import 'package:izukbs/screens/devamsizlikdurumu.dart';
import 'package:izukbs/screens/ogrencibilgileri.dart';
import 'package:izukbs/screens/sinavsonuclari.dart';
import 'package:izukbs/screens/sinavtakvimi.dart';
import 'package:izukbs/screens/transkript.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B2231),
        title: Text("Ana Sayfa", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: drawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                color: Color(0xFF8B2231),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 30, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text("Ayşe Yılmaz",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text("030722000",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                    Text("Mühendislik ve Doğa Bilimleri Fakültesi",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text("Yazılım Mühendisliği",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("3. Sınıf",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("AGNO: 3.31",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 20,
            right: 20,
            child: Text("Hızlı Menü",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Positioned(
            top: 255,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuButton(Icons.person, "Öğrenci Bilgileri", context, ogrencibilgileri()),
                SizedBox(width: 8),
                menuButton(Icons.calendar_today, "Ders Programı", context, dersprogrami()),
                SizedBox(width: 8),
                menuButton(Icons.assignment, "Sınav Sonuçları", context, sinavsonuclari()),
              ],
            ),
          ),
          Positioned(
            top: 345,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                menuButton(Icons.note, "Transkript Belgesi", context, transkript()),
                SizedBox(width: 8),
                menuButton(Icons.auto_graph, "Devam Durumu", context, DevamsizlikDurumu()),
                SizedBox(width: 8),
                menuButton(Icons.assignment, "Sınav Takvimi", context, sinavtakvimi()),
              ],
            ),
          ),
          Positioned(
            top: 440,
            left: 20,
            right: 20,
            child: Text("Duyurular",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          Positioned(
            top: 470,
            left: 20,
            right: 20,
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) => _buildCard(context, index)),
                ),
              )
            )
          )
        ],
      ),

    );
  }

  Widget _buildCard(BuildContext context, int index){
  List<Map<String, String>> cardData = [
      {
        'image': 'assets/images/hosgeldin_1.jpg',
        'text': 'Ramazan ayı, manevi huzurun doruğa ulaştığı, paylaşma ve dayanışmanın en güzel örneklerinin yaşandığı mübarek bir zaman dilimidir. İstanbul Sabahattin Zaim Üniversitesinde de Ramazan ayı, her yıl büyük bir coşku ve heyecanla karşılanır. Üniversitenin huzur veren atmosferinde Ramazan, sadece oruç tutmaktan ibaret değil; aynı zamanda birlik ve beraberliği pekiştiren özel etkinliklerle doludur. Kampüsün her köşesinde Ramazan’ın bereketini hissettiren etkinlikler düzenlenir. Geleneksel iftar programları, öğrenci ve akademisyenleri bir araya getirerek, paylaşmanın ve birlikte olmanın verdiği mutluluğu artırır. Üniversite bahçesinde kurulan iftar sofraları, farklı kültürlerden öğrencileri bir araya getirerek, Ramazanın evrensel mesajını en güzel şekilde yansıtır. Hatiplerin ve akademisyenlerin katıldığı söyleşiler, Ramazan’ın manevi derinliğini kavramaya yardımcı olur. Teravih namazları, öğrencilerin ve akademisyenlerin cemaatle bir araya geldiği manevi buluşmalara sahne olur. Bu mübarek ay boyunca Zaim Üniversitesi, ilimle maneviyatın iç içe geçtiği bir atmosfer sunarak öğrencilerine sadece akademik değil, aynı zamanda manevi anlamda da büyük bir kazanım sağlar. Ramazan ayının huzuru ve coşkusu, bu köklü üniversitenin sıcak ortamında daha da anlam kazanır.',
      },
      {
        'image': 'assets/images/çanakkalekongresi.png',
        'text': 'İstanbul Zaim Üniversitesi, akademik dünyada önemli bir yer tutan 5. Uluslararası Çanakkale Kongresini büyük bir heyecanla gerçekleştirdi. Her yıl farklı disiplinlerde yapılan bu kongre, bilim dünyasını bir araya getirerek, araştırmaların ve fikirlerin paylaşıldığı bir platform sunuyor.Bu yılki kongre, Çanakkalenin tarihi ve kültürel mirasını daha derinlemesine incelemeyi amaçlayarak, katılımcılara benzersiz bir deneyim sundu. Uluslararası düzeydeki akademisyenler, araştırmacılar ve öğrenciler, kongrede çeşitli oturumlar, paneller ve seminerlerle bilgi alışverişinde bulundular.Uluslararası Çanakkale Kongresi, sadece bilimsel anlamda değil, aynı zamanda sosyal ve kültürel açıdan da zengin bir program sunarak, katılımcılara tarih, edebiyat, sosyoloji ve diğer sosyal bilimler alanlarında yeni bakış açıları kazandırmayı hedefledi. Kongre kapsamında yapılan sunumlar, Çanakkalenin Türk tarihi için ne kadar önemli bir yere sahip olduğunu bir kez daha gözler önüne serdi.Ayrıca, kongreye katılanlar, Çanakkalenin hem geçmişteki hem de günümüzdeki kültürel ve toplumsal dinamiklerini tartışma fırsatı buldular. Katılımcıların bu deneyimden, sadece akademik anlamda değil, aynı zamanda insani ve kültürel anlamda da önemli kazanımlar sağladıkları bir ortam yaratıldı. İstanbul Zaim Üniversitesi, 5. Uluslararası Çanakkale Kongresi ile hem akademik dünyadaki yerini güçlendirirken, hem de geleceğin liderlerine ve bilim insanlarına ilham verme misyonunu bir kez daha pekiştirdi. Bu tür uluslararası organizasyonlar, üniversitenin hem ulusal hem de küresel düzeyde daha geniş bir etki alanına sahip olmasını sağlıyor.',},
      {
        'image': 'assets/images/kongre.jpg',
        'text': 'İstanbul Zaim Üniversitesi, akademik dünyada önemli bir adım daha atarak 2. Lisansüstü Öğrenci Kongresi’ni başarıyla gerçekleştirdi. Bu yıl ikincisi düzenlenen kongre, lisansüstü öğrencilerin bilimsel araştırmalarını sergileyebileceği, fikir alışverişinde bulunabileceği ve akademik kariyerlerine katkı sağlayacak bir platform sundu.Kongre, üniversitenin bilimsel düşünceye ve araştırmaya verdiği önemin bir yansıması olarak, lisansüstü öğrencilerin teorik bilgilerini pratiğe dökme ve ulusal düzeyde tanıtma fırsatı sundu. Öğrenciler, kendi alanlarında gerçekleştirdikleri araştırmalarını sunarak, diğer akademisyenlerle bilgi alışverişinde bulundular.Lisansüstü Öğrenci Kongresi’nde farklı disiplinlerden gelen katılımcılar, seminerler, paneller ve çalıştaylarla zengin bir programda yer aldılar. Katılımcılar, sadece akademik konularda değil, aynı zamanda profesyonel gelişimlerine katkı sağlayacak önemli bilgiler edindiler.Bu kongre, öğrencilerin araştırma yapma süreçlerini daha derinlemesine anlamalarına, yeni bakış açıları kazanmalarına ve ulusal ve uluslararası akademik çevrelerde tanınırlıklarını artırmalarına olanak sağladı. Öğrenciler, farklı disiplinlerdeki sunumları ve tartışmaları takip ederek, araştırma dünyasındaki gelişmeleri yakından izleme fırsatı buldular.İstanbul Zaim Üniversitesi, 2. Lisansüstü Öğrenci Kongresi ile akademik anlamda ilerleme kaydederken, aynı zamanda üniversite öğrencilerinin bilimsel gelişimlerine katkıda bulunarak, araştırma ve akademik mükemmeliyet konusunda önemli bir adım atmış oldu.',
      },
      {
        'image': 'assets/images/ii-uluslararasi-sağlik-bilimleri-kongresi_.png',
        'text': 'İstanbul Zaim Üniversitesi, sağlık alanındaki bilgi ve deneyimlerin paylaşıldığı önemli bir etkinlik olan 1. Uluslararası ve 2. Ulusal Sağlık Kongresini düzenleyecek. Bu kongre, sağlık bilimleri, tıbbî araştırmalar ve sağlık politikaları alanındaki en son gelişmeleri ele almak ve ulusal ve uluslararası düzeydeki uzmanları bir araya getirmek amacıyla gerçekleştirilecek.Kongre, sağlık sektöründeki akademisyenler, araştırmacılar, profesyoneller ve öğrenciler için eşsiz bir fırsat sunuyor. Katılımcılar, sağlık alanındaki en güncel konular üzerinde derinlemesine tartışmalar yapacak, bilimsel sunumlar ve paneller aracılığıyla bilgi alışverişinde bulunacaklar. Kongre, yalnızca sağlık bilimleriyle ilgili akademik çalışmaların öne çıkmasını sağlamakla kalmayacak, aynı zamanda sağlık alanındaki yenilikçi yaklaşımlar, uygulamalar ve çözüm önerileri üzerine de önemli fikirler ortaya koyacak.1. Uluslararası ve 2. Ulusal Sağlık Kongresi, sağlık alanındaki disiplinler arası işbirliğini teşvik etmeyi, yenilikçi araştırmaları desteklemeyi ve sağlık sistemlerinin gelişimine katkı sağlamayı amaçlıyor. Katılımcılar, farklı sağlık alanlarındaki uzmanlarla tanışacak, global sağlık sorunları üzerine fikir yürütecek ve sağlık politikaları hakkında daha geniş bir perspektif kazanacaklar.Bu prestijli etkinlik, İstanbul Zaim Üniversitesi’nin sağlık bilimleri alanındaki akademik gücünü bir kez daha gözler önüne sererken, üniversitenin sağlık alanındaki ulusal ve uluslararası işbirliklerini güçlendirmeyi de hedefliyor. Kongre, sağlık alanındaki en son araştırmaların, yenilikçi uygulamaların ve toplumsal sağlık sorunlarının ele alındığı dinamik bir platform oluşturacak.',
      },
      {
        'image': 'assets/images/tarihihisset.jpg',
        'text': 'İZÜ Kampüsü tarihe tanıklık etmiş bir alanda kuruldu. 1892 yılında, II. Abdülhamid döneminde açılışı yapılan Ziraat ve Baytar Mektebi Binası, İZÜ Kampüsüne tarihi bir kimlik kazandırıyor. Öğrenciler, İstiklâl Şairimiz Mehmet Akif’in de önce öğrencilik, sonra hocalık yaptığı koridorları ve yolları arşınlayarak tarihi dokunun gölgesinde eğitim görmenin ayrıcalığını yaşıyor.“Medeniyet değerlerine bağlı olmak” İZÜ’nün olmazsa olmazlarından. Ülkemizin ve insanlığın ihtiyaç duyduğu insani değerlere önem veren İZÜ, kadim medeniyetimizin değerleri olan iyilik, doğruluk, güzel ahlak, yardımlaşma ve tevazuyu, mesleki yetkinlik ile eşzamanlı olarak öğrencilere kazandırmayı hedefliyor. Teorik bilgilerin pratik deneyimlerle bir araya getirildiği bütünsel bir anlayışın hâkim olduğu İZÜ’de farklı eğitim modelleri ön plana çıkıyor.Kronolojik Tarihçe1884 II. Abdülhamid devrinde Ziraat Mektebi Ali’si olarak kuruldu.1889 ‘Mülkiye Baytarı talebeleri’ öğrenime başladı.1892 Resmi açılışı yapıldı.1893 Okul ilk mezunlarını verdi.1895 Halkalı Ziraat Mekteb-i Ali’si adıyla ilk mezunlarını verdi.1914 I. Dünya Savaşında Halkalı Ziraat Mektebi’nde de derslere ara verildi. Öğretmen ve öğrencilerin büyük çoğunluğu cepheye koştu. Öğrencilerin çoğu gazi ya da şehit oldu.1916 Savaş içerisinde zirai üretim, tohum muayenesi ve dağıtım gibi konularda duyulan ihtiyaç üzerine okul yeniden açıldı.1928 Islah-ı Tedrisat Kanunu ile okul kapatıldı.1930 Halkalı Ziraat Mektebi adı ile 3 yıl süreli orta dereceli meslek okulu olarak yeniden öğretime açıldı.1980 Öğretim süresi 4 yıla çıkartıldı.2005 Okul kapatılıp yerine Halkalı Zirai Üretim İşletmesi Tarımsal Yayım ve Hizmet İçi Eğitim Merkezi Müdürlüğü kuruldu.2010 İstanbul Sabahattin Zaim Üniversitesi kuruldu.',
      },
    ];

    if (index < 0 || index >= cardData.length) return SizedBox.shrink();

    String text = cardData[index]['text']!;
    String shortText = text.length > 300 ? text.substring(0, 280) + '...' : text;
    String imagePath = cardData[index]['image']!;

    return Container(
      width: 200,
      height: 300,
      margin: EdgeInsets.only(right: 10, top: 5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8, right: 8, left: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                cardData[index]['image']!,
                width: 200,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Stack(
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),

                Column(
                  children: [
                    Text(
                      shortText,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (text.length > 50)
                      TextButton(
                        onPressed: () {
                          _showFullTextDialog(context, text, imagePath);
                        },
                        child: Text(
                          "Devamını Gör",
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  void _showFullTextDialog(BuildContext context, String text, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Kapat"),
            ),
          ],
        );
      },
    );
  }


  Widget menuButton(IconData icon, String title, BuildContext context, Widget? page) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 35),
            SizedBox(height: 10),
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 10),
              maxLines: 2,  // Tek satırda gösterir
              minFontSize: 10,  // Minimum font boyutunu ayarla
            ),
          ],
        ),
      ),
    );
  }
}

