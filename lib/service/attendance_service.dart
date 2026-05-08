class AttendanceService {

  static final Set<String> _presentStudents = {};

  
  static final List<Map<String, dynamic>> _attendanceHistory = [];


  static void markPresent(String email) {
    _presentStudents.add(email);
  }

 
  static bool isPresent(String email) {
    return _presentStudents.contains(email);
  }

  static int get presentCount => _presentStudents.length;

  
  static void reset() {
    _presentStudents.clear();
  }


  static void saveAttendance({
    required String name,
    required String email,
    required String courseCode,
    required String courseName,
  }) {
    _attendanceHistory.add({
      "name": name,
      "email": email,
      "courseCode": courseCode,
      "courseName": courseName,
      "present": true,
      "date": DateTime.now(),
    });
  }


  static List<Map<String, dynamic>>
      getAttendanceByCourseAndDate(
    String courseCode,
    DateTime selectedDate,
  ) {
    return _attendanceHistory.where((record) {

      final date = record["date"] as DateTime;

      return record["courseCode"] == courseCode &&
          date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;

    }).toList();
  }

  
  static List<Map<String, dynamic>> getAllHistory() {
    return _attendanceHistory;
  }
}