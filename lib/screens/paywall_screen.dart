import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:bonsui/models/paywall.dart';
import 'package:bonsui/utils.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BonsuiPaywallScreen extends StatefulWidget {
  const BonsuiPaywallScreen({
    super.key,
    this.logo,
    required this.title,
    required this.description,
    required this.items,
    this.onClose,
    required this.prices,
    this.privacyPolicyUrl,
    this.termsOfServiceUrl,
    this.trialText,
    required this.onBuy,
    this.background,
  });

  final Widget? logo;
  final String title;
  final String description;
  final List<BonsuiPaywallItem> items;
  final Function? onClose;
  final List<BonsuiPaywallPrice> prices;
  final String? privacyPolicyUrl;
  final String? termsOfServiceUrl;
  final String? trialText;
  final Function(int) onBuy;
  final Image? background;

  @override
  State<BonsuiPaywallScreen> createState() => _BonsuiPaywallScreenState();
}

class _BonsuiPaywallScreenState extends State<BonsuiPaywallScreen> {
  int selectedSubscription = 0;

  @override
  void initState() {
    selectedSubscription =
        widget.prices.isNotEmpty ? widget.prices.first.id : 0;
    super.initState();
  }

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
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeIn(
                delay: const Duration(milliseconds: 200),
                duration: BonsuiDesign
                    .animationDurations[BonsuiAnimationDuration.medium]!,
                child: Column(children: [
                  if (widget.onClose != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 5,
                        ),
                        child: BonsuiButton(
                          icon: BonsuiIcons.close,
                          type: BonsuiButtonType.text,
                          size: BonsuiButtonSize.large,
                          onPressed: () {
                            widget.onClose!();
                          },
                        ),
                      ),
                    ),
                  if (widget.logo != null && widget.onClose == null)
                    BonsuiSpacing.vertical(2),
                  if (widget.logo != null) widget.logo!,
                  BonsuiHeading(widget.title,
                      align: TextAlign.center,
                      lineHeight: 1.5,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      )),
                  BonsuiText(
                    widget.description,
                    size: 15,
                    color: Colors.grey.shade600,
                    align: TextAlign.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 30),
              for (var i = 0; i < widget.items.length; i++)
                _getSubscriptionCardDescription(
                  i,
                  widget.items[i].icon,
                  widget.items[i].color,
                  widget.items[i].title,
                  widget.items[i].description,
                  context,
                ),
              FadeIn(
                duration: BonsuiDesign
                    .animationDurations[BonsuiAnimationDuration.medium]!,
                child: BonsuiDivider(
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                ),
              ),
              for (var i = 0; i < widget.prices.length; i++)
                _getSubscriptionPaymentCard(
                  i,
                  '${formatCurrency(
                    context,
                    widget.prices[i].price,
                  )} / ${widget.prices[i].duration}',
                  widget.prices[i].title,
                  widget.prices[i].discount != null
                      ? BonsuiBadge(
                          shape: BonsuiShape.regular,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          label: widget.prices[i].discount,
                        )
                      : null,
                  widget.prices[i].id,
                ),
              const SizedBox(
                height: 20,
              ),
              if (widget.trialText != null)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  child: BonsuiText(
                    widget.trialText!,
                    size: 12,
                    align: TextAlign.center,
                    weight: FontWeight.w600,
                  ),
                ),
              BonsuiButton(
                minSize: Size(
                  MediaQuery.of(context).size.width - 40,
                  60,
                ),
                child: BonsuiText(
                  widget.trialText != null
                      ? BonsuiLocalization.get('start_free_trial')
                      : BonsuiLocalization.get('buy_now'),
                  color: Colors.white,
                  weight: FontWeight.w600,
                  size: 18,
                ),
                onPressed: () {
                  widget.onBuy(selectedSubscription);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              if (widget.privacyPolicyUrl != null &&
                  widget.termsOfServiceUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        TextSpan(
                          text: BonsuiLocalization.get('by_clicking_buy'),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: BonsuiLink(
                            label: BonsuiLocalization.get('privacy_policy'),
                            url: widget.privacyPolicyUrl,
                            openInExternalBrowser: true,
                            size: 10,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: BonsuiLocalization.get('and_our'),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: BonsuiLink(
                            label: BonsuiLocalization.get('terms_of_service'),
                            url: widget.termsOfServiceUrl,
                            openInExternalBrowser: true,
                            size: 10,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )
    ]));
  }

  String formatCurrency(BuildContext context, double amount) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final f = NumberFormat.simpleCurrency(locale: locale);
    return f.format(amount);
  }

  Widget _getSubscriptionPaymentCard(
      int i, String price, String title, Widget? child, int value) {
    int baseDelay = widget.items.length * 150;
    return FadeInUp(
      from: 30,
      duration: BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
      delay: Duration(milliseconds: baseDelay + (150 * i)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 19,
          right: 19,
          bottom: 20,
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedSubscription = value;
            });
          },
          splashFactory: Utils.getSplashFactory(),
          borderRadius: BorderRadius.circular(
            BonsuiDesign.borderRadius,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: selectedSubscription == value
                  ? BonsuiDesign.primaryColor.withAlpha(20)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                BonsuiDesign.borderRadius,
              ),
              border: Border.all(
                width: 2,
                color: selectedSubscription == value
                    ? BonsuiDesign.primaryColor
                    : BonsuiDesign.useDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BonsuiText(
                          title,
                          weight: FontWeight.w600,
                          color: selectedSubscription == value
                              ? BonsuiDesign.primaryColor
                              : BonsuiDesign.useDarkMode
                                  ? BonsuiDesign.whiteColor
                                  : Colors.grey.shade400,
                        ),
                        if (child != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: child,
                          ),
                      ],
                    ),
                    BonsuiSpacing.vertical(0.3),
                    BonsuiText(
                      price,
                      size: 27,
                      color: selectedSubscription == value
                          ? BonsuiDesign.primaryColor
                          : BonsuiDesign.useDarkMode
                              ? BonsuiDesign.whiteColor
                              : Colors.grey.shade800,
                    ),
                  ],
                ),
                const Spacer(),
                BonsuiRadio(
                  value: value,
                  groupValue: selectedSubscription,
                  onChanged: (value) {
                    setState(() {
                      selectedSubscription = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _getSubscriptionCardDescription(int i, IconData icon,
      Color color, String title, String description, BuildContext context) {
    return FadeInUp(
      from: 30,
      duration: BonsuiDesign.animationDurations[BonsuiAnimationDuration.medium]!,
      delay: Duration(milliseconds: 150 * i),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(
              BonsuiDesign.borderRadius,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 34,
                color: color,
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BonsuiText(
                    title,
                    size: 17,
                    weight: FontWeight.w600,
                    lineHeight: 0,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: BonsuiText(
                      description,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
