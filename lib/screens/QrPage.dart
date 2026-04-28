import 'package:flutter/material.dart';

import 'QrPage.dart';
import 'historyPage.dart';
import 'profile.dart';

class QrPage extends StatelessWidget {
  final String studentId;
  final String name;
  final String email;

  const QrPage({
    super.key,
    required this.studentId,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("QR for $name"));
  }
}
