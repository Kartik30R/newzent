// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:newzent/view/screens/app/explore_screen.dart';
// import 'package:newzent/view/screens/app/feed_screen.dart';
// import 'package:newzent/view/screens/app/main_screen.dart';
// import 'package:newzent/view/screens/app/profile_screen.dart';

// class BottomNavigationController extends GetxController{
//   RxInt currentIndex =0.obs;
//    Rx<ThemeMode> themeMode  = ThemeMode.dark.obs;

//   RxList pages=[
//     FeedScreen(),
//     ExploreScreen(),
//     ProfileScreen()

//   ].obs;

//   void onTabTapped(int index) {
//       currentIndex.value = index;

//   }
//    void toggleThemeMode() {
//       themeMode.value =
//           themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  Rx<ThemeMode> themeMode = ThemeMode.dark.obs;

  void onTabClick(int newTab) {
    print('Tab $newTab');
    currentIndex(newTab);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onTabTapped(int index) {
    currentIndex.value = index;
  }

  void toggleThemeMode() {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
