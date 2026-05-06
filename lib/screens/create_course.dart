import 'package:flutter/material.dart';

import '../model/course.dart';
import '../service/course_service.dart';
class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final studentController = TextEditingController();

  String? department;
  String? year;
  String? semester;

  bool isLoading = false;

 
  void createCourse() {
    if (!_formKey.currentState!.validate()) return;

    if (semester == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select semester")),
      );
      return;
    }

    final course = Course(
      name: nameController.text.trim(),
      code: codeController.text.trim(),
      department: department!,
      students: int.parse(studentController.text.trim()),
      year: year!,
      semester: semester!,
    );

    CourseService.addCourse(course);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Course created successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    studentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("DDU", style: TextStyle(color: Colors.black)),
      ),

      body: Center(
        child: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  const Text(
                    "Create New Course",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Initialize academic registry for the new term.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                 
                  _label("COURSE NAME"),
                  _field(
                    controller: nameController,
                    hint: "e.g. Advanced Thermodynamics",
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 20),

                 
                  _label("COURSE CODE"),
                  _field(
                    controller: codeController,
                    hint: "MECH-4102",
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),

                  const SizedBox(height: 20),
                  _label("FACULTY / DEPARTMENT"),
                  DropdownButtonFormField<String>(
                    value: department,
                    decoration: _decoration(),
                    items: const [
                      DropdownMenuItem(value: "Software Engineering", child: Text("Software Engineering")),
                      DropdownMenuItem(value: "IT", child: Text("Information Technology")),
                      DropdownMenuItem(value: "Computer Science", child: Text("Computer Science")),
                    ],
                    onChanged: (v) => setState(() => department = v),
                    validator: (v) => v == null ? "Select department" : null,
                  ),

                  const SizedBox(height: 20),

                  
                  _label("NUMBER OF STUDENTS"),
                  _field(
                    controller: studentController,
                    hint: "e.g. 40",
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "Required";
                      if (int.tryParse(v) == null) return "Enter valid number";
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                 
                  _label("YEAR"),
                  DropdownButtonFormField<String>(
                    value: year,
                    decoration: _decoration(),
                    items: const [
                      DropdownMenuItem(value: "1", child: Text("1st Year")),
                      DropdownMenuItem(value: "2", child: Text("2nd Year")),
                      DropdownMenuItem(value: "3", child: Text("3rd Year")),
                      DropdownMenuItem(value: "4", child: Text("4th Year")),
                      DropdownMenuItem(value: "5", child: Text("5th Year")),
                    ],
                    onChanged: (v) => setState(() => year = v),
                    validator: (v) => v == null ? "Select year" : null,
                  ),

                  const SizedBox(height: 20),

                 
                  _label("SEMESTER"),
                  Row(
                    children: [
                      Expanded(child: _semesterBtn("1")),
                      const SizedBox(width: 10),
                      Expanded(child: _semesterBtn("2")),
                    ],
                  ),

                  const SizedBox(height: 30),

                
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E4B7A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : createCourse,
                      child: const Text(
                        "Deploy Course",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: _decoration(hint: hint),
      ),
    );
  }InputDecoration _decoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _semesterBtn(String value) {
    final selected = semester == value;

    return GestureDetector(
      onTap: () => setState(() => semester = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1E4B7A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value == "1" ? "Sem I" : "Sem II",
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}   