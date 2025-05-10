import 'package:flutter/material.dart';
import 'package:izukbs/widgets/custom_appbar.dart';
import '../services/api_service.dart';
import '../models/attendance_detail.dart';
import 'package:intl/intl.dart';

class Devamsizlikdetay extends StatefulWidget {
  final String dersAdi;
  final int termId;

  const Devamsizlikdetay({
    super.key,
    required this.dersAdi,
    required this.termId,
  });

  @override
  State<Devamsizlikdetay> createState() => _DevamsizlikdetayState();
}

class _DevamsizlikdetayState extends State<Devamsizlikdetay> {
  final ApiService apiService = ApiService();
  late Future<List<AttendanceDetail>> detailFuture;

  @override
  void initState() {
    super.initState();
    detailFuture = apiService.getAttendanceDetail(
      className: widget.dersAdi,
      termId: widget.termId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CustomAppBar(title: widget.dersAdi),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<AttendanceDetail>>(
                future: detailFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Devamsızlık kaydı bulunamadı"));
                  } else {
                    final detaylar = snapshot.data!
                        .where((detay) => (detay.toplamSaati - detay.katilimSaati) > 0)
                        .toList();

                    if (detaylar.isEmpty) {
                      return const Center(
                        child: Text(
                          "Bu derste devamsızlık yapılmamış.",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: detaylar.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final detay = detaylar[index];
                        final DateTime parsedDate = DateTime.parse(detay.tarih);
                        final String formattedDate = DateFormat('dd.MM.yyyy').format(parsedDate);
                        final int saat = detay.toplamSaati - detay.katilimSaati;

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.blue,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Devamsızlık",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "$saat saat",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
