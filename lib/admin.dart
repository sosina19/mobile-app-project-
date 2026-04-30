import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widget/profile.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List users = [];
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // ===================== GET USERS =====================
  Future<void> fetchUsers() async {
    setState(() => isLoading = true);

    final url = Uri.parse("http://10.0.2.2:3000/users");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }

    setState(() => isLoading = false);
  }

  // ===================== CREATE TEACHER =====================
  Future<void> createTeacher() async {
    final url = Uri.parse("http://10.0.2.2:3000/admin/create-teacher");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "role": "teacher",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Teacher created")));

        emailController.clear();
        passwordController.clear();

        fetchUsers(); // refresh list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to create teacher")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // ===================== DELETE USER =====================
  Future<void> deleteUser(String id) async {
    final url = Uri.parse("http://10.0.2.2:3000/users/$id");

    await http.delete(url);

    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: const Color(0xFF0D3B66),
        actions: [ProfileButton(name: "Sosi Admin", email: "admin@email.com")],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // ================= STATS =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _card("Users", users.length.toString()),
                      _card(
                        "Teachers",
                        users
                            .where((u) => u["role"] == "teacher")
                            .length
                            .toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ================= CREATE TEACHER =================
                  const Text(
                    "Create Teacher",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),

                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: createTeacher,
                    child: const Text("Create Teacher"),
                  ),

                  const SizedBox(height: 20),

                  // ================= USERS LIST =================
                  const Text(
                    "All Users",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return Card(
                          child: ListTile(
                            title: Text(user["email"]),
                            subtitle: Text("Role: ${user["role"]}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  deleteUser(user["id"].toString()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
