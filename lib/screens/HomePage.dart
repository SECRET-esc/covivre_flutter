import 'package:flutter/material.dart';
import '../components/Header.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _incrementInit();
  }

  _incrementInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('FirstLunch') == true) {
      // if app was lunched in the first time, we should be create this
      //SharedPreferences and reload statment if

      await prefs.setBool('risk', false);
      await prefs.setBool('positive', false);
      await prefs.setBool('closeContact', false);
      print("Was in the first lunch statment");
    } else {
      var closeContact = prefs.getBool('closeContact');
      print("closeContact is $closeContact");
      var risk = prefs.getBool('risk');
      print("risk is $risk");
      var positive = prefs.getBool('positive');
      print("positive is $positive");
      print(prefs.getBool('FirstLunch'));
    }
  }

  _furstLanchCencelation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var name = prefs.getBool('FirstLunch');
    if (name == null) {
      await prefs.setBool('FirstLunch', true);
    } else {
      await prefs.setBool('FirstLunch', false);
    }
    print("First lunch is:$name");
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _furstLanchCencelation();
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var value = 39;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Header(),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              // color: Colors.amber
              child: Container(
                width: width * 0.5,
                height: width * 0.5,
                // color: Colors.amber,
                child: Stack(
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.insteadImg,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$value%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width < 376 ? 50 : 60,
                                  decoration: TextDecoration.none)),
                          Text(
                            "Contraction".toUpperCase(),
                            style: TextStyle(
                                fontSize: width < 376 ? 13 : 16,
                                color: Colors.grey[400],
                                decoration: TextDecoration.none),
                          ),
                          Text(
                            "Risk".toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.base,
                                decoration: TextDecoration.none,
                                fontSize: width < 376 ? 40 : 45),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.yellow,
              child: Stack(
                children: [
                  Container(
                    // Image Backgound add here...
                    color: Colors.blue,
                  ),
                  Container(
                    height: height * 0.17,
                    alignment: Alignment.bottomCenter,
                    constraints: BoxConstraints(minHeight: height * 0.14),
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, 'I'),
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.amber,
                            width: width * 0.14,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.14,
                                  height: width * 0.14,
                                  color:
                                      Theme.of(context).colorScheme.insteadImg,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    "I am...".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontSize: width < 376 ? 11 : 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, 'StaySafe'),
                          child: Container(
                              // color: Colors.amber,
                              width: height * 0.17,
                              // height: width * 0.3,
                              alignment: Alignment.center,
                              child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      width: height * 0.17,
                                      height: height * 0.17,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .base,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      // constraints: BoxConstraints(maxWidth: 90),
                                    ),
                                    Container(
                                      width: height * 0.17,
                                      // color: Colors.black12,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Stay safe".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .buttonText,
                                            fontSize: width < 376.0 ? 20 : 30,
                                            height: 0.9,
                                            decoration: TextDecoration.none),
                                      ),
                                    )
                                  ])),
                        ),
                        GestureDetector(
                          onTap: () => print("Was tapped!"),
                          child: Container(
                            alignment: Alignment.center,
                            // color: Colors.amber,
                            width: width * 0.14,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.14,
                                  height: width * 0.14,
                                  color:
                                      Theme.of(context).colorScheme.insteadImg,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    "Fight".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontSize: width < 376 ? 11 : 12),
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
          )
        ],
      )),
    );
  }
}
