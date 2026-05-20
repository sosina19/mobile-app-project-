class AttendanceService {

  static final Set<String> _presentStudents = {};

  
  static final List<Map<String, dynamic>> _attendanceHistory = [];


  static void markPresent(String id) {
    _presentStudents.add(id);
  }

 
  static bool isPresent(String id) {
    return _presentStudents.contains(id);
  }

  static int get presentCount => _presentStudents.length;

  
  static void reset() {
    _presentStudents.clear();
  }


  static void saveAttendance({
    required String id,
    required String name,
    required String courseCode,
    required String courseName,
  }) {
    _attendanceHistory.add({
      "name": name,
      "id": id,
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