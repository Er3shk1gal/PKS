import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;

  const ProfileHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}