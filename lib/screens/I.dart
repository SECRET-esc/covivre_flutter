import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/components/Header.dart';
import 'package:covivre/components/SliderFilling.dart';
import 'package:flutter/material.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class I extends StatefulWidget {
  const I({Key key}) : super(key: key);

  @override
  _IState createState() => _IState();
}

class _IState extends State<I> {
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
            Header(
              title: "i am",
            ),
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.amber,
                  child: Column(
                children: [
                  Flexible(
                      flex: 1,
                      //thiscobtainer
                      child: SliderFilling()),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow,
                      child: Container(
                        width: width < 376 ? width * 0.9 : width * 0.85,
                        height: height * 0.14,
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.green,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.black,
                child: Column(
                  children: [
                    Flexible(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.orange,
                            border: Border(
                                top:
                                    BorderSide(color: Colors.white, width: 0.3),
                                bottom: BorderSide(
                                    color: Colors.white, width: 0.3))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.08),
                                // color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'vulnerable'.toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: "FaturaMedium",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    SwitchCustom(nameState: 'risk')
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                // color: Colors.black,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BaseButton(
                                        title: 'am i more vulnerable to covid?',
                                        width: 0.85)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            // color: Colors.yellow,
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 0.3))),
                        height: height * 0.2,
                        constraints: BoxConstraints(minHeight: height * 0.1),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'positive'.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "FaturaMedium",
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Flexible(
                                child: SwitchCustom(nameState: 'positive'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        // color: Colors.blue,
                        height: height * 0.2,
                        constraints: BoxConstraints(minHeight: height * 0.1),
                        margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                        // color: Colors.yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'close contact'.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "FaturaMedium",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SwitchCustom(nameState: 'closeContact')
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          // color: Colors.pink
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
