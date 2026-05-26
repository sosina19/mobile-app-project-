import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile_app/main.dart';
import '../service/token_service.dart';
import 'package:mobile_app/login/log_in.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({super.key, required this.name, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imagePath;
  String? department;

  @override
  void initState() {
    super.initState();
    loadDepartment();
  }

  Future<void> loadDepartment() async {
    final dept = await TokenService.getDepartment();

    setState(() {
      department = dept ?? "No Department";
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => imagePath = file.path);
    }
  }

  Future<void> logout() async {
    await TokenService.clear();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void confirmLogout() {
    // 1. Check if the current theme is Dark Mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // 2. Dynamic background: deep grey for dark mode, light grey for light mode
          backgroundColor: isDark
              ? Colors.grey[900]
              : const Color.fromARGB(255, 228, 225, 225),
          title: Text(
            "Confirm Logout",
            style: TextStyle(
              // 3. Dynamic title color
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              // 4. Dynamic body text color
              color: isDark ? Colors.grey[300] : Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "No",
                style: TextStyle(
                  // 5. Dynamic button color so it stands out against dark backgrounds
                  color: isDark ? Colors.grey[400] : const Color(0xFF1E4B7A),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await logout();
              },
              // Kept this red as it indicates a destructive action, which works great in both themes!
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Add this variable at the top of your _ProfilePageState class with your other variables
  bool isDarkMode = false;

  void showSettingsPopup() {
    showDialog(
      context: context,
      builder: (context) {
        // StatefulBuilder lets the switch animate toggling on/off inside the popup
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // 1. Check if the active theme is Dark Mode inside the builder block
            final isDark = Theme.of(context).brightness == Brightness.dark;

            return AlertDialog(
              // 2. Dynamic background color changing safely
              backgroundColor: isDark
                  ? Colors.grey[900]
                  : const Color.fromARGB(255, 228, 225, 225),
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: isDark
                        ? const Color(0xFF5B92E5)
                        : const Color(0xFF1E4B7A),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Account Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.white
                          : Colors.black87, // Dynamic title
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Keeps the popup compact
                  children: [
                    // Option 1: Change Profile Photo shortcut
                    // Option 1: Change Profile Photo shortcut
                    ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                        color: isDark ? Colors.grey[400] : Colors.black87,
                      ),
                      title: Text(
                        "Update Profile Photo",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      // 1. Mark this function as async
                      onTap: () async {
                        // 2. Temporarily hide the dialog layout so the gallery can open
                        Navigator.pop(context);

                        // 3. AWAIT forces the app to pause until the user selects an image
                        await pickImage();

                        // 4. Forcefully refresh the main Profile page UI with the new image file path
                        setState(() {});
                      },
                    ),
                    Divider(
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                    ),

                    // Option 2: Dark Mode Switch
                    SwitchListTile(
                      secondary: Icon(
                        Icons.dark_mode,
                        color: isDark ? Colors.grey[400] : Colors.black87,
                      ),
                      title: Text(
                        "Dark Mode",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      activeColor: const Color(0xFF5B92E5),
                      // Checks if the global theme mode is currently set to dark
                      value: themeNotifier.value == ThemeMode.dark,
                      onChanged: (bool value) {
                        // 1. Change the global notifier value
                        themeNotifier.value = value
                            ? ThemeMode.dark
                            : ThemeMode.light;

                        // 2. Re-render the switch button inside the popup immediately
                        setDialogState(() {});

                        // 3. Re-render the profile page background layout behind the popup
                        setState(() {});
                      },
                    ),
                    Divider(
                      color: isDark ? Colors.grey[800] : Colors.grey[300],
                    ),

                    const SizedBox(height: 10),
                    // App Version Tracking
                    Text(
                      "App Version 1.0.0",
                      style: TextStyle(
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFF5B92E5)
                          : const Color(0xFF1E4B7A),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showPrivacyPolicy(BuildContext context) {
    // 1. Check theme mode safely
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Use a distinct context name for the builder
        return AlertDialog(
          backgroundColor: isDark
              ? Colors.grey[900]
              : const Color.fromARGB(255, 228, 225, 225),
          title: Row(
            children: [
              Icon(
                Icons.security,
                color: isDark
                    ? const Color(0xFF5B92E5)
                    : const Color(0xFF1E4B7A),
              ),
              const SizedBox(width: 10),
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "QR Attendance App",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark
                          ? const Color(0xFF5B92E5)
                          : const Color(0xFF1E4B7A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "1. Camera Access\n"
                    "This app requires access to your device's camera solely to scan classroom QR codes for recording your attendance. We never take, store, or transmit personal photos or videos.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "2. Data Collection\n"
                    "We only collect information necessary to log your presence, including your Name, Email, Department, and the Timestamp of your scan. This data is securely sent directly to your institution's database.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "3. Data Security\n"
                    "Your profile tokens and session data are stored securely on your local device. We do not sell, rent, or share your data with any third-party advertisers or external organizations.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: isDark ? Colors.grey[300] : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext), // Closes the dialog cleanly
              child: Text(
                "I Understand",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? const Color(0xFF5B92E5)
                      : const Color(0xFF1E4B7A),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatName(String name) {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 600
              ? 600
              : constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: maxWidth,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF123456)
                            : const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                                image: imagePath != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(imagePath!),
                                        ), // This works perfectly now!
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: imagePath == null
                                  ? Icon(
                                      Icons.person,
                                      size: 40,
                                      color: isDark
                                          ? Colors.grey[400]
                                          : Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            formatName(widget.name),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.email,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey[900]
                            : const Color(0xFFF2F3F5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DEPARTMENT",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.grey[400] : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            department ?? "Loading...",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,

                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _item(
                      Icons.settings,
                      "Account Settings",
                      showSettingsPopup,
                    ),
                    const SizedBox(height: 10),

                    _item(
                      Icons.lock,
                      "Privacy Policy",
                      () => showPrivacyPolicy(context),
                    ),
                    const SizedBox(height: 10),
                    _item(
                      Icons.logout,
                      "Logout",
                      confirmLogout,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Updated custom list item builder
  Widget _item(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Fallback standard text colors for light/dark modes if no custom color (like red) is passed
    final defaultColor = isDark ? Colors.white70 : Colors.black87;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // 6. Make button background adapt automatically
        color: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 245, 244, 244),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? defaultColor),
        title: Text(title, style: TextStyle(color: color ?? defaultColor)),
        onTap: onTap,
      ),
    );
  }
}
