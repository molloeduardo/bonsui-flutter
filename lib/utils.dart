import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';

class Utils {
  static BorderRadius getBorderRadius(BonsuiShape? shape) {
    if (shape == BonsuiShape.squared) {
      return BorderRadius.circular(0);
    }
    if (shape == BonsuiShape.rounded) {
      return BorderRadius.circular(100);
    }
    if (shape == BonsuiShape.regular) {
      return BorderRadius.circular(8);
    }
    if (BonsuiDesign.defaultElementsShape == BonsuiShape.squared) {
      return BorderRadius.circular(0);
    }
    if (BonsuiDesign.defaultElementsShape == BonsuiShape.rounded) {
      return BorderRadius.circular(100);
    }
    return BorderRadius.circular(BonsuiDesign.borderRadius);
  }

  static double getBorderRadiusNumber(BonsuiShape? shape) {
    if (shape == BonsuiShape.squared ||
        BonsuiDesign.defaultElementsShape == BonsuiShape.squared) {
      return 0;
    }
    if (shape == BonsuiShape.rounded ||
        BonsuiDesign.defaultElementsShape == BonsuiShape.rounded) {
      return 100;
    }
    return BonsuiDesign.borderRadius;
  }

  static InteractiveInkFeatureFactory getSplashFactory() {
    return BonsuiUtils.isIos() ? NoSplash.splashFactory : InkRipple.splashFactory;
  }
}
