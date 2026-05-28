import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/course.dart';
import '../service/attendance_service.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  DateTime selectedDate = DateTime.now();

  String selectedCourse = "";
  bool showWholeHistory = false;

  List<Map<String, dynamic>> records = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      selectedCourse = "";
      records = [];
    });
  }

  Future<void> loadRecords() async {
    if (selectedCourse.isEmpty) return;

    try {
      final data = await AttendanceService.getAttendance();

      final List<Map<String, dynamic>> typedData =
          List<Map<String, dynamic>>.from(data);

      records = typedData.where((item) {
        final date = DateTime.parse(item["attendanceDate"]);

        final sameCourse =
            item["Course"].toString().toLowerCase() ==
                selectedCourse.toLowerCase();

        if (showWholeHistory) {
          return sameCourse;
        }

        return sameCourse &&
            date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;
      }).toList();

      setState(() {});
    } catch (e) {
      debugPrint("Error loading attendance: $e");
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      loadRecords();
    }
  }

  Future<void> enterCourse() async {
    final controller = TextEditingController();

    bool allHistory = false;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Enter Course"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "e.g. Software Engineering",
                  ),
                ),
                const SizedBox(height: 15),
                CheckboxListTile(
                  value: allHistory,
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Show Whole History"),
                  onChanged: (value) {
                    setDialogState(() {
                      allHistory = value ?? false;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final course = controller.text.trim();

                  if (course.isEmpty) return;

                  setState(() {
                    selectedCourse = course;
                    showWholeHistory = allHistory;
                    records = [];
                  });

                  Navigator.pop(context);
                  loadRecords();
                },
                child: const Text("Apply"),
              ),
            ],
          );
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    List months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];

    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

Future<void> loadFrequentAbsentees() async {
  if (selectedCourse.isEmpty) return;

  try {
    final data = await AttendanceService.getAttendance();

    final List<Map<String, dynamic>> all =
        List<Map<String, dynamic>>.from(data);

    // STEP 1: filter by course
    final courseRecords = all.where((item) {
      return item["Course"].toString().toLowerCase() ==
          selectedCourse.toLowerCase();
    }).toList();

    // STEP 2: count absences per student + store details
    Map<String, int> absenceCount = {};
    Map<String, Map<String, dynamic>> studentInfo = {};

    for (var item in courseRecords) {
      final userId = item["userId"]?.toString();
      if (userId == null) continue;

      studentInfo[userId] = item;

      final status = item["status"]?.toString().toLowerCase();

      if (status == "absent") {
        absenceCount[userId] = (absenceCount[userId] ?? 0) + 1;
      }
    }

    // STEP 3: filter > 3 absences
    final List<Map<String, dynamic>> result = [];

    absenceCount.forEach((userId, count) {
      if (count > 3) {
        final student = studentInfo[userId]!;
        result.add({
          ...student,
          "absentCount": count,
        });
      }
    });

    setState(() {
      records = result;
    });
  } catch (e) {
    debugPrint("Error: $e");
  }
}
  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ACADEMIC YEAR $currentYear",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          const Text(
            "Attendance History",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("DATE", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(
                      formatDate(selectedDate),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: pickDate,
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF1E4B7A),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          GestureDetector(
            onTap: enterCourse,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("COURSE",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 5),
                      Text(
                        selectedCourse.isEmpty
                            ? "Enter Course"
                            : selectedCourse,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.edit),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),

             Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: loadFrequentAbsentees,
                icon: const Icon(Icons.person_off, size: 18),
                label: const Text("Absent > 3 Days"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "STUDENT REGISTRY",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${records.length} Records Found",
                  style: const TextStyle(color: Color(0xFF1E4B7A)),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Expanded(
            child: records.isEmpty
                ? const Center(child: Text("No attendance records"))
                : ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (_, index) {
                      final student = records[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (student["user"]?["fullName"] ??
                                            "Unknown Student")
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    student["user"]?["studId"] ?? "",
                                    style: const TextStyle(
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    student["attendanceDate"]
                                        .toString()
                                        .split("T")[0],
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                           Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "ABSENT: ${student["absentCount"] ?? 0}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}