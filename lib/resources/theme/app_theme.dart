import 'package:flutter/material.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/theme/custom_theme.dart/card_theme.dart';
import 'package:newzent/resources/theme/custom_theme.dart/icon_theme.dart';
import 'package:newzent/resources/theme/custom_theme.dart/input_decoration_theme.dart';
import 'package:newzent/resources/theme/custom_theme.dart/navigator.theme.dart';
import 'package:newzent/resources/theme/custom_theme.dart/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      dividerTheme: const DividerThemeData(
        color: Color.fromARGB(39, 163, 167, 174),
      ),
      iconTheme: AppIconTheme.lightIconTheme,
      inputDecorationTheme: AppInputDecorationTheme.lightInputTheme,
      primaryColorLight: AppColor.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.light,
      textTheme: AppTextTheme.lightTextTheme,
      bottomNavigationBarTheme: AppNavigationTheme.lightNavigationTheme,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      cardTheme: AppCardTheme.lightCardTheme
      
      );

  static ThemeData darkTheme = ThemeData(
      dividerTheme:
          const DividerThemeData(color: Color.fromARGB(39, 119, 121, 125)),
      primaryColorLight: AppColor.light,
      inputDecorationTheme: AppInputDecorationTheme.darkInputTheme,
      iconTheme: AppIconTheme.darkIconTheme,
      primaryColor: AppColor.primary,
      bottomNavigationBarTheme: AppNavigationTheme.darkNavigationTheme,
      scaffoldBackgroundColor: AppColor.dark,
      brightness: Brightness.dark,
      textTheme: AppTextTheme.darkTextTheme,
      fontFamily: 'Inter',
      cardTheme: AppCardTheme.darkCardTheme);
      
}