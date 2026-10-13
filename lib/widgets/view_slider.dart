import 'package:bonsui/bonsui.dart';
import 'package:flutter/material.dart';

class BonsuiViewSlider extends StatefulWidget {
  const BonsuiViewSlider(
      {super.key,
      required this.options,
      this.padding,
      this.tabsPadding,
      this.onTabChanged});

  final List<BonsuiViewSliderOption> options;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? tabsPadding;
  final Function(int index)? onTabChanged;

  @override
  State<BonsuiViewSlider> createState() => _BonsuiViewSliderState();
}

class _BonsuiViewSliderState extends State<BonsuiViewSlider> {
  late final PageController _pageController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _indexOfSelected();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void didUpdateWidget(covariant BonsuiViewSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIndex = _indexOfSelected(oldWidget.options);
    final newIndex = _indexOfSelected(widget.options);
    if (oldIndex != newIndex && newIndex != _selectedIndex) {
      _selectedIndex = newIndex;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          newIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _indexOfSelected([List<BonsuiViewSliderOption>? options]) {
    final index =
        (options ?? widget.options).indexWhere((option) => option.isSelected);
    return index == -1 ? 0 : index;
  }

  void _selectOption(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    if (widget.onTabChanged != null) {
      widget.onTabChanged!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = ((constraints.maxWidth / widget.options.length) -
                  (widget.tabsPadding != null
                      ? (widget.tabsPadding!.horizontal / widget.options.length)
                      : 0));
              return Padding(
                padding: widget.tabsPadding ?? EdgeInsets.zero,
                child: Stack(
                  children: [
                    Row(
                      children: widget.options.map((option) {
                        final index = widget.options.indexOf(option);
                        return Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(BonsuiDesign.borderRadius),
                            topRight:
                                Radius.circular(BonsuiDesign.borderRadius),
                          ),
                          child: Ink(
                            child: InkWell(
                              splashFactory: BonsuiUtils.getSplashFactory(),
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(BonsuiDesign.borderRadius),
                                topRight:
                                    Radius.circular(BonsuiDesign.borderRadius),
                              ),
                              onTap: () {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                                _selectOption(index);
                              },
                              child: Container(
                                width: tabWidth,
                                height: 40.0,
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    option.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      height: 0,
                                      fontWeight: index == _selectedIndex
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, _) {
                        final page = _pageController.hasClients
                            ? (_pageController.page ??
                                _selectedIndex.toDouble())
                            : _selectedIndex.toDouble();
                        return Positioned(
                          left: page * tabWidth,
                          bottom: 0,
                          width: tabWidth,
                          child: Container(
                            height: 3.0,
                            color: BonsuiDesign.primaryColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _selectOption,
              children: widget.options
                  .map((option) => SingleChildScrollView(
                        padding: option.contentPadding != null
                            ? option.contentPadding!.padding
                            : const EdgeInsets.symmetric(vertical: 14),
                        child: option.content,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
