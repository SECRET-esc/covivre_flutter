import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:flutter/rendering.dart';

class I extends StatefulWidget {
  I({Key key, this.height}) : super(key: key);
  final double height;

  @override
  _IState createState() => _IState();
}

class _IState extends State<I> {
  double a;

  bool cyrcleCovid = false;

  bool symptomsList = false;
  double valueHeight = 0.13;
  double valueHeightPerent = 0.45;

  double _value;
  double indicatior = 0.0;

  @override
  void initState() {
    super.initState();
    cyrcleCovid = false;
    symptomsList = false;

    _value = 66.6;
    this.a = 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (a == 0) {
      setState(() {
        this.a = height;
        this.valueHeight = a * 0.13;
        this.valueHeightPerent = a * 0.45;
      });
    }

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Header(
              title: "i am",
            ),
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: valueHeightPerent,
                    child: Container(
                        // color: Colors.red,
                        child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.black,
                            child: Container(
                              width: width < 412 ? width * 0.9 : width * 0.75,
                              height: height * 0.13,
                              // color: Colors.pink,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Flexible(
                                  child: Container(
                                    // color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: width * 0.11,
                                          height: height * 0.13,
                                          // color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "lib/assets/img/Good.png",
                                                  width: width * 0.09,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.035),
                                                child: Text(
                                                  "great".toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "FaturaHeavy",
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.11,
                                          height: height * 0.13,
                                          // color: Colors.black,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "lib/assets/img/Middle.png",
                                                  width: width * 0.09,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.035),
                                                child: Text(
                                                  "ok".toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "FaturaHeavy",
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.11,
                                          height: height * 0.13,
                                          // color: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "lib/assets/img/Hard.png",
                                                  width: width * 0.09,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.035),
                                                child: Text(
                                                  "a bit down".toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "FaturaHeavy",
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.11,
                                          height: height * 0.13,
                                          // color: Colors.yellow,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                  "lib/assets/img/Bad.png",
                                                  width: width * 0.09,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.035),
                                                child: Text(
                                                  "poorly".toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "FaturaHeavy",
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      width < 412 ? width * 0.9 : width * 0.75,
                                  child: Slider(
                                    min: 0,
                                    value: _value,
                                    max: 100,
                                    inactiveColor: Colors.white,
                                    activeColor: Colors.white,
                                    divisions: 3,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: width < 376 ? width * 0.9 : width * 0.85,
                            height: valueHeight,
                            decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    // color: Colors.green,

                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 0.2)),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * 0.05),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "SYMPTOMS OF COVID"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontFamily: "FaturaLight",
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      letterSpacing: 2,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cyrcleCovid = !cyrcleCovid;
                                        print(valueHeightPerent);
                                        if (cyrcleCovid) {
                                          setState(() {
                                            valueHeight =
                                                valueHeight + height * 0.15;
                                            valueHeightPerent =
                                                valueHeightPerent +
                                                    height * 0.2;
                                          });
                                        } else
                                          setState(() {
                                            valueHeight =
                                                valueHeight - height * 0.15;
                                            valueHeightPerent =
                                                valueHeightPerent +
                                                    height * 0.2;
                                          });
                                      });
                                    },
                                    child: Container(
                                      // color: Colors.red,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.05),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "LIFE CYCLE OF COVID"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "FaturaLight",
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        letterSpacing: 2,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    !cyrcleCovid
                                                        ? Icons
                                                            .keyboard_arrow_down
                                                        : Icons
                                                            .keyboard_arrow_up,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                )
                                              ],
                                            ),
                                            cyrcleCovid
                                                ? Flexible(
                                                    child: Container(
                                                      height: height * 0.2,
                                                      child: Image.asset(
                                                          "lib/assets/img/circleCovid.png"),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                  Container(
                    height: height * 0.35,
                    child: Container(
                        // color: Colors.yellow,
                        child: Column(children: [
                      Flexible(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.orange,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.white, width: 0.3),
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
                                          title:
                                              'am i more vulnerable to covid?',
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
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.08),
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
                    ])),
                  ),
                ],
              ),
            ),
            // Expanded(
            //     flex: 1,
            //     // child: Container(
            //     // color: Colors.amber,

            // Expanded(
            // flex: 1,
            // // child: Container(
            // // color: Colors.black,
          ],
        ),
      ),

      // ],
      //   ),
      // ),
    );
  }
}
