import 'package:bonsui/bonsui.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BonsuiButton extends StatefulWidget {
  const BonsuiButton({
    super.key,
    this.type,
    this.shape,
    this.label,
    this.labelColor,
    this.icon,
    this.iconPosition,
    this.onPressed,
    this.isLoading,
    this.minSize,
    this.child,
    this.disabled,
    this.color,
    this.customPrefix,
    this.iconSize,
    this.padding,
    this.margin,
    this.size,
    this.borderColor,
    this.useHapticFeedback,
  });

  final BonsuiButtonType? type;
  final BonsuiShape? shape;
  final String? label;
  final Color? labelColor;
  final IconData? icon;
  final BonsuiIconPosition? iconPosition;
  final Function? onPressed;
  final bool? isLoading;
  final Size? minSize;
  final Widget? child;
  final bool? disabled;
  final Color? color;
  final Widget? customPrefix;
  final double? iconSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BonsuiButtonSize? size;
  final Color? borderColor;
  final bool? useHapticFeedback;

  @override
  State<BonsuiButton> createState() => _BonsuiButtonState();
}

class _BonsuiButtonState extends State<BonsuiButton> {
  @override
  Widget build(BuildContext context) {
    return _getChild();
  }

  Widget _getChild() {
    if (widget.type == BonsuiButtonType.outlined) {
      return _getSecondaryButton();
    }
    if (widget.type == BonsuiButtonType.text) {
      return _getTextButton();
    }
    return _getPrimaryButton();
  }

  Widget _getPrimaryButton() {
    return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: ElevatedButton(
          style: _getButtonStyle(),
          onPressed: _getOnPressed(),
          child: _getButtonContent(),
        ));
  }

  Widget _getTextButton() {
    return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: TextButton(
          onPressed: _getOnPressed(),
          style: _getButtonStyle(),
          child: _getButtonContent(),
        ));
  }

  Widget _getSecondaryButton() {
    return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: OutlinedButton(
          onPressed: _getOnPressed(),
          style: _getButtonStyle(),
          child: _getButtonContent(),
        ));
  }

  Widget _getButtonContent() {
    return Padding(
      padding: _getPadding(),
      child: widget.isLoading != null && widget.isLoading!
          ? Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0,
                  child: _getIdleButtonContent(),
                ),
                Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: _getProgressIndicator(),
                    ),
                  ),
                ),
              ],
            )
          : _getIdleButtonContent(),
    );
  }

  Widget _getIdleButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Child
        if (widget.child != null) ...[
          widget.child!

          // Prefix
        ] else if (_isPrefix()) ...[
          if (widget.icon != null) _getIcon(),
          if (widget.customPrefix != null) widget.customPrefix!,
          const SizedBox(
            width: 6,
          ),
          _getText(),

          // Suffix
        ] else if (widget.iconPosition == BonsuiIconPosition.suffix) ...[
          _getText(),
          const SizedBox(
            width: 6,
          ),
          _getIcon(),

          // Icon only
        ] else if (widget.icon != null && widget.label == null) ...[
          _getIcon(),

          // Label only
        ] else if (widget.icon == null && widget.label != null) ...[
          _getText(),
        ],
      ],
    );
  }

  bool _isPrefix() {
    return (((widget.icon != null && widget.iconPosition == null) ||
                widget.customPrefix != null) ||
            widget.iconPosition == BonsuiIconPosition.prefix) &&
        widget.label != null;
  }

  Widget _getIcon() {
    return Icon(
      widget.icon,
      color: _getTextColor(),
      size: _getIconSize(),
    );
  }

  double _getIconSize() {
    if (widget.iconSize != null) {
      return widget.iconSize!;
    }
    switch (widget.size) {
      case BonsuiButtonSize.extraLarge:
        return 32;
      case BonsuiButtonSize.large:
        return 24;
      case BonsuiButtonSize.small:
        return 16;
      case BonsuiButtonSize.medium:
      default:
        return 20;
    }
  }

  Text _getText() {
    return Text(
      widget.label!,
      style: TextStyle(
        color: _getTextColor(),
        fontSize: _getTextSize(),
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }

  double _getTextSize() {
    switch (widget.size) {
      case BonsuiButtonSize.extraLarge:
        return 28;
      case BonsuiButtonSize.large:
        return 20;
      case BonsuiButtonSize.small:
        return 13;
      case BonsuiButtonSize.medium:
      default:
        return 15;
    }
  }

  Widget _getProgressIndicator() {
    if (BonsuiUtils.isIos()) {
      return CupertinoActivityIndicator(
        color: _getTextColor(),
        radius: 10,
      );
    } else {
      return CircularProgressIndicator(
        color: _getTextColor(),
        strokeWidth: 2,
      );
    }
  }

  dynamic _getOnPressed() {
    if (widget.useHapticFeedback != null && widget.useHapticFeedback!) {
      HapticFeedback.lightImpact();
    }
    return widget.onPressed != null &&
            (widget.isLoading == null || !widget.isLoading!) &&
            (widget.disabled == null || !widget.disabled!)
        ? () => widget.onPressed!()
        : null;
  }

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      shadowColor: BonsuiUtils.isIos() ||
              (widget.type == null || widget.type != BonsuiButtonType.primary)
          ? WidgetStateProperty.all(Colors.transparent)
          : null,
      backgroundColor: widget.type == null ||
              widget.type == BonsuiButtonType.primary ||
              widget.type == BonsuiButtonType.secondary
          ? WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                return _getSurfaceColor(states);
              },
            )
          : null,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: WidgetStateProperty.all(_getOverlayColor()),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      minimumSize: widget.icon != null && widget.label == null
          ? WidgetStateProperty.all(widget.minSize ?? const Size(0, 0))
          : WidgetStateProperty.all(
              widget.minSize ??
                  Size(
                    widget.size == null || widget.size != BonsuiButtonSize.small
                        ? 150
                        : 0,
                    0,
                  ),
            ),
      splashFactory: Utils.getSplashFactory(),
      side: widget.type == BonsuiButtonType.text
          ? null
          : WidgetStateProperty.resolveWith<BorderSide>(
              (Set<WidgetState> states) {
                return BorderSide(
                  width: 1,
                  color: widget.type == BonsuiButtonType.outlined ||
                          widget.borderColor != null
                      ? (widget.onPressed != null &&
                              (widget.isLoading == null ||
                                  !widget.isLoading!) &&
                              (widget.disabled == null || !widget.disabled!))
                          ? widget.borderColor ??
                              widget.color ??
                              BonsuiDesign.primaryColor
                          : BonsuiDesign.useDarkMode
                              ? BonsuiUtils.darken(
                                  BonsuiDesign.disabledColor,
                                  0.5,
                                )
                              : BonsuiDesign.disabledColor
                      : _getSurfaceColor(states),
                );
              },
            ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: Utils.getBorderRadius(widget.shape),
        ),
      ),
    );
  }

  Color _getSurfaceColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled) ||
        (widget.isLoading != null && widget.isLoading!)) {
      if (BonsuiDesign.useDarkMode) {
        return BonsuiUtils.darken(BonsuiDesign.disabledColor, 0.5);
      } else {
        return BonsuiDesign.disabledColor;
      }
    } else {
      if (widget.color != null) {
        if (widget.type == BonsuiButtonType.secondary) {
          return widget.color!.withAlpha(40);
        } else {
          return widget.color!;
        }
      }
      if (widget.type == BonsuiButtonType.secondary) {
        return BonsuiDesign.primaryColor.withAlpha(40);
      }
      return BonsuiDesign.primaryColor;
    }
  }

  Color? _getOverlayColor() {
    if (widget.color != null) {
      if (widget.type == null || widget.type == BonsuiButtonType.primary) {
        return BonsuiUtils.darken(widget.color!, 0.15).withAlpha(70);
      } else if (widget.type == BonsuiButtonType.secondary) {
        return widget.color!.withAlpha(70);
      } else {
        return widget.color!.withAlpha(50);
      }
    }
    if (widget.type == BonsuiButtonType.secondary) {
      return BonsuiDesign.primaryColor.withAlpha(70);
    }
    return widget.type == null || widget.type == BonsuiButtonType.primary
        ? BonsuiUtils.darken(BonsuiDesign.primaryColor, 0.15).withAlpha(70)
        : BonsuiDesign.primaryColor.withAlpha(50);
  }

  Color? _getTextColor() {
    if (widget.disabled != null && widget.disabled! ||
        (widget.isLoading != null && widget.isLoading!) ||
        widget.onPressed == null) {
      return BonsuiUtils.darken(BonsuiDesign.disabledColor, 0.3);
    }
    if (widget.labelColor != null) {
      return widget.labelColor;
    }
    if (((widget.type == BonsuiButtonType.text ||
                widget.type == BonsuiButtonType.outlined) &&
            widget.onPressed == null) ||
        (widget.type == BonsuiButtonType.outlined ||
                widget.type == BonsuiButtonType.text) &&
            ((widget.isLoading != null && widget.isLoading!) ||
                (widget.disabled != null && widget.disabled!))) {
      if (BonsuiDesign.useDarkMode) {
        return BonsuiUtils.darken(BonsuiDesign.disabledColor, 0.5);
      } else {
        return BonsuiDesign.disabledColor;
      }
    }
    if (widget.color != null &&
        (widget.type != null && widget.type != BonsuiButtonType.primary)) {
      return widget.color;
    }
    if (widget.type == null || widget.type == BonsuiButtonType.primary) {
      return Colors.white;
    } else {
      return BonsuiDesign.primaryColor;
    }
  }

  EdgeInsets _getPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }
    if (widget.label == null) {
      return const EdgeInsets.symmetric(horizontal: 4, vertical: 4);
    }
    switch (widget.size) {
      case BonsuiButtonSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 30, vertical: 24);
      case BonsuiButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 22, vertical: 16);
      case BonsuiButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
      case BonsuiButtonSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }
}
