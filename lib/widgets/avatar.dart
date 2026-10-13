import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiAvatar extends StatefulWidget {
  const BonsuiAvatar({
    super.key,
    this.size,
    this.shape,
    this.isOnline,
    this.url,
    this.path,
    this.notifications,
    this.child,
    this.border,
    this.shadow,
    this.color,
    this.widthHeight,
    this.fit,
  });

  final BonsuiAvatarSize? size;
  final BonsuiShape? shape;
  final bool? isOnline;
  final String? url;
  final String? path;
  final int? notifications;
  final Widget? child;
  final Border? border;
  final BoxShadow? shadow;
  final Color? color;
  final double? widthHeight;
  final BoxFit? fit;

  @override
  State<BonsuiAvatar> createState() => _BonsuiAvatarState();
}

class _BonsuiAvatarState extends State<BonsuiAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: _getSize(),
          height: _getSize(),
          decoration: BoxDecoration(
            border: widget.border,
            boxShadow: widget.shadow != null ? [widget.shadow!] : [],
            borderRadius: _getShape(),
          ),
          child: ClipRRect(
            borderRadius: _getShape(),
            child: _getImage(),
          ),
        ),
        if (widget.child != null) widget.child!,
        if (widget.isOnline != null && widget.isOnline!)
          Positioned(
            bottom: _getOnlinePosition(),
            right: _getOnlinePosition(),
            child: Container(
              width: _getOnlineStatusSize(),
              height: _getOnlineStatusSize(),
              decoration: BoxDecoration(
                color: BonsuiDesign.successColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        if (widget.notifications != null && widget.notifications! > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: _getNotificationsSize(),
              height: _getNotificationsSize(),
              decoration: BoxDecoration(
                color: BonsuiDesign.dangerColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: BonsuiText(
                  widget.notifications! > 9
                      ? '+9'
                      : widget.notifications.toString(),
                  color: Colors.white,
                  size: _getNotificationsFontSize(),
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  double _getNotificationsFontSize() {
    double defautlSize;
    switch (widget.size) {
      case BonsuiAvatarSize.extraSmall:
        defautlSize = 7;
        break;
      case BonsuiAvatarSize.small:
        defautlSize = 9;
        break;
      case BonsuiAvatarSize.large:
        defautlSize = 13;
        break;
      case BonsuiAvatarSize.extraLarge:
        defautlSize = 17;
        break;
      case BonsuiAvatarSize.medium:
      default:
        defautlSize = 11;
        break;
    }
    if (widget.notifications != null && widget.notifications! > 9) {
      defautlSize -= 2;
    }
    return defautlSize;
  }

  double _getOnlinePosition() {
    double defaultPosition;
    switch (widget.size) {
      case BonsuiAvatarSize.extraSmall:
      case BonsuiAvatarSize.small:
        defaultPosition = 0;
        break;
      case BonsuiAvatarSize.large:
        defaultPosition = 3;
        break;
      case BonsuiAvatarSize.extraLarge:
        defaultPosition = 6;
        break;
      case BonsuiAvatarSize.medium:
      default:
        defaultPosition = 0;
        break;
    }
    return defaultPosition;
  }

  double _getNotificationsSize() {
    double defautlSize;
    switch (widget.size) {
      case BonsuiAvatarSize.extraSmall:
        defautlSize = 11;
        break;
      case BonsuiAvatarSize.small:
        defautlSize = 14;
        break;
      case BonsuiAvatarSize.large:
        defautlSize = 22;
        break;
      case BonsuiAvatarSize.extraLarge:
        defautlSize = 27;
        break;
      case BonsuiAvatarSize.medium:
      default:
        defautlSize = 18;
        break;
    }
    return defautlSize;
  }

  double _getOnlineStatusSize() {
    double defautlSize;
    switch (widget.size) {
      case BonsuiAvatarSize.extraSmall:
        defautlSize = 11;
        break;
      case BonsuiAvatarSize.small:
        defautlSize = 11;
        break;
      case BonsuiAvatarSize.large:
        defautlSize = 20;
        break;
      case BonsuiAvatarSize.extraLarge:
        defautlSize = 27;
        break;
      case BonsuiAvatarSize.medium:
      default:
        defautlSize = 15;
        break;
    }
    return defautlSize;
  }

  double _getSize() {
    double defautlSize;
    if (widget.widthHeight != null) {
      return widget.widthHeight!;
    }
    switch (widget.size) {
      case BonsuiAvatarSize.extraSmall:
        defautlSize = 25;
        break;
      case BonsuiAvatarSize.small:
        defautlSize = 35;
        break;
      case BonsuiAvatarSize.large:
        defautlSize = 80;
        break;
      case BonsuiAvatarSize.extraLarge:
        defautlSize = 120;
        break;
      case BonsuiAvatarSize.medium:
      default:
        defautlSize = 50;
        break;
    }
    return defautlSize;
  }

  BorderRadius _getShape() {
    BonsuiShape selectedShape = widget.shape ?? BonsuiShape.rounded;
    return Utils.getBorderRadius(selectedShape);
  }

  Widget? _getImage() {
    if (widget.url != null) {
      return BonsuiCachedNetworkImage(
        url: widget.url!,
        fit: BoxFit.cover,
        placeholder: const SizedBox(
          child: BonsuiCircularProgressIndicator(
            size: BonsuiProgressIndicatorSize.small,
          ),
        ),
        errorWidget: const Icon(
          Icons.error,
        ),
      );
    } else if (widget.path != null) {
      return Image.asset(
        widget.path!,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,
      );
    }
    return null;
  }
}
