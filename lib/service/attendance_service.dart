class AttendanceService {
  // stores unique present students (by email)
  static final Set<String> _presentStudents = {};

  /// Mark a student as present
  static void markPresent(String email) {
    _presentStudents.add(email);
  }

  /// Check if already marked present
  static bool isPresent(String email) {
    return _presentStudents.contains(email);
  }

  /// Total present students
  static int get presentCount => _presentStudents.length;

  /// Reset attendance (new session / new course)
  static void reset() {
    _presentStudents.clear();
  }

  /// Get all present students (optional use for history page)
  static List<String> getAllPresent() {
    return _presentStudents.toList();
  }
}