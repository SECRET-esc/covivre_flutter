import 'package:covivre/components/CovidUpdatesListViewLatest.dart';
import 'package:covivre/components/CovidUpdatesListViewForYou.dart';
import 'package:covivre/components/CovidUpdatesListViewMarker.dart';
import 'package:covivre/components/CovidUpdatesListViewFun.dart';
import 'package:flutter/material.dart';
import 'package:covivre/components/Header.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:easy_localization/easy_localization.dart';

class CovidUpdates extends StatefulWidget {
  @override
  _CovidUpdatesState createState() => _CovidUpdatesState();
}

class _CovidUpdatesState extends State<CovidUpdates>
    with TickerProviderStateMixin {
  TextEditingController _controller;
  TextEditingController _suggestionController = TextEditingController();

  bool forYou = true;
  bool latest = false;
  bool popular = false;
  bool marker = false;
  bool questionForm = false;
  bool isEmpty = false;

  String errorMessage;

  // AnimationController _animationController;
  // Animation<double> _animation;
  // Tween<double> _tween = Tween(begin: 0.45, end: 0.65);

  PageController controller;
  void initState() {
    super.initState();
    _controller = TextEditingController();
    forYou = true;
    latest = false;
    popular = false;
    _initController();

    // _animationController = AnimationController(
    //     duration: const Duration(milliseconds: 1300), vsync: this, value: 1)
    //   ..repeat(reverse: true);
    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.fastOutSlowIn,
    // );
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

  void fourhPage() {
    controller..jumpToPage(3);
    _onTapMarkerState();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
    // _animationController.dispose();
  }

  _onTapMarkerState() {
    setState(() {
      if (marker == false) {
        forYou = false;
        latest = false;
        popular = false;
        marker = true;
        if (currentPageValue != 3.0) fourhPage();
      }
    });
  }

  _onTapForYouState() {
    setState(() {
      if (forYou == false) {
        forYou = true;
        latest = false;
        marker = false;
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
        marker = false;
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
        marker = false;
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
            marker = false;
          });
        } else if (currentPageValue == 1.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            latest = true;
            forYou = false;
            popular = false;
            marker = false;
          });
        } else if (currentPageValue == 2.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            latest = false;
            forYou = false;
            popular = true;
            marker = false;
          });
        } else if (currentPageValue == 3.0) {
          print("currentPageValue is $currentPageValue");
          setState(() {
            latest = false;
            forYou = false;
            popular = false;
            marker = true;
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
        child: Stack(children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Header(
                title: "CoVivre Blog",
                showItems: false,
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //       color: Colors.black,
              //       alignment: Alignment.center,
              //       child: Container(
              //         constraints: BoxConstraints(minHeight: 60),
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(15)),
              //         width: width * 0.85,
              //         height: height * 0.07,
              //         child: Row(
              //           children: [
              //             Container(
              //               alignment: Alignment.center,
              //               // color: Colors.yellow,
              //               width: width * 0.15,
              //               child: Icon(
              //                 Icons.search,
              //                 color: Colors.grey,
              //                 size: width * 0.09,
              //               ),
              //             ),
              //             Container(
              //               width: width * 0.65,
              //               child: TextField(
              //                 onSubmitted: (val) {
              //                   print(height * 0.07);
              //                 },
              //                 autocorrect: true,
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                 ),
              //                 controller: _controller,
              //                 decoration: InputDecoration(
              //                   border: InputBorder.none,
              //                   hintText: "Search here",
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )),
              // ),
              Expanded(
                flex: 2,
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
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Colors.transparent))),
                              child: Text(
                                "For you".tr().toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "FaturaMedium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: width > 412 ? 22 : 19,
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
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Colors.transparent))),
                              child: Text(
                                "all".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "FaturaMedium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: width > 412 ? 22 : 19,
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
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Colors.transparent))),
                              child: Text(
                                "fun".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "FaturaMedium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: width > 412 ? 22 : 17,
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
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              _onTapMarkerState();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: marker ? 2 : 0,
                                          color: marker
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .base
                                              : Colors.transparent))),
                              child: Text(
                                "marker".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "FaturaMedium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: width > 412 ? 22 : 17,
                                    decoration: TextDecoration.none,
                                    color: marker == true
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
              // Expanded(
              //   flex: 3,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              //     child: Column(
              //       children: [
              //         Container(
              //           // color: Colors.amber,
              //           alignment: Alignment.centerLeft,
              //           child: Text(
              //             "Filtrer les articles par localisation:",
              //             style: TextStyle(
              //                 fontFamily: "FaturaBook",
              //                 fontSize: width > 412 ? 18 : 16,
              //                 decoration: TextDecoration.none,
              //                 color: Colors.white),
              //           ),
              //         ),
              //         Container()
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 18,
                // child: _getStateUpdates(),
                child: PageView(
                  controller: controller,
                  children: [
                    CovidUpdatesListViewForYou(),
                    CovidUpdatesListViewLatest(),
                    CovidUpdatesListViewFun(),
                    CovidUpdatesListViewMarker()
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
          !questionForm
              ? Positioned(
                  top: height * 0.7,
                  right: width * 0.03,
                  child: GestureDetector(
                    onTap: () {
                      print('was tapped!');
                      setState(() {
                        questionForm = true;
                      });
                    },
                    child: Container(
                      width: width * 0.16,
                      height: width * 0.16,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.base,
                          borderRadius: BorderRadius.circular(100)),
                      alignment: Alignment.center,
                      // child: ScaleTransition(
                      //   scale: _tween.animate(CurvedAnimation(
                      //     parent: _animationController,
                      //     curve: Curves.fastOutSlowIn,
                      //   )),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.03),
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            child: Image.asset(
                              "lib/assets/img/Bubble.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            child: Text("?",
                                style: TextStyle(
                                    fontFamily: "FaturaDemi",
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.base)),
                          )
                        ]),
                      ),
                    ),
                  ),
                  // ),
                )
              : Container(),
          questionForm
              ? Positioned(
                  top: height * 0.15,
                  left: width * 0.05,
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.035, vertical: 8),
                          alignment: Alignment.topRight,
                          // color: Colors.amber,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                questionForm = false;
                                _suggestionController.text = "";
                                isEmpty = false;
                              });
                            },
                            child: Icon(
                              Icons.close_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.03),
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  // color: Colors.blue,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "NEED MORE INFO!",
                                    style: TextStyle(
                                        fontFamily: "FaturaHeavy",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontSize: width > 412 ? 22 : 18),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Container(
                                    // color: Colors.green,
                                    child: Text(
                                      "The blog is there to give you as much relevant information as possible, but maybe you want to see articles on a particular topic?\n\nSubmit your suggestion and it might be the subject of a future blog post!",
                                      style: TextStyle(
                                          fontFamily: "FaturaMedium",
                                          fontSize: width > 412 ? 16 : 14),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 10,
                                child: Container(
                                  // color: Colors.yellow,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: width * 0.03),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: !isEmpty
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .background
                                                  : Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03),
                                        child: TextField(
                                            controller: _suggestionController,
                                            maxLines: 100,
                                            autocorrect: true,
                                            onChanged: (DetailsElement) {
                                              setState(() {
                                                isEmpty = false;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "My suggestion...",
                                                hintStyle: TextStyle(
                                                    fontFamily: "FaturaMedium",
                                                    fontSize:
                                                        width > 412 ? 16 : 14,
                                                    color: !isEmpty
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .background
                                                        : Colors.red))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: isEmpty
                                    ? Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          this.errorMessage,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "FaturaDemi",
                                              fontSize: width > 412 ? 16 : 14),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: width > 412 ? height * 0.01 : 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_suggestionController.text == "") {
                                        setState(() {
                                          isEmpty = true;
                                          errorMessage =
                                              "This field must not be empty! *";
                                        });
                                      } else if (_suggestionController.text
                                              .replaceAll(" ", "")
                                              .length <
                                          50) {
                                        print("empty");
                                        setState(() {
                                          isEmpty = true;
                                          errorMessage =
                                              "This field must be longer as 50 symbols! *";
                                        });
                                      } else {
                                        print(
                                            _suggestionController.text.length);
                                        setState(() {
                                          _suggestionController.text = "";
                                          questionForm = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      // color: Colors.amber,s
                                      alignment: width > 412
                                          ? Alignment.bottomCenter
                                          : Alignment.center,
                                      child: Container(
                                        width: double.infinity,
                                        height: height * 0.05,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .base,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(0, 2),
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.7)
                                            ]),
                                        child: Text(
                                          "SEND MY SUGGESTION".toUpperCase(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              fontFamily: "FaturaBold",
                                              fontSize: width > 412 ? 18 : 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
