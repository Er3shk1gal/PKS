import 'package:flutter/material.dart';
import 'pages/components/home_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeData> _themeNotifier = ValueNotifier(ThemeData.dark());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: _themeNotifier,
      builder: (context, theme, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VK Clone',
          theme: theme,
          home: HomePage(changeTheme: (newTheme) {
            _themeNotifier.value = newTheme;
          }),
        );
      },
    );
  }
}
