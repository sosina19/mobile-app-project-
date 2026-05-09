class Course {
  final String name;
  final String code;
  final String department;
  final int students;
  final String year;
  final String semester;

  Course({
    required this.name,
    required this.code,
    required this.department,
    required this.students,
    required this.year,
    required this.semester,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "code": code,
      "department": department,
      "students": students,
      "year": year,
      "semester": semester,
    };
  }

  // 🔥 convert json → object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json["name"],
      code: json["code"],
      department: json["department"],
      students: json["students"],
      year: json["year"],
      semester: json["semester"],
    );
  }
}
