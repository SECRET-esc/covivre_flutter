import 'package:covivre/components/Header.dart';
import 'package:covivre/components/PercentageProgress.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/ItemFight.dart';

class Fight extends StatelessWidget {
  const Fight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).backgroundColor,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.bottomCenter,
      //         end: Alignment.topCenter,
      //         colors: [
      //       Color.fromRGBO(11, 8, 29, 1),
      //       Color.fromRGBO(11, 8, 29, 1),
      //       Color.fromRGBO(52, 47, 80, 1),
      //       Color.fromRGBO(52, 47, 80, 1)
      //     ])),
      child: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Header(title: "fight"),
            Expanded(
              flex: 5,
              // child: Container(
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
                      )),
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
                  Container(
                    alignment: Alignment.center,
                    child: PercentageProgress(),
                  ),
                ],
                // ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: ListView(
                  children: [
                    ItemFight(
                      title: "Wash your hands",
                      contant:
                          "With plain soap and water for at 40\nseconds.The best way to prevent the spread!",
                    ),
                    ItemFight(
                      title: "Wear a mask",
                      contant: "The musk must cover your face.",
                    ),
                    ItemFight(
                      title: "Use hand sanitazer",
                      contant: "Share the application with your loved ones.",
                    ),
                    ItemFight(
                      title: "Keep your distance",
                      contant: "Stay at least 6 feet away from others.",
                    ),
                    ItemFight(
                      title: "Share the app",
                      contant: "Share the application with your loved ones.",
                    ),
                  ],
                ),
                // color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
