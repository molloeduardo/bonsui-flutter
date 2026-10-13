import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/material.dart';

class BonsuiSignUpScreen extends StatefulWidget {
  const BonsuiSignUpScreen({
    super.key,
    this.title,
    this.description,
    this.content,
    this.logo,
    this.thirdPartAuthTypes,
    this.onThirdPartSignUp,
    required this.onSignUp,
    required this.onSignIn,
    this.termsOfServiceUrl,
    this.privacyPolicyUrl,
    this.signUpEnabled,
    this.isCreating,
    this.emailNotConfirmed,
    this.onEmailVerificationResend,
    this.onSignInAgain,
    this.background,
    this.defaultEmailAddress,
  });

  final String? title;
  final String? description;
  final Widget? content;
  final Widget? logo;
  final List<BonsuiAuthType>? thirdPartAuthTypes;
  final Function(BonsuiAuthType)? onThirdPartSignUp;
  final Function onSignUp;
  final Function? onSignIn;
  final String? termsOfServiceUrl;
  final String? privacyPolicyUrl;
  final bool? signUpEnabled;
  final bool? isCreating;
  final bool? emailNotConfirmed;
  final Function? onEmailVerificationResend;
  final Function? onSignInAgain;
  final Image? background;
  final String? defaultEmailAddress;

  @override
  State<BonsuiSignUpScreen> createState() => _BonsuiSignUpScreenState();
}

class _BonsuiSignUpScreenState extends State<BonsuiSignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;

  TextStyle agreementsTextStyle =
      const TextStyle(color: Colors.black, fontSize: 14, height: 1.5);

  @override
  void initState() {
    if (widget.defaultEmailAddress != null) {
      _emailController.text = widget.defaultEmailAddress!;
      isEmailValid = _emailController.text.isNotEmpty;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
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
            child: widget.emailNotConfirmed == null ||
                    !widget.emailNotConfirmed!
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        if (widget.logo != null) ...[
                          FadeInUp(
                            from: 20,
                            duration: BonsuiDesign.animationDurations[
                                BonsuiAnimationDuration.medium]!,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: widget.logo!,
                            ),
                          ),
                        ],
                        const SizedBox(width: 35),
                        BonsuiSpacing.vertical(),
                        FadeInUp(
                          from: 20,
                          duration: BonsuiDesign.animationDurations[
                              BonsuiAnimationDuration.medium]!,
                          delay: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              BonsuiHeading(
                                widget.title ??
                                    Localization.getValue('create_an_account'),
                              ),
                              BonsuiText(
                                widget.description ??
                                    Localization.getValue(
                                        'create_an_account_description'),
                                lineHeight: 0,
                              ),
                            ],
                          ),
                        ),
                        BonsuiSpacing.vertical(2.5),
                        Column(
                          children: [
                            FadeInUp(
                              from: 20,
                              duration: BonsuiDesign.animationDurations[
                                  BonsuiAnimationDuration.medium]!,
                              delay: const Duration(milliseconds: 300),
                              child: Column(children: [
                                BonsuiTextField(
                                  disabled: _isCreating() ||
                                      widget.defaultEmailAddress != null,
                                  controller: _emailController,
                                  onValidation: (value) {
                                    setState(() {
                                      isEmailValid = value;
                                    });
                                  },
                                  type: BonsuiTextFieldType.email,
                                  label: Localization.getValue('email_address'),
                                  placeholder: Localization.getValue(
                                      'email_address_placeholder'),
                                  validator: BonsuiTextFieldValidator(
                                    required: true,
                                  ),
                                ),
                                BonsuiSpacing.vertical(),
                                BonsuiTextField(
                                  disabled: _isCreating(),
                                  controller: _passwordController,
                                  onValidation: (value) {
                                    setState(() {
                                      isPasswordValid = value;
                                    });
                                  },
                                  type: BonsuiTextFieldType.password,
                                  label: Localization.getValue('password'),
                                  placeholder: Localization.getValue(
                                      'password_placeholder'),
                                  validator: BonsuiTextFieldValidator(
                                    required: true,
                                    securePassword: true,
                                  ),
                                ),
                                if (widget.content != null) ...[
                                  BonsuiSpacing.vertical(),
                                  widget.content!,
                                ],
                                BonsuiSpacing.vertical(),
                                BonsuiButton(
                                  label: Localization.getValue('sign_up'),
                                  disabled: _isCreating() ||
                                      _emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty ||
                                      !isEmailValid ||
                                      !isPasswordValid ||
                                      (widget.signUpEnabled != null &&
                                          !widget.signUpEnabled!),
                                  minSize: const Size(double.infinity, 50),
                                  isLoading: _isCreating(),
                                  onPressed: () {
                                    widget.onSignUp({
                                      'email': _emailController.text,
                                      'password': _passwordController.text,
                                    });
                                  },
                                ),
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            if (widget.thirdPartAuthTypes != null &&
                                widget.thirdPartAuthTypes!
                                    .contains(BonsuiAuthType.google))
                              FadeInUp(
                                from: 20,
                                duration: BonsuiDesign.animationDurations[
                                    BonsuiAnimationDuration.medium]!,
                                delay: const Duration(milliseconds: 500),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: BonsuiButton(
                                    minSize: const Size(double.infinity, 50),
                                    customPrefix: const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: SizedBox() // TODO
                                        ),
                                    disabled: _isCreating(),
                                    type: BonsuiButtonType.outlined,
                                    label: Localization.getValue(
                                        'continue_with_google'),
                                    onPressed: () {
                                      _onThirdPartSignUp(BonsuiAuthType.google);
                                    },
                                  ),
                                ),
                              ),
                            if (widget.thirdPartAuthTypes != null &&
                                widget.thirdPartAuthTypes!
                                    .contains(BonsuiAuthType.apple))
                              FadeInUp(
                                  from: 20,
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.medium]!,
                                  delay: const Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: BonsuiButton(
                                      minSize: const Size(double.infinity, 50),
                                      customPrefix: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: SizedBox() // TODO
                                          ),
                                      color: BonsuiDesign.useDarkMode
                                          ? BonsuiDesign.whiteColor
                                          : BonsuiDesign.blackColor,
                                      disabled: _isCreating(),
                                      type: BonsuiButtonType.outlined,
                                      label: Localization.getValue(
                                          'continue_with_apple'),
                                      onPressed: () {
                                        _onThirdPartSignUp(
                                            BonsuiAuthType.apple);
                                      },
                                    ),
                                  )),
                            if (widget.thirdPartAuthTypes != null &&
                                widget.thirdPartAuthTypes!
                                    .contains(BonsuiAuthType.facebook))
                              FadeInUp(
                                  from: 20,
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.medium]!,
                                  delay: const Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: BonsuiButton(
                                      minSize: const Size(double.infinity, 50),
                                      customPrefix: const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: SizedBox() // TODO
                                          ),
                                      disabled: _isCreating(),
                                      type: BonsuiButtonType.outlined,
                                      label: Localization.getValue(
                                          'continue_with_facebook'),
                                      color: const Color(0xFF3B5998),
                                      onPressed: () {
                                        _onThirdPartSignUp(
                                            BonsuiAuthType.facebook);
                                      },
                                    ),
                                  )),
                            if (widget.thirdPartAuthTypes != null &&
                                widget.thirdPartAuthTypes!
                                    .contains(BonsuiAuthType.linkedin))
                              FadeInUp(
                                  from: 20,
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.medium]!,
                                  delay: const Duration(milliseconds: 500),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: BonsuiButton(
                                      minSize: const Size(double.infinity, 50),
                                      customPrefix: const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: SizedBox() // TODO
                                          ),
                                      disabled: _isCreating(),
                                      type: BonsuiButtonType.outlined,
                                      label: Localization.getValue(
                                          'continue_with_linkedin'),
                                      color: const Color(0xFF0077B5),
                                      onPressed: () {
                                        _onThirdPartSignUp(
                                            BonsuiAuthType.linkedin);
                                      },
                                    ),
                                  )),
                            if (widget.termsOfServiceUrl != null &&
                                widget.privacyPolicyUrl != null)
                              FadeInUp(
                                from: 20,
                                duration: BonsuiDesign.animationDurations[
                                    BonsuiAnimationDuration.medium]!,
                                delay: const Duration(milliseconds: 600),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 6,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: BonsuiLocalization.get(
                                              'by_signing_up'),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: BonsuiLink(
                                            label: BonsuiLocalization.get(
                                                'privacy_policy'),
                                            url: widget.privacyPolicyUrl,
                                            openInExternalBrowser: true,
                                            size: 12,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 2,
                                              vertical: 2,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              BonsuiLocalization.get('and_our'),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: BonsuiLink(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 2,
                                              vertical: 2,
                                            ),
                                            label: BonsuiLocalization.get(
                                                'terms_of_service'),
                                            url: widget.termsOfServiceUrl,
                                            openInExternalBrowser: true,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.onSignIn != null)
                              FadeInLeft(
                                from: 20,
                                delay: const Duration(milliseconds: 400),
                                duration: BonsuiDesign.animationDurations[
                                    BonsuiAnimationDuration.medium]!,
                                child: BonsuiDivider(
                                  color: Colors.grey.shade300,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 26,
                                  ),
                                ),
                              ),
                            if (widget.onSignIn != null)
                              FadeInUp(
                                  from: 20,
                                  delay: const Duration(milliseconds: 600),
                                  duration: BonsuiDesign.animationDurations[
                                      BonsuiAnimationDuration.medium]!,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BonsuiText(
                                        Localization.getValue(
                                            'already_have_account'),
                                      ),
                                      BonsuiSpacing.vertical(0.8),
                                      BonsuiButton(
                                        type: BonsuiButtonType.outlined,
                                        disabled: _isCreating(),
                                        label: Localization.getValue('sign_in'),
                                        size: BonsuiButtonSize.small,
                                        onPressed: () {
                                          widget.onSignIn!();
                                        },
                                      ),
                                      BonsuiSpacing.vertical(2),
                                    ],
                                  )),
                          ],
                        ),
                      ],
                    ),
                  )
                : _emailNotConfirmedWidget(),
          ),
        ),
      ]),
    );
  }

  Widget _emailNotConfirmedWidget() {
    return Center(
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
          BonsuiSpacing.vertical(4),
          FadeInUp(
            from: 20,
            duration: BonsuiDesign
                .animationDurations[BonsuiAnimationDuration.medium]!,
            delay: const Duration(milliseconds: 200),
            child: Icon(
              BonsuiIcons.mail,
              size: 55,
              color: BonsuiDesign.primaryColor,
            ),
          ),
          BonsuiSpacing.vertical(),
          FadeInUp(
            from: 20,
            duration: BonsuiDesign
                .animationDurations[BonsuiAnimationDuration.medium]!,
            delay: const Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BonsuiHeading(
                  Localization.getValue('email_not_confirmed_error'),
                  align: TextAlign.center,
                  size: 18,
                ),
                BonsuiSpacing.vertical(0.7),
                BonsuiText(
                  Localization.getValue('check_your_email_spam'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  BonsuiButton(
                    label: Localization.getValue('resend_confirmation_email'),
                    minSize: const Size(double.infinity, 50),
                    isLoading: _isCreating(),
                    onPressed: () {
                      if (widget.onEmailVerificationResend != null) {
                        widget.onEmailVerificationResend!();
                      }
                    },
                  ),
                  BonsuiSpacing.vertical(0.6),
                  BonsuiButton(
                    label: Localization.getValue('sign_in'),
                    minSize: const Size(double.infinity, 50),
                    type: BonsuiButtonType.outlined,
                    disabled: _isCreating(),
                    onPressed: () {
                      if (widget.onSignInAgain != null) {
                        widget.onSignInAgain!();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  bool _isCreating() {
    return widget.isCreating != null && widget.isCreating!;
  }

  void _onThirdPartSignUp(BonsuiAuthType type) {
    if (widget.onThirdPartSignUp != null) {
      widget.onThirdPartSignUp!(type);
    }
  }
}
