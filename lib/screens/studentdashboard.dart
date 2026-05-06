import 'package:flutter/material.dart';
import 'package:mobile_app/login/log_in.dart';
import 'package:mobile_app/service/token_service.dart';
// PAGES
import 'coursesPage.dart';
import 'QrPage.dart';
import 'historyPage.dart';
import 'profile.dart';

class StudentDashboard extends StatefulWidget {
  final String studentId;
  final String name;
  final String email;
  final String role;

  const StudentDashboard({
    super.key,
    required this.studentId,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int currentIndex = 0;
  String? email;
  int attendanceRate = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
      loadEmail();

    pages = [
      _homePage(),
      const CoursePage(),
      const HistoryPage(),
      QrPage(name: widget.name.toUpperCase(), email: widget.email),
      ProfilePage(name: widget.name.toUpperCase(), email: widget.email),
    ];
  }
  
  Future<void> loadEmail() async {
  String? savedEmail = await TokenService.getEmail();

  setState(() {
    email = savedEmail;
  });
} 

  Future<void> logout() async {
    await TokenService.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: const Color(0xFF1E4B7A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // ✅ RESPONSIVE HOME PAGE
  Widget _homePage() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 225, 225),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4B7A),
        centerTitle: true,
          title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.school, color: Colors.white),
          SizedBox(width: 8),
          Text(
            "Dire Dawa University",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
       actions: const [
    Padding(
      padding: EdgeInsets.only(right: 12),
      child: Icon(Icons.notifications_none, color: Colors.white),
    ),
  ],
 ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 600
              ? 600
              : constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: maxWidth,
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE (CENTERED)
                    const Center(
                      child: Text(
                        "Welcome To Student Dashboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E4B7A),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PROFILE CARD (FULL WIDTH RESPONSIVE)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF1E4B7A),
                              size: 40,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            widget.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            widget.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ATTENDANCE
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "ATTENDANCE RATE",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$attendanceRate%",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E4B7A),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📚 COURSES
                    const Text(
                      "Enrolled Courses",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4B7A),
                      ),
                    ),

                    const SizedBox(height: 15),

                    _courseItem("Software Engineering"),
                    _courseItem("Database Systems"),
                    _courseItem("Mobile App Development"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 📘 COURSE ITEM
  Widget _courseItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.book, color: Color(0xFF1E4B7A)),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
