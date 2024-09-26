import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  final int currentIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    const iconSize = 30.0;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home_outlined,
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Cities',
          icon: Icon(
            Icons.location_on_outlined,
            size: iconSize,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.person_outline,
            size: iconSize,
          ),
        ),
      ],
    );
  }
}
