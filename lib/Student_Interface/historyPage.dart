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

  // MODE 1: DAILY CHECK
  Future<void> checkAttendance() async {
    if (selectedCourse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a course")),
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
        if (item["attendanceDate"] == null) return false;

        final date = DateTime.parse(item["attendanceDate"]);

        return item["Course"].toString().toLowerCase() ==
                selectedCourse.toLowerCase() &&
            date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day;
      }).toList();

      if (filtered.isEmpty) {
        setState(() {
          statusMessage = "NO ATTENDANCE TAKEN";
          loading = false;
        });
        return;
      }

      final exists = filtered.any((item) {
        return item["userId"] == widget.studentId;
      });

      setState(() {
        statusMessage = exists ? "PRESENT" : "ABSENT";
        loading = false;
      });
    } catch (e) {
      setState(() {
        statusMessage = "ERROR LOADING DATA";
        loading = false;
      });
    }
  }

  // MODE 2: COURSE REPORT

  Future<void> loadCourseReport() async {
    if (selectedCourse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select a course first")),
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

      final courseRecords = records.where((item) {
        return item["Course"].toString().toLowerCase() ==
            selectedCourse.toLowerCase();
      }).toList();

      final sessions = courseRecords.map((item) {
        final d = DateTime.parse(item["attendanceDate"]);
        return DateTime(d.year, d.month, d.day);
      }).toSet();

      final studentRecords = courseRecords.where((item) {
        return item["userId"] == widget.studentId;
      }).toList();

      final presentDates = studentRecords.map((item) {
        final d = DateTime.parse(item["attendanceDate"]);
        return DateTime(d.year, d.month, d.day);
      }).toSet();

      int totalSessions = sessions.length;
      int presentCount = presentDates.length;
      int absentCount = totalSessions - presentCount;

      double percentage =
          totalSessions == 0 ? 0 : (presentCount / totalSessions) * 100;

      setState(() {
        statusMessage =
            "Present: $presentCount | Absent: $absentCount | ${percentage.toStringAsFixed(1)}%";
        loading = false;
      });
    } catch (e) {
      setState(() {
        statusMessage = "ERROR LOADING DATA";
        loading = false;
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
    if (statusMessage.contains("PRESENT")) return Colors.green;
    if (statusMessage.contains("ABSENT")) return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 225, 225),
      appBar: AppBar(
           automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF1E4B7A),
        title: const Text("Attendance History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SELECT DATE",
                style: TextStyle(color: Colors.grey)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(selectedDate),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("SELECT COURSE",
                style: TextStyle(color: Colors.grey)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCourse.isEmpty
                          ? "Enter Course"
                          : selectedCourse,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // TWO MODES
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : checkAttendance,
                    child: const Text("Check Specific Day"),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : loadCourseReport,
                    child: const Text("View Course Report"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            if (statusMessage.isNotEmpty)
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  decoration: BoxDecoration(
                    color: getStatusColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getStatusColor(),
                      fontSize: 18,
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