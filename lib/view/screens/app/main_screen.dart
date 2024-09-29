import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/view_model/controllers/bottom_navigation_controller.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final BottomNavigationController navigationController =
      Get.put(BottomNavigationController());
  final FeedNewsController feedNewsController = Get.put(FeedNewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          navigationController.pages[navigationController.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => navigationController.onTabTapped(value),
          currentIndex: navigationController.currentIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
