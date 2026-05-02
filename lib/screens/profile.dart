import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../service/token_service.dart';
import 'package:mobile_app/login/log_in.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({super.key, required this.name, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imagePath;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => imagePath = file.path);
    }
  }

  Future<void> logout() async {
    await TokenService.clear();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 228, 225, 225),
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await logout();
              },
              child: const Text("Yes", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 225, 225),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4B7A),
        title: const Text("Profile"),
        centerTitle: true,
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
                  children: [
                    // 👤 PROFILE CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                                image: imagePath != null
                                    ? DecorationImage(
                                        image: FileImage(File(imagePath!)),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: imagePath == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),

                          const SizedBox(height: 15),

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
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "DEPARTMENT",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Software Engineering",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 244, 244),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                      child: _item(Icons.settings, "Account Settings", () {}),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 244, 244),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                      child: _item(Icons.lock, "Privacy Policy", () {}),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 244, 244),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                      child: _item(
                        Icons.logout,
                        "Logout",
                        confirmLogout,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _item(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.black,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),

      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        onTap: onTap,
      ),
    );
  }
}
