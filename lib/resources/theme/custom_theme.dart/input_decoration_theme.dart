import 'package:flutter/material.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme darkInputTheme = InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(118, 118, 128, .24),
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      outlineBorder: BorderSide.none,
      border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimension().borderRadius),
          borderSide: BorderSide.none),
      alignLabelWithHint: true,
      hintStyle: const TextStyle(color: Color.fromRGBO(235, 235, 245, .6)),
      prefixIconColor: const Color.fromRGBO(235, 235, 245, .6));

  static InputDecorationTheme lightInputTheme = InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(118, 118, 128, .24),
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      outlineBorder: BorderSide.none,
      border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimension().borderRadius),
          borderSide: BorderSide.none),
      alignLabelWithHint: true,
      hintStyle: const TextStyle(color:Color.fromARGB(153, 47, 47, 47)),
      prefixIconColor: Color.fromARGB(153, 47, 47, 47));



}
