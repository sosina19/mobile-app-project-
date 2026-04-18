import 'package:flutter/material.dart';
import 'log_in.dart';


class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5), // light gray
      body: SafeArea(
          child: Center(
    child: SizedBox(
      width: 400,
      
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(), // top spacing
            // CENTER CONTENT
            Column(
              children: [
                // Icon card
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 50,
                    color: Color(0xFF1E4B7A),
                  ),
                ),

                const SizedBox(height: 25),

                // Title
                const Text(
                  "Dire Dawa University",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Divider(indent: 60, endIndent: 10, thickness: 1),
                    ),
                    Text(
                      "ATTENDANCE SYSTEM",
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Divider(indent: 10, endIndent: 60, thickness: 1),
                    ),
                  ],
                ),
              ],
            ),
             SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(140, 50),
                  elevation: 10,
                  shadowColor: Colors.black,
                  backgroundColor:Color(0xFF1E4B7A)
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

            // BOTTOM CONTENT
            Column(
              children: [
                // Progress bar
                SizedBox(
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.4, // static progress (40%)
                      backgroundColor: const Color.fromARGB(255, 177, 173, 173),
                      color: const Color(0xFF1E4B7A),
                      minHeight: 6,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text("2026", style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 30),

               
              ],
            ),
          ],
        ),
      ),
          ),  
          ) ,
    );
  }
}
