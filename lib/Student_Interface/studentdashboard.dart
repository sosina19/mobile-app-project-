import 'package:flutter/material.dart';
import 'package:Qr_Attendance/login/log_in.dart';
import 'package:Qr_Attendance/service/token_service.dart';
import 'QrPage.dart';
import 'historyPage.dart';
import 'profile.dart';

class StudentDashboard extends StatefulWidget {
  final String studentId;
  final String name;
  final String email;
  final String role;
  final String serverId;

  const StudentDashboard({
    super.key,
    required this.serverId,
    required this.studentId,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int currentIndex = 0;
  String? email;
  int attendanceRate = 0;

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  Future<void> loadEmail() async {
    String? savedEmail = await TokenService.getEmail();
    if (mounted) {
      setState(() {
        email = savedEmail;
      });
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

  List<Widget> _getPages() {
    return [
      _homePage(),
      HistoryPage(studentId: widget.serverId),
      QrPage(name: widget.name.toUpperCase(), id: widget.serverId),
      ProfilePage(name: widget.name.toUpperCase(), email: widget.email),
    ];
  }

  // Helper method to let home items cleanly switch bottom navigation tabs
  void _navigateToTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pages = _getPages();

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        selectedItemColor: isDark
            ? const Color(0xFF5B92E5)
            : const Color(0xFF1E4B7A),
        unselectedItemColor: isDark ? Colors.grey[500] : Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _homePage() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.grey[900] : const Color(0xFF1E4B7A),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Dire Dawa University",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Welcome To Student Dashboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? const Color(0xFF5B92E5)
                              : const Color(0xFF1E4B7A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF143252)
                            : const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: isDark
                                ? Colors.grey[800]
                                : Colors.white,
                            child: Icon(
                              Icons.person,
                              color: isDark
                                  ? const Color(0xFF5B92E5)
                                  : const Color(0xFF1E4B7A),
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            // Added .toUpperCase() here to force the string to capital letters
                            widget.name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Check My Status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFF5B92E5)
                            : const Color(0xFF1E4B7A),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 1. Updated dynamic layout options with dedicated index routing targets
                    _statusNavigationItem(
                      title: "My History",
                      subtitle: "View your attendance logs",
                      icon: Icons.history,
                      targetTabIndex: 1,
                      isDark: isDark,
                    ),
                    _statusNavigationItem(
                      title: "My QR Code",
                      subtitle: "Cheack my Qr code",
                      icon: Icons.qr_code,
                      targetTabIndex: 2,
                      isDark: isDark,
                    ),
                    _statusNavigationItem(
                      title: "My Profile",
                      subtitle: "Manage account settings",
                      icon: Icons.account_circle,
                      targetTabIndex: 3,
                      isDark: isDark,
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

  // 2. Beautifully engineered structural navigation card supporting material responses
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
          color: isDark
              ? Colors.grey[900]
              : const Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.circular(12),
          border: isDark
              ? Border.all(color: Colors.grey[800]!, width: 1)
              : null,
          boxShadow: isDark
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF143252)
                          : const Color(0xFFE8F0FE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: isDark
                          ? const Color(0xFF5B92E5)
                          : const Color(0xFF1E4B7A),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
