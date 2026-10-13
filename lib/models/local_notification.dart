import 'package:bonsui/enums/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:bonsui/widgets/scaffold.dart';

class LocalNotification {
  final int? id;
  final Color? color;
  final IconData? icon;
  final String? title;
  final String? description;
  final Widget? child;
  final Duration? duration;
  final Function? onTap;
  final LocalNotificationType? type;
  final GlobalKey<BonsuiScaffoldState>? scaffoldKey;

  LocalNotification({
    this.id,
    this.color,
    this.icon,
    this.title,
    this.description,
    this.child,
    this.duration,
    this.onTap,
    this.type,
    this.scaffoldKey,
  });
}
