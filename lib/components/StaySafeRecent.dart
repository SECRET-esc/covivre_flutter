import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:covivre/components/DayChart.dart';
import 'package:covivre/components/HourChart.dart';
import 'package:covivre/components/MinuteChart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaySafeRecent extends StatefulWidget {
  StaySafeRecent({Key key}) : super(key: key);

  @override
  _StaySafeRecentState createState() => _StaySafeRecentState();
}

class _StaySafeRecentState extends State<StaySafeRecent> {
  bool stateDay = true;
  bool stateHour = false;
  bool stateSwitch = false;
  Map data = new Map();
  static const platform = const MethodChannel('covivre/scan');

  @override
  void initState() {
    super.initState();
    stateDay = true;
    stateHour = false;
    _getSwitchState();
    platform.setMethodCallHandler((call) => myUtilsHandler(call));
  }

  Future<dynamic> myUtilsHandler(MethodCall methodCall) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (methodCall.method) {
      case 'dataGraph':
        data = methodCall.arguments;
        return "1";
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  _getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var state = prefs.getBool("show people at risk");
    if (state == null) {
      await prefs.setBool("show people at risk", false);
      setState(() {
        this.stateSwitch = false;
      });
    } else {
      setState(() {
        this.stateSwitch = state;
      });
    }
  }

  _onTopStateDay() {
    setState(() {
      if (stateDay == false) {
        stateDay = true;
        stateHour = false;
      }
    });
  }

  _onTopStateHour() {
    setState(() {
      if (stateHour == false) {
        stateHour = true;
        stateDay = false;
      }
    });
  }


  _returnCharts() {
    if (stateDay) {
      return DayChart(stateAtRisk: this.stateSwitch, data: data);
    } else if (stateHour) {
      return HourChart(stateAtRisk: this.stateSwitch, data: data);
    }
  }

  _getStateSwitch(bool state) {
    setState(() {
      this.stateSwitch = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.amber,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              // color: Colors.black,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      // color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.2,
                            height: height * 0.1,
                            // color: Theme.of(context).colorScheme.insteadImg,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(children: [
                                Container(
                                  alignment: Alignment.center,
                                  // color: Colors.black,
                                  child: Image.asset(
                                    "lib/assets/img/safe-shield-protection2.png",
                                  ),
                                ),
                                Positioned(
                                  top: width > 412
                                      ? width * 0.01
                                      : width * 0.001,
                                  left: width > 412
                                      ? width * 0.045
                                      : width * 0.05,
                                  child: Container(
                                    // alignment: Alignment.center,
                                    // color: Colors.amberAccent,
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: width > 412 ? 35 : 25,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontFamily: "FaturaBold",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            width: width * 0.02,
                            height: height * 0.1,
                            // color: Colors.deepOrange,
                          ),
                          Container(
                            // color: Colors.red,
                            width: width * 0.75,
                            height: height * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stay Safe Streak Title'.tr().toUpperCase(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontFamily: "FaturaMedium",
                                      fontSize: width > 412 ? 18 : 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Stay Safe Streak Content'.tr(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .switchCircle,
                                      fontFamily: "FaturaMedium",
                                      fontSize: width > 412 ? 14 : 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: width > 376 ? height * 0.01 : height * 0.02),
                      // color: Colors.pink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.2,
                            height: height * 0.1,
                            // color: Theme.of(context).colorScheme.insteadImg,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Stack(children: [
                                Container(
                                  alignment: Alignment.center,
                                  // color: Colors.black,
                                  child: Image.asset(
                                    "lib/assets/img/safe-shield-protection.png",
                                  ),
                                ),
                                Positioned(
                                  top: width > 412
                                      ? width * 0.01
                                      : width * 0.001,
                                  left: width > 412
                                      ? width * 0.045
                                      : width * 0.05,
                                  child: Container(
                                    // alignment: Alignment.center,
                                    // color: Colors.amberAccent,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: width > 412 ? 35 : 25,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontFamily: "FaturaBold",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Container(
                            width: width * 0.02,
                            height: height * 0.1,
                            // color: Colors.deepOrange,
                          ),
                          Container(
                            // color: Colors.red,
                            width: width * 0.75,
                            height: height * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stay Safe Protection Title'
                                      .tr()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontFamily: "FaturaMedium",
                                      fontSize: width > 412 ? 18 : 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Stay Safe Protection Content'.tr(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .switchCircle,
                                      fontFamily: "FaturaMedium",
                                      fontSize: width > 412 ? 14 : 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: width * 0.11),
              // color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        _onTopStateDay();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: stateDay ? 2 : 0,
                                    color: stateDay
                                        ? Theme.of(context).colorScheme.base
                                        : Colors.transparent))),
                        child: Text(
                          "Stay Safe Recent Day".tr(),
                          style: TextStyle(
                              color: stateDay
                                  ? Theme.of(context).colorScheme.base
                                  : Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w600,
                              fontSize: width > 412 ? 20 : 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.08),
                    child: GestureDetector(
                      onTap: () {
                        _onTopStateHour();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: stateHour ? 2 : 0,
                                    color: stateHour
                                        ? Theme.of(context).colorScheme.base
                                        : Colors.transparent))),
                        child: Text(
                          "Stay Safe Recent Hour".tr(),
                          style: TextStyle(
                              color: stateHour
                                  ? Theme.of(context).colorScheme.base
                                  : Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w500,
                              fontSize: width > 412 ? 20 : 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 5, child: _returnCharts()),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              // color: Colors.green,
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
                    nameState: "show people at risk",
                    returnState: _getStateSwitch,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
