import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaySafeNow extends StatefulWidget {
  StaySafeNow({Key key}) : super(key: key);

  @override
  _StauSafeNowState createState() => _StauSafeNowState();
}

class _StauSafeNowState extends State<StaySafeNow> {
  int value = 0;
  int valueVulnerable = 0;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  String _scanResult = '0';
  static const platform = const MethodChannel('covivre/scan');

  initState() {
    super.initState();
    platform.setMethodCallHandler((call) => myUtilsHandler(call));
  }

  Future<void> _startScan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool risk = sharedPreferences.getBool('risk');
    bool positive = sharedPreferences.getBool('positive');
    bool closeContact = sharedPreferences.getBool('closeContact');
    bool showAtRisk = sharedPreferences.getBool('showAtRisk');
    bool showMeetingRooms = sharedPreferences.getBool('showMeetingRooms');

    print(
        "state before risk - $risk, positive - $positive, closeContact - $closeContact, showAtRisk - $showAtRisk, showMeetingRooms - $showMeetingRooms");

    var map = {
      "risk": risk,
      "positive": positive,
      "closeContact": closeContact,
      "showAtRisk": showAtRisk,
      "showMeetingRooms": showMeetingRooms
    };
    String scanStartResult;
    try {
      final int result = await platform.invokeMethod('startScan', map);
      scanStartResult = '$result % .';
    } on PlatformException catch (e) {
      scanStartResult = "Failed to get info: '${e.message}'.";
    }

    setState(() {
      _scanResult = scanStartResult;
    });
  }

  Future<dynamic> myUtilsHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'result':
        setState(() {
          valueVulnerable = methodCall.arguments["old"];
          value = methodCall.arguments["ill"];
          _scanResult = methodCall.arguments.toString();
        });
        return "1";
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
            flex: 7,
            child: Container(
              // color: Colors.black,
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
                                              color: Color.fromRGBO(
                                                  155, 177, 71, 1),
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
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: width * 0.5),
                                          width: width * 0.15,
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
                                                  fontSize: 240,
                                                  fontFamily: "FaturaDemi",
                                                  decoration:
                                                      TextDecoration.none,
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
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: width * 0.66,
                              height: height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.1),
                                    // color: Colors.yellow,
                                    child: Text(
                                      '$valueVulnerable',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 120,
                                          fontFamily: "FaturaMedium",
                                          decoration: TextDecoration.none,
                                          color:
                                              Color.fromRGBO(245, 132, 74, 1),
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
                                          Container(
                                            width: width * 0.6,
                                            height: height * 0.04,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    245, 132, 74, 1),
                                                borderRadius:
                                                    BorderRadius.circular(13)),
                                            child: Text(
                                              "VULNERABLE PEOPLE AROUND ME"
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "FaturaMedium",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Positioned(
                                            left: width * 0.01,
                                            top: height * 0.017,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: width * 0.1,
                                              height: width * 0.1,
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
                                            right: width * 0.44,
                                            top: height * 0.01,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: height * 0.01, left: width * 0.08),
                            width: width,
                            child: Text(
                              "TIME SPENT AROUND HIGH-RISK CONTACTS:"
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaMedium",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            width: width * 0.9,
                            child: Stack(children: [
                              RangeSlider(
                                divisions: 4,
                                min: 0,
                                max: 100,
                                values: _currentRangeValues,
                                onChanged: (value) => print("was changed"),
                                activeColor: Theme.of(context).colorScheme.base,
                                inactiveColor: Color.fromRGBO(145, 143, 153, 1),
                              ),
                              Container(
                                width: width,
                                height: height * 0.07,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            fontSize: 13,
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
                                            fontSize: 13,
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
                                            fontSize: 13,
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
                                            fontSize: 13,
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
                                        "1h or\nmore",
                                        style: TextStyle(
                                            fontFamily: "FaturaBook",
                                            fontSize: 13,
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
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 3,
          child: Container(
            // color: Colors.blue,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.08),
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
                        SwitchCustom(nameState: "showAtRisk"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.08),
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
                        SwitchCustom(nameState: "showMeetingRooms"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BaseButton(
                          title: "scan now",
                          width: 0.44,
                          onTap: _startScan,
                        )
                      ],
                    ),
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
        ),
      ],
    );
  }
}
