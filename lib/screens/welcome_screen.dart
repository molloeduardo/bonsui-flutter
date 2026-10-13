import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/material.dart';

class BonsuiWelcomeScreen extends StatefulWidget {
  const BonsuiWelcomeScreen({
    super.key,
    required this.sections,
    this.finishButtonLabel,
    this.onFinish,
    this.logo,
    this.background,
  });

  final List<BonsuiWelcomeScreenSection> sections;
  final String? finishButtonLabel;
  final Function? onFinish;
  final Widget? logo;
  final Image? background;

  @override
  State<BonsuiWelcomeScreen> createState() => _BonsuiWelcomeScreenState();
}

class _BonsuiWelcomeScreenState extends State<BonsuiWelcomeScreen> {
  int _currentPage = 0;
  late final PageController _pageViewController = PageController();

  void nextStep() {
    if (_currentPage < widget.sections.length - 1) {
      _pageViewController.animateToPage(
        _currentPage + 1,
        duration: BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
        curve: Curves.easeInOut,
      );
      _updateCurrentPage(_currentPage++);
    } else {
      if (widget.onFinish != null) {
        widget.onFinish!();
      }
    }
  }

  void previousStep() {
    int goToPage = _currentPage - 1;
    if (_currentPage == 0) {
      goToPage = widget.sections.length - 1;
    }
    _pageViewController.animateToPage(
      goToPage,
      duration: BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
      curve: Curves.easeInOut,
    );
    _updateCurrentPage(goToPage);
  }

  void goToStep(int newStep) {
    _pageViewController.jumpToPage(
      newStep,
    );
    _updateCurrentPage(newStep);
  }

  void _updateCurrentPage(int step) {
    setState(() {
      _currentPage = step;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
      body: Stack(
        children: [
          if (widget.background != null)
            Positioned(
              right: 0,
              top: 0,
              child: FadeInDown(
                from: 20,
                duration: BonsuiDesign
                    .animationDurations[BonsuiAnimationDuration.medium]!,
                delay: const Duration(milliseconds: 200),
                child: widget.background!,
              ),
            ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: widget.logo != null
                      ? FadeIn(
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: SizedBox(
                            height: 50,
                            child: widget.logo!,
                          ),
                        )
                      : null,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.69,
                  child: Stack(
                    children: [
                      PageView(
                        onPageChanged: _updateCurrentPage,
                        controller: _pageViewController,
                        children: List.generate(
                          widget.sections.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                FadeInUp(
                                  from: 20,
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.medium]!,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.39,
                                    child: widget.sections[index].content,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                FadeInRight(
                                  from: 20,
                                  delay: const Duration(milliseconds: 150),
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.fast]!,
                                  child: Row(
                                    children: [
                                      BonsuiStepper(
                                        totalSteps: widget.sections.length,
                                        currentStep: _currentPage + 1,
                                        onStepChange: (int step) {
                                          goToStep(step - 1);
                                        },
                                        hideNumbers: true,
                                        hideSeparators: true,
                                      ),
                                    ],
                                  ),
                                ),
                                BonsuiSpacing.vertical(),
                                FadeInUp(
                                  from: 20,
                                  delay: const Duration(milliseconds: 250),
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.fast]!,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: BonsuiHeading(
                                      widget.sections[index].title,
                                      align: TextAlign.start,
                                      maxLines: 2,
                                      size:
                                          BonsuiUtils.dynamicWidth(context, 17) *
                                              0.4,
                                      lineHeight: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                  from: 20,
                                  delay: const Duration(milliseconds: 350),
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.fast]!,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: BonsuiText(
                                      widget.sections[index].description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BonsuiSpacing.vertical(),
                BonsuiSpacing.vertical(),
                FadeIn(
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  delay: const Duration(milliseconds: 450),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: MediaQuery.of(context).padding.bottom > 0
                            ? 20
                            : 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BonsuiButton(
                          type: BonsuiButtonType.outlined,
                          icon: _currentPage > 0 ? BonsuiIcons.arrowBack : null,
                          label: _currentPage == 0
                              ? Localization.getValue('skip')
                              : Localization.getValue('back'),
                          onPressed: () => previousStep(),
                          minSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 45),
                        ),
                        BonsuiButton(
                          icon: BonsuiIcons.arrowForward,
                          iconPosition: BonsuiIconPosition.suffix,
                          label: _currentPage < widget.sections.length - 1
                              ? Localization.getValue('next')
                              : widget.finishButtonLabel ??
                                  Localization.getValue('finish'),
                          onPressed: () => nextStep(),
                          minSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 45),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
