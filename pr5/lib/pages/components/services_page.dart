import 'package:flutter/material.dart';
import 'settings_page.dart';

class ServicesPage extends StatelessWidget {
  final Function(ThemeData) changeTheme;

  const ServicesPage({super.key, required this.changeTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(changeTheme: changeTheme)),
                );
              },
              child: const Card(
                child: Center(
                  child: Text('Settings'),
                ),
              ),
            ),
            // Добавьте другие сервисы здесь
          ],
        ),
      ),
    );
  }
}
