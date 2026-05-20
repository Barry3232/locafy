import 'package:flutter/material.dart';
import 'package:locafy/features/screens/home.dart';
import 'package:locafy/features/screens/profile.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;
  bool _isSelected = false;

  final List<Widget> _screens = [
    HomeScreen(), // Home Screen
    Container(color: Colors.green), // Search Screen
    Container(color: Colors.blue), // Messages Screen
    Container(color: Colors.orange), // Notifications Screen
    ProfileScreen(), // Profile Screen
  ];

  Widget navItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        if (_currentIndex == index) {
          _isSelected = !_isSelected;
        } else {
          _currentIndex = index;
          _isSelected = true;
        }
      }),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 26,
          color: _currentIndex == index ? Color(0xFF0A4FD6) : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Stack(children: [_screens[_currentIndex]]),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 8),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              _isSelected && _currentIndex == 0
                  ? Icons.home_filled
                  : Icons.home_outlined,
              0,
            ),
            navItem(
              _isSelected && _currentIndex == 1
                  ? Icons.search
                  : Icons.search_outlined,
              1,
            ),
            navItem(
              _isSelected && _currentIndex == 2
                  ? Icons.add_circle_outline
                  : Icons.add_circle_outline,
              2,
            ),
            navItem(
              _isSelected && _currentIndex == 3
                  ? Icons.message_rounded
                  : Icons.message_outlined,
              3,
            ),

            navItem(
              _isSelected && _currentIndex == 4
                  ? Icons.person
                  : Icons.person_outlined,
              4,
            ),
          ],
        ),
      ),
    );
  }
}
