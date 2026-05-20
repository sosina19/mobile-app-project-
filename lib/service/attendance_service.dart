import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceService {
  static const String baseUrl =
      "https://s-backend-5f4c.onrender.com/attendance";

  // MARK ATTENDANCE
  static Future<void> markAttendance({
    required String userId,
    required String course,
    required String status,
      required String name,
  }) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
         "name": name,
        "Course": course,
        "Status": status,
        "attendanceDate": DateTime.now().toIso8601String(),
      }),
    );
  }

  // GET ALL ATTENDANCE
  static Future<List<dynamic>> getAttendance() async {
    final res = await http.get(Uri.parse(baseUrl));
    return jsonDecode(res.body);
  }
}