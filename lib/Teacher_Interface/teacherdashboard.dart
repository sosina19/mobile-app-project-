import 'package:flutter/material.dart';
import 'package:mobile_app/Teacher_Interface/attendance_history.dart';
import '../service/course_service.dart';
import '../model/course.dart';
import '../service/token_service.dart';
import '../service/attendance_service.dart';

import 'create_course.dart';
import '../Student_Interface/profile.dart';
import 'scan_qr.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int currentIndex = 0;

  List<Course> courses = []; // ✅ keep this

  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadCourses(); // 🔥 FIXED (no direct assignment anymore)
  }

  // 🔥 FIX 1: async course loading
  Future<void> loadCourses() async {
    courses = await CourseService.getCourses();
    setState(() {});
  }

  Future<void> loadUserData() async {
    name = await TokenService.getName();
    email = await TokenService.getEmail();
    setState(() {});
  }

  String formatName(String? name) {
    if (name == null || name.isEmpty) return "Teacher";
    return name[0].toUpperCase() + name.substring(1);
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  int getTotalStudents(List<Course> courses) {
    return courses.fold(0, (sum, c) => sum + c.students);
  }

  double getAvgAttendance(List<Course> courses) {
    int total = getTotalStudents(courses);
    if (total == 0) return 0;
    return (AttendanceService.presentCount / total) * 100;
  }

  String getCurrentYear() => DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homePage(courses),
      const ScanQrPage(),
      _historyPage(),
      ProfilePage(name: name ?? "Loading...", email: email ?? "Loading..."),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      appBar: AppBar(
        automaticallyImplyLeading: false,
       backgroundColor:const Color(0xFF1E4B7A),
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Dire Dawa University",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),

      body: pages[currentIndex],

      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateCoursePage()),
                );

                // 🔥 FIX 2: reload correctly after adding course
                if (result == true) {
                  loadCourses();
                }
              },
              child: const Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: const Color(0xFF1E4B7A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _homePage(List<Course> courses) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "ACADEMIC YEAR ${getCurrentYear()}",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 5),

          Text(
            "${getGreeting()}, ${formatName(name)}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  "AVG. ATTENDANCE",
                  "${getAvgAttendance(courses).toStringAsFixed(1)}%",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  "TOTAL STUDENTS",
                  getTotalStudents(courses).toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E4B7A),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quick Attendance",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => setState(() => currentIndex = 1),
                  child: const Text("Go to Scan QR"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Active Courses",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Column(children: courses.map((c) => _courseItem(c)).toList()),
        ],
      ),
    );
  }

  Widget _historyPage() {
    return const AttendanceHistoryPage();
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E4B7A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _courseItem(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.book, color: Color(0xFF1E4B7A)),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${course.code}: ${course.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  "Year ${course.year} • ${course.students} Students",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // 🔥 DELETE BUTTON
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),

            onPressed: () async {
              await CourseService.deleteCourse(course.code);

              loadCourses();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Course deleted")));
            },
          ),
        ],
      ),
    );
  }
}
