import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherSignupPage extends StatefulWidget {
  const TeacherSignupPage({super.key});

  @override
  State<TeacherSignupPage> createState() => _TeacherSignupPageState();
}

class _TeacherSignupPageState extends State<TeacherSignupPage> {
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isLoading = false;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final studentIdController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedDepartment;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    studentIdController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> createTeacherAccount() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse("https://s-backend-5f4c.onrender.com/users");

    try {
      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "fullName": fullNameController.text.trim(),
              "email": emailController.text.trim(),
              "password": passwordController.text.trim(),
              "studId": studentIdController.text.trim(),
              "department": selectedDepartment ?? "",
              "phoneNo": phoneController.text.trim(),
              "role": "Teacher",
            }),
          )
          .timeout(const Duration(seconds: 40));

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully"),
            backgroundColor: Colors.green,
          ),
        );

        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        studentIdController.clear();
        phoneController.clear();

        setState(() => selectedDepartment = null);

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server error: $e")),
      );
    }

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // TOP BAR
                  SafeArea(
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF1E4B7A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
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

                  const SizedBox(height: 20),

                  const Text(
                    "Teacher Portal",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Join the academic community",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  label("FULL NAME"),
                  textField(
                    controller: fullNameController,
                    hint: "",
                    icon: Icons.person_outline,
                    validator: (v) => v == null || v.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 20),

                  label("EMAIL"),
                  textField(
                    controller: emailController,
                    hint: "",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      if (!v.contains("@")) return "Invalid email";
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label("PASSWORD"),
                            passwordField(
                              controller: passwordController,
                              isHidden: hidePassword,
                              onTap: () {
                                setState(() => hidePassword = !hidePassword);
                              },
                              validator: (v) {
                                if (v == null || v.length < 6) {
                                  return "Minimum 6 characters";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label("CONFIRM"),
                            passwordField(
                              controller: confirmPasswordController,
                              isHidden: hideConfirmPassword,
                              onTap: () {
                                setState(() => hideConfirmPassword = !hideConfirmPassword);
                              },
                              validator: (v) {
                                if (v == null || v.isEmpty) return "Required";
                                if (v != passwordController.text) return "No match";
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  label("Teacher ID"),
                  textField(
                    controller: studentIdController,
                    hint: "",
                    icon: Icons.badge,
                    validator: (v) => v == null || v.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 20),

                  label("DEPARTMENT"),
                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.school),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "software engineering",
                        child: Text("Software Engineering"),
                      ),
                      DropdownMenuItem(value: "IT", child: Text("IT")),
                      DropdownMenuItem(
                        value: "computer science",
                        child: Text("Computer Science"),
                      ),
                      DropdownMenuItem(
                        value: "architecture",
                        child: Text("Architecture"),
                      ),
                      DropdownMenuItem(
                        value: "socialscience",
                        child: Text("Social Science"),
                      ),
                      DropdownMenuItem(
                        value: "electrical engineering",
                        child: Text("Electrical Engineering"),
                      ),
                      DropdownMenuItem(
                        value: "Applied science",
                        child: Text("Applied Science"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => selectedDepartment = value);
                    },
                    validator: (v) => v == null ? "Select department" : null,
                  ),

                  const SizedBox(height: 20),

                  label("PHONE"),
                  textField(
                    controller: phoneController,
                    hint: "",
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) => v == null || v.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: 180,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D3B66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : createTeacherAccount,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Create Account",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D3B66),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "DDU REGISTRY",
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 100, 100, 100),
          ),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget passwordField({
    required TextEditingController controller,
    required bool isHidden,
    required VoidCallback onTap,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isHidden,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
            onPressed: onTap,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
