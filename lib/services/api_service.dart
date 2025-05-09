import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/StudentInfo.dart';
import '../models/attendance.dart';
import '../models/attendance_detail.dart';
import '../models/course_schedule.dart';
import '../models/exam_results.dart';
import '../models/exam_schedule.dart';
import '../models/transcript.dart';
import 'token_service.dart';
import 'package:izukbs/models/student_info.dart';
import 'package:izukbs/models/class_materials.dart';

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
  Future<List<TranscriptCourse>> getTranscript(int termId) async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception("Token bulunamadı.");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/transcript?term_id=$termId'),
      headers: {
        'Authorization': 'Bearer $token',

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
      return Student_Info.fromJson(
          data); // model sınıfının adını burada da kullan
    } else {
      throw Exception("Öğrenci bilgileri getirilemedi: ${response.body}");
    }
  }

  //devamsizlik sayfasi icin
  Future<List<Attendance>> getAttendanceList(int termId) async {
    final token = await AuthService.getToken();
    if (token == null) throw Exception("Token bulunamadı.");

    final response = await http.get(
      Uri.parse('$baseUrl/api/attendance?term_id=$termId'),
      headers: { 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Attendance.fromJson(e)).toList();
    } else {
      throw Exception(
          "Devamsızlık verisi alınamadı: ${response.statusCode} - ${response
              .body}");
    }
  }

  //devamsizlik detay icin
  Future<List<AttendanceDetail>> getAttendanceDetail({
    required String className,
    required int termId,
  }) async {
    final token = await AuthService.getToken();
    if (token == null) throw Exception("Token bulunamadı.");

    final response = await http.get(
      Uri.parse(
          '$baseUrl/api/attendance/detail?class_name=$className&term_id=$termId'),
      headers: { 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => AttendanceDetail.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception("Devamsızlık detayı alınamadı: ${response.statusCode}");
    }
  }

  //sinav takvimi icin
  Future<List<ExamSchedule>> getExamScheduleList(int termId) async {
    final token = await AuthService.getToken();
    if (token == null) throw Exception("Token bulunamadı.");

    final response = await http.get(
      Uri.parse('$baseUrl/api/examschedule?term_id=$termId'),
      headers: { 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ExamSchedule.fromJson(e)).toList();
    } else {
      throw Exception(
          "Sınav takvimi alınamadı: ${response.statusCode} - ${response.body}");
    }
  }


  Future<List<ClassMaterial>> getClassesMaterial(int termId) async {
    final token = await AuthService.getToken();
    if (token == null) throw Exception("Token eksik");

    final response = await http.get(
      Uri.parse('$baseUrl/api/classesmaterial?term_id=$termId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print("🔥 CLASSES MATERIAL RAW DATA: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ClassMaterial.fromJson(e)).toList(); // ✅ işte bu
    } else {
      throw Exception("Materyaller alınamadı: ${response.body}");
    }
  }


}