import 'package:flutter/material.dart';

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

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const Center(child: Text("Home Page", style: TextStyle(fontSize: 20))),

      const Center(child: Text("Courses Page", style: TextStyle(fontSize: 20))),

      // 📷 QR PAGE
      QrPage(
        studentId: widget.studentId,
        name: widget.name,
        email: widget.email,
      ),

      // 📊 HISTORY PAGE
      HistoryPage(
        studentId: widget.studentId,
        name: widget.name,
        email: widget.email,
      ),

      // 👤 PROFILE PAGE
      Profile(
        studentId: widget.studentId,
        name: widget.name,
        email: widget.email,
        role: widget.role,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1B305B),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Courses",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "QR"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
