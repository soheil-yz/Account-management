import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/screens/Home_screen.dart';
import 'package:money_managment/screens/Info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget body = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.info],
        activeIndex: currentIndex,
        inactiveColor: Colors.black54,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) {
          if (index == 0) {
            body = const Center(
              child: const HomeScreen(),
            );
          } else {
            body = const Center(
              child: const InfoScreen(),
            );
          }
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: body,
    );
  }
}
