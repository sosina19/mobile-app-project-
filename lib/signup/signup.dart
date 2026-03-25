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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(backgroundColor: Colors.grey[100]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "SignUp Page",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // bold
                  color: Colors.blue, // text color
                  fontFamily: "Roboto", // font family
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isStudent = true;
                    });
                  },
                  child: Text("Student"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isStudent = false;
                    });
                  },
                  child: Text("Teacher"),
                ),
              ],
            ),

            SizedBox(height: 30),

            Expanded(
              child: Center(
                child: isStudent ? studentsignup() : TeacherSignup(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
