import 'package:mycart/screens/main_menu.dart';
import 'package:mycart/screens/profile.dart';
import 'package:mycart/screens/search.dart';
import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class DrawerScreen extends StatefulWidget {
  static const routeName = '/drawer-screen';

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<Map<String, Object>> _pages = [
    {
      'page': MainMenuScreen(),
      'title': 'Home',
    },
    {
      'page': SearchScreen(),
      'title': 'Search',
    },
    {
      'page': ProfileScreen(),
      'title': 'Profile',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          brightness: Brightness.dark,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF89CFF0),
                  Color(0xFF0047AB),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
