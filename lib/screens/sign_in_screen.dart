import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/material.dart';

class BonsuiSignInScreen extends StatefulWidget {
  const BonsuiSignInScreen({
    super.key,
    required this.onSignIn,
    this.logo,
    this.onThirdPartSignIn,
    this.onSignUp,
    this.thirdPartAuthTypes,
    this.onForgotPassword,
    this.background,
    this.isLoading,
  });

  final Widget? logo;
  final Function(BonsuiAuthType)? onThirdPartSignIn;
  final Function(BonsuiSignInPayload) onSignIn;
  final Function? onSignUp;
  final List<BonsuiAuthType>? thirdPartAuthTypes;
  final Function? onForgotPassword;
  final Image? background;
  final bool? isLoading;

  @override
  State<BonsuiSignInScreen> createState() => _BonsuiSignInScreenState();
}

class _BonsuiSignInScreenState extends State<BonsuiSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSignInButtonEnabled = false;

  void _checkSignInButtonEnabled() {
    setState(() {
      isSignInButtonEnabled = emailController.text.trim() != '' &&
          passwordController.text.trim() != '' &&
          BonsuiUtils.isEmailValid(
            emailController.text,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          if (widget.background != null)
            Positioned(
              top: 0,
              right: 0,
              child: FadeInDown(
                from: 20,
                duration: BonsuiDesign
                    .animationDurations[BonsuiAnimationDuration.medium]!,
                delay: const Duration(milliseconds: 200),
                child: widget.background!,
              ),
            ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 70,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        from: 20,
                        delay: const Duration(milliseconds: 200),
                        duration: BonsuiDesign.animationDurations[
                            BonsuiAnimationDuration.medium]!,
                        child: Column(children: [
                          if (widget.logo != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: widget.logo!,
                            ),
                          BonsuiText(
                            Localization.getValue('sign_in'),
                            align: TextAlign.center,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                        from: 20,
                        delay: const Duration(milliseconds: 400),
                        duration: BonsuiDesign.animationDurations[
                            BonsuiAnimationDuration.medium]!,
                        child: Column(children: [
                          BonsuiTextField(
                            placeholder: Localization.getValue('email_address'),
                            controller: emailController,
                            prefixIcon: Icons.email,
                            onChanged: (value) => _checkSignInButtonEnabled(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BonsuiTextField(
                            placeholder: Localization.getValue('password'),
                            type: BonsuiTextFieldType.password,
                            controller: passwordController,
                            prefixIcon: Icons.password,
                            onChanged: (value) => _checkSignInButtonEnabled(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BonsuiButton(
                            minSize: const Size(double.infinity, 50),
                            isLoading: widget.isLoading ?? false,
                            label: Localization.getValue('sign_in'),
                            onPressed: isSignInButtonEnabled
                                ? () => widget.onSignIn(
                                      BonsuiSignInPayload(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    )
                                : null,
                          ),
                          BonsuiSpacing.vertical(),
                          BonsuiLink(
                              label: Localization.getValue('forgot_password'),
                              onPressed: () {
                                if (widget.onForgotPassword != null) {
                                  widget.onForgotPassword!();
                                }
                              }),
                        ]),
                      ),
                      if (widget.thirdPartAuthTypes != null &&
                          widget.thirdPartAuthTypes!.isNotEmpty)
                        FadeInLeft(
                          from: 20,
                          delay: const Duration(milliseconds: 400),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: BonsuiDivider(
                            label: Localization.getValue('or'),
                            color: Colors.grey.shade300,
                          ),
                        ),
                      if (widget.thirdPartAuthTypes != null &&
                          widget.thirdPartAuthTypes!
                              .contains(BonsuiAuthType.google))
                        FadeInUp(
                          from: 20,
                          delay: const Duration(milliseconds: 600),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: BonsuiButton(
                              minSize: const Size(double.infinity, 50),
                              disabled: widget.isLoading ?? false,
                              customPrefix: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: SizedBox()),
                              type: BonsuiButtonType.outlined,
                              label:
                                  Localization.getValue('continue_with_google'),
                              onPressed: () {
                                _onThirdPartSignIn(BonsuiAuthType.google);
                              },
                            ),
                          ),
                        ),
                      if (widget.thirdPartAuthTypes != null &&
                          widget.thirdPartAuthTypes!
                              .contains(BonsuiAuthType.apple))
                        FadeInUp(
                          from: 20,
                          delay: const Duration(milliseconds: 600),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: BonsuiButton(
                              minSize: const Size(double.infinity, 50),
                              disabled: widget.isLoading ?? false,
                              customPrefix: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: SizedBox()),
                              color: BonsuiDesign.useDarkMode
                                  ? BonsuiDesign.whiteColor
                                  : BonsuiDesign.blackColor,
                              type: BonsuiButtonType.outlined,
                              label:
                                  Localization.getValue('continue_with_apple'),
                              onPressed: () {
                                _onThirdPartSignIn(BonsuiAuthType.apple);
                              },
                            ),
                          ),
                        ),
                      if (widget.thirdPartAuthTypes != null &&
                          widget.thirdPartAuthTypes!
                              .contains(BonsuiAuthType.facebook))
                        FadeInUp(
                          from: 20,
                          delay: const Duration(milliseconds: 600),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: BonsuiButton(
                              minSize: const Size(double.infinity, 50),
                              disabled: widget.isLoading ?? false,
                              customPrefix: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: SizedBox()),
                              type: BonsuiButtonType.outlined,
                              label: Localization.getValue(
                                  'continue_with_facebook'),
                              color: const Color(0xFF3B5998),
                              onPressed: () {
                                _onThirdPartSignIn(BonsuiAuthType.facebook);
                              },
                            ),
                          ),
                        ),
                      if (widget.thirdPartAuthTypes != null &&
                          widget.thirdPartAuthTypes!
                              .contains(BonsuiAuthType.linkedin))
                        FadeInUp(
                          from: 20,
                          delay: const Duration(milliseconds: 600),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: BonsuiButton(
                              minSize: const Size(double.infinity, 50),
                              disabled: widget.isLoading ?? false,
                              customPrefix: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: SizedBox()),
                              type: BonsuiButtonType.outlined,
                              label: Localization.getValue(
                                  'continue_with_linkedin'),
                              color: const Color(0xFF0077B5),
                              onPressed: () {
                                _onThirdPartSignIn(BonsuiAuthType.linkedin);
                              },
                            ),
                          ),
                        ),
                      BonsuiSpacing.vertical(),
                      if (widget.onSignUp != null)
                        FadeInUp(
                          from: 20,
                          delay: const Duration(milliseconds: 600),
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.thirdPartAuthTypes == null ||
                                  widget.thirdPartAuthTypes!.isEmpty)
                                const BonsuiDivider(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 30)),
                              BonsuiText(
                                Localization.getValue('dont_have_account'),
                              ),
                              BonsuiSpacing.vertical(0.8),
                              BonsuiButton(
                                type: BonsuiButtonType.outlined,
                                size: BonsuiButtonSize.small,
                                label: Localization.getValue('sign_up'),
                                onPressed: () {
                                  widget.onSignUp!();
                                },
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onThirdPartSignIn(BonsuiAuthType type) {
    if (widget.onThirdPartSignIn != null) {
      widget.onThirdPartSignIn!(type);
    }
  }
}
