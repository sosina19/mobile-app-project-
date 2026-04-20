import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'LoginPage.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // DDU + ICON
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
              Icons.school,
              color: Color(0xff204381),
              size: 30,
            ),

      SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        text: "DIRE DAWA",
                        style: TextStyle(
                          fontSize: 18,
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
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: 8),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Welcome Text
              Text.rich(
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    fontSize: 29,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff080808),
                  ),
                  children: [
                    TextSpan(
                      text: "DDU",
                      style: TextStyle(
                        color: Color(0xff204381),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " \nAttendance System",
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff080808),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              Text(
                'Access the university portal to manage \nacademic presence and schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6d6d6d),
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 30),

              // LOGIN BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 60),
                  elevation: 0,
                  backgroundColor: Color(0xff204381),
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
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: 10),

              // REGISTER BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(180, 60),
                  elevation: 0,
                  backgroundColor: Color(0xffd4d2d2),
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
                  'Create Account',
                  style: TextStyle(
                    color: Color(0xff204381),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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