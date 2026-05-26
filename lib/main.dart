import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash.dart';

// 1. Create a global theme controller accessible anywhere in the app
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize SharedPreferences
  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Wrap MaterialApp with ValueListenableBuilder to listen for theme toggles
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // 3. Define your Light Theme configurations
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color.fromARGB(
              255,
              214,
              210,
              210,
            ), // Your original background
          ),

          // 4. Define your Dark Theme configurations
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(
              0xFF121212,
            ), // Sleek dark gray background
          ),

          // 5. Connect the current state mode
          themeMode: currentMode,

          home: const Splash(),
        );
      },
    );
  }
}
