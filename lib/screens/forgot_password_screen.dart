import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/cupertino.dart';

class BonsuiForgotPasswordScreen extends StatefulWidget {
  const BonsuiForgotPasswordScreen(
      {super.key,
      this.logo,
      this.isSending,
      required this.onPasswordResetSend,
      this.background});

  final Image? logo;
  final bool? isSending;
  final Function(String)? onPasswordResetSend;
  final Image? background;

  @override
  State<BonsuiForgotPasswordScreen> createState() =>
      _BonsuiForgotPasswordScreenState();
}

class _BonsuiForgotPasswordScreenState extends State<BonsuiForgotPasswordScreen> {
  final TextEditingController controller = TextEditingController();
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
        body: Stack(children: [
      if (widget.background != null)
        Positioned(
          top: 0,
          right: 0,
          child: FadeInDown(
            from: 20,
            duration:
                BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
            delay: const Duration(milliseconds: 200),
            child: widget.background!,
          ),
        ),
      Positioned(
        left: 20,
        top: MediaQuery.of(context).padding.top + 20,
        child: FadeIn(
          duration:
              BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
          delay: const Duration(milliseconds: 200),
          child: BonsuiButton(
            icon: BonsuiIcons.arrowBack,
            type: BonsuiButtonType.text,
            size: BonsuiButtonSize.large,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.logo != null) ...[
                  FadeInUp(
                    from: 20,
                    duration: BonsuiDesign
                        .animationDurations[BonsuiAnimationDuration.medium]!,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: widget.logo!,
                      ),
                    ),
                  )
                ],
                BonsuiSpacing.vertical(2),
                FadeInUp(
                  from: 20,
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  delay: const Duration(milliseconds: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BonsuiText(
                        Localization.getValue('forgot_password_email'),
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                BonsuiSpacing.vertical(2),
                FadeInUp(
                  from: 20,
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  delay: const Duration(milliseconds: 400),
                  child: BonsuiTextField(
                    controller: controller,
                    placeholder: Localization.getValue('email_placeholder'),
                    onChanged: (value) {
                      setState(() {
                        isEmailValid = BonsuiUtils.isEmailValid(value);
                      });
                    },
                  ),
                ),
                BonsuiSpacing.vertical(0.6),
                FadeInUp(
                  from: 20,
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  delay: const Duration(milliseconds: 500),
                  child: BonsuiButton(
                    label: Localization.getValue('forgot_password_submit'),
                    minSize: const Size(double.infinity, 50),
                    isLoading: _isSending(),
                    disabled: !isEmailValid,
                    onPressed: () {
                      if (widget.onPasswordResetSend != null) {
                        widget.onPasswordResetSend!(controller.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ))),
    ]));
  }

  bool _isSending() {
    return widget.isSending != null && widget.isSending!;
  }
}
