import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:newzent/view/screens/explore_screen.dart';
import 'package:newzent/view/screens/feed_screen.dart';
import 'package:newzent/view/screens/main_screen.dart';
import 'package:newzent/view/screens/profile_screen.dart';

class BottomNavigationController extends GetxController{
  RxInt currentIndex =0.obs;
   Rx<ThemeMode> themeMode  = ThemeMode.dark.obs;



  RxList pages=[
    FeedScreen(),
    ExploreScreen(),
    ProfileScreen()

  ].obs;
  
  void onTabTapped(int index) {
      currentIndex.value = index;
  
  }
   void toggleThemeMode() {
      themeMode.value =
          themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}