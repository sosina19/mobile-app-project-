import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  final String name;
  final String email;

  const QrPage({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        Text(email),

        const SizedBox(height: 20),

        QrImageView(data: "$name|$email", size: 200),
      ],
    );
  }
}
