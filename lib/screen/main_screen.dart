import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'main_screens/favorite_screen.dart';
import 'main_screens/home_screen.dart';
import 'main_screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> pages = [];
  int selectedindex = 0;

  @override
  void initState() {
    pages = [
      HomeScreen(),
      FavoriteScreen(),
      Container(
        color: Colors.teal,
      ),
      Container(
        color: Colors.amber,
      ),
      ProfileScreen(),
    ];

    super.initState();
  }

  onBottomNavTap(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedindex],
      backgroundColor: Color(0xfff6faf9),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedindex,
        buttonBackgroundColor: Color(0xff0d9776),
        items: [
          Icon(
            IconsaxPlusLinear.home_2,
            color: selectedindex == 0 ? Colors.white : Color(0xffd9d9d9),
          ),
          Icon(
            IconsaxPlusLinear.heart,
            color: selectedindex == 1 ? Colors.white : Color(0xffd9d9d9),
          ),
          Icon(
            IconsaxPlusLinear.add,
            color: selectedindex == 2 ? Colors.white : Color(0xffd9d9d9),
          ),
          Icon(
            IconsaxPlusLinear.notification_bing,
            color: selectedindex == 3 ? Colors.white : Color(0xffd9d9d9),
          ),
          Icon(
            IconsaxPlusLinear.profile,
            color: selectedindex == 4 ? Colors.white : Color(0xffd9d9d9),
          ),
        ],
        onTap: (index) {
          onBottomNavTap(index);
        },
      ),
    );
  }
}
