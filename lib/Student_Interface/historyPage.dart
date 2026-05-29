import 'package:flutter/material.dart';
import '../service/attendance_service.dart';

class HistoryPage extends StatefulWidget {
  final String studentId;

  const HistoryPage({super.key, required this.studentId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime selectedDate = DateTime.now();

  String selectedCourse = "";
  String statusMessage = "";
  bool loading = false;
  int presentCount = 0;
  int absentCount = 0;
  double attendancePercentage = 0;
  bool showReport = false;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 245, 244, 244),
        title: Text(
          "Enter Course",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            hintText: "e.g. Security",
            hintStyle: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.grey[600]! : Colors.grey,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E4B7A),
              foregroundColor: Colors.white,
            ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a course")));
      return;
    }

    setState(() {
      loading = true;
      statusMessage = "";
      showReport = false;
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

  Future<void> loadCourseReport() async {
    if (selectedCourse.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Select a course first")));
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

      double percentage = totalSessions == 0
          ? 0
          : (presentCount / totalSessions) * 100;

      setState(() {
        this.presentCount = presentCount;
        this.absentCount = absentCount;
        attendancePercentage = percentage;
        showReport = true;
        statusMessage = "";
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

  // DARK MODE CARD WIDGET
  Widget buildModernCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 42),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[400] : Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.grey[900] : const Color(0xFF1E4B7A),
        title: Text(
          "Attendance History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SELECT DATE",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickDate,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(selectedDate),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "ENTER COURSE",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: enterCourse,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCourse.isEmpty
                            ? "Enter Course"
                            : selectedCourse,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Action buttons container layout
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF1E4B7A,
                            ).withOpacity(isDark ? 0.1 : 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? const Color(0xFF143252)
                              : const Color(0xFF1E4B7A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: loading ? null : checkAttendance,
                        child: const Text(
                          "Check Day",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(
                              isDark ? 0.1 : 0.25,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? Colors.green[700]
                              : Colors.green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: loading ? null : loadCourseReport,
                        child: const Text(
                          "View Report",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Status message
              if (statusMessage.isNotEmpty)
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.all(22),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: getStatusColor().withOpacity(0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          statusMessage.contains("PRESENT")
                              ? Icons.check_circle
                              : statusMessage.contains("ABSENT")
                              ? Icons.cancel
                              : statusMessage.contains("ERROR")
                              ? Icons.error
                              : Icons.info,
                          size: 70,
                          color: getStatusColor(),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          statusMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getStatusColor(),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Summary Data Metrics 
              if (showReport)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: buildModernCard(
                              title: "Present",
                              value: presentCount.toString(),
                              icon: Icons.check_circle,
                              color: Colors.green,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: buildModernCard(
                              title: "Absent",
                              value: absentCount.toString(),
                              icon: Icons.cancel,
                              color: Colors.red,
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    const Color(0xFF143252),
                                    const Color(0xFF1A4475),
                                  ]
                                : [
                                    const Color(0xFF1E4B7A),
                                    const Color(0xFF2F80ED),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(
                                isDark ? 0.1 : 0.25,
                              ),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.bar_chart,
                              color: Colors.white,
                              size: 45,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "${attendancePercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                               
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Attendance Rate",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
