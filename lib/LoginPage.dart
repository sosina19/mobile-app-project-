import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_app/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameC = TextEditingController();
  final _idC = TextEditingController();

  Future<void> _login() async {
    final enteredName = _nameC.text.trim();
    final enteredId = _idC.text.trim();

    if (enteredName.isEmpty || enteredId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter name and ID")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString("user_data");

    if (jsonString == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No account found. Please register.")),
      );
      return;
    }

    final userData = jsonDecode(jsonString);

    final savedName = userData["name"];
    final savedId = userData["id"];

    if (enteredName == savedName && enteredId == savedId) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect Name or ID")),
      );
    }
  }

  @override
  void dispose() {
    _nameC.dispose();
    _idC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("")),
      backgroundColor: Colors.white,
      body: Center(
        child:SizedBox(
        width: 400,
        child:Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

      // School Icon
      const Icon(
        Icons.school,
        size: 40,
        color: Color(0xff204381),
      ),
        const SizedBox(height: 20),
              Text(
                "DIREDAWA UNIVERSITY",
                style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color:Color(0xff204381)),
                    textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
           "portal access for students and faculity \nmembers",
           style:TextStyle(
                    fontSize: 15,
                    color:Colors.grey),
                    textAlign: TextAlign.center,
                    ),
                     const SizedBox(height: 20),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _nameC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color(0xffd7d5d5)),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Id:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _idC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Color(0xffd7d5d5)),
                  ),
                ],
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: 180,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 60),
                    elevation: 0,
                    shadowColor: Colors.black,
                    backgroundColor: const Color(0xff204381),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _login,
                  child: Text(
                    'Login ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontFamily: 'Arial',
                    ),
                  ),
                  
                ),
              ),
              const SizedBox(height: 20),
                Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF1E4B7A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}
