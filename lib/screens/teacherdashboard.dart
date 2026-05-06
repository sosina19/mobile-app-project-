import 'package:flutter/material.dart';
import '../service/course_service.dart';
import '../model/course.dart';
import 'create_course.dart';
import 'profile.dart';
import '../service/token_service.dart';

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

  Future<void> loadUserData() async {
    String? savedName = await TokenService.getName();
    String? savedEmail = await TokenService.getEmail();

    setState(() {
      name = savedName;
      email = savedEmail;
    });
  }
  int getTotalStudents(List<Course> courses) {
    return courses.fold(0, (sum, c) => sum + c.students);
  }

  double getAvgAttendance() {
    return 0.0; 
  }

  String getCurrentYear() {
    return DateTime.now().year.toString();
  }

 
  @override
  Widget build(BuildContext context) {
    List<Course> courses = CourseService.getCourses();

    
    final pages = [
      _homePage(courses),
      _scanPage(),
      _historyPage(),
     ProfilePage(name: name ?? "Loading...",
        email: email ?? "Loading...",),
    ];

    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 228, 225, 225),
  appBar: AppBar(
    backgroundColor: const Color(0xFF1E4B7A),
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.school, color: Colors.white),
        SizedBox(width: 8),
        Text("Dire Dawa University",
            style: TextStyle(color: Colors.white)),
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

     
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 114, 164, 218),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateCoursePage(),
                  ),
                );

                if (result == true) {
                  setState(() {});
                }
              },
              child: const Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        selectedItemColor: const Color(0xFF1E4B7A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  
  Widget _homePage(List<Course> courses) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            Text(
              "ACADEMIC YEAR ${getCurrentYear()}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 5),

           
            Text(
              "Welcome To Teacher Dashboard",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    "AVG. ATTENDANCE",
                    "${getAvgAttendance().toStringAsFixed(1)}%",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    "TOTAL STUDENTS",
                    getTotalStudents(courses).toString(),
                  ),
                ),
              ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Attendance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Start your session by scanning student IDs",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E4B7A),
                    ),
                    onPressed: () {
                      setState(() => currentIndex = 1); 
                    },
                    child: const Text("Scan Student QR"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            
            const Text(
              "Active Courses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

           
            courses.isEmpty
                ? const Text("No courses yet")
                : Column(
                    children: courses.map((course) {
                      return _courseItem(course);
                    }).toList(),
                  ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

 
  Widget _scanPage() {
    return const Center(child: Text("Scan QR (Coming next)"));
  }

  
  Widget _historyPage() {
    return const Center(child: Text("Attendance History"));
  }
  
  
  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E4B7A),
            ),
          ),
        ],
      ),
    );
  }
  Widget _courseItem(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.book, color: Color(0xFF1E4B7A)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${course.code}: ${course.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Year ${course.year} • ${course.students} Students",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}  