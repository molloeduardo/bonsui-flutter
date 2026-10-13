import 'package:flutter/cupertino.dart';

class BonsuiPaywallItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  BonsuiPaywallItem(
      {required this.title,
      required this.description,
      required this.icon,
      required this.color});
}

class BonsuiPaywallPrice {
  final int id;
  final String title;
  final double price;
  final String duration;
  final String? discount;

  BonsuiPaywallPrice(
      {required this.id,
      required this.title,
      required this.price,
      required this.duration,
      this.discount});
}
