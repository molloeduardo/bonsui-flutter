import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BonsuiTextField extends StatefulWidget {
  const BonsuiTextField({
    super.key,
    this.placeholder,
    this.label,
    this.secondaryLabel,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixLabel,
    this.suffix,
    required this.controller,
    this.validator,
    this.onChanged,
    this.showBorder,
    this.onValidation,
    this.disabled,
    this.readonly,
    this.type,
    this.multiline,
    this.maxLines,
    this.shape,
    this.onSubmitted,
    this.showCounter,
    this.borderRadius,
    this.options,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.padding,
    this.focusNode,
    this.textColor,
    this.filled,
    this.hideFocusState,
  });

  final TextEditingController controller;
  final String? placeholder;
  final String? label;
  final String? secondaryLabel;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? suffixLabel;
  final Widget? suffix;
  final BonsuiTextFieldValidator? validator;
  final Function? onChanged;
  final bool? showBorder;
  final Function(bool)? onValidation;
  final bool? disabled;
  final bool? readonly;
  final BonsuiTextFieldType? type;
  final bool? multiline;
  final int? maxLines;
  final BonsuiShape? shape;
  final Function? onSubmitted;
  final bool? showCounter;
  final double? borderRadius;
  final List<BonsuiDropdownItem>? options;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final Color? textColor;
  final bool? filled;
  final bool? hideFocusState;

  @override
  State<BonsuiTextField> createState() => _BonsuiTextFieldState();
}

class _BonsuiTextFieldState extends State<BonsuiTextField> {
  bool isInvalid = false;
  String errorMessage = '';
  final _debouncer = BonsuiDebouncer(milliseconds: 500);
  bool showPassword = false;

  FocusNode? _internalFocusNode;
  late FocusNode _effectiveFocusNode;
  bool get _hasFocus => _effectiveFocusNode.hasFocus;

  // Shows a human-readable version of the date/time while widget.controller keeps the raw parseable value
  TextEditingController? _displayController;
  bool get _isDateType =>
      widget.type != null &&
      (widget.type == BonsuiTextFieldType.datetime ||
          widget.type == BonsuiTextFieldType.date ||
          widget.type == BonsuiTextFieldType.time);
  TextEditingController get _effectiveController =>
      _isDateType ? _displayController! : widget.controller;

  double defaultFontSize = 15;

  @override
  initState() {
    super.initState();
    _setupFocusNode();
    _setupDisplayController();
  }

  @override
  void didUpdateWidget(covariant BonsuiTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _effectiveFocusNode.removeListener(_onFocusChanged);

      if (widget.focusNode != null) {
        _internalFocusNode?.dispose();

        _internalFocusNode = null;
      }
      _setupFocusNode();
    }
    if (oldWidget.controller != widget.controller ||
        oldWidget.type != widget.type) {
      oldWidget.controller.removeListener(_syncDisplayController);
      _setupDisplayController();
    }
  }

  void _setupDisplayController() {
    if (_isDateType) {
      _displayController ??= TextEditingController();
      _displayController!.text = _getDisplayText(widget.controller.text);
      widget.controller.addListener(_syncDisplayController);
    } else if (_displayController != null) {
      widget.controller.removeListener(_syncDisplayController);
      _displayController!.dispose();
      _displayController = null;
    }
  }

  void _syncDisplayController() {
    final displayText = _getDisplayText(widget.controller.text);
    if (_displayController != null && _displayController!.text != displayText) {
      _displayController!.text = displayText;
    }
  }

  String _getDisplayText(String rawValue) {
    if (rawValue.isEmpty) return rawValue;
    final locale = BonsuiLocalization.getLanguage();
    try {
      switch (widget.type) {
        case BonsuiTextFieldType.date:
          final date = DateTime.parse(rawValue);
          if (_isToday(date)) return BonsuiLocalization.get('today');
          if (_isYesterday(date)) return BonsuiLocalization.get('yesterday');
          return DateFormat.yMMMd(locale).format(date);
        case BonsuiTextFieldType.datetime:
          final date = DateTime.parse(rawValue);
          final time = DateFormat.Hm(locale).format(date);
          if (_isToday(date)) {
            return '${BonsuiLocalization.get('today')} $time';
          }
          if (_isYesterday(date)) {
            return '${BonsuiLocalization.get('yesterday')} $time';
          }
          return '${DateFormat.yMMMd(locale).format(date)} $time';
        case BonsuiTextFieldType.time:
          final timeParts = rawValue.split(':');
          return DateFormat.Hm(locale).format(
            DateTime(
              2000,
              1,
              1,
              int.parse(timeParts[0]),
              int.parse(timeParts[1]),
            ),
          );
        default:
          return rawValue;
      }
    } catch (_) {
      return rawValue;
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  void _setupFocusNode() {
    _internalFocusNode ??= widget.focusNode == null ? FocusNode() : null;
    _effectiveFocusNode = widget.focusNode ?? _internalFocusNode!;
    _effectiveFocusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _internalFocusNode?.dispose();
    widget.controller.removeListener(_syncDisplayController);
    _displayController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null || widget.secondaryLabel != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              children: [
                if (widget.label != null)
                  BonsuiText(
                    widget.label!,
                    weight: FontWeight.w700,
                    size: 15,
                    align: widget.textAlign ?? TextAlign.start,
                  ),
                if (widget.secondaryLabel != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: BonsuiText(
                      widget.secondaryLabel!,
                      weight: FontWeight.w600,
                      size: 15,
                      align: widget.textAlign ?? TextAlign.start,
                      color: Colors.grey.shade500,
                    ),
                  ),
              ],
            ),
          ),
        if (BonsuiUtils.isIos()) _getIosTextField(),
        if (!BonsuiUtils.isIos()) _getAnimatedContainer(_getAndroidTextField()),
        if (widget.showCounter != null && widget.showCounter!)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: BonsuiText(
                  '${widget.controller.text.length} / ${widget.validator?.max?.toInt() ?? 100}',
                  color: Colors.grey,
                  size: 12,
                  align: TextAlign.end,
                ),
              ),
            ],
          ),
        if (isInvalid && errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: BonsuiIcon(BonsuiIcons.error,
                        color: BonsuiDesign.dangerColor, size: 15),
                  ),
                  BonsuiSpacing.horizontal(0.3),
                  Expanded(
                    child: BonsuiText(errorMessage,
                        color: BonsuiDesign.dangerColor,
                        size: 13,
                        weight: FontWeight.w600,
                        lineHeight: 1.4),
                  ),
                ]),
          ),
      ],
    );
  }

  AnimatedContainer _getAnimatedContainer(Widget child) {
    return AnimatedContainer(
      duration:
          BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
        color: _getBackgroundColor(),
        borderRadius: _getBorderRadius(),
      ),
      child: child,
    );
  }

  void _runValidationCheck(String value) {
    final validationError = _checkValidation(value);
    if (validationError != null) {
      setState(() {
        isInvalid = true;
        errorMessage = validationError;
      });
      if (widget.onValidation != null) {
        widget.onValidation!(false);
      }
    } else {
      setState(() {
        isInvalid = false;
        errorMessage = '';
      });
      if (widget.onValidation != null) {
        widget.onValidation!(true);
      }
    }
  }

  Widget _getIosTextField() {
    return TweenAnimationBuilder<Color?>(
        duration:
            BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
        curve: Curves.easeOut,
        tween: ColorTween(
          end: _getBorderColor(),
        ),
        builder: (context, borderColor, child) {
          return CupertinoTextField(
            focusNode: _effectiveFocusNode,
            textAlign: widget.textAlign ?? TextAlign.start,
            style: TextStyle(
              color: widget.textColor ??
                  (BonsuiDesign.useDarkMode
                      ? BonsuiDesign.whiteColor
                      : BonsuiDesign.textColor),
              fontSize: widget.fontSize ?? defaultFontSize,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
            ),
            onSubmitted: (value) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(value);
              }
            },
            keyboardType: _getKeyboardType(),
            maxLines: widget.maxLines ?? 1,
            controller: _effectiveController,
            onChanged: (value) {
              if (_isDateType) return;
              _debouncer.run(() {
                _runValidationCheck(value);
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onTap: _onTap(),
            readOnly:
                _isReadOnly() || widget.disabled != null && widget.disabled!,
            placeholder: widget.placeholder,
            placeholderStyle: TextStyle(
              color: BonsuiDesign.useDarkMode
                  ? Colors.grey.shade600
                  : Colors.grey[400],
              fontWeight: FontWeight.w600,
              fontSize: widget.fontSize ?? defaultFontSize,
            ),
            padding: _getPadding(),
            obscureText: _isPasswordField() && !showPassword,
            prefix: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: _getAnimatedIcon(widget.prefixIcon!, size: 20),
                  )
                : null,
            suffix: _getSuffix(),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? _getBorderColor(),
                width: 1,
              ),
              color: _getBackgroundColor(),
              borderRadius: _getBorderRadius(),
            ),
          );
        });
  }

  Color _getBackgroundColor() {
    // Disabled state
    if (widget.disabled != null && widget.disabled!) {
      if (BonsuiDesign.useDarkMode) {
        return const Color(0xff303030);
      } else {
        return BonsuiDesign.disabledColor.withAlpha(100);
      }
    }

    if (widget.filled == null || !widget.filled!) {
      return Colors.transparent;
    }
    if (widget.color != null) {
      return widget.color!;
    }
    if (BonsuiDesign.useDarkMode) {
      return const Color(0xff202020);
    } else {
      return const Color(0xffEEEEEC);
    }
  }

  Widget _getAndroidTextField() {
    return TextField(
      focusNode: _effectiveFocusNode,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: TextStyle(
        color: BonsuiDesign.useDarkMode && widget.color == null
            ? Colors.white
            : BonsuiDesign.textColor,
        fontSize: widget.fontSize ?? defaultFontSize,
        fontWeight: widget.fontWeight ?? FontWeight.normal,
      ),
      onSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },
      keyboardType: _getKeyboardType(),
      maxLines: widget.maxLines ?? 1,
      controller: _effectiveController,
      onChanged: (value) {
        if (_isDateType) return;
        _debouncer.run(() {
          _runValidationCheck(value);
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTap: _onTap(),
      enabled: widget.disabled != null ? !widget.disabled! : true,
      readOnly: _isReadOnly(),
      decoration: InputDecoration(
          contentPadding: _getPadding(),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: BonsuiDesign.useDarkMode
                ? Colors.grey.shade600
                : Colors.grey[400],
            fontWeight: FontWeight.w700,
            fontSize: widget.fontSize ?? defaultFontSize,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                  ),
                  child: _getAnimatedIcon(widget.prefixIcon!),
                )
              : null,
          suffixIcon: _getSuffix(centerLabel: true),
          focusedBorder: OutlineInputBorder(
            borderRadius: _getBorderRadius(),
            borderSide: BorderSide(
              color: widget.hideFocusState != null && widget.hideFocusState!
                  ? Colors.transparent
                  : widget.color ?? BonsuiDesign.primaryColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: _getBorderRadius(),
            borderSide: BorderSide(
              color: _getBorderColor(),
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: _getBorderRadius(),
            borderSide: BorderSide(
              color: _getBorderColor(),
              width: 1,
            ),
          ),
          filled: widget.filled != null && widget.filled!,
          fillColor: _getBackgroundColor()),
      obscureText: _isPasswordField() && !showPassword,
    );
  }

  bool _isReadOnly() {
    return (widget.readonly != null && widget.readonly!) ||
        widget.options != null ||
        (widget.type != null &&
            (widget.type == BonsuiTextFieldType.datetime ||
                widget.type == BonsuiTextFieldType.date ||
                widget.type == BonsuiTextFieldType.time));
  }

  dynamic _onTap() {
    if (widget.options != null) {
      return () {
        if (BonsuiUtils.isIos()) {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                  title: Text(widget.label ??
                      BonsuiLocalization.get('select_an_option')),
                  actions: <Widget>[
                    for (var option in widget.options!)
                      CupertinoActionSheetAction(
                        onPressed: () {
                          widget.controller.text = option.label!;
                          if (widget.onChanged != null) {
                            widget.onChanged!(option.value);
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (option.icon != null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        option.icon,
                                        color: _getIconColor(),
                                        size: 20,
                                      ),
                                    ),
                                  Text(option.label!),
                                ],
                              ),
                              if (widget.controller.text == option.label)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    BonsuiIcons.check,
                                    size: 18,
                                    color: BonsuiDesign.primaryColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isDefaultAction: true,
                    child: Text(
                      BonsuiLocalization.get('cancel'),
                    ),
                  ));
            },
          );
        } else {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      widget.label ??
                          BonsuiLocalization.get('select_an_option'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Divider(height: 1),
                  ...widget.options!.map((option) {
                    final isSelected = widget.controller.text == option.label;
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (option.icon != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                option.icon,
                                color: _getIconColor(),
                                size: 20,
                              ),
                            ),
                          Text(option.label!),
                        ],
                      ),
                      trailing: isSelected
                          ? Icon(
                              BonsuiIcons.check,
                              size: 18,
                              color: BonsuiDesign.primaryColor,
                            )
                          : null,
                      onTap: () {
                        widget.controller.text = option.label!;
                        widget.onChanged?.call(option.value);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                  const Divider(height: 1),
                  ListTile(
                    title: Center(
                      child: Text(
                        BonsuiLocalization.get('cancel'),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        }
      };
    }
    if (widget.type != null &&
        (widget.type == BonsuiTextFieldType.datetime ||
            widget.type == BonsuiTextFieldType.date ||
            widget.type == BonsuiTextFieldType.time)) {
      if (widget.disabled ?? false) {
        return null;
      }
      if (BonsuiUtils.isIos()) {
        return () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.white,
                height: 260,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getDateValidationInfo(),
                    BonsuiSpacing.vertical(),
                    SizedBox(
                      height: 160,
                      child: CupertinoDatePicker(
                        initialDateTime: _getInitialDateTime(),
                        minimumDate: widget.validator != null &&
                                widget.validator!.minDate != null
                            ? widget.validator!.minDate
                            : null,
                        maximumDate: widget.validator != null &&
                                widget.validator!.maxDate != null
                            ? widget.validator!.maxDate
                            : null,
                        use24hFormat:
                            MediaQuery.of(context).alwaysUse24HourFormat,
                        mode: widget.type == BonsuiTextFieldType.datetime
                            ? CupertinoDatePickerMode.dateAndTime
                            : widget.type == BonsuiTextFieldType.date
                                ? CupertinoDatePickerMode.date
                                : CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          widget.controller.text = _getDateTimeText(value);
                          if (widget.onChanged != null) {
                            widget.onChanged!(value);
                          }
                          _runValidationCheck(value.toString());
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        };
      } else {
        return () async {
          DateTime? picked = DateTime.now();

          DateTime? initialDate;
          if (widget.type != null) {
            if (widget.type == BonsuiTextFieldType.time) {
              initialDate = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                widget.controller.text != ''
                    ? int.parse(widget.controller.text.split(':')[0].toString())
                    : DateTime.now().hour,
                widget.controller.text != ''
                    ? int.parse(widget.controller.text.split(':')[1].toString())
                    : DateTime.now().minute,
              );
            }
          }

          initialDate ??= widget.controller.text.isNotEmpty
              ? DateTime.parse(widget.controller.text)
              : DateTime.now();

          // Date picker
          if (widget.type != null && widget.type == BonsuiTextFieldType.date) {
            picked = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate:
                  widget.validator != null && widget.validator!.minDate != null
                      ? widget.validator!.minDate!
                      : DateTime(1900),
              lastDate:
                  widget.validator != null && widget.validator!.maxDate != null
                      ? widget.validator!.maxDate!
                      : DateTime.now(),
            );
          }

          // Time picker
          if (widget.type != null && widget.type == BonsuiTextFieldType.time) {
            TimeOfDay? time = await showTimePicker(
              // ignore: use_build_context_synchronously
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialDate),
            );

            if (time != null) {
              picked = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                time.hour,
                time.minute,
              );
            }
          }

          // Date and time picker
          if (widget.type != null &&
              widget.type == BonsuiTextFieldType.datetime) {
            showDatePicker(
              // ignore: use_build_context_synchronously
              context: context,
              initialDate: initialDate,
              firstDate:
                  widget.validator != null && widget.validator!.minDate != null
                      ? widget.validator!.minDate!
                      : DateTime(1900),
              lastDate:
                  widget.validator != null && widget.validator!.maxDate != null
                      ? widget.validator!.maxDate!
                      : DateTime.now(),
            ).then((date) {
              if (date != null) {
                showTimePicker(
                  // ignore: use_build_context_synchronously
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(initialDate!),
                ).then((time) {
                  if (time != null) {
                    picked = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  }
                });
              }
            });
          }

          if (picked != null) {
            widget.controller.text = _getDateTimeText(picked!);
            if (widget.onChanged != null) {
              widget.onChanged!(picked);
            }
            _runValidationCheck(picked.toString());
          }
        };
      }
    }
  }

  DateTime? _getInitialDateTime() {
    if (widget.controller.text.isNotEmpty) {
      if (widget.type == BonsuiTextFieldType.time) {
        final timeParts = widget.controller.text.split(':');
        return DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(timeParts[0]),
          int.parse(timeParts[1]),
        );
      } else {
        return DateTime.parse(widget.controller.text);
      }
    }
    if (widget.validator != null && widget.validator!.maxDate != null) {
      return widget.validator!.maxDate;
    }
    return DateTime.now();
  }

  String _getDateTimeText(DateTime value) {
    if (widget.type == BonsuiTextFieldType.datetime) {
      final splittedValue = value.toString().split(':');
      return '${splittedValue[0]}:${splittedValue[1]}';
    } else if (widget.type == BonsuiTextFieldType.date) {
      final splittedValue = value.toString().split(' ');
      return splittedValue[0];
    } else {
      final splittedValue = value.toString().split(' ');
      final splittedTime = splittedValue[1].split(':');
      return '${splittedTime[0]}:${splittedTime[1]}';
    }
  }

  Widget _getDateValidationInfo() {
    if (widget.validator != null) {
      String infoText = '';
      String type = BonsuiLocalization.get('date');
      if (widget.type == BonsuiTextFieldType.time) {
        type = BonsuiLocalization.get('time');
      }

      final maxDate = widget.validator!.maxDate?.add(const Duration(days: 1));

      if (widget.validator!.minDate != null &&
          widget.validator!.maxDate != null) {
        infoText =
            '${BonsuiLocalization.get('select-a')} $type ${BonsuiLocalization.get('between')} ${_getDateTimeText(widget.validator!.minDate!)} and ${_getDateTimeText(widget.validator!.maxDate!)}';
      } else if (widget.validator!.minDate != null) {
        infoText =
            '${BonsuiLocalization.get('select-a')} $type ${BonsuiLocalization.get('after')} ${_getDateTimeText(widget.validator!.minDate!)}';
      } else if (widget.validator!.maxDate != null) {
        infoText =
            '${BonsuiLocalization.get('select-a')} $type ${BonsuiLocalization.get('before')} ${_getDateTimeText(maxDate!)}';
      }

      if (widget.validator!.minDate != null ||
          widget.validator!.maxDate != null) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.grey,
                size: 22,
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: BonsuiText(
                  infoText,
                  color: Colors.grey,
                  maxLines: 2,
                  lineHeight: 0,
                ),
              ),
            ],
          ),
        );
      }
    }
    return const SizedBox();
  }

  Widget? _getSuffix({bool centerLabel = false}) {
    if (widget.suffix != null) {
      return widget.suffix;
    }
    if (widget.options != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: _getAnimatedIcon(BonsuiIcons.list, size: 20),
      );
    }
    if (widget.suffixLabel != null) {
      final label = BonsuiText(
        widget.suffixLabel!,
        color: _getIconColor(),
        size: widget.fontSize ?? defaultFontSize,
        weight: FontWeight.w600,
        lineHeight: centerLabel ? 1 : 0,
      );
      return Padding(
        padding: const EdgeInsets.only(right: 15),
        child: centerLabel
            ? Align(
                alignment: Alignment.centerRight,
                widthFactor: 1,
                heightFactor: 1,
                child: label,
              )
            : label,
      );
    }
    return widget.suffixIcon != null
        ? Padding(
            padding: const EdgeInsets.only(right: 15),
            child: _getAnimatedIcon(widget.suffixIcon!, size: 20),
          )
        : _isPasswordField()
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TweenAnimationBuilder<Color?>(
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  curve: Curves.easeOut,
                  tween: ColorTween(end: _getIconColor()),
                  builder: (context, color, child) {
                    return BonsuiButton(
                      shape: widget.shape,
                      color: color,
                      minSize: const Size(0, 0),
                      icon: !showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      type: BonsuiButtonType.text,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    );
                  },
                ),
              )
            : null;
  }

  Widget _getAnimatedIcon(IconData icon, {double? size}) {
    return TweenAnimationBuilder<Color?>(
      duration:
          BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
      curve: Curves.easeOut,
      tween: ColorTween(end: _getIconColor()),
      builder: (context, color, child) {
        return Icon(icon, color: color, size: size);
      },
    );
  }

  EdgeInsets _getPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }
    if (widget.prefixIcon != null && widget.suffixIcon != null) {
      return const EdgeInsets.symmetric(horizontal: 8, vertical: 14);
    } else if (widget.prefixIcon != null && widget.suffixIcon == null) {
      return const EdgeInsets.only(top: 14, bottom: 14, left: 8, right: 16);
    } else if (widget.prefixIcon == null && widget.suffixIcon != null) {
      return const EdgeInsets.only(top: 14, bottom: 14, left: 16, right: 8);
    } else {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
    }
  }

  Color _getBorderColor() {
    if (isInvalid) {
      return BonsuiDesign.dangerColor;
    }

    if (widget.hideFocusState != null && widget.hideFocusState!) {
      return Colors.transparent;
    }

    // Disabled state
    if (widget.disabled != null && widget.disabled!) {
      return _getBackgroundColor();
    }

    if (_hasFocus) {
      return widget.color ?? BonsuiDesign.primaryColor;
    }

    if (widget.showBorder == null && widget.filled == null) {
      if (BonsuiDesign.useDarkMode) {
        return Colors.grey.shade800;
      }
      return BonsuiDesign.borderColor;
    } else if (widget.showBorder != null && widget.showBorder!) {
      return BonsuiDesign.primaryColor;
    } else {
      return Colors.transparent;
    }
  }

  Color _getIconColor() {
    if (isInvalid) {
      return BonsuiDesign.dangerColor;
    } else if (widget.disabled != null && widget.disabled! ||
        (widget.readonly != null && widget.readonly!)) {
      return BonsuiDesign.disabledColor;
    } else if (_hasFocus) {
      return widget.color ?? BonsuiDesign.primaryColor;
    } else {
      return Colors.grey;
    }
  }

  bool _isPasswordField() {
    return widget.type != null && widget.type! == BonsuiTextFieldType.password;
  }

  TextInputType? _getKeyboardType() {
    if (widget.multiline != null && widget.multiline!) {
      return TextInputType.multiline;
    }
    if (widget.type == BonsuiTextFieldType.number) {
      return const TextInputType.numberWithOptions(decimal: true);
    }
    return null;
  }

  String _getErrorText(String errorText) {
    if (widget.validator != null && widget.validator!.errorText != null) {
      return widget.validator!.errorText!;
    }
    return errorText;
  }

  String? _checkValidation(String value) {
    final numberValue = _parseNumber(value);

    // Number validation
    if (widget.type != null && widget.type! == BonsuiTextFieldType.number) {
      if (numberValue == null) {
        return _getErrorText(Localization.getValue('field_number_error'));
      }
    }

    // Email validation
    if (widget.type != null && widget.type! == BonsuiTextFieldType.email) {
      if (!BonsuiUtils.isEmailValid(value)) {
        return _getErrorText(Localization.getValue('field_email_error'));
      }
    }

    if (widget.validator != null) {
      // Required validation
      if (widget.validator!.required != null &&
          widget.validator!.required! &&
          (value.isEmpty || value.trim() == '')) {
        return _getErrorText(Localization.getValue('field_required_error'));
      }

      // Min length validation
      if (widget.validator!.min != null) {
        if (widget.type == null || widget.type! == BonsuiTextFieldType.text) {
          if (value.length < widget.validator!.min!) {
            return _getErrorText(
                '${Localization.getValue('field_min_chars_error')} ${widget.validator!.min} ${Localization.getValue('characters')}');
          }
        } else if (widget.type == BonsuiTextFieldType.number) {
          if (numberValue != null && numberValue < widget.validator!.min!) {
            return _getErrorText(
              '${Localization.getValue('field_min_error')} ${widget.validator!.min}',
            );
          }
        }
      }

      // Max length validation
      if (widget.validator!.max != null) {
        if (widget.type == null || widget.type! == BonsuiTextFieldType.text) {
          if (value.length > widget.validator!.max!) {
            return _getErrorText(
                '${Localization.getValue('field_max_chars_error')} ${widget.validator!.max} ${Localization.getValue('characters')}');
          }
        } else if (widget.type == BonsuiTextFieldType.number) {
          if (numberValue != null && numberValue > widget.validator!.max!) {
            return _getErrorText(
              '${Localization.getValue('field_max_error')} ${widget.validator!.max}',
            );
          }
        }
      }

      // Password validation
      if (widget.type != null &&
          widget.type! == BonsuiTextFieldType.password &&
          widget.validator!.securePassword != null &&
          widget.validator!.securePassword!) {
        if (!_isPasswordSecure(value)) {
          return _getErrorText(
            Localization.getValue(
              'password_not_safe_error',
            ),
          );
        }
      }

      // Min age validation
      if (widget.validator!.minAge != null) {
        final currentDate = DateTime.now();
        final birthDate = DateTime.parse(value);
        int age = currentDate.year - birthDate.year;
        if (currentDate.month < birthDate.month ||
            (currentDate.month == birthDate.month &&
                currentDate.day < birthDate.day)) {
          age--;
        }
        if (age < widget.validator!.minAge!) {
          return _getErrorText(
            '${Localization.getValue('age_min_error')} ${widget.validator!.minAge} ${Localization.getValue('years_old')}',
          );
        }
      }

      // Max age validation
      if (widget.validator!.maxAge != null) {
        final currentDate = DateTime.now();
        final birthDate = DateTime.parse(value);
        int age = currentDate.year - birthDate.year;
        if (currentDate.month < birthDate.month ||
            (currentDate.month == birthDate.month &&
                currentDate.day < birthDate.day)) {
          age--;
        }
        if (age > widget.validator!.maxAge!) {
          return _getErrorText(
            '${Localization.getValue('age_max_error')} ${widget.validator!.maxAge} ${Localization.getValue('years_old')}',
          );
        }
      }

      // No spaces validation
      if (widget.validator!.noSpaces != null && widget.validator!.noSpaces!) {
        if (value.contains(' ')) {
          return _getErrorText(Localization.getValue('field_no_spaces_error'));
        }
      }

      // Regex validation
      if (widget.validator!.regex != null) {
        if (!widget.validator!.regex!.hasMatch(value)) {
          return _getErrorText(Localization.getValue('invalid_format_erorr'));
        }
      }
    }

    return null;
  }

  double? _parseNumber(String value) {
    return double.tryParse(value.replaceAll(',', '.'));
  }

  bool _isPasswordSecure(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }

  BorderRadius _getBorderRadius() {
    if (widget.borderRadius != null) {
      return BorderRadius.circular(widget.borderRadius!);
    } else {
      return Utils.getBorderRadius(widget.shape);
    }
  }
}
