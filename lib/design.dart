import 'package:bonsui/enums/general.dart';
import 'package:flutter/material.dart';

import 'enums/animation.dart';

class BonsuiDesign {
  // Colors
  static Color primaryColor = const Color(0xff3B93F6);
  static Color secondaryColor = const Color(0xff20d1d8);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff181818);
  static Color disabledColor = const Color(0xffC9D0DB);
  static Color textColor = const Color(0xff222222);
  static Color textColorLight = const Color(0xff666666);
  static Color backgroundColor = const Color(0xffffffff);
  static Color backgroundColorDark = const Color(0xff121212);
  static Color borderColor = Colors.grey.shade300;
  static Color dangerColor = const Color(0xffff5733);
  static Color successColor = const Color(0xff8bc34a);
  static Color warningColor = const Color(0xffff892e);
  static Color infoColor = const Color.fromARGB(255, 86, 135, 251);

  // Other
  static bool useDarkMode = false;
  static bool autoDarkMode = false;
  static BonsuiShape defaultElementsShape = BonsuiShape.regular;
  static double borderRadius = 12;
  static double spacing = 8.0;
  static Duration animationDuration = const Duration(milliseconds: 200);

  // Animation durations
  static Map<BonsuiAnimationDuration, Duration> animationDurations = {
    BonsuiAnimationDuration.slow: const Duration(milliseconds: 600),
    BonsuiAnimationDuration.medium: const Duration(milliseconds: 400),
    BonsuiAnimationDuration.fast: const Duration(milliseconds: 200),
  };

  // Paddings
  static Map<String, EdgeInsets> paddings = {
    'small': const EdgeInsets.all(6.0),
    'medium': const EdgeInsets.all(10.0),
    'large': const EdgeInsets.all(12.0),
    'biggest': const EdgeInsets.all(16.0),
    'small-horizontal': const EdgeInsets.symmetric(horizontal: 6.0),
    'medium-horizontal': const EdgeInsets.symmetric(horizontal: 10.0),
    'large-horizontal': const EdgeInsets.symmetric(horizontal: 12.0),
    'biggest-horizontal': const EdgeInsets.symmetric(horizontal: 16.0),
    'small-vertical': const EdgeInsets.symmetric(vertical: 6.0),
    'medium-vertical': const EdgeInsets.symmetric(vertical: 10.0),
    'large-vertical': const EdgeInsets.symmetric(vertical: 12.0),
    'biggest-vertical': const EdgeInsets.symmetric(vertical: 16.0),
  };
}
