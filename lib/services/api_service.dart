import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/StudentInfo.dart';
import '../models/course_schedule.dart';
import '../models/exam_results.dart';
import '../models/transcript.dart';
import 'token_service.dart';
import 'package:izukbs/models/student_info.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3000';

  // Ana sayfa verisi
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

  // Öğrenci bilgileri (studentinfo sayfası için)
  Future<StudentInfo> getStudentInfo() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception("Token bulunamadı.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/studentinfo'),
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

  // Ders programı
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

  // Sınav sonuçları
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

  // Transkript
  Future<List<TranscriptCourse>> getTranscript(String termId) async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception("Token bulunamadı.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/transcript?term_id=$termId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TranscriptCourse.fromJson(e)).toList();
    } else {
      throw Exception("Transkript verisi getirilemedi: ${response.body}");
    }
  }

  Future<Student_Info> get_StudentInfo() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception("Token bulunamadı.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/studentinfo'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Student_Info.fromJson(data); // model sınıfının adını burada da kullan
    } else {
      throw Exception("Öğrenci bilgileri getirilemedi: ${response.body}");
    }
  }
}
