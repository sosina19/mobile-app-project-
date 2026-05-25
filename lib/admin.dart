import 'package:flutter/material.dart';
import 'package:mobile_app/signup/studentsignup.dart';
import 'package:mobile_app/signup/teachersignup.dart';
import '../service/token_service.dart';
import 'Student_Interface/profile.dart';
import '../service/attendance_service.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String? name;
  String? email;
  String? role;

  int currentIndex = 0;
  int totalStudents = 0;
int totalTeachers = 0;
int totalCourses = 0;
int totalRecords = 0;

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadAdminStats();
  }
  Future<void> loadAdminStats() async {
  try {
    final data = await AttendanceService.getAttendance();
    final records = List<Map<String, dynamic>>.from(data);

    final students = <String>{};
    final courses = <String>{};

    for (var item in records) {
      students.add(item["userId"].toString());
      courses.add(item["Course"].toString());
    }

    setState(() {
      totalStudents = students.length;
      totalCourses = courses.length;
      totalRecords = records.length;

      // teachers not in attendance → placeholder or API later
      totalTeachers = 10;
    });
  } catch (e) {
    debugPrint("Error: $e");
  }
}

  Future<void> loadUserData() async {
    String? savedEmail = await TokenService.getEmail();
    String? savedName = await TokenService.getName();
    String? savedRole = await TokenService.getRole();

    setState(() {
      email = savedEmail;
      name = savedName;
      role = savedRole;
    });
  }

  Widget _overviewCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

  Widget _homeBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
 
         padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Welcome To Admin Dashboard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E4B7A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E4B7A),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF1E4B7A),
                              size: 40,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            name ?? "Loading...",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            email ?? "Loading...",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

const Text(
  "Admin Overview",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E4B7A),
  ),
),

const SizedBox(height: 15),

Row(
  children: [
    Expanded(
      child: _overviewCard(
        title: "Students",
        value: totalStudents.toString(),
        icon: Icons.school,
        color: Colors.blue,
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: _overviewCard(
        title: "Teachers",
        value: totalTeachers.toString(),
        icon: Icons.person,
        color: Colors.green,
      ),
    ),
  ],
),

const SizedBox(height: 12),

Row(
  children: [
    Expanded(
      child: _overviewCard(
        title: "Courses",
        value: totalCourses.toString(),
        icon: Icons.book,
        color: Colors.orange,
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: _overviewCard(
        title: "Records",
        value: totalRecords.toString(),
        icon: Icons.bar_chart,
        color: Colors.red,
      ),
    ),
  ],
),

const SizedBox(height: 15),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

      List<Widget> get pages => [
      _homeBody(),
      const SizedBox(),    
      ProfilePage(
        name: name ?? "Loading...",
        email: email ?? "Loading...",
      ),
      
    ];

  void _showAddMenu() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Create New Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 53, 79, 122),
              ),
            ),

            const SizedBox(height: 20),

           
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Studentsignup()),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 53, 79, 122),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.school, color: Colors.blue, size: 26),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Student Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey.shade300),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TeacherSignupPage()),
                );
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 53, 79, 122),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.green, size: 26),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Teacher Sign Up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey.shade300),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 225, 225),
     appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1E4B7A),
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school, color: Colors.white),
          SizedBox(width: 8),
          Text(
            "Dire Dawa University",
            style: TextStyle(color: Colors.white),
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

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF1E4B7A),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 1) {
            _showAddMenu();
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 35),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}