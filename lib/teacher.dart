import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Teachers Dashboard",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 252, 250, 250),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      size: 30,
                      color: const Color.fromARGB(255, 12, 9, 9),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 53, 79, 122),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello...",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Welcome To Student Qr \n\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0Attendance",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              )),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "Scan Qr Code",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: const Color.fromARGB(255, 252, 251, 251),
                  ),
                ),
                icon: Icon(
                  Icons.qr_code,
                  size: 40,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                  alignment: Alignment.centerLeft,
                  backgroundColor: Color.fromARGB(255, 53, 79, 122),
                  minimumSize: Size(500, 70),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "My Courses",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: const Color.fromARGB(255, 252, 251, 251),
                  ),
                ),
                icon: Icon(
                  Icons.menu_book,
                  size: 40,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                  alignment: Alignment.centerLeft,
                  backgroundColor: Color.fromARGB(255, 53, 79, 122),
                  minimumSize: Size(500, 70),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "Attendance History",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: const Color.fromARGB(255, 252, 251, 251),
                  ),
                ),
                icon: Icon(
                  Icons.calendar_month,
                  size: 40,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shadowColor: Colors.black,
                  alignment: Alignment.centerLeft,
                  backgroundColor: Color.fromARGB(255, 53, 79, 122),
                  minimumSize: Size(500, 70),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.home, size: 45)),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person, size: 45),
                  ),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.qr_code, size: 45)),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.menu_book, size: 45)),
                )
              ],
            ),
          ),
        ));
  }
}
