import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to previous page
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12, width: 1),
                ),
                child: const Icon(
                  Icons.person,
                  size: 90,
                  color: Color(0xFF1B305B),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello, Student',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'serif',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            _buttonItem(Icons.qr_code_2, 'My QR Code'),
            _buttonItem(Icons.article_outlined, 'My Courses'),
            _buttonItem(Icons.calendar_month, 'Attendance History'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buttonItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFE3E9E2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}