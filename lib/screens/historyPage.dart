import 'package:flutter/material.dart';

import 'QrPage.dart';
import 'historyPage.dart';
import 'profile.dart';

class HistoryPage extends StatelessWidget {
  final String studentId;
  final String name;
  final String email;

  const HistoryPage({
    super.key,
    required this.studentId,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("History of $name"));
  }
}
