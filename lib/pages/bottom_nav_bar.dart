import 'package:flutter/material.dart';
import 'package:parkingslot/pages/camerascreen.dart';
import 'package:parkingslot/pages/analyticscreen.dart';
import 'package:parkingslot/pages/profilescreen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Detect',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: (index) => onItemTapped(context, index),
    );
  }
}
