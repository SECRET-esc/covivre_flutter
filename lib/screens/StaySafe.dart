import 'package:flutter/material.dart';
import '../components/Header.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class StaySafe extends StatefulWidget {
  const StaySafe({Key key}) : super(key: key);

  @override
  _StaySafeState createState() => _StaySafeState();
}

class _StaySafeState extends State<StaySafe> {
  bool nowState = true;
  bool recentState = false;

  @override
  void initState() {
    super.initState();
    nowState = true;
    recentState = false;
  }

  _onTopNowState() {
    setState(() {
      if (nowState == false) {
        nowState = true;
        recentState = false;
      }
    });
  }

  _onTopRecentState() {
    setState(() {
      if (recentState == false) {
        recentState = true;
        nowState = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Flex(direction: Axis.vertical, children: [
          Header(title: "stay safe"),
          Expanded(
            flex: 1,
            child: Container(
                // color: Colors.amber,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _onTopNowState();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: nowState ? 2 : 0,
                                    color: nowState
                                        ? Theme.of(context).colorScheme.base
                                        : Colors.transparent))),
                        child: Text(
                          "now".toUpperCase(),
                          style: TextStyle(
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              decoration: TextDecoration.none,
                              color: nowState == true
                                  ? Theme.of(context).colorScheme.base
                                  : Theme.of(context).colorScheme.switchCircle),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _onTopRecentState();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: recentState ? 2 : 0,
                                    color: recentState
                                        ? Theme.of(context).colorScheme.base
                                        : Colors.transparent))),
                        child: Text(
                          "recent".toUpperCase(),
                          style: TextStyle(
                              fontFamily: "FaturaMedium",
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              color: recentState == true
                                  ? Theme.of(context).colorScheme.base
                                  : Theme.of(context).colorScheme.switchCircle),
                        ),
                      ),
                    ),
                  )
                ])),
          ),
          nowState
              ? Expanded(
                  flex: 9,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                          flex: 6,
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
                                  flex: 6,
                                  child: Container(
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.red,
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
                                child: Container(color: Colors.amber),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(color: Colors.blue),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(color: Colors.green),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  flex: 9,
                  child: Container(
                    color: Colors.amber,
                  ),
                )
        ]),
      ),
    );
  }
}
