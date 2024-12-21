import 'package:flutter/material.dart';

class ProfileLink extends StatelessWidget {
  final String text;

  const ProfileLink({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
        ),
      ),
    );
  }
}
