import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

  Course? selectedCourse;
  bool scanningStarted = false;
  bool isProcessing = false;

  final Set<String> scannedEmails = {};
  final List<Map<String, String>> recentScans = [];

  Future<bool> _onBack() async => false;

  void selectCourse() {
    final courses = CourseService.getCourses();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Choose Course"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (_, i) {
              final c = courses[i];
              return ListTile(
                title: Text(c.name),
                subtitle: Text(c.code),
                onTap: () {
  setState(() {
    selectedCourse = c;
    scanningStarted = true;

    scannedEmails.clear();
    recentScans.clear();

    AttendanceService.reset();
  });

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("${c.code} selected"),
      backgroundColor: const Color(0xFF1E4B7A),
      duration: const Duration(seconds: 2),
    ),
  );
},
              );
            },
          ),
        ),
      ),
    );
  }

  void handleScan(String raw) async {
    if (!scanningStarted || isProcessing) return;

    isProcessing = true;

    try {
      final data = jsonDecode(raw);

      final name = data["name"] ?? "Unknown";
      final email = data["email"] ?? "";

      if (email.isEmpty) return;

      if (AttendanceService.isPresent(email)) return;

      AttendanceService.markPresent(email);
      AttendanceService.saveAttendance(
  name: name,
  email: email,
  courseCode: selectedCourse!.code,
  courseName: selectedCourse!.name,
);
      scannedEmails.add(email);

      recentScans.insert(0, {
        "name": name,
        "email": email,
      });

      if (recentScans.length > 5) recentScans.removeLast();

      setState(() {});
    } catch (_) {}

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
          backgroundColor: Colors.white,
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

            ElevatedButton(
              onPressed: selectCourse,
              child: Text(selectedCourse == null
                  ? "Choose Course"
                  : "Change Course"),
            ),

            const SizedBox(height: 10),

            Expanded(
              flex: 4,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  final bar = capture.barcodes.first;
                  if (bar.rawValue != null) {
                    handleScan(bar.rawValue!);
                  }
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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${scannedEmails.length} Present",
                          style: const TextStyle(
                              color: Color(0xFF1E4B7A),
                              fontWeight: FontWeight.bold),
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
                                  subtitle: Text(s["email"]!),
                                  trailing: const Icon(Icons.check,
                                      color: Colors.green),
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