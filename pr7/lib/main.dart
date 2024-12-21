import 'package:flutter/material.dart';
import 'package:pr7/models/shoppingCart.dart';
import 'package:pr7/pages/homePage.dart';
import 'package:pr7/pages/profilePage.dart';
import 'package:pr7/pages/shoppingCartPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingCart(), 
      child: AppRoot(),
    ),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = <Widget>[
    HomePage(),
    ShoppingCartPage(),
    ProfilePage()
  ];

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/Home.png',
              width: 24,
              height: 24,
              color: currentIndex == 0 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/Cart.png',
              width: 24,
              height: 24,
              color: currentIndex == 1 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/User.png',
              width: 24,
              height: 24,
              color: currentIndex == 2 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
