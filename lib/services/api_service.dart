//ornek bir api_service sayfası. bunu gelistirip degistirecegiz...
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://okulsistemi-api.vercel.app/api"; //buraya saitin verecegi adres gelecek

  // ogrencinin aldığı dersleri getiriyor
  static Future<List<dynamic>> getDersler() async {
    final response = await http.get(Uri.parse("$baseUrl/dersler"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // JSON array döner
    } else {
      throw Exception("Dersler yüklenemedi");
    }
  }

  // öğrenci bilgilerini getiriyor
  static Future<Map<String, dynamic>> getOgrenci(String ogrenciId) async {
    final response = await http.get(Uri.parse("$baseUrl/ogrenci/$ogrenciId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Öğrenci bilgisi yüklenemedi");
    }
  }
}
