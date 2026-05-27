import 'package:flutter/material.dart';
import 'package:Qr_Attendance/Teacher_Interface/attendance_history.dart';
import '../service/course_service.dart';
import '../model/course.dart';
import '../service/token_service.dart';

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
  List<Course> courses = [];
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadCourses();
  }

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

  String getCurrentYear() => DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    // 1. Detect if Dark Mode is active
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = [
      _homePage(courses, isDark), // Pass dark mode flag down
      const ScanQrPage(),
      _historyPage(),
      ProfilePage(name: name ?? "Loading...", email: email ?? "Loading..."),
    ];

    return Scaffold(
      // 2. Dynamic app background color
      backgroundColor: isDark
          ? Colors.black
          : const Color.fromARGB(255, 214, 210, 210),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        // 3. Dynamic AppBar background color
        backgroundColor: isDark
            ? const Color(0xFF123456)
            : const Color(0xFF1E4B7A),
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Dire Dawa University",
            // 4. Dynamic AppBar Title text color
            style: TextStyle(
              color: isDark ? Colors.white : Colors.white60,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            // 5. Dynamic Action Icon Color
            child: Icon(
              Icons.notifications_none,
              color: isDark ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),

      body: pages[currentIndex],

      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: isDark
                  ? const Color(0xFF5B92E5)
                  : const Color(0xFF1E4B7A),
              foregroundColor: Colors.white,
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateCoursePage()),
                );

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
        // 6. Dynamic Bottom Navigation color palette mapping
        selectedItemColor: isDark
            ? const Color(0xFF5B92E5)
            : const Color(0xFF1E4B7A),
        unselectedItemColor: isDark ? Colors.grey[500] : Colors.grey,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
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

  Widget _homePage(List<Course> courses, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "ACADEMIC YEAR ${getCurrentYear()}",
            style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
          ),

          const SizedBox(height: 5),

          Text(
            "${getGreeting()}, ${formatName(name)}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          // Quick Attendance Banner Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF123456) : const Color(0xFF1E4B7A),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF5B92E5)
                        : Colors.white,
                    foregroundColor: isDark
                        ? Colors.white
                        : const Color(0xFF1E4B7A),
                  ),
                  onPressed: () => setState(() => currentIndex = 1),
                  child: const Text("Go to Scan QR"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Active Courses",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          Column(children: courses.map((c) => _courseItem(c, isDark)).toList()),
        ],
      ),
    );
  }

  Widget _historyPage() {
    return const AttendanceHistoryPage();
  }

  Widget _courseItem(Course course, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        // Card color changes safely matching light vs dark background
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.book,
            color: isDark ? const Color(0xFF5B92E5) : const Color(0xFF1E4B7A),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${course.code}: ${course.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),

                Text(
                  "Year ${course.year} • ${course.students} Students",
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await CourseService.deleteCourse(course.code);
              loadCourses();

              if (!mounted) return;
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
