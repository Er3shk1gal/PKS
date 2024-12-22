import 'package:flutter/material.dart';
import 'package:pr6/models/cart.dart';
import 'package:pr6/models/goods.dart';
import 'package:pr6/models/liked_goods.dart';
import 'package:pr6/models/user.dart';
import 'package:provider/provider.dart';
import 'pages/components/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => LikedGoods()),
        ChangeNotifierProvider(create: (context) => Goods()),
        ChangeNotifierProvider(create: (context) => User( id: 1, username: 'Roma', about: 'Student', profilePicture: 'assets/profile.png')),
        // Add more providers here as needed
      ],
      child: MyApp(),
    ),
  );
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
          title: 'Shop',
          theme: theme,
          home: HomePage(changeTheme: (newTheme) {
            _themeNotifier.value = newTheme;
          }),
        );
      },
    );
  }
}
