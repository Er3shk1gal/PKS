import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeData) changeTheme;

  const SettingsPage({super.key, required this.changeTheme});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color primaryColor = Colors.black;
  Color accentColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      primaryColor = Color(prefs.getInt('primaryColor') ?? Colors.black.value);
      accentColor = Color(prefs.getInt('accentColor') ?? Colors.red.value);
    });
    _applyTheme();
  }

  void _applyTheme() {
    widget.changeTheme(
      ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: accentColor),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          selectedItemColor: accentColor,
          unselectedItemColor: accentColor.withOpacity(0.6),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: accentColor,
          onPrimary: accentColor,
        ),
        iconTheme: IconThemeData(color: accentColor),
        buttonTheme: ButtonThemeData(buttonColor: accentColor),
      ),
    );
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primaryColor', primaryColor.value);
    prefs.setInt('accentColor', accentColor.value);
    _applyTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Primary Color'),
              trailing: CircleAvatar(backgroundColor: primaryColor),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Primary Color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: primaryColor,
                        onColorChanged: (color) {
                          setState(() {
                            primaryColor = color;
                          });
                          Navigator.of(context).pop();
                          _applyTheme();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Accent Color'),
              trailing: CircleAvatar(backgroundColor: accentColor),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Accent Color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: accentColor,
                        onColorChanged: (color) {
                          setState(() {
                            accentColor = color;
                          });
                          Navigator.of(context).pop();
                          _applyTheme();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: _saveTheme,
              child: const Text('Save Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
