import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:mobile_app/service/token_service.dart';
import 'admin.dart';
import 'package:mobile_app/Student_Interface/studentdashboard.dart';
import 'package:mobile_app/Teacher_Interface/teacherdashboard.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
  await Future.delayed(const Duration(seconds: 2));

  final token = await TokenService.getToken();
  final role = await TokenService.getRole();
  final id = await TokenService.getUserId();
  final name = await TokenService.getName();
  final email = await TokenService.getEmail();
  print("TOKEN: $token");
  print("ROLE: $role");
  if (!mounted) return;

  if (token != null && role != null) {
    if (role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminHome()),
      );
    } 
    else if (role == "teacher") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TeacherDashboard()),
      );
    } 
    else {
      //  FIX: you must NOT call empty constructor
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => StudentDashboard(
            studentId: id ?? "",
            name: name ?? "",
            email: email ?? "",
            role: role,
          ),
        ),
      );
    }
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Welcome()),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),

                // CENTER CONTENT
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 50,
                        color: Color(0xFF1E4B7A),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Dire Dawa University",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Divider(
                            indent: 60,
                            endIndent: 10,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          "ATTENDANCE SYSTEM",
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 2,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 60,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 50),
                Column(
                  children: [
                    SizedBox(
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: null, // makes it animated loading
                          backgroundColor: const Color.fromARGB(255,177,173,173,),
                          color: const Color(0xFF1E4B7A),
                          minHeight: 6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text("2026", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
