import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

  e
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Welcome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Color(0xFFEFF3FB),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            
            Image.asset(
              'assets/logo.png',
              width: 150,
            ),

            SizedBox(height: 20),

            
            Text(
              "SMART STUDENT ATTENDANCE",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff080808),
                letterSpacing: 1,
              ),
            ),

            SizedBox(height: 25),

            
            CircularProgressIndicator(
              color: Color(0xFF354F7A),
            ),

          ],
        ),
      ),
    );
  }
}
