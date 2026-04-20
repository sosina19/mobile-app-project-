import 'dart:convert';
import 'profilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString("user_data");

    if (jsonString != null) {
      setState(() {
        userData = jsonDecode(jsonString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Acadamic Clarity",
          style: TextStyle(
            color: Color(0xffefeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff204381),
      ),
      backgroundColor: Color(0xffefeeee),
      body: userData == null
          ? const Center(child: Text("No user data found"))
          : Padding(padding: const EdgeInsets.all(16)),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffefeeee),
        shape: CircularNotchedRectangle(),
        height: 80, // optional (for floating button notch)
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(
                    Icons.dashboard,
                    size: 24,
                    color: Color(0xff9c9b9b),
                  ),
                  onPressed: () {},
                ),
                Text("DASHBOARD", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.qr_code, size: 28, color: Color(0xff9c9b9b)),
                  onPressed: () {},
                ),
                Text("MY QR", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.history, size: 24, color: Color(0xff9c9b9b)),
                  onPressed: () {},
                ),
                Text("HISTORY", style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.person, size: 24, color: Color(0xff9c9b9b)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => profilePage()),
                    );
                  },
                ),
                Text("PROFILE", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
