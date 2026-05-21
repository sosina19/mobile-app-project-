import 'package:flutter/material.dart';
import '../service/attendance_service.dart';

class HistoryPage extends StatefulWidget {
  final String studentId;

  const HistoryPage({
    super.key,
    required this.studentId,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime selectedDate = DateTime.now();

  String selectedCourse = "";

  String statusMessage = "";

  bool loading = false;

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
            hintText: "e.g. Security",
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
              });

              Navigator.pop(context);
            },
            child: const Text("Apply"),
          ),
        ],
      ),
    );
  }

  Future<void> checkAttendance() async {
    if (selectedCourse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a course"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
      statusMessage = "";
    });

    try {
      final data = await AttendanceService.getAttendance();

      final records = List<Map<String, dynamic>>.from(data);

      final filtered = records.where((item) {
        if (item["attendanceDate"] == null) {
          return false;
        }

        final date = DateTime.parse(item["attendanceDate"]);

        return item["Course"]
                    .toString()
                    .toLowerCase() ==
                selectedCourse.toLowerCase() &&
            date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;
      }).toList();

      // No attendance session created
      if (filtered.isEmpty) {
        setState(() {
          statusMessage = "NO ATTENDANCE TAKEN";
          loading = false;
        });

        return;
      }

      // Attendance session exists
      final exists = filtered.any((item) {
        return item["userId"] == widget.studentId;
      });

      setState(() {
        statusMessage = exists ? "PRESENT" : "ABSENT";
        loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        loading = false;
        statusMessage = "ERROR LOADING DATA";
      });
    }
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

  Color getStatusColor() {
    if (statusMessage == "PRESENT") {
      return Colors.green;
    }

    if (statusMessage == "ABSENT") {
      return Colors.red;
    }

    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        228,
        225,
        225,
      ),

      appBar: AppBar(
        title: const Text("Attendance History"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SELECT DATE",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: pickDate,

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      formatDate(selectedDate),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "SELECT COURSE",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: enterCourse,

              child: Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      selectedCourse.isEmpty
                          ? "Enter Course"
                          : selectedCourse,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : checkAttendance,

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "CHECK ATTENDANCE",
                        ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            if (statusMessage.isNotEmpty)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),

                  decoration: BoxDecoration(
                    color: getStatusColor()
                        .withOpacity(0.15),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: Text(
                    statusMessage,

                    style: TextStyle(
                      color: getStatusColor(),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
