import 'package:covivre/components/Header.dart';
import 'package:covivre/components/PercentageProgress.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:covivre/components/ItemFight.dart';

class Fight extends StatelessWidget {
  const Fight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Header(title: "Fight"),
            Expanded(
              flex: 5,
              // color: Colors.green,
              child: Stack(
                children: [
                  Positioned(
                    right: width * 0.6,
                    top: height * 0.05,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      width: width * 0.55,
                      // color: Colors.white,

                      child: ColorFiltered(
                        child: Image.asset(
                          "lib/assets/img/Calque34.png",
                          fit: BoxFit.cover,
                        ),
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.8),
                            BlendMode.srcATop),
                      ),
                    ),
                  ),
                  Positioned(
                    top: (height * 0.01),
                    left: width * 0.5,
                    child: Container(
                      width: width * 0.5,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.background,
                              Colors.transparent
                            ],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'lib/assets/img/Calque33.png',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -height * 0.01,
                    left: width * 0.25,
                    child: Container(
                      alignment: Alignment.center,
                      child: PercentageProgress(
                        small: true,
                      ),
                    ),
                  ),
                  Positioned(
                    top: width > 412 ? height * 0.19 : height * 0.22,
                    left: width > 412 ? width * 0.21 : width * 0.25,
                    child: Container(
                      // color: Colors.black,
                      child: Text(
                        "FightItem Question".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "FaturaBold",
                            fontSize: width > 412 ? 25 : 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
                // ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView(
                children: [
                  ItemFight(
                      // title: "Wash your hands",
                      title: 'FightItem WashHands Title'.tr(),
                      urlImage: "lib/assets/img/HandsIcon.png",
                      urlNavigationSee: 'WashHands',
                      content: 'FightItem WashHands Content'.tr()),
                  ItemFight(
                    urlImage: "lib/assets/img/MaskIcon.png",
                    title: "FightItem WearMask Title".tr(),
                    content: "FightItem WearMask Content".tr(),
                    urlNavigationSee: 'Mask',
                  ),
                  ItemFight(
                    title: "FightItem Sanitizer Title".tr(),
                    urlImage: "lib/assets/img/SanitizerIcon.png",
                    content: "FightItem Sanitizer Content".tr(),
                    urlNavigationSee: 'Sanitizer',
                  ),
                  ItemFight(
                    title: "FightItem Distance Title".tr(),
                    urlImage: "lib/assets/img/DistanceIcon.png",
                    content: "FightItem Distance Content".tr(),
                    urlNavigationSee: 'Distance',
                  ),
                  ItemFight(
                    title: "FightItem Share Title".tr(),
                    showNavigate: false,
                    urlImage: "lib/assets/img/ShareIcon.png",
                    content: "FightItem Share Content".tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
