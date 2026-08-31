import 'package:flutter/material.dart';
import 'package:locafy/features/screens/home.dart';
import 'package:locafy/features/screens/message.dart';
import 'package:locafy/features/screens/profile.dart';
import 'package:locafy/features/screens/publish.dart';
import 'package:locafy/features/screens/search_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      SearchScreen(),
      PublishScreen(),
      MessagesScreen(),
      ProfileScreen(),
    ];
  }

  Widget navItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _currentIndex = index;
      }),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? Colors.blue.withOpacity(0.1)
              : Colors.transparent,
        ),
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

      body: IndexedStack(index: _currentIndex, children: _screens),

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
              _currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
              0,
            ),
            navItem(
              _currentIndex == 1 ? Icons.search : Icons.search_outlined,
              1,
            ),
            navItem(
              _currentIndex == 2 ? Icons.add_circle : Icons.add_circle_outline,
              2,
            ),
            navItem(
              _currentIndex == 3
                  ? Icons.message_rounded
                  : Icons.message_outlined,
              3,
            ),

            navItem(
              _currentIndex == 4 ? Icons.person : Icons.person_outlined,
              4,
            ),
          ],
        ),
      ),
    );
  }
}
