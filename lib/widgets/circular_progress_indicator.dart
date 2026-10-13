import 'package:bonsui/bonsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonsuiCircularProgressIndicator extends StatelessWidget {
  const BonsuiCircularProgressIndicator({super.key, this.color, this.size});

  final Color? color;
  final BonsuiProgressIndicatorSize? size;

  @override
  Widget build(BuildContext context) {
    if (BonsuiUtils.isIos()) {
      return CupertinoActivityIndicator(
        color: color ?? BonsuiDesign.primaryColor,
        radius: _getSize(),
      );
    } else {
      return Transform.scale(
        scale: _getSize(),
        child: CircularProgressIndicator(
          color: color ?? BonsuiDesign.primaryColor,
          strokeWidth: 2,
        ),
      );
    }
  }

  double _getSize() {
    double defautlSize;
    if (BonsuiUtils.isIos()) {
      defautlSize = 10;
    } else {
      defautlSize = 0.6;
    }
    switch (size) {
      case BonsuiProgressIndicatorSize.small:
        return defautlSize;
      case BonsuiProgressIndicatorSize.medium:
        return defautlSize + (BonsuiUtils.isIos() ? 3 : 0.3);
      case BonsuiProgressIndicatorSize.large:
        return defautlSize + (BonsuiUtils.isIos() ? 6 : 0.6);
      default:
        return defautlSize;
    }
  }
}
