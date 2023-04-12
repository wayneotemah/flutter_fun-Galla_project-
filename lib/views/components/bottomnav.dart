import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../config.dart';
import '../../controllers/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  BottomNav({
    super.key,
  });

  final BottomNavigationContoller bottomNavigationContoller =
      Get.put(BottomNavigationContoller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          rippleColor: Colors.grey[300]!,
          gap: 8,
          activeColor: Colors.grey[100],
          iconSize: 24,
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          color: Colors.black,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.account_tree_outlined,
              text: 'Collection',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Profile',
            ),
          ],
          onTabChange: (index) {
            bottomNavigationContoller.changeIndex(index);
          },
        ),
      ),
    );
  }
}
