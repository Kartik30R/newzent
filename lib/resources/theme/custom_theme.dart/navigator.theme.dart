import 'package:flutter/material.dart';
import 'package:newzent/resources/constants/color/app_color.dart';

class AppNavigationTheme {
  static BottomNavigationBarThemeData lightNavigationTheme =
      const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color: AppColor.primary,
      size: 24,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColor.dark,
      size: 24
    ),
    selectedItemColor: AppColor.primary,
    unselectedItemColor: AppColor.dark,
    backgroundColor: AppColor.light,
  );

  static BottomNavigationBarThemeData darkNavigationTheme =
      const BottomNavigationBarThemeData(
          backgroundColor: AppColor.dark,
          unselectedIconTheme: IconThemeData(
            size: 24,
            color: AppColor.light
          ),
          selectedIconTheme: IconThemeData(
            color: AppColor.primary,
            size: 24,
          ),
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.light);
}
