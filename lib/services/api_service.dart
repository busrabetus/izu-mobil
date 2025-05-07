import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/StudentInfo.dart';
import '../models/course_schedule.dart';
import 'token_service.dart';
import 'package:izukbs/models/exam_results.dart';
//model
class ApiService {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<StudentInfo> getHomepageData() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception("Token bulunamadı, kullanıcı giriş yapmamış.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/homepage'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return StudentInfo.fromJson(data);
    } else {
      throw Exception("Öğrenci bilgileri getirilemedi: ${response.body}");
    }
  }

  Future<List<CourseSchedule>> getCourseSchedule(int termId) async {
    final token = await AuthService.getToken();
    if (token == null) throw Exception("Token bulunamadı.");

    final response = await http.get(
      Uri.parse('$baseUrl/api/courseSchedule?term_id=$termId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CourseSchedule.fromJson(e)).toList();
    } else {
      throw Exception('Ders programı getirilemedi: ${response.body}');
    }
  }



Future<List<ExamResult>> getExamResults(String termId) async {
  final token = await AuthService.getToken();
  if (token == null) {
    throw Exception("Token bulunamadı, kullanıcı giriş yapmamış.");
  }

  final response = await http.get(
    Uri.parse('$baseUrl/api/examResults?term_id=$termId'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((e) => ExamResult.fromJson(e)).toList();
  } else {
    throw Exception("Sınav sonuçları alınamadı: ${response.body}");
  }
}
}