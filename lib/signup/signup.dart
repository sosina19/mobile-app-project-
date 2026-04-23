import 'package:flutter/material.dart';
import 'studentsignup.dart';
import 'teachersignup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isStudent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              // TOP BAR
              SafeArea(
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF1E4B7A),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Icon(
                        Icons.school,
                        color: Color.fromARGB(255, 204, 223, 240),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "DDU Attendance System",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // MAIN CONTAINER HOLDING SELECTOR + FORM
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // SELECTOR BUTTONS INSIDE CONTAINER
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140, // change width here
                            child: ChoiceChip(
                              label: Center(child: Text("Student")),
                              selected: isStudent,
                              onSelected: (val) {
                                setState(() => isStudent = true);
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          SizedBox(
                            width: 140, // change width here
                            child: ChoiceChip(
                              label: Center(child: Text("Teacher")),
                              selected: !isStudent,
                              onSelected: (val) {
                                setState(() => isStudent = false);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // FORM AREA INSIDE CONTAINER
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isStudent
                              ? const Studentsignup(
                                  key: ValueKey("student"),
                                )
                              : const TeacherSignupPage(
                                  key: ValueKey("teacher"),
                                ),
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
    );
  }
}