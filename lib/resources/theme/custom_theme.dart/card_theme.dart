import 'package:flutter/material.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';

class AppCardTheme {
  static CardTheme lightCardTheme = CardTheme(
      color: AppColor.lightCard,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimension().borderRadius), side: BorderSide.none));

  static CardTheme darkCardTheme = CardTheme(
      color: AppColor.darkCard,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimension().borderRadius), side: BorderSide.none));
}
