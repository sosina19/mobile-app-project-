import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import '../model/course.dart';
import '../service/course_service.dart';
import '../service/attendance_service.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController controller = MobileScannerController();
  final TextEditingController courseController = TextEditingController();

  String selectedCourse = "";
  bool scanningStarted = false;
  bool isProcessing = false;
  bool _courseWarningShown = false;
  final Set<String> scannedid = {};
  final List<Map<String, String>> recentScans = [];

  Future<bool> _onBack() async => false;
  Future<void> selectCourse() async {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Course"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "e.g. Mathematics 101"),
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
                scanningStarted = true;

                scannedid.clear();
                recentScans.clear();
                _courseWarningShown = false;
              });

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$course selected"),
                  backgroundColor: const Color(0xFF1E4B7A),
                ),
              );
            },
            child: const Text("Start"),
          ),
        ],
      ),
    );
  }

  void handleScan(String raw) async {
    if (!scanningStarted || isProcessing) return;

    isProcessing = true;

    try {
      final data = jsonDecode(raw);
      final id = data["id"] ?? "";
      final name = data["name"] ?? "Unknown";

      if (id.isEmpty) return;

      // prevent duplicate scan in UI
      if (scannedid.contains(id)) return;

      scannedid.add(id);

      // SEND TO BACKEND (THIS IS THE REAL FIX)
      await AttendanceService.markAttendance(
        userId: id,
        name: name,
        course: selectedCourse,
        status: "present",
      );

      recentScans.insert(0, {"name": name, "id": id});

      if (recentScans.length > 5) {
        recentScans.removeLast();
      }

      setState(() {});
    } catch (e) {
      debugPrint("QR error: $e");
    }

    await Future.delayed(const Duration(seconds: 2));
    isProcessing = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 214, 210, 210),
          elevation: 0,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Scan Attendance",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        body: Column(
          children: [
            const SizedBox(height: 10),

           GestureDetector(
  onTap: selectCourse,
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF1E4B7A),
          Color(0xFF2F80ED),
        ],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        const Icon(
          Icons.menu_book_rounded,
          color: Colors.white,
          size: 28,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Course Input",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                selectedCourse.isEmpty
                    ? "Tap to enter course name"
                    : selectedCourse,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        const Icon(
          Icons.edit,
          color: Colors.white,
          size: 18,
        ),
      ],
    ),
  ),
),

            const SizedBox(height: 10),

            SizedBox(
              height: 250,
              width: 250,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) async {
                  final barcodes = capture.barcodes;

                  if (barcodes.isEmpty) return;

                  final raw = barcodes.first.rawValue;

                  if (raw == null || raw.isEmpty) return;

                  // NO COURSE SELECTED
                  if (selectedCourse.isEmpty) {
                    if (!_courseWarningShown) {
                      _courseWarningShown = true;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a course first"),
                        ),
                      );
                    }

                    return;
                  }

                  // COURSE EXISTS
                  _courseWarningShown = false;

                  handleScan(raw);
                },
              ),
            ),

            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Scans",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${scannedid.length} Present",
                          style: const TextStyle(
                            color: Color(0xFF1E4B7A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: recentScans.isEmpty
                          ? const Center(child: Text("No scans yet"))
                          : ListView(
                              children: recentScans.map((s) {
                                return ListTile(
                                  title: Text(s["name"]!),
                                  subtitle: Text(s["id"]!),
                                  trailing: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
