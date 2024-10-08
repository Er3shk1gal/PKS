import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'feed_page.dart';
import 'services_page.dart';
import 'favorites_page.dart';
import '../../models/user.dart';

class HomePage extends StatefulWidget {
  final Function(ThemeData) changeTheme;
  const HomePage({super.key, required this.changeTheme});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  List<Widget> get _pages => [
    ProfilePage(user: User(id: 1, username: 'Default User', about: 'About me')),
    const FeedPage(),
    ServicesPage(changeTheme: widget.changeTheme),
    const FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
