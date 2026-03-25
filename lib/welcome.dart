import 'package:flutter/material.dart';
import 'log_in.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 350,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '   \n\n\nWelcome  to Smart \n \u00A0\u00A0\u00A0\u00A0\u00A0Attendance',
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff080808),
                ),
              ),
              SizedBox(height: 10),
              /*Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),*/
              SizedBox(height: 200),
              Text(
                'Fast and Sequre Qr Attendance!',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 211, 208, 208),
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
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(140, 50),
                  elevation: 10,
                  shadowColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 92, 146, 245),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontFamily: 'Arial',
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
