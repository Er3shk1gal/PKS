import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String iconPath;
  final String title;

  const ProfileOption({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 24,
        height: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Montserrat'),
      ),
      onTap: () {
        
      },
    );
  }
}