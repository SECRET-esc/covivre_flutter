import 'package:covivre/components/CovidUpdatesListViewLatest.dart';
import 'package:covivre/components/CovidUpdatesListViewForYou.dart';
import 'package:covivre/components/CovidUpdatesListViewPopular.dart';
import 'package:flutter/material.dart';
import 'package:covivre/components/Header.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:easy_localization/easy_localization.dart';

class CovidUpdates extends StatefulWidget {
  @override
  _CovidUpdatesState createState() => _CovidUpdatesState();
}

class _CovidUpdatesState extends State<CovidUpdates> {
  TextEditingController _controller;
  bool forYou = true;
  bool latest = false;
  bool popular = false;
  PageController controller;
  void initState() {
    super.initState();
    _controller = TextEditingController();
    forYou = true;
    latest = false;
    popular = false;
    _initController();
  }

  var currentPageValue = 0.0;

  void firstPage() {
    controller.jumpToPage(0);
    _onTapForYouState();
  }

  void secondPage() {
    controller.jumpToPage(1);
    _onTapLatestState();
  }

  void thirdPage() {
    controller..jumpToPage(2);
    _onTapPopularState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onTapForYouState() {
    setState(() {
      if (forYou == false) {
        forYou = true;
        latest = false;
        popular = false;
        if (currentPageValue != 0.0) firstPage();
      }
    });
  }

  _onTapLatestState() {
    setState(() {
      if (latest == false) {
        latest = true;
        forYou = false;
        popular = false;
        if (currentPageValue != 1.0) secondPage();
      }
    });
  }

  _onTapPopularState() {
    setState(() {
      if (popular == false) {
        popular = true;
        latest = false;
        forYou = false;
        if (currentPageValue != 2.0) thirdPage();
      }
    });
  }

  _initController() {
    controller = PageController()
      ..addListener(() {
        currentPageValue = controller.page;
        if (currentPageValue == 0.0) {
          print("currentPageValue is 0.0");
          setState(() {
            forYou = true;
            latest = false;
            popular = false;
          });
        } else if (currentPageValue == 1.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            latest = true;
            forYou = false;
            popular = false;
          });
        } else if (currentPageValue == 2.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            latest = false;
            forYou = false;
            popular = true;
          });
        }
      });
  }

  // _getStateUpdates() {
  //   if (forYou) {
  //     print("CovidUpdatesListViewForYou");
  //     return CovidUpdatesListViewForYou();
  //   } else if (popular) {
  //     print("CovidUpdatesListViewPopular");
  //     return CovidUpdatesListViewPopular();
  //   } else {
  //     print("CovidUpdatesListViewLatest");
  //     return CovidUpdatesListViewLatest();
  //   }
  // }

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
              title: "CoVivre Blog",
              showItems: false,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  // color: Colors.black,
                  alignment: Alignment.center,
                  child: Container(
                    constraints: BoxConstraints(minHeight: 60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: width * 0.85,
                    height: height * 0.07,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          // color: Colors.yellow,
                          width: width * 0.15,
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: width * 0.09,
                          ),
                        ),
                        Container(
                          width: width * 0.65,
                          child: TextField(
                            onSubmitted: (val) {
                              print(height * 0.07);
                            },
                            autocorrect: true,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.blue,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _onTapForYouState();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: forYou ? 2 : 0,
                                        color: forYou
                                            ? Theme.of(context).colorScheme.base
                                            : Colors.transparent))),
                            child: Text(
                              "For you".tr().toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "FaturaMedium",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  decoration: TextDecoration.none,
                                  color: forYou == true
                                      ? Theme.of(context).colorScheme.base
                                      : Theme.of(context)
                                          .colorScheme
                                          .switchCircle),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _onTapLatestState();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: latest ? 2 : 0,
                                        color: latest
                                            ? Theme.of(context).colorScheme.base
                                            : Colors.transparent))),
                            child: Text(
                              "latest".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "FaturaMedium",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  decoration: TextDecoration.none,
                                  color: latest == true
                                      ? Theme.of(context).colorScheme.base
                                      : Theme.of(context)
                                          .colorScheme
                                          .switchCircle),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            _onTapPopularState();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: popular ? 2 : 0,
                                        color: popular
                                            ? Theme.of(context).colorScheme.base
                                            : Colors.transparent))),
                            child: Text(
                              "popular".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "FaturaMedium",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  decoration: TextDecoration.none,
                                  color: popular == true
                                      ? Theme.of(context).colorScheme.base
                                      : Theme.of(context)
                                          .colorScheme
                                          .switchCircle),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              // child: _getStateUpdates(),
              child: PageView(
                controller: controller,
                children: [
                  CovidUpdatesListViewForYou(),
                  CovidUpdatesListViewLatest(),
                  CovidUpdatesListViewPopular()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
