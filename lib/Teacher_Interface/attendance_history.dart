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

  List<Map<String, dynamic>> records = [];

  @override
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

      return item["Course"] == selectedCourse &&
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

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Course"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "e.g. Software Engineering",
          ),
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
                   records = [];
              });

              Navigator.pop(context);
              loadRecords();
            },
            child: const Text("Apply"),
          ),
        ],
      ),
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
                      debugPrint(student.toString());
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
                                    (student["user"]?["fullName"]  ?? "Unknown Student").toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                  student["user"]?["studId"] ?? "",
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
