import 'package:bonsui/bonsui.dart';
import 'package:bonsui/models/picker.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiIconPicker extends StatefulWidget {
  const BonsuiIconPicker({
    super.key,
    required this.icons,
    this.selectedIcon,
    this.label,
    this.spaceBetween,
    this.color,
    this.onSelected,
    this.size,
  });
  final List<BonsuiIconPickerList> icons;
  final IconData? selectedIcon;
  final String? label;
  final bool? spaceBetween;
  final Color? color;
  final Function(IconData)? onSelected;
  final double? size;

  @override
  State<BonsuiIconPicker> createState() => _BonsuiIconPickerState();
}

class _BonsuiIconPickerState extends State<BonsuiIconPicker> {
  IconData selectedIcon = BonsuiIcons.airplane;

  @override
  void initState() {
    setState(() {
      if (widget.selectedIcon != null) {
        selectedIcon = widget.selectedIcon!;
        return;
      }
      if (widget.icons.isNotEmpty) {
        selectedIcon = widget.icons.first.icons.first;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: widget.spaceBetween == null || widget.spaceBetween == false
          ? MainAxisSize.min
          : MainAxisSize.max,
      mainAxisAlignment:
          widget.spaceBetween == null || widget.spaceBetween == false
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
      children: [
        if (widget.label != null &&
            widget.spaceBetween != null &&
            widget.spaceBetween == true)
          BonsuiText(
            widget.label!,
          ),
        Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(50),
                splashFactory: Utils.getSplashFactory(),
                onTap: () async {
                  BonsuiUtils.openBottomSheet(
                    context: context,
                    actions: [],
                    content: Column(
                      children: [
                        for (var iconList in widget.icons)
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(children: [
                                if (iconList.label != null)
                                  Row(
                                    children: [
                                      BonsuiText(
                                        iconList.label!,
                                        color: BonsuiDesign.textColor,
                                        weight: FontWeight.w600,
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                Center(
                                    child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: iconList.icons.length > 6
                                      ? (iconList.icons.length / 6).ceil() * 50
                                      : 50,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 6,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: iconList.icons.length,
                                    itemBuilder: (context, index) {
                                      final icon = iconList.icons[index];
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          splashFactory:
                                              Utils.getSplashFactory(),
                                          onTap: () {
                                            setState(() {
                                              selectedIcon = icon;
                                            });
                                            if (widget.onSelected != null) {
                                              widget.onSelected!(icon);
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(icon,
                                              color: widget.color ??
                                                  BonsuiDesign.primaryColor,
                                              size: 35),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                              ])),
                      ],
                    ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(selectedIcon,
                        color: widget.color ?? BonsuiDesign.primaryColor,
                        size: widget.size ?? 35)))),
        if (widget.label != null &&
            (widget.spaceBetween == null || widget.spaceBetween == false))
          BonsuiText(
            widget.label!,
            padding: const EdgeInsets.only(
              left: 12,
            ),
          ),
      ],
    );
  }
}
