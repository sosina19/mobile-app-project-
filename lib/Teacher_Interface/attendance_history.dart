import 'package:flutter/material.dart';

import '../model/course.dart';
import '../service/course_service.dart';
import '../service/attendance_service.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  DateTime selectedDate = DateTime.now();

  Course? selectedCourse;

  List<Map<String, dynamic>> records = [];

  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final courses = await CourseService.getCourses();

      if (courses.isNotEmpty) {
        setState(() {
          selectedCourse = courses.first;
        });

        loadRecords();
      }
    });
  }

  void loadRecords() {
    if (selectedCourse == null) return;

    records = AttendanceService.getAttendanceByCourseAndDate(
      selectedCourse!.code,
      selectedDate,
    );

    setState(() {});
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;

      loadRecords();
    }
  }

  Future<void> selectCourse() async {
    final courses = await CourseService.getCourses();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (_, index) {
            final course = courses[index];

            return ListTile(
              title: Text(course.name),
              subtitle: Text(course.code),
              onTap: () {
                selectedCourse = course;

                Navigator.pop(context);

                loadRecords();
              },
            );
          },
        );
      },
    );
  }

  String formatDate(DateTime date) {
    List months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];

    return "${months[date.month - 1]} ${date.day}, ${date.year}";
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
            onTap: selectCourse,

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
                      const Text(
                        "COURSE",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        selectedCourse?.name ?? "Choose Course",

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
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
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(Icons.person),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    student["email"],
                                    style: const TextStyle(color: Colors.grey),
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
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: const Text(
                                "PRESENT",
                                style: TextStyle(
                                  color: Colors.green,
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
