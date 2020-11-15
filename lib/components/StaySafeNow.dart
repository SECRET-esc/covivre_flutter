import 'package:covivre/components/BaseButton.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covivre/components/AlertDialogCovid.dart';

class StaySafeNow extends StatefulWidget {
  StaySafeNow({Key key}) : super(key: key);

  @override
  _StauSafeNowState createState() => _StauSafeNowState();
}

class _StauSafeNowState extends State<StaySafeNow> {
  int value = 0;
  int valueVulnerable = 0;
  // if true display vulnerable
  bool stateAtRisk = false;
  // if false alert is hide
  bool alertAtRisk = false;
  bool alertAtRiskCallBack = false;

  RangeValues _currentRangeValues = const RangeValues(25, 75);
  String text =
      "Your symptoms might be those of COVID. Let’s monitor that closely and don’t take any chance with your loved ones.";

  String _scanResult = '0';
  static const platform = const MethodChannel('covivre/scan');

  initState() {
    super.initState();
    _initState();
    platform.setMethodCallHandler((call) => myUtilsHandler(call));
  }

  Future<dynamic> myUtilsHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'result':
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        setState(() {
          valueVulnerable = methodCall.arguments["old"];
          value = methodCall.arguments["ill"];
          _scanResult = methodCall.arguments.toString();

          sharedPreferences.setInt('valueVulnerable', valueVulnerable);
          sharedPreferences.setInt('value', value);
          sharedPreferences.setString('_scanResult', _scanResult);
        });
        return "1";
      default:
        throw MissingPluginException('notImplemented');
    }
  }


  _notShowAgain(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("_notShowAgain");
    if (prefs.getBool(key) == null) {
      await prefs.setBool(key, true);
    }
    await prefs.setBool(key, false);
  }

  _getAlertAtRiskState(bool state) {
    setState(() {
      this.alertAtRiskCallBack = state;
      // print('state at risk $state');
    });
  }

  _initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool state = prefs.getBool("show at risk");
    valueVulnerable = prefs.getInt('valueVulnerable');
    value = prefs.getInt('value');
    _scanResult = prefs.getString('_scanResult');
    setState(() {
      this.stateAtRisk = state;
    });
  }

  _getStateAtRisk(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.stateAtRisk = state;
    });
    if (state) {
      bool showAlertAtRisk = prefs.getBool("show at risk alert");
      print("showAlertAtRisk $showAlertAtRisk");
      if (showAlertAtRisk == null) {
        await prefs.setBool("show at risk alert", true);
        showAlertAtRisk = true;
      }
      if (showAlertAtRisk) {
        setState(() {
          this.alertAtRisk = showAlertAtRisk;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(alignment: Alignment.center, children: [
      Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 7,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.pink,
                    alignment: Alignment.center,
                    child: Text(
                      "Last scan: 24 Oct, 9:28 PM",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                          fontSize: 22,
                          fontFamily: "FaturaMedium",
                          color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    width: width,
                    // color: Colors.black,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: -width * 0.01,
                          child: Container(
                            width: width * 1.45,
                            child: Image.asset("lib/assets/img/map_Fond.png"),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: width * 0.70,
                            height: height * 0.4,
                            // color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.55,
                                        height: height * 0.05,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(155, 177, 71, 1),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      Positioned(
                                        top: height * 0.05,
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          child: Image.asset(
                                              "lib/assets/img/RiskArrow.png"),
                                        ),
                                      ),
                                      Positioned(
                                        right: width * 0.13,
                                        child: Container(
                                          child: Text(
                                            "COVID HIGH-RISK CONTACTS\nAROUND ME"
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "FaturaMedium",
                                                fontSize: width > 412 ? 13 : 11,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: width * 0.5),
                                        width: width > 412
                                            ? width * 0.15
                                            : width * 0.14,
                                        height: width * 0.15,
                                        child: Image.asset(
                                          "lib/assets/img/VirusLightGreen.png",
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                                Container(
                                  height: height * 0.25,
                                  width: width * 0.6,
                                  // color: Colors.yellow,
                                  child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Positioned(
                                          top: -height * 0.06,
                                          child: Text(
                                            '$value',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize:
                                                    width > 412 ? 240 : 160,
                                                fontFamily: "FaturaDemi",
                                                decoration: TextDecoration.none,
                                                color: Color.fromRGBO(
                                                    155, 177, 71, 1),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                            // color: Colors.white,
                          ),
                        ),
                        Positioned(
                          left: width * 0.01,
                          child: this.stateAtRisk
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  width: width * 0.66,
                                  height: height * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: width * 0.1),
                                        // color: Colors.yellow,
                                        child: Text(
                                          '$valueVulnerable',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: width > 412 ? 120 : 90,
                                              fontFamily: "FaturaMedium",
                                              decoration: TextDecoration.none,
                                              color: Color.fromRGBO(
                                                  245, 132, 74, 1),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                          width: width * 0.75,
                                          height: height * 0.08,
                                          // color: Colors.blue,
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Positioned(
                                                left: width < 412
                                                    ? width * 0.08
                                                    : null,
                                                child: Container(
                                                  width: width > 412
                                                      ? width * 0.6
                                                      : width * 0.4,
                                                  height: width > 412
                                                      ? height * 0.04
                                                      : height * 0.06,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          245, 132, 74, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13)),
                                                  child: Text(
                                                    "VULNERABLE PEOPLE AROUND ME"
                                                        .toUpperCase(),
                                                    textAlign: width < 412
                                                        ? TextAlign.center
                                                        : null,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "FaturaMedium",
                                                        fontSize: width > 412
                                                            ? 14
                                                            : 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: width > 412
                                                    ? width * 0.01
                                                    : width * 0.02,
                                                top: width > 412
                                                    ? height * 0.017
                                                    : height * 0.006,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width > 412
                                                      ? width * 0.1
                                                      : width * 0.12,
                                                  height: width > 412
                                                      ? width * 0.1
                                                      : width * 0.12,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          245, 132, 74, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200)),
                                                  child: Icon(Icons.add_alert,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Positioned(
                                                right: width > 412
                                                    ? width * 0.44
                                                    : width * 0.45,
                                                top: width > 412
                                                    ? height * 0.01
                                                    : -height * 0.001,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      "lib/assets/img/VulnerableArrow.png"),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  // color: Colors.red,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            top: height * 0.01, left: width * 0.08),
                        width: width,
                        child: Text(
                          "TIME SPENT AROUND HIGH-RISK CONTACTS:".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FaturaMedium",
                              fontSize: width > 412 ? 15 : 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Container(
                        width: width * 0.9,
                        // color: Colors.white,
                        child: Stack(children: [
                          Positioned(
                            top: height * 0.006,
                            child: Container(
                              // color: Colors.white,
                              width: width * 0.9,
                              height: height * 0.02,
                              child: RangeSlider(
                                divisions: 4,
                                min: 0,
                                max: 100,
                                values: _currentRangeValues,
                                onChanged: (value) => print("was changed"),
                                activeColor: Theme.of(context).colorScheme.base,
                                inactiveColor: Color.fromRGBO(145, 143, 153, 1),
                              ),
                            ),
                          ),
                          Container(
                            width: width,
                            height: height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: width * 0.11,
                                  height: height * 0.06,
                                  // color: Colors.red,
                                  child: Text(
                                    "0 min",
                                    style: TextStyle(
                                        fontFamily: "FaturaBook",
                                        fontSize: width > 412 ? 13 : 11,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: width * 0.11,
                                  height: height * 0.06,
                                  // color: Colors.green,
                                  child: Text(
                                    "5 min",
                                    style: TextStyle(
                                        fontFamily: "FaturaBook",
                                        fontSize: width > 412 ? 13 : 11,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: width * 0.11,
                                  height: height * 0.06,
                                  // color: Colors.yellow,
                                  child: Text(
                                    "15 min",
                                    style: TextStyle(
                                        fontFamily: "FaturaBook",
                                        fontSize: width > 412 ? 13 : 11,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: width * 0.11,
                                  height: height * 0.06,
                                  // color: Colors.blue,
                                  child: Text(
                                    "30 min",
                                    style: TextStyle(
                                        fontFamily: "FaturaBook",
                                        fontSize: width > 412 ? 13 : 11,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  width: width * 0.11,
                                  height: height * 0.07,
                                  // color: Colors.black,
                                  child: Text(
                                    "1h or more",
                                    style: TextStyle(
                                        fontFamily: "FaturaBook",
                                        fontSize: width > 412 ? 13 : 11,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'show "at-risk" people'.toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SwitchCustom(
                          nameState: "show at risk",
                          returnState: _getStateAtRisk,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'show safe meeting rooms'.toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SwitchCustom(nameState: "show meeting rooms"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [BaseButton(title: "scan now", width: 0.44)],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      // color: Colors.amber
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      alertAtRisk
          ? Container(
              color: Theme.of(context).colorScheme.background.withOpacity(0.8),
              width: width,
              height: height,
            )
          : Container(),
      alertAtRisk
          ? AlertDialogCovid(
              titleText: "YOU’RE FEELING A BIT DOWN?".toUpperCase(),
              text: text,
              getStateShow: _getAlertAtRiskState,
              hideDialog: () {
                setState(() {
                  if (this.alertAtRiskCallBack) {
                    _notShowAgain("show at risk alert");
                  }
                  this.alertAtRisk = false;
                });
              },
            )
          : Container(),
    ]);
  }
}
