import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covivre/components/SwitchCustom.dart';
import 'package:flutter/rendering.dart';
import 'package:covivre/components/AlertDialogCovid.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class I extends StatefulWidget {
  I({Key key, this.height}) : super(key: key);
  final double height;

  @override
  _IState createState() => _IState();
}

class _IState extends State<I> {
  double stateOne = 0.0;
  double stateTwo = 33.33333333333333;
  double stateThree = 66.66666666666666;
  double stateFour = 100.0;
  double a;
  double valueHeight = 0.593;
  double valueHeightPerent = 0.45;
  double defaultHeight = 0;
  double _value;
  double indicatior;

  bool showAlert = false;
  bool cyrcleCovid = false;
  bool scrollState = false;
  bool symptomsCovid = false;
  bool stateShow = false;
  bool showAlertDialog = true;
  bool buildContext = false;
  bool dataState = false;
  bool showDialog = false;

  String data;
  String text = "Alert Dialog Feeling a Bit Down Content".tr();

  @override
  void initState() {
    super.initState();
    cyrcleCovid = false;
    symptomsCovid = false;
    scrollState = false;
    _setStateIndicator();
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    this.data = formatter.format(now);
    print(data);
    // _init();
    _checkData();
    this.a = 0;
  }

  _checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('feeling today');
    if (this.data == data) {
      this.dataState = true;
    } else {
      await prefs.setDouble("state slider", 0.0);
      print('state was changad on new day');
      setState(() {
        this._value = 0.0;
      });
    }
  }

  _setStateIndicator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double state = prefs.getDouble("state slider");
    if (state == null) {
      await prefs.setDouble("state slider", 0.0);
      print('state is null saved');
      setState(() {
        this._value = 0.0;
      });
    } else {
      print('state is $state saved');
      setState(() {
        this._value = state;
      });
    }
  }

  _getSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool state = prefs.getBool("show alert feeling a bit down");
    if (state == null) {
      setState(() {
        prefs.setBool("show alert feeling a bit down", true);
        this.showAlert = true;
        print('show alert is null set defoult true');
      });
    } else {
      setState(() {
        print('show alert is $state');
        this.showAlert = state;
      });
    }
  }

  _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("show alert feeling a bit down", true);
    print('Bool was changed!');
  }

  _initPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool state = prefs.getBool("show alert feeling a bit down");
    print('show alert is $state');
    return prefs.getBool("show alert feeling a bit down");
  }

  _notShowAgain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("_notShowAgain");
    if (prefs.getBool("show alert feeling a bit down") == null) {
      await prefs.setBool("show alert feeling a bit down", true);
    }
    await prefs.setBool("show alert feeling a bit down", false);
  }

  _getStateShow(bool value) async {
    print("_getStateShow");
    print(value);
    setState(() {
      this.stateShow = value;
    });
  }

  _saveStateSlider(double state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("state slider", state);
    await prefs.setString('feeling today', this.data);
    setState(() {
      this.buildContext = true;
    });
    print("state was saved!");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (a == 0) {
      setState(() {
        this.a = height;
        this.valueHeight = a * 0.124;
        this.valueHeightPerent = a * 0.45;
        this.defaultHeight = valueHeight;
      });
    }

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Stack(alignment: Alignment.center, children: [
          Column(
            children: [
              Header(
                  title: "i am",
                  context: this.dataState ? true : this.buildContext),
              Expanded(
                child: ListView(
                  physics: scrollState ? null : NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: valueHeightPerent,
                      // height: height * 0.85,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.05),
                          // color: Colors.red,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Flexible(
                                  flex: 1,
                                  child: Container(
                                    // color: Colors.black,
                                    child: Container(
                                      width: width < 412
                                          ? width * 0.8
                                          : width * 0.75,
                                      height: width < 412
                                          ? height * 0.13
                                          : height * 0.14,
                                      // color: Colors.pink,
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                // color: Colors.amber,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: width > 412
                                                          ? width * 0.11
                                                          : width * 0.12,
                                                      height: width < 412
                                                          ? height * 0.13
                                                          : height * 0.14,
                                                      // color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                              "lib/assets/img/Good.png",
                                                              width:
                                                                  width * 0.09,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: width >
                                                                        412
                                                                    ? height *
                                                                        0.035
                                                                    : height *
                                                                        0.03),
                                                            child: Text(
                                                              "I Great"
                                                                  .tr()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "FaturaHeavy",
                                                                  fontSize:
                                                                      width > 412
                                                                          ? 8
                                                                          : 7,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width > 412
                                                          ? width * 0.11
                                                          : width * 0.12,
                                                      height: width < 412
                                                          ? height * 0.13
                                                          : height * 0.14,
                                                      // color: Colors.black,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                              "lib/assets/img/Middle.png",
                                                              width:
                                                                  width * 0.09,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: width >
                                                                        412
                                                                    ? height *
                                                                        0.035
                                                                    : height *
                                                                        0.03),
                                                            child: Text(
                                                              "I Ok"
                                                                  .tr()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "FaturaHeavy",
                                                                  fontSize:
                                                                      width > 412
                                                                          ? 8
                                                                          : 7,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width > 412
                                                          ? width * 0.11
                                                          : width * 0.12,
                                                      height: width < 412
                                                          ? height * 0.13
                                                          : height * 0.14,
                                                      // color: Colors.green,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                              "lib/assets/img/Hard.png",
                                                              width:
                                                                  width * 0.09,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: width >
                                                                        412
                                                                    ? height *
                                                                        0.035
                                                                    : height *
                                                                        0.03),
                                                            child: Text(
                                                              "I a Bit Down"
                                                                  .tr()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "FaturaHeavy",
                                                                  fontSize:
                                                                      width > 412
                                                                          ? 8
                                                                          : 7,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width > 412
                                                          ? width * 0.11
                                                          : width * 0.12,
                                                      height: width < 412
                                                          ? height * 0.13
                                                          : height * 0.14,
                                                      // color: Colors.yellow,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                              "lib/assets/img/Bad.png",
                                                              width:
                                                                  width * 0.09,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: width >
                                                                        412
                                                                    ? height *
                                                                        0.035
                                                                    : height *
                                                                        0.03),
                                                            child: Text(
                                                              "I Portly"
                                                                  .tr()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "FaturaHeavy",
                                                                  fontSize:
                                                                      width > 412
                                                                          ? 8
                                                                          : 7,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width < 412
                                                  ? width * 0.8
                                                  : width * 0.75,
                                              child: Slider(
                                                min: 0,
                                                value: _value,
                                                max: 100,
                                                inactiveColor: Colors.white,
                                                activeColor: Colors.white,
                                                divisions: 3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                onChangeEnd: (value) {
                                                  print('value $value');
                                                  if (value ==
                                                      this.stateThree) {
                                                    print('value is $value');
                                                    _getSync();
                                                  }
                                                  _saveStateSlider(value);
                                                },
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.03),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: width < 376
                                        ? width * 0.9
                                        : width * 0.85,
                                    height: valueHeight,
                                    // height: height * 0.593,
                                    decoration: BoxDecoration(
                                        // color: Colors.blue,
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.green,
                                              border: !symptomsCovid
                                                  ? Border.all(
                                                      color: Colors.white,
                                                      width: 0.2)
                                                  : Border.all(
                                                      color: Colors.transparent,
                                                      width: 0)),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                symptomsCovid = !symptomsCovid;
                                                print('$symptomsCovid');
                                                if (symptomsCovid) {
                                                  valueHeight = valueHeight +
                                                      height * 0.45;
                                                  valueHeightPerent =
                                                      valueHeightPerent +
                                                          height * 0.45;
                                                  scrollState = true;
                                                } else {
                                                  valueHeight = valueHeight -
                                                      height * 0.45;
                                                  valueHeightPerent =
                                                      valueHeightPerent -
                                                          height * 0.45;
                                                  if (!cyrcleCovid) {
                                                    scrollState = false;
                                                  }
                                                }
                                              });
                                            },
                                            child: Container(
                                              // height: defaultHeight,
                                              height: height * 0.06,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // height: defaultHeight / 2.1,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "I Symptoms"
                                                          .tr()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "FaturaLight",
                                                          color: Colors.white,
                                                          fontSize: width > 412
                                                              ? 16
                                                              : 14,
                                                          letterSpacing: 3,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      !symptomsCovid
                                                          ? Icons
                                                              .keyboard_arrow_down
                                                          : Icons
                                                              .keyboard_arrow_up,
                                                      color: Colors.white,
                                                      size:
                                                          width > 412 ? 40 : 35,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        symptomsCovid
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                    border: symptomsCovid
                                                        ? Border(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 0.2),
                                                          )
                                                        : null),
                                                height: height * 0.45,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  child: Column(
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: Container(
                                                          // color: Colors.amber,
                                                          child: Text(
                                                            "Symptoms Begin Block"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaBook",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 14
                                                                        : 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // color: Colors.blue,
                                                          child: Text(
                                                            "Symptoms Title First Symptoms"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaDemi",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 16
                                                                        : 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // color: Colors.green,
                                                          child: Text(
                                                            "Symptoms Bottom Title First Symptoms"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaBook",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 14
                                                                        : 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // color: Colors.grey,
                                                          child: Text(
                                                            "Symptoms Content First Symptoms"
                                                                .tr()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaBook",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 14
                                                                        : 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // color: Colors.yellow
                                                          child: Text(
                                                            "Symptoms Title Secondary Symptoms"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaDemi",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 16
                                                                        : 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          // color: Colors.white,
                                                          child: Text(
                                                            "Symptoms Bottom Secondary Symptoms"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaBook",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 14
                                                                        : 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 4,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.006),
                                                          child: Container(
                                                            // color: Colors.red,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    // color: Colors
                                                                    //     .amber,
                                                                    child: Text(
                                                                      "Symptoms Content Left Side Secondary Symptoms"
                                                                          .tr()
                                                                          .toUpperCase(),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "FaturaBook",
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: width > 412
                                                                              ? 14
                                                                              : 12,
                                                                          decoration:
                                                                              TextDecoration.none),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    // color: Colors
                                                                    //     .blue,
                                                                    //     alignment:
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "Symptoms Content Right Side Secondary Symptoms"
                                                                          .tr()
                                                                          .toUpperCase(),
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "FaturaBook",
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: width > 412
                                                                              ? 14
                                                                              : 12,
                                                                          decoration:
                                                                              TextDecoration.none),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          // color: Colors.orange,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Symptoms Title Severe"
                                                                .tr(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaDemi",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 16
                                                                        : 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        child: Container(
                                                          // color: Colors.black,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "Symproms Content Severe"
                                                                .tr()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaBook",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 14
                                                                        : 12,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                cyrcleCovid = !cyrcleCovid;
                                                print(valueHeightPerent);
                                                if (cyrcleCovid) {
                                                  setState(() {
                                                    valueHeight = valueHeight +
                                                        height * 0.45;
                                                    valueHeightPerent =
                                                        valueHeightPerent +
                                                            height * 0.45;
                                                    scrollState = true;
                                                  });
                                                } else
                                                  setState(() {
                                                    valueHeight = valueHeight -
                                                        height * 0.45;
                                                    valueHeightPerent =
                                                        valueHeightPerent -
                                                            height * 0.45;
                                                    if (!symptomsCovid) {
                                                      scrollState = false;
                                                    }
                                                  });
                                              });
                                            },
                                            child: Container(
                                              // color: Colors.red,
                                              height: height * 0.06,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "I Cyrcle"
                                                                .tr()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "FaturaLight",
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width > 412
                                                                        ? 16
                                                                        : 14,
                                                                letterSpacing:
                                                                    3,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            !cyrcleCovid
                                                                ? Icons
                                                                    .keyboard_arrow_down
                                                                : Icons
                                                                    .keyboard_arrow_up,
                                                            color: Colors.white,
                                                            size: width > 412
                                                                ? 40
                                                                : 35,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        cyrcleCovid
                                            ? Container(
                                                height: height * 0.45,
                                                child: Image.asset(
                                                    "lib/assets/img/circleCovid.png"),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      height: height * 0.35,
                      child: Container(
                          // color: Colors.yellow,
                          child: Column(children: [
                        Flexible(
                          flex: showDialog ? 5 : 3,
                          child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.orange,
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.white, width: 0.3),
                                    bottom: BorderSide(
                                        color: Colors.white, width: 0.3))),
                            child: Column(
                              mainAxisAlignment: showDialog
                                  ? MainAxisAlignment.spaceEvenly
                                  : MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.08),
                                    // color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'I Vulnerable'.tr().toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "FaturaMedium",
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 2,
                                              decoration: TextDecoration.none,
                                              fontSize: width > 412 ? 20 : 16,
                                              color: Colors.white),
                                        ),
                                        SwitchCustom(nameState: 'risk')
                                      ],
                                    ),
                                  ),
                                ),
                                showDialog
                                    ? Flexible(
                                        flex: 1,
                                        child: Container(
                                          // color: Colors.black,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BaseButton(
                                                  title:
                                                      'I Vulnerable Covid'.tr(),
                                                  width: 0.85)
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                // color: Colors.yellow,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 0.3))),
                            height: height * 0.2,
                            constraints:
                                BoxConstraints(minHeight: height * 0.1),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.08),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'I Positive'.tr().toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: "FaturaMedium",
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 3,
                                        decoration: TextDecoration.none,
                                        fontSize: width > 412 ? 20 : 16,
                                        color: Colors.white),
                                  ),
                                  Flexible(
                                    child: SwitchCustom(nameState: 'positive'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            // color: Colors.blue,
                            height: height * 0.2,
                            constraints:
                                BoxConstraints(minHeight: height * 0.1),
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.08),
                            // color: Colors.yellow,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'I Close Contact'.tr().toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "FaturaMedium",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2,
                                      decoration: TextDecoration.none,
                                      fontSize: width > 412 ? 20 : 16,
                                      color: Colors.white),
                                ),
                                SwitchCustom(nameState: 'closeContact')
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              // color: Colors.pink
                              ),
                        ),
                      ])),
                    ),
                  ],
                ),
              ),
            ],
          ),
          showAlert
              ? Container(
                  width: width,
                  height: height,
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.7))
              : Container(),
          showAlert
              ? AlertDialogCovid(
                  titleText: "Alert Dialog Feeling a Bit Down Title".tr(),
                  text: text,
                  getStateShow: _getStateShow,
                  hideDialog: () {
                    if (this.stateShow) {
                      _notShowAgain();
                    }
                    setState(() {
                      showAlert = false;
                    });
                  },
                )
              : Container()
        ]),
      ),
    );
  }
}
