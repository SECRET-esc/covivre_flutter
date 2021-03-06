import 'package:covivre/components/BaseButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/Header.dart';
import '../components/PercentageProgress.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covivre/screens/FirstLunch.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var now = new DateTime.now();

  int firstLunchCounter = 1;

  bool firstLunch = false;
  bool showAlertTour = false;
  bool showTour = false;
  bool iAmState = false;

  String data;

  static const platform = const MethodChannel('covivre/scan');

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    this.data = formatter.format(now);
    print(data);
    _incrementInit();
    _furstLanchCencelation();
  }

  Future<void> _startScan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool risk = sharedPreferences.getBool('risk');
    bool positive = sharedPreferences.getBool('positive');
    bool closeContact = sharedPreferences.getBool('closeContact');
    bool showAtRisk = sharedPreferences.getBool('showAtRisk');
    bool showMeetingRooms = sharedPreferences.getBool('showMeetingRooms');
    bool stateDistance = sharedPreferences.getBool('stateDistance');

    print(
        "state before risk - $risk, positive - $positive, closeContact - $closeContact, showAtRisk - $showAtRisk, showMeetingRooms - $showMeetingRooms");

    var map = {
      "risk": risk,
      "positive": positive,
      "closeContact": closeContact,
      "showAtRisk": showAtRisk,
      "showMeetingRooms": showMeetingRooms,
      "stateDistance": stateDistance
    };
    String scanStartResult;
    try {
      final int result = await platform.invokeMethod('startScan', map);
      scanStartResult = '$result % .';
    } on PlatformException catch (e) {
      scanStartResult = "Failed to get info: '${e.message}'.";
    }

    setState(() {
      // _scanResult = scanStartResult;
    });
    Navigator.pushNamed(context, 'StaySafe');
  }

  Future<void> _showPermissions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool risk = sharedPreferences.getBool('risk');
    bool positive = sharedPreferences.getBool('positive');
    bool closeContact = sharedPreferences.getBool('closeContact');
    bool showAtRisk = sharedPreferences.getBool('showAtRisk');
    bool showMeetingRooms = sharedPreferences.getBool('showMeetingRooms');
    bool stateDistance = sharedPreferences.getBool('stateDistance');

    print(
        "state before risk - $risk, positive - $positive, closeContact - $closeContact, showAtRisk - $showAtRisk, showMeetingRooms - $showMeetingRooms");

    var map = {
      "risk": risk,
      "positive": positive,
      "closeContact": closeContact,
      "showAtRisk": showAtRisk,
      "showMeetingRooms": showMeetingRooms,
      "stateDistance": stateDistance
    };
    String scanStartResult;
    try {
      final int result = await platform.invokeMethod('startAdvertise', map);
      scanStartResult = '$result % .';
    } on PlatformException catch (e) {
      scanStartResult = "Failed to get info: '${e.message}'.";
    }
    print(scanStartResult);
  }

  _nextSlideFirstLunch() {
    firstLunchCounter++;
    print(firstLunchCounter);
  }

  _incrementInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('FirstLunch') == true) {
      // if app was lunched in the first time, we should be create this
      //SharedPreferences and reload statment if

      await prefs.setBool('risk', false);
      await prefs.setBool('positive', false);
      await prefs.setBool('closeContact', false);
      await prefs.setBool('show at risk', false);
      await prefs.setBool('stateDistance', false);
      await prefs.setBool('show meeting rooms', false);
      await prefs.setBool('show alert feeling a bit down', true);
      await prefs.setString('feeling today', 'empty');
      await prefs.setDouble('state slider', 0.0);
      await prefs.setBool('meeting state', false);
      await prefs.setBool("show alert feeling a bit down", true);
      await prefs.setBool('bluetooth state', false);
      setState(() {
        firstLunch = true;
        showAlertTour = true;
      });

      print("Was in the first lunch statment");
    } else {
      // var closeContact = prefs.getBool('closeContact');
      // // print("closeContact is $closeContact");
      // var risk = prefs.getBool('risk');
      // // print("risk is $risk");
      // var positive = prefs.getBool('positive');
      // print("positive is $positive");
      print(prefs.getBool('FirstLunch'));
    }
  }

  _furstLanchCencelation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getBool('FirstLunch');
    if (name == null) {
      await prefs.setBool('FirstLunch', true);
      _incrementInit();
    } else {
      await prefs.setBool('FirstLunch', false);
      String data = prefs.getString('feeling today');
      if (data != this.data) {
        setState(() {
          this.iAmState = false;
          print('data is $data');
          // print("if data in prefs is $data");
        });
      } else {
        setState(() {
          this.iAmState = true;
          print("else data in prefs is $data");
        });
      }
    }
    if (prefs.getBool('FirstLunch') == false) {
      _startScan();
    }
    print("First lunch is:$name");
  }

  _navigation(BuildContext context, String name) async {
    final state = await Navigator.pushNamed(context, 'I');
    setState(() {
      this.iAmState = state ?? this.iAmState;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print('px width = $width');
    return Container(
      color: Theme.of(context).backgroundColor,
      // color: Colors.white,
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: height * 0.6,
          // right: ,
          child: firstLunch
              ? firstLunchCounter == 2 || firstLunchCounter == 5
                  ? Container()
                  : Container(
                      width: width * 1.3,
                      child: Image.asset(
                        "lib/assets/img/BackgroundImage.png",
                        width: width * 1.1,
                      ))
              : Container(
                  width: width * 1.3,
                  child: Image.asset(
                    "lib/assets/img/BackgroundImage.png",
                    width: width * 1.1,
                  )),
        ),
        Opacity(
          opacity: 0.8,
          child: Container(color: Theme.of(context).colorScheme.background),
        ),
        SafeArea(
            child: Flex(
          direction: Axis.vertical,
          children: [
            Header(),
            Expanded(
                flex: 1,
                child: firstLunch
                    ? firstLunchCounter >= 1
                        ? Container()
                        : Container(
                            alignment: Alignment.center,
                            // color: Colors.amber,
                            width: width * 0.6,
                            height: width * 0.6,
                            child: PercentageProgress())
                    : Container(
                        alignment: Alignment.center,
                        // color: Colors.amber,
                        width: width * 0.6,
                        height: width * 0.6,
                        child: PercentageProgress())),
            Expanded(
              flex: 1,
              // color: Colors.yellow,
              child: firstLunchCounter == 2 && firstLunch ||
                      firstLunchCounter == 5 && firstLunch
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(top: height * 0.01),
                      child: Stack(
                        children: [
                          Container(
                            height: height * 0.17,
                            alignment: Alignment.bottomCenter,
                            constraints:
                                BoxConstraints(minHeight: height * 0.14),
                            // color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => _navigation(context, "I"),
                                  child: Container(
                                    alignment: Alignment.center,
                                    // color: Colors.amber,
                                    width: width * 0.14,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: width * 0.14,
                                            height: width * 0.14,
                                            // color:
                                            //     Theme.of(context).colorScheme.insteadImg,
                                            child: !this.iAmState
                                                ? Image.asset(
                                                    "lib/assets/img/IamFillOff.png")
                                                : Image.asset(
                                                    "lib/assets/img/IAmIcon.png")),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: Text(
                                            "I am".tr().toUpperCase(),
                                            style: TextStyle(
                                                fontFamily: "FaturaMedium",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    width < 412 ? 14 : 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _startScan(),
                                  child: Container(
                                      // color: Colors.amber,
                                      width: height * 0.17,
                                      // height: width * 0.3,
                                      alignment: Alignment.center,
                                      child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                              width: height * 0.16,
                                              height: height * 0.16,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .base,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              // constraints: BoxConstraints(maxWidth: 90),
                                            ),
                                            Container(
                                              width: height * 0.16,
                                              // color: Colors.black12,
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Stay safe'.tr().toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .buttonText,
                                                    fontSize:
                                                        width < 412.0 ? 20 : 30,
                                                    fontFamily:
                                                        "FaturaExtraBold",
                                                    height: 0.9,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            )
                                          ])),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, 'Fight'),
                                  child: Container(
                                    alignment: Alignment.center,
                                    // color: Colors.amber,
                                    width: width * 0.14,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.12,
                                          height: width * 0.12,
                                          // color:
                                          //     Theme.of(context).colorScheme.insteadImg,
                                          child: Image.asset(
                                              "lib/assets/img/FightIcon.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * 0.01),
                                          child: Text(
                                            "Fight".tr().toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "FaturaMedium",
                                                fontWeight: FontWeight.w500,
                                                decoration: TextDecoration.none,
                                                fontSize:
                                                    width < 412 ? 14 : 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        )),
        if (showAlertTour)
          Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Stack(alignment: Alignment.center, children: [
              Container(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
                width: width,
                height: height,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.5,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(102, 99, 141, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 5,
                      // color: Colors.black,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 20,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Tour Alert Welcome".tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontFamily: "FaturaHeavy",
                                    fontSize: width > 412 ? 25 : 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Positioned(
                            left: width > 412 ? -width * 0.1 : width * 0.03,
                            bottom: width > 412
                                ? -height * 0.15
                                : width < 390
                                    ? -height * 0.12
                                    : -height * 0.16,
                            child: Container(
                              // alignment: Alignment.centerLeft,
                              // color: Colors.amber,
                              width: width > 412 ? width * 0.9 : width * 0.7,
                              child: Image.asset(
                                "lib/assets/img/CoVivre.png",
                                width: width * 0.6,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                        child: Column(
                          children: [
                            Text(
                              "Tour Alert Content".tr(),
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontFamily: "FaturaDemi",
                                  fontSize: width > 412 ? 18 : 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    // ),
                    Expanded(
                      flex: 5,
                      // color: Colors.green,
                      // child: Container(
                      //   margin: EdgeInsets.symmetric(vertical: height * 0.03),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseButton(
                              title: "Tour Alert Get Started".tr(),
                              width: 0.4,
                              onTap: () {
                                setState(() {
                                  showTour = true;
                                  showAlertTour = false;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showTour = false;
                                  firstLunch = false;
                                  showAlertTour = false;
                                });
                              },
                              child: Text(
                                "Tour Alert Skip The Tour".tr(),
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontFamily: "FaturaDemi",
                                    fontSize: width > 412 ? 25 : 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ]),
          )
        else
          Container(),
        showTour && firstLunch
            ? FirstLunch(
                onTapNext: () {
                  setState(() {
                    _nextSlideFirstLunch();
                  });
                },
                finishTour: () {
                  setState(() {
                    _showPermissions();
                    firstLunch = false;
                  });
                },
              )
            : Container()
      ]),
    );
  }
}
