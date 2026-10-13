import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiSettingsGroup extends StatelessWidget {
  const BonsuiSettingsGroup(
      {super.key, this.title, required this.items, this.titleChild});

  final String? title;
  final Widget? titleChild;
  final List<BonsuiSettingsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BonsuiText(title!, size: 12),
                titleChild ?? const SizedBox(),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.only(
            left: 7,
            right: 7,
            top: 3,
            bottom: 3,
          ),
          decoration: BoxDecoration(
            color: BonsuiDesign.useDarkMode
                ? Colors.grey.shade900
                : Colors.grey.shade100,
            border: Border.all(
              color: BonsuiDesign.useDarkMode
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(BonsuiDesign.borderRadius),
          ),
          child: Column(
            children: items
                .asMap()
                .map((i, item) => MapEntry(
                    i,
                    Column(
                      children: [
                        Material(
                          borderRadius: Utils.getBorderRadius(
                              BonsuiDesign.defaultElementsShape),
                          color: Colors.transparent,
                          child: InkWell(
                            splashFactory: Utils.getSplashFactory(),
                            borderRadius: Utils.getBorderRadius(
                                BonsuiDesign.defaultElementsShape),
                            onTap: item.onTap,
                            child: Ink(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        item.icon != null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:
                                                      BonsuiDesign.useDarkMode ||
                                                              item.color != null
                                                          ? _getColor(item)
                                                              .withAlpha(30)
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Icon(item.icon,
                                                    color: _getColor(item)),
                                              )
                                            : const SizedBox(),
                                        item.iconChild != null
                                            ? item.iconChild!
                                            : const SizedBox(),
                                        const SizedBox(width: 10),
                                        item.description != null
                                            ? BonsuiText(
                                                item.description!,
                                                color: item.color,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    item.child
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (i < items.length - 1)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: BonsuiDivider(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              color: BonsuiDesign.useDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                            ),
                          ),
                      ],
                    )))
                .values
                .toList(),
          ),
        ),
      ],
    );
  }

  Color _getColor(BonsuiSettingsItem item) {
    if (item.color != null) {
      return item.color!;
    }
    if (BonsuiDesign.useDarkMode) {
      return Colors.white;
    }
    return BonsuiDesign.textColor;
  }
}
