import 'package:flutter/material.dart';
import 'package:mobile_app/login/log_in.dart';
import 'package:mobile_app/service/token_service.dart';

// ✅ PAGES
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

  // ✅ CHANGEABLE ATTENDANCE VALUE
  int attendanceRate = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      _homePage(),
      const CoursePage(),
      const HistoryPage(),
      QrPage(name: widget.name, email: widget.email),
      ProfilePage(name: widget.name, email: widget.email),
    ];
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
        onTap: (index) {
          setState(() => currentIndex = index);
        },
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

  // ✅ HOME PAGE
  Widget _homePage() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 253),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4B7A),
        centerTitle: true,
        title: const Text(
          "Dire Dawa University",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Center(
        child: Container(
          width: 500,
          margin: const EdgeInsets.all(12),

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dire Dawa University",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E4B7A),
                  ),
                ),

                const SizedBox(height: 20),

                // 👤 STUDENT INFO CARD
                Center(
                  child: Container(
                    width: 480,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Color(0xFF1E4B7A),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromARGB(255, 252, 252, 252),
                          child: Icon(Icons.person, color: Color(0xFF1E4B7A)),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          widget.email,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
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

                          const SizedBox(width: 10),

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
          color: const Color(0xFFE3E9E2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.book, color: Color(0xFF1E4B7A)),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
