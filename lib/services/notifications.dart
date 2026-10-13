import 'package:bonsui/models/local_notification.dart';
import 'package:bonsui/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class BonsuiNotifications {
  static GlobalKey<BonsuiScaffoldState> key = GlobalKey<BonsuiScaffoldState>();
  static Map<String, GlobalKey<BonsuiScaffoldState>> keys = {};

  static void show(LocalNotification notification) {
    if (notification.scaffoldKey != null) {
      notification.scaffoldKey?.currentState?.enqueue(notification);
      return;
    }
    key.currentState?.enqueue(notification);
  }

  static void generateKey() {
    key = GlobalKey<BonsuiScaffoldState>();
  }

  static GlobalKey<BonsuiScaffoldState> getRandomKey() {
    return GlobalKey<BonsuiScaffoldState>();
  }
}

class QueuedNotification {
  final LocalNotification notification;
  QueuedNotification(this.notification);
}
