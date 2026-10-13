import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/local_notification.dart';
import 'package:flutter/material.dart';

class BonsuiNotificationBanner extends StatefulWidget {
  const BonsuiNotificationBanner({
    super.key,
    this.notification,
    this.hasSafeArea,
  });

  final LocalNotification? notification;
  final bool? hasSafeArea;

  @override
  State<BonsuiNotificationBanner> createState() =>
      _BonsuiNotificationBannerState();
}

class _BonsuiNotificationBannerState extends State<BonsuiNotificationBanner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.notification != null && widget.notification!.onTap != null
          ? () {
              widget.notification!.onTap!();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: _getNotificationBannerColor(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(90),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
          borderRadius: BorderRadius.circular(
            BonsuiDesign.borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (widget.notification?.child != null)
              Container(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                width: 50,
                child: widget.notification!.child!,
              ),
            if ((widget.notification?.icon != null ||
                    widget.notification?.type != null) &&
                widget.notification?.child == null)
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  _getNotificationBannerIcon(),
                  color: Colors.white,
                  size: 34,
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.notification != null &&
                    widget.notification?.title != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                      right: 10,
                    ),
                    child: BonsuiText(
                      widget.notification!.title!,
                      color: Colors.white,
                      weight: FontWeight.w600,
                      lineHeight: 1.3,
                    ),
                  ),
                if (widget.notification != null &&
                    widget.notification!.description != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 0,
                    ),
                    child: SizedBox(
                      width: _getDescriptionWidth(),
                      child: BonsuiText(
                        widget.notification!.description!,
                        color: Colors.white,
                        lineHeight: 1.3,
                        size: 15,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getDescriptionWidth() {
    var toSubtract = 0;
    if (widget.notification != null &&
        widget.notification!.description != null) {
      if (widget.notification!.child != null) {
        toSubtract = 50;
      }
      if (widget.notification!.icon != null ||
          widget.notification!.type != null) {
        toSubtract = 50;
      }
    }
    return MediaQuery.of(context).size.width - (80 + toSubtract);
  }

  IconData _getNotificationBannerIcon() {
    if (widget.notification != null && widget.notification!.icon != null) {
      return widget.notification!.icon!;
    }
    if (widget.notification!.type != null) {
      switch (widget.notification!.type) {
        case LocalNotificationType.danger:
          return BonsuiIcons.error;
        case LocalNotificationType.success:
          return BonsuiIcons.checkCircle;
        case LocalNotificationType.warning:
          return BonsuiIcons.warning;
        case LocalNotificationType.info:
        default:
          return BonsuiIcons.info;
      }
    }
    return BonsuiIcons.info;
  }

  Color _getNotificationBannerColor() {
    if (widget.notification != null && widget.notification!.color != null) {
      return widget.notification!.color!;
    }
    if (widget.notification != null && widget.notification!.type != null) {
      switch (widget.notification!.type) {
        case LocalNotificationType.danger:
          return BonsuiDesign.dangerColor;
        case LocalNotificationType.success:
          return BonsuiDesign.successColor;
        case LocalNotificationType.warning:
          return BonsuiDesign.warningColor;
        case LocalNotificationType.info:
          return BonsuiDesign.infoColor;
        default:
          return BonsuiDesign.primaryColor;
      }
    }
    return BonsuiDesign.primaryColor;
  }
}
