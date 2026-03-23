import 'welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // run the root app, not Login directly
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Welcome(), // start app with Login page
    );
  }
}
