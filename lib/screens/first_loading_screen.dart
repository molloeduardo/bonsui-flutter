import 'package:animate_do/animate_do.dart';
import 'package:bonsui/bonsui.dart';
import 'package:bonsui/enums/animation.dart';
import 'package:flutter/cupertino.dart';

class BonsuiFirstLoadingScreen extends StatelessWidget {
  const BonsuiFirstLoadingScreen(
      {super.key,
      this.logo,
      required this.description,
      this.child,
      this.ownerLogo});

  final Image? logo;
  final String description;
  final Widget? child;
  final String? ownerLogo;

  @override
  Widget build(BuildContext context) {
    return BonsuiScaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (logo != null)
                  ElasticIn(
                    delay: const Duration(milliseconds: 200),
                    duration: BonsuiDesign
                        .animationDurations[BonsuiAnimationDuration.medium]!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: logo,
                    ),
                  ),
                BounceInUp(
                  from: 20,
                  delay: const Duration(milliseconds: 500),
                  duration: BonsuiDesign
                      .animationDurations[BonsuiAnimationDuration.medium]!,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 14,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            BonsuiText(
                              description,
                              size: 18,
                              align: TextAlign.center,
                            ),
                            if (child != null) ...[
                              const SizedBox(height: 20),
                              child!,
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            left: MediaQuery.of(context).size.width / 2 - 55,
            child: FadeIn(
              duration: BonsuiDesign
                  .animationDurations[BonsuiAnimationDuration.medium]!,
              delay: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  if (ownerLogo != null)
                    Image.asset(
                      ownerLogo!,
                      width: 110,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
