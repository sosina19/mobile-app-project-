import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widget/profile.dart';
import '../service/token_service.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override

    String? email;

    void initState() {
      super.initState();
      loadEmail();
    }

    Future<void> loadEmail() async {
      String? savedEmail = await TokenService.getEmail();

      setState(() {
        email = savedEmail;
      });
    } 

Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 225, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 79, 122),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
       centerTitle: true,
        title: const Text(
          "Dire Dawa University",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: email == null
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : Text(
                        email![0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            )
          ],
      ),

      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            "Welcome To Admin Dashboard",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}