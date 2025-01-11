import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentLocation,
  });

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
            size: width * 0.07,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings_sharp,
            size: width * 0.07,
          ),
          label: 'Settings',
        ),
      ],
      currentIndex: _calculateSelectedIndex(currentLocation),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white, // Changed background color to white
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/settings')) return 1;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/settings');
        break;
    }
  }
}
