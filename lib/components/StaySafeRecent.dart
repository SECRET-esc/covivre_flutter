import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:covivre/components/DayChart.dart';
import 'package:covivre/components/HourCharts.dart';
import 'package:covivre/components/MinuteChart.dart';

class StaySafeRecent extends StatefulWidget {
  StaySafeRecent({Key key}) : super(key: key);

  @override
  _StaySafeRecentState createState() => _StaySafeRecentState();
}

class _StaySafeRecentState extends State<StaySafeRecent> {
  bool stateDay = true;
  bool stateHour = false;
  bool stateMinute = false;

  @override
  void initState() {
    super.initState();
    stateDay = true;
    stateHour = false;
    stateMinute = false;
  }

  _onTopStateDay() {
    setState(() {
      if (stateDay == false) {
        stateDay = true;
        stateHour = false;
        stateMinute = false;
      }
    });
  }

  _onTopStateHour() {
    setState(() {
      if (stateHour == false) {
        stateHour = true;
        stateDay = false;
        stateMinute = false;
      }
    });
  }

  _onTopStateMinute() {
    setState(() {
      if (stateMinute == false) {
        stateMinute = true;
        stateHour = false;
        stateDay = false;
      }
    });
  }

  _returnCharts() {
    if (stateDay) {
      return DayChart();
    } else if (stateHour) {
      return HourChart();
    } else {
      return MinuteChart();
    }
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
                            color: Theme.of(context).colorScheme.insteadImg,
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
                                  'anti-spread streak'.toUpperCase(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontFamily: "FaturaMedium",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  width < 376
                                      ? 'Nomber of days you stayed away from COVID risk.Well done!'
                                      : 'Nomber of days you stayed away from COVID risk.Well done!',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .switchCircle,
                                      fontFamily: "FaturaMedium",
                                      fontSize: 14,
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
                            color: Theme.of(context).colorScheme.insteadImg,
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
                                  'protection streack'.toUpperCase(),
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontFamily: "FaturaMedium",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Number of days you protected people at risk by\nkeeping your distance.Keep up the good work!',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .switchCircle,
                                      fontFamily: "FaturaMedium",
                                      fontSize: 14,
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
              margin: EdgeInsets.only(left: width * 0.1),
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
                          "Day",
                          style: TextStyle(
                              color: stateDay
                                  ? Theme.of(context).colorScheme.base
                                  : Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
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
                          "Hour",
                          style: TextStyle(
                              color: stateHour
                                  ? Theme.of(context).colorScheme.base
                                  : Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.08),
                    width: width * 0.15,
                    child: GestureDetector(
                      onTap: () {
                        _onTopStateMinute();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: stateMinute ? 2 : 0,
                                    color: stateMinute
                                        ? Theme.of(context).colorScheme.base
                                        : Colors.transparent))),
                        child: Text(
                          "Minute",
                          style: TextStyle(
                              color: stateMinute
                                  ? Theme.of(context).colorScheme.base
                                  : Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
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
                    nameState: "show people at risk",
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
