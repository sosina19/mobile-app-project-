import 'package:flutter/material.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teacher Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 53, 79, 122),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 40),

            const Center(
              child: Column(
                children: [
                  Text(
                    "Hello...",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome to Attendance System",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            _buildButton(
              icon: Icons.qr_code,
              text: "Scan QR Code",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            _buildButton(
              icon: Icons.menu_book,
              text: "My Courses",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            _buildButton(
              icon: Icons.calendar_month,
              text: "Attendance History",
              onTap: () {},
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home, size: 35),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person, size: 35),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.qr_code, size: 35),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_book, size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // reusable button
  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 30, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        backgroundColor: const Color.fromARGB(255, 53, 79, 122),
      ),
    );
  }
}
