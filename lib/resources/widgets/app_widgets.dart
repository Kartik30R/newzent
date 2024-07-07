import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:newzent/resources/constants/color/app_color.dart';

class AppWidgets {
  static const loadingIndicator = SizedBox(
      width: 40,
      height: 40,
      child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [
            AppColor.primaryShade1,
            AppColor.primary,
          ]));
}
