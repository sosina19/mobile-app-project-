import 'package:flutter/material.dart';

class Studentsignup extends StatefulWidget {
  const Studentsignup({super.key});

  @override
  State<Studentsignup> createState() => _StudentsignupState();
}

class _StudentsignupState extends State<Studentsignup> {
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

  // ✅ FAKE SIGNUP (NO FIREBASE / NO ROUTING)
  Future<void> createStudentAccount() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully"),
        backgroundColor: Colors.green,
      ),
    );

    // optional clear fields
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    studentIdController.clear();
    phoneController.clear();
    setState(() => selectedDepartment = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),

                const Text(
                  "Student Portal",
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
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
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
                                return "Minimum6 characters";
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
                              setState(() =>
                                  hideConfirmPassword = !hideConfirmPassword);
                            },
                            validator: (v) {
                              if (v != passwordController.text) {
                                return "No match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                label("STUDENT ID"),
                textField(
                  controller: studentIdController,
                  hint: "",
                  icon: Icons.badge,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 20),

                label("DEPARTMENT"),
                DropdownButtonFormField<String>(
                  value: selectedDepartment,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: "Engineering", child: Text("Engineering")),
                    DropdownMenuItem(value: "IT", child: Text("IT")),
                    DropdownMenuItem(
                        value: "Business", child: Text("Business")),
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
                  validator: (v) =>
                      v == null || v.isEmpty ? "Required" : null,
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
                    onPressed: isLoading ? null : createStudentAccount,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white)
                        : const Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    "DDU REGISTRY",
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.grey,
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

  // LABEL
  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        color: Colors.black54,
      ),
    );
  }

  // TEXT FIELD
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
          prefixIcon: Icon(icon, color: Colors.grey),
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

  // PASSWORD FIELD
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
            icon: Icon(
              isHidden ? Icons.visibility_off : Icons.visibility,
            ),
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