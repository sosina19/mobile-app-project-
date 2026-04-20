import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity, // 👈 gives full width
                  child: Text.rich(
                    TextSpan(
                      text: "DIRE DAWA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff204381),
                      ),
                      children: [
                        TextSpan(
                          text: "\nUNIVERSITY",
                          style: TextStyle(color: Color(0xff6b6b6b)),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left, // try left / center / right
                  ),
                ),
                SizedBox(height: 80),
                Text.rich(
                  TextSpan(
                    text: '   \nWelcome to ',
                    style: TextStyle(
                      fontSize: 40,
                      height: 1.2,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff080808),
                    ),
                    children: [
                      TextSpan(
                        text: "DDU",
                        style: TextStyle(
                          height: 1,
                          color: Color(0xff204381), // ✅ only this part is blue
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " Attendance \nSystem",
                        style: TextStyle(
                          fontSize: 40,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff080808),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Access the university portal to \nmanege acadamic presence \nand schedual',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff6d6d6d),
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 60),
                    elevation: 0,
                    shadowColor: Colors.black,
                    backgroundColor: const Color(0xff204381),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
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
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 60),
                    elevation: 0,
                    shadowColor: Colors.black,
                    backgroundColor: const Color(0xffd4d2d2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Creat Account',
                    style: TextStyle(
                      color: const Color(0xff204381),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      fontFamily: 'Arial',
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
}
