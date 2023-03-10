// packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// controllers
import '../controllers/bottom_nav_controller.dart';

// componets
import 'components/bottomnav.dart';

// pages
import 'pages/profile.dart';
import 'pages/collections.dart';
import 'pages/events.dart';
import 'pages/home.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(),
    );
  }
}

class Screen extends StatelessWidget {
  Screen({super.key});

  final BottomNavigationContoller bottomNavigationContoller =
      Get.put(BottomNavigationContoller());

  final page = const [Home(), Collections(), Events(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        page[bottomNavigationContoller.selectedIndex.value],
        Positioned(
          bottom: 20,
          width: MediaQuery.of(context).size.width,
          child: BottomNav(),
        ),
      ]),
    );
  }
}
