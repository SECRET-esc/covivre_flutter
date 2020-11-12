import 'package:flutter/material.dart';
import '../components/Header.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/StaySafeNow.dart';
import 'package:covivre/components/StaySafeRecent.dart';

class StaySafe extends StatefulWidget {
  const StaySafe({Key key}) : super(key: key);

  @override
  _StaySafeState createState() => _StaySafeState();
}

class _StaySafeState extends State<StaySafe> {
  bool nowState = true;
  bool recentState = false;
  PageController _controller;

  var currentPageValue = 0.0;

  void nextPage() {
    _controller.animateToPage(_controller.page.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    setState(() {
      nowState = false;
      recentState = true;
    });
  }

  void previousPage() {
    _controller.animateToPage(_controller.page.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    setState(() {
      recentState = false;
      nowState = true;
    });
  }

  _initController() {
    _controller = PageController()
      ..addListener(() {
        currentPageValue = _controller.page;
        if (currentPageValue == 0.0) {
          print("currentPageValue is 0.0");
          setState(() {
            nowState = true;
            recentState = false;
          });
        } else if (currentPageValue == 1.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            recentState = true;
            nowState = false;
          });
        }
      });
  }

  @override
  void initState() {
    super.initState();
    nowState = true;
    recentState = false;
    _initController();
  }

  _onTapNowState() {
    setState(() {
      if (nowState == false) {
        nowState = true;
        recentState = false;
        print("now state is: $currentPageValue");
        if (currentPageValue == 1.0) previousPage();
      }
    });
  }

  _onTapRecentState() {
    setState(() {
      if (recentState == false) {
        recentState = true;
        nowState = false;
        print("state recent is: $currentPageValue");
        if (currentPageValue == 0.0) nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Flex(direction: Axis.vertical, children: [
          Header(title: "stay safe"),
          Expanded(
            flex: 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _onTapNowState();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
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
                                    : Theme.of(context)
                                        .colorScheme
                                        .switchCircle),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _onTapRecentState();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
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
                                    : Theme.of(context)
                                        .colorScheme
                                        .switchCircle),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          // nowState
          //     ? Expanded(flex: 9, child: StaySafeNow())
          //     : Expanded(flex: 9, child: StaySafeRecent())
          Expanded(
            flex: 9,
            child: PageView(
              controller: _controller,
              children: [StaySafeNow(), StaySafeRecent()],
            ),
          )
        ]),
      ),
    );
  }
}
