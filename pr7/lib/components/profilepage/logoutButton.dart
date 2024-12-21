import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: TextButton(
          onPressed: () {
            // Добавьте действие выхода
          },
          child: const Text(
            'Выход',
            style: TextStyle(color: Colors.red, fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );
  }
}