import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/enums/local_notification.dart';
import 'package:bonsui/models/survey.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';

class BonsuiSurveyScreen extends StatefulWidget {
  const BonsuiSurveyScreen(
      {super.key,
      required this.questions,
      this.onSkip,
      this.onFinish,
      this.hideProgressBar,
      this.logo});

  final List<BonsuiSurveyQuestion> questions;
  final Function()? onSkip;
  final Function(Map<int, List<BonsuiSurveyAnswer>>)? onFinish;
  final String? logo;
  final bool? hideProgressBar;

  @override
  State<BonsuiSurveyScreen> createState() => _BonsuiSurveyScreenState();
}

class _BonsuiSurveyScreenState extends State<BonsuiSurveyScreen> {
  int currentStep = 0;
  final Map<int, List<BonsuiSurveyAnswer>> answers = {};
  bool isGoingPrevious = false;

  @override
  initState() {
    final key = BonsuiNotifications.getRandomKey();
    BonsuiNotifications.keys['survey'] = key;
    for (var question in widget.questions) {
      for (var answer in question.answers) {
        if (answer.selected != null && answer.selected == true) {
          if (answers[widget.questions.indexOf(question)] == null) {
            answers[widget.questions.indexOf(question)] = [];
          }
          answers[widget.questions.indexOf(question)]!.add(answer);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
      key: BonsuiNotifications.keys['survey'],
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 24,
            top: widget.onSkip != null ||
                    widget.logo != null ||
                    widget.hideProgressBar != true
                ? 24
                : 0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // centered independently of the button/logo widths on either side
                  if (widget.hideProgressBar != true)
                    BonsuiProgressBar(
                        height: 7,
                        width: MediaQuery.of(context).size.width * 0.44,
                        percentage: (100 * (currentStep + 1)) /
                                widget.questions.length +
                            1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.onSkip != null)
                        BonsuiButton(
                          minSize: const Size(45, 25),
                          onPressed: () {
                            widget.onSkip!();
                          },
                          label: BonsuiLocalization.get('skip'),
                          size: BonsuiButtonSize.small,
                          type: BonsuiButtonType.text,
                        )
                      else
                        const SizedBox(),
                      if (widget.logo != null)
                        Image.asset(
                          widget.logo!,
                          height: 30,
                          width: 30,
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            BonsuiSpacing.vertical(),
            FadeInRight(
              from: isGoingPrevious ? -30 : 30,
              key: ValueKey(currentStep),
              duration: BonsuiDesign
                  .animationDurations[BonsuiAnimationDuration.fast]!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BonsuiHeading(
                  widget.questions[currentStep].question,
                  lineHeight: 1.3,
                  align: TextAlign.center,
                ),
              ),
            ),
            BonsuiSpacing.vertical(),
            SizedBox(
                height: MediaQuery.of(context).size.height -
                    300 -
                    MediaQuery.of(context).padding.bottom * 2,
                child: SingleChildScrollView(
                    child: Column(children: [
                  ...widget.questions[currentStep].answers
                      .asMap()
                      .map((i, e) => MapEntry(
                          i,
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: FadeInUp(
                                key: ValueKey(e.id + currentStep),
                                from: 10,
                                duration: BonsuiDesign.animationDurations[
                                    BonsuiAnimationDuration.fast]!,
                                delay: Duration(milliseconds: 100 * i),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                        BonsuiDesign.borderRadius,
                                      ),
                                      splashFactory: Utils.getSplashFactory(),
                                      onTap: () {
                                        onAnswerTap(e);
                                      },
                                      child: Ink(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 10),
                                          decoration: BoxDecoration(
                                            color:
                                                answers[currentStep] != null &&
                                                        answers[currentStep]!
                                                            .map((e) => e.id)
                                                            .contains(e.id)
                                                    ? BonsuiDesign.primaryColor
                                                        .withAlpha(30)
                                                    : Colors.transparent,
                                            border: Border.all(
                                                color: _getBorderColor(e),
                                                width: 1),
                                            borderRadius: BorderRadius.circular(
                                              BonsuiDesign.borderRadius,
                                            ),
                                          ),
                                          child: Row(children: [
                                            if (e.icon != null)
                                              Icon(
                                                e.icon,
                                                size: 23,
                                              ),
                                            if (e.icon != null)
                                              BonsuiSpacing.horizontal(0.5),
                                            BonsuiText(
                                              e.text,
                                              size: 19,
                                            ),
                                            const Spacer(),
                                            if (widget.questions[currentStep]
                                                .multipleChoices) ...[
                                              BonsuiCheckbox(
                                                checked: answers[currentStep] !=
                                                        null &&
                                                    answers[currentStep]!
                                                        .map((e) => e.id)
                                                        .contains(e.id),
                                                onChanged: (value) {
                                                  onAnswerTap(e);
                                                },
                                              )
                                            ] else ...[
                                              BonsuiRadio(
                                                  value: e.id,
                                                  onChanged: (value) {
                                                    onAnswerTap(e);
                                                  },
                                                  groupValue:
                                                      answers[currentStep]
                                                          ?.first
                                                          .id)
                                            ]
                                          ])),
                                    )),
                              ))))
                      .values
                      .toList(),
                ]))),
            const Spacer(),
            Row(
              children: [
                if (widget.questions.length > 1)
                  BonsuiButton(
                    label: BonsuiLocalization.get('back'),
                    icon: BonsuiIcons.arrowBack,
                    type: BonsuiButtonType.outlined,
                    minSize: Size(MediaQuery.of(context).size.width * 0.42, 48),
                    onPressed: currentStep > 0
                        ? () {
                            isGoingPrevious = true;
                            setState(() {
                              currentStep--;
                            });
                          }
                        : null,
                  ),
                if (widget.questions.length > 1) const Spacer(),
                BonsuiButton(
                  label: currentStep < widget.questions.length - 1
                      ? BonsuiLocalization.get('next')
                      : BonsuiLocalization.get('finish'),
                  icon: BonsuiIcons.arrowForward,
                  iconPosition: BonsuiIconPosition.suffix,
                  minSize: Size(
                      widget.questions.length > 1
                          ? MediaQuery.of(context).size.width * 0.42
                          : MediaQuery.of(context).size.width - 48,
                      48),
                  onPressed: answers[currentStep] != null &&
                          answers[currentStep]!.isNotEmpty
                      ? () {
                          isGoingPrevious = false;
                          if (currentStep < widget.questions.length - 1) {
                            setState(() {
                              currentStep++;
                            });
                          } else {
                            if (widget.onFinish != null) {
                              widget.onFinish!(answers);
                            }
                          }
                        }
                      : null,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void onAnswerTap(BonsuiSurveyAnswer answer) {
    if (widget.questions[currentStep].multipleChoices) {
      setState(() {
        if (answers[currentStep] == null) {
          answers[currentStep] = [];
        }
        if (answers[currentStep]!.map((e) => e.id).contains(answer.id)) {
          answers[currentStep]!
              .removeWhere((element) => element.id == answer.id);
        } else {
          if (widget.questions[currentStep].maxChoices != null &&
              answers[currentStep]!.length >=
                  widget.questions[currentStep].maxChoices!) {
            BonsuiNotifications.show(LocalNotification(
              description: BonsuiLocalization.get('survey_max_choices_reached'),
              type: LocalNotificationType.danger,
            ));
            return;
          }
          answers[currentStep]!.add(answer);
        }
      });
    } else {
      setState(() {
        answers[currentStep] = [answer];
      });
    }
  }

  Color _getBorderColor(BonsuiSurveyAnswer answer) {
    return answers[currentStep] != null &&
            answers[currentStep]!.map((e) => e.id).contains(answer.id)
        ? BonsuiDesign.primaryColor
        : Colors.grey.withAlpha(70);
  }
}
