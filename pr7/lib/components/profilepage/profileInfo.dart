import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String text;
  final Color color;

  const ProfileInfo({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: color,
      ),
    );
  }
}
