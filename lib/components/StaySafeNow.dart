import 'package:covivre/components/BaseButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covivre/components/AlertDialogCovid.dart';
import 'package:easy_localization/easy_localization.dart';

class StaySafeNow extends StatefulWidget {
  StaySafeNow({Key key}) : super(key: key);

  @override
  _StatusSafeNowState createState() => _StatusSafeNowState();
}

class _StatusSafeNowState extends State<StaySafeNow> {
  int value = 0;
  int valueVulnerable = 0;
  int meetingRooms = 0;
  // if true display vulnerable
  bool stateAtRisk = false;
  bool stateMeeting = false;
  // if true is chosen close if false is chosen max
  bool stateDistance = false;
  // if false alert is hide
  bool alertAtRisk = false;
  bool showScanNowButton = false;
  bool alertAtRiskCallBack = false;
  var date = new DateTime.now();
  var format = DateFormat('d MMM, h:mm a');
  String formatted = "";

  RangeValues _currentRangeValues = const RangeValues(25, 75);
  String text =
      "Your symptoms might be those of COVID. Let’s monitor that closely and don’t take any chance with your loved ones.";

  String _scanResult = '0';
  static const platform = const MethodChannel('covivre/scan');

  initState() {
    super.initState();
    _initState();
    formatted = format.format(this.date);
    platform.setMethodCallHandler((call) => myUtilsHandler(call));
  }

  updateDistance() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('stateDistance', stateDistance);
  }

  Future<dynamic> myUtilsHandler(MethodCall methodCall) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (methodCall.method) {
      case 'result':
        setState(() {
          valueVulnerable = methodCall.arguments["old"] ?? 0;
          value = methodCall.arguments["ill"] ?? 0;
          _scanResult = methodCall.arguments.toString();
          if (value == null) {
            value = 0;
          }
          if (valueVulnerable == null) {
            valueVulnerable = 0;
          }

          sharedPreferences.setInt('valueVulnerable', valueVulnerable);
          sharedPreferences.setInt('value', value);
          sharedPreferences.setString('_scanResult', _scanResult);
        });
        return "1";
      case 'data':
        var timestamp = methodCall.arguments["timestampLast"] ?? 0;
        timestamp = timestamp * 1000;
        print("timestamp $timestamp");
        sharedPreferences.setInt('timestamp', timestamp);
        this.date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
        formatted = format.format(this.date);
        return "1";
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  _getColor(int integer) {
    if (integer == null) {
      integer = 0;
    }
    if (integer <= 2) {
      return Color.fromRGBO(62, 178, 0, 1.0);
    } else if (integer > 2 && integer <= 5) {
      return Color.fromRGBO(237, 174, 62, 1);
    } else if (integer > 5) {
      return Color.fromRGBO(222, 91, 91, 1);
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
    bool state = prefs.getBool("show at risk") ?? false;
    bool stateMeeting = prefs.getBool('meeting state') ?? false;
    stateDistance = prefs.getBool('stateDistance') ?? false;
    valueVulnerable = prefs.getInt('valueVulnerable') ?? 0;
    value = prefs.getInt('value') ?? 0;
    date =
        new DateTime.fromMicrosecondsSinceEpoch(prefs.getInt('timestamp') ?? 0);
    _scanResult = prefs.getString('_scanResult');
    setState(() {
      this.stateAtRisk = state;
      this.stateMeeting = stateMeeting;
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

  _getStateMeeting(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('meeting state', state);
    setState(() {
      this.stateMeeting = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("width $width");
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
                      "Last scan: $formatted",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                          fontSize: width > 412 ? 22 : 20,
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
                                            "Stay Safe Around Me"
                                                .tr()
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
                                          top: -height * 0.04,
                                          child: Text(
                                            '$value',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize:
                                                    width > 412 ? 240 : 160,
                                                fontFamily: "FaturaDemi",
                                                decoration: TextDecoration.none,
                                                color: _getColor(this.value),
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
                                  // color: Colors.amber,
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
                                                  144, 132, 233, 1),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                          width: width * 0.75,
                                          height: height * 0.08,
                                          // color: Colors.blue,
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Positioned(
                                                left: width < 412
                                                    ? width * 0.08
                                                    : width * 0.04,
                                                child: Container(
                                                  width: width > 412
                                                      ? width * 0.4
                                                      : width * 0.35,
                                                  height: width > 412
                                                      ? height * 0.04
                                                      : height * 0.06,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          144, 132, 233, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13)),
                                                  child: Text(
                                                    "Stay Safe Around Me Vulnerable"
                                                        .tr()
                                                        .toUpperCase(),
                                                    textAlign: width < 412
                                                        ? TextAlign.center
                                                        : null,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "FaturaMedium",
                                                        fontSize: width > 412
                                                            ? 12
                                                            : 11,
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
                                                    : width < 390
                                                        ? height * 0.006
                                                        : height * 0.0077,
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
                                                          144, 132, 233, 1),
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
                                                    : width < 390
                                                        ? width * 0.45
                                                        : width * 0.455,
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
                        Positioned(
                          bottom: height * 0.002,
                          right: width * 0.03,
                          child: stateMeeting
                              ? Container(
                                  width: width * 0.45,
                                  height: height * 0.18,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  // color: Colors.white,
                                  child: Stack(
                                    // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Positioned(
                                        right: width * 0.02,
                                        child: Container(
                                          child: Text(
                                            '$meetingRooms',
                                            style: TextStyle(
                                                fontSize:
                                                    width > 412 ? 100 : 70,
                                                fontFamily: "FaturaMedium",
                                                decoration: TextDecoration.none,
                                                color: Color.fromRGBO(
                                                    132, 190, 233, 1),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: height * 0.003,
                                        right: 0,
                                        child: Container(
                                          width: width * 0.365,
                                          height: height * 0.04,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 3,
                                                right: 4,
                                                bottom: 3,
                                                left: width * 0.03),
                                            alignment: Alignment.centerRight,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: Color.fromRGBO(
                                                  132, 190, 233, 1),

                                              // color: Colors.red
                                            ),
                                            child: Text(
                                              "DISINFECTED PREMISES SEE THE LIST!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "FaturaDemi",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: height * 0.001,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          height: height * 0.045,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  132, 190, 233, 1),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Image.asset(
                                              "lib/assets/img/meeting.png"),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: height * 0.033,
                                        right: width * 0.055,
                                        child: Container(
                                          width: width * 0.04,
                                          child: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              child: Image.asset(
                                                "lib/assets/img/VulnerableArrow.png",
                                                fit: BoxFit.cover,
                                              ),
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      132, 190, 233, 1),
                                                  Color.fromRGBO(
                                                      132, 190, 233, 1)
                                                ]).createShader(bounds);
                                              }),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        )
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
                          "Stay Safe Around Me Time".tr().toUpperCase(),
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
                                    "Stay Safe Min".tr(args: ['0']),
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
                                    "Stay Safe Min".tr(args: ['5']),
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
                                    "Stay Safe Min".tr(args: ['15']),
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
                                    "Stay Safe Min".tr(args: ['30']),
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
                                    "Stay Safe Hour".tr(),
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
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Distance:".toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: width > 412 ? 18 : 16,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: width * 0.35,
                          height: 30,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!stateDistance) {
                                        setState(() {
                                          stateDistance = !stateDistance;
                                          updateDistance();
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: stateDistance
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                          border: Border.all(
                                              color: !stateDistance
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              width: 1),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30))),
                                      child: Text("Close".toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: stateDistance
                                                  ? "FaturaBold"
                                                  : "FaturaBook",
                                              color: stateDistance
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .background
                                                  : Colors.white,
                                              fontSize: 14)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (stateDistance) {
                                        setState(() {
                                          stateDistance = !stateDistance;
                                          updateDistance();
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: !stateDistance
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                          border: Border.all(
                                              color: stateDistance
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              width: 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(30))),
                                      child: Text("max".toUpperCase(),
                                          style: TextStyle(
                                              // fontFamily: "FaturaBold",
                                              fontFamily: stateDistance
                                                  ? "FaturaBook"
                                                  : "FaturaBold",
                                              // color: Theme.of(context)
                                              //     .colorScheme
                                              //     .background,
                                              color: !stateDistance
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .background
                                                  : Colors.white,
                                              fontSize: 14)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // color: Colors.amber,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Stay Safe At Risk People'.tr().toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: width > 412 ? 14 : 12,
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
                            'Stay Safe Meering Rooms'.tr().toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: width > 412 ? 14 : 12,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SwitchCustom(
                          nameState: "show meeting rooms",
                          returnState: _getStateMeeting,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      this.showScanNowButton
                          ? BaseButton(title: "scan now", width: 0.44)
                          : Container()
                    ],
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
