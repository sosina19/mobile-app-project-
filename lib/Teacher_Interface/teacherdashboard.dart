import 'package:flutter/material.dart';
import 'package:Qr_Attendance/Teacher_Interface/attendance_history.dart';
import '../service/token_service.dart';
import '../Student_Interface/profile.dart';
import 'scan_qr.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int currentIndex = 0;
  
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
    
  }

  void _navigateToTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  

  Future<void> loadUserData() async {
    name = await TokenService.getName();
    email = await TokenService.getEmail();
    setState(() {});
  }

  String formatName(String? name) {
    if (name == null || name.isEmpty) return "Teacher";
    return name[0].toUpperCase() + name.substring(1);
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  

  String getCurrentYear() => DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = [
      _homePage(isDark),
      const ScanQrPage(),
      _historyPage(),
      ProfilePage(name: name ?? "Loading...", email: email ?? "Loading..."),
    ];

    return Scaffold(
      backgroundColor: isDark
          ? Colors.black
          : const Color.fromARGB(255, 214, 210, 210),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark
            ? const Color(0xFF123456)
            : const Color(0xFF1E4B7A),
        title: const Text(
          "Dire Dawa University",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: isDark
            ? const Color(0xFF5B92E5)
            : const Color(0xFF1E4B7A),
        unselectedItemColor: isDark ? Colors.grey[500] : Colors.grey,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _homePage(bool isDark) {
    return SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "ACADEMIC YEAR ${getCurrentYear()}",
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "${getGreeting()}, ${formatName(name)}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF123456) : const Color(0xFF1E4B7A),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quick Attendance",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _navigateToTab(1),
                  child: const Text("Go to Scan QR"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Quick Navigation",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          _statusNavigationItem(
            title: "Scan QR",
            subtitle: "Start taking attendance",
            icon: Icons.qr_code_scanner,
            targetTabIndex: 1,
            isDark: isDark,
          ),

          _statusNavigationItem(
            title: "Attendance History",
            subtitle: "View past records",
            icon: Icons.history,
            targetTabIndex: 2,
            isDark: isDark,
          ),

          _statusNavigationItem(
            title: "Profile",
            subtitle: "Account details",
            icon: Icons.person,
            targetTabIndex: 3,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _historyPage() {
    return const AttendanceHistoryPage();
  }

  Widget _statusNavigationItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required int targetTabIndex,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _navigateToTab(targetTabIndex),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon,
                      color: isDark
                          ? const Color(0xFF5B92E5)
                          : const Color(0xFF1E4B7A)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey[400]
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}