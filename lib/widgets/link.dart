import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiLink extends StatelessWidget {
  const BonsuiLink({
    super.key,
    required this.label,
    this.url,
    this.openInExternalBrowser,
    this.color,
    this.onPressed,
    this.padding,
    this.size,
  });

  final String label;
  final String? url;
  final bool? openInExternalBrowser;
  final Color? color;
  final Function? onPressed;
  final EdgeInsets? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (onPressed != null) {
          onPressed!();
        }
        if (url != null) {
          await BonsuiUtils.openUrl(
            url!,
            openInExternalBrowser ?? false,
          );
        }
      },
      highlightColor: color != null
          ? color!.withAlpha(30)
          : BonsuiDesign.primaryColor.withAlpha(30),
      splashFactory: Utils.getSplashFactory(),
      borderRadius: Utils.getBorderRadius(BonsuiDesign.defaultElementsShape),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: BonsuiDesign.spacing,
              vertical: BonsuiDesign.spacing / 2,
            ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color ?? BonsuiDesign.primaryColor.withAlpha(200),
                width: 1,
              ),
            ),
          ),
          child: BonsuiText(
            label,
            color: color ?? BonsuiDesign.primaryColor.withAlpha(200),
            size: size,
          ),
        ),
      ),
    );
  }
}
