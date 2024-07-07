import 'package:flutter/material.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
      bodyMedium: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().bodyText,
      ),
      bodyLarge: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().bodyLargeText,
      ),
      bodySmall: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().bodySmallText,
      ),
      titleLarge: const TextStyle().copyWith(
          color: AppColor.lightRegularText,
          fontSize: AppDimension().title1Text,
          fontWeight: FontWeight.bold),
      titleMedium: const TextStyle().copyWith(
          color: AppColor.lightRegularText,
          fontSize: AppDimension().title2Text,
          fontWeight: FontWeight.bold),
      titleSmall: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().title3Text,
      ),
      headlineLarge: const TextStyle().copyWith(
          color: AppColor.lightRegularText,
          fontSize: AppDimension().headlineText,
          fontWeight: FontWeight.w600),
      headlineMedium: const TextStyle().copyWith(
          color: AppColor.lightRegularText,
          fontSize: AppDimension().subHeadlineText,
          fontWeight: FontWeight.w500),
      headlineSmall: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().subHeadlineText,
      ),

      //caption
      labelSmall: const TextStyle().copyWith(
        color: AppColor.lightSecondaryText,
        fontSize: AppDimension().captionText,
      ),
      //caption medium
      labelMedium: const TextStyle().copyWith(
        color: AppColor.lightTertiaryText,
        fontSize: AppDimension().captionText,
      ),
//navigationn label
      displaySmall: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().navigationLabelText
      )
      
      
      
      );

  static TextTheme darkTextTheme = TextTheme(
      bodyMedium: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().bodyText,
      ),
      bodyLarge: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().bodyLargeText,
      ),
      bodySmall: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().bodySmallText,
      ),

      //title 1
      titleLarge: const TextStyle().copyWith(
          color: AppColor.darkRegularText,
          fontSize: AppDimension().title1Text,
          fontWeight: FontWeight.bold),
      titleMedium: const TextStyle().copyWith(
          color: AppColor.darkRegularText,
          fontSize: AppDimension().title2Text,
          fontWeight: FontWeight.bold),
      titleSmall: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().title3Text,
      ),

      //Headline
      headlineLarge: const TextStyle().copyWith(
          color: AppColor.darkRegularText,
          fontSize: AppDimension().headlineText,
          fontWeight: FontWeight.w600),

      // Subheadline - Medium
      headlineMedium: const TextStyle().copyWith(
          color: AppColor.darkRegularText,
          fontSize: AppDimension().subHeadlineText,
          fontWeight: FontWeight.w500),

//Subheadline
      headlineSmall: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().subHeadlineText,
      ),

      //caption
      labelSmall: const TextStyle().copyWith(
        color: AppColor.darkSecondaryText,
        fontSize: AppDimension().captionText,
      ),
      //caption medium
      labelMedium: const TextStyle().copyWith(
        color: AppColor.darkTertiaryText,
        fontSize: AppDimension().captionText,
      ),

      //navigation label
      displaySmall: const TextStyle().copyWith(
        color: AppColor.darkRegularText,
        fontSize: AppDimension().navigationLabelText
      )
      
      );
}
