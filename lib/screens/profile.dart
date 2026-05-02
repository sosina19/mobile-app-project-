import 'package:flutter/material.dart';
import 'package:mobile_app/login/log_in.dart';
import 'package:mobile_app/service/token_service.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({super.key, required this.name, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout() async {
    await TokenService.clear();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void showEmailDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Student Email"),
        content: Text(widget.email),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 📌 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4B7A),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: showEmailDialog,
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                // 🧾 PROFILE CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E4B7A),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 👤 ICON
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 246, 246, 247),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.name.isNotEmpty ? widget.name[0] : "U",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E4B7A),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // NAME
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // EMAIL
                      Text(
                        widget.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 🏫 DEPARTMENT
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DEPARTMENT",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.school, color: Color(0xFF1E4B7A)),
                      SizedBox(width: 10),
                      Text(
                        "Software Engineering",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ⚙️ SETTINGS
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ACADEMIC SETTINGS",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                _item(Icons.privacy_tip, "Privacy Policy", () {}),
                _item(Icons.settings, "Account Settings", () {}),

                const SizedBox(height: 25),

                // 🔴 LOGOUT
                GestureDetector(
                  onTap: logout,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "LOG OUT",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1E4B7A)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
