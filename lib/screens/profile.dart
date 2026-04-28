import 'package:flutter/material.dart';

import 'QrPage.dart';
import 'historyPage.dart';
import 'profile.dart';

class Profile extends StatelessWidget {
  final String studentId;
  final String name;
  final String email;
  final String role;

  const Profile({
    super.key,
    required this.studentId,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile: $name ($role)"));
  }
}
