import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/course.dart';

class CourseService {
  static const String key = "courses";

  // 🔥 SAVE COURSE
  static Future<void> addCourse(Course course) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = prefs.getStringList(key) ?? [];

    data.add(jsonEncode(course.toJson()));

    await prefs.setStringList(key, data);
  }

  // 🔥 GET COURSES
  static Future<List<Course>> getCourses() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = prefs.getStringList(key) ?? [];

    return data.map((item) => Course.fromJson(jsonDecode(item))).toList();
  }

  // 🔥 DELETE COURSE
  static Future<void> deleteCourse(String code) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = prefs.getStringList(key) ?? [];

    data.removeWhere((item) {
      final course = Course.fromJson(jsonDecode(item));
      return course.code == code;
    });

    await prefs.setStringList(key, data);
  }
}
