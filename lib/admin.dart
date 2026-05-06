import 'package:flutter/material.dart';
import 'package:mobile_app/signup/studentsignup.dart';
import 'package:mobile_app/signup/teachersignup.dart';
import '../service/token_service.dart';
import 'Student_Interface/profile.dart';

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

  @override
  void initState() {
    super.initState();
    loadUserData();
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

  Widget _homeBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 600
            ? 600
            : constraints.maxWidth;

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(100),

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
      const Center(child: Text("Courses")),
      const SizedBox(),
      const Center(child: Text("History")),

     
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
      centerTitle: true,
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
          if (index == 2) {
            _showAddMenu();
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Courses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 35),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}