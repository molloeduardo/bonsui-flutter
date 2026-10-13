import 'package:bonsui/bonsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonsuiAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  const BonsuiAppBar({super.key, this.title, this.titleChild, this.actions});

  final String? title;
  final Widget? titleChild;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    if (BonsuiUtils.isIos()) {
      return CupertinoTheme(
          data: CupertinoThemeData(
            primaryColor: BonsuiDesign.primaryColor,
          ),
          child: CupertinoNavigationBar(
            backgroundColor: BonsuiDesign.useDarkMode
                ? BonsuiDesign.blackColor
                : BonsuiDesign.whiteColor,
            middle: _getTitle(),
            trailing: actions,
          ));
    } else {
      return AppBar(
        backgroundColor: BonsuiDesign.useDarkMode
            ? BonsuiDesign.blackColor
            : BonsuiDesign.whiteColor,
        title: _getTitle(),
        actions: actions != null ? [actions!] : null,
        foregroundColor: BonsuiDesign.useDarkMode ? BonsuiDesign.whiteColor : null,
      );
    }
  }

  Widget? _getTitle() {
    if (title != null) {
      return BonsuiText(
        title!,
        weight: FontWeight.w600,
      );
    } else if (titleChild != null) {
      return titleChild;
    } else {
      return null;
    }
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    throw UnimplementedError();
  }
}
