import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile_app/service/token_service.dart';
import 'package:mobile_app/login/log_in.dart';

class ProfileButton extends StatefulWidget {
  final String name;
  final String email;

  const ProfileButton({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  String? imagePath;

  String getInitials(String name) {
    List<String> parts = name.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }

      Future<void> logout() async {
  await TokenService.clear();

  if (!mounted) return;

  Navigator.pop(context); 

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (route) => false,
  );
}

  void openProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      imagePath != null ? FileImage(File(imagePath!)) : null,
                  child: imagePath == null
                      ? Text(
                          getInitials(widget.name),
                          style: TextStyle(fontSize: 22),
                        )
                      : null,
                ),
              ),

              SizedBox(height: 10),
              Text(widget.name, style: TextStyle(fontSize: 18)),
              Text(widget.email),

              Divider(),

              ListTile(
                leading: Icon(Icons.email),
                title: Text("Ch"),
                onTap: () {},
              ),

              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
                onTap: () {},
              ),

                ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            onTap: logout,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openProfile(context),
      child: CircleAvatar(
        backgroundImage:
            imagePath != null ? FileImage(File(imagePath!)) : null,
        child: imagePath == null
            ? Text(getInitials(widget.name))
            : null,
      ),
    );
  }
}
