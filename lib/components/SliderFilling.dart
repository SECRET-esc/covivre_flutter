import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderFilling extends StatefulWidget {
  SliderFilling({Key key}) : super(key: key);

  @override
  _SliderFillingState createState() => _SliderFillingState();
}

class _SliderFillingState extends State<SliderFilling> {
  _incrementInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var number = prefs.getDouble("SliderFilling");
    if (number == null)
      setState(() {
        prefs.setDouble("SliderFilling", 0.0);
        _value = 0.0;
      });
    else
      setState(() {
        _value = number;
      });
  }

  _setDouble(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("SliderFilling", value);
    print("vlaue is $value");
  }

  double _value;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _incrementInit();
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      // color: Colors.black,
      child: Container(
        width: width < 412 ? width * 0.8 : width * 0.75,
        height: width > 412 ? height * 0.13 : height * 0.15,
        // color: Colors.pink,
        child: Stack(alignment: Alignment.center, children: [
          Flexible(
            child: Container(
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.11,
                    height: width > 412 ? height * 0.13 : height * 0.15,
                    // color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Image.asset(
                            "lib/assets/img/Good.png",
                            width: width * 0.09,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.035),
                          child: Text(
                            "great".toUpperCase(),
                            style: TextStyle(
                                fontFamily: "FaturaHeavy",
                                fontSize: width > 412 ? 8 : 7,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.11,
                    height: width > 412 ? height * 0.13 : height * 0.15,
                    // color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Image.asset(
                            "lib/assets/img/Middle.png",
                            width: width * 0.09,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.035),
                          child: Text(
                            "ok".toUpperCase(),
                            style: TextStyle(
                                fontFamily: "FaturaHeavy",
                                fontSize: width > 412 ? 8 : 7,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.11,
                    height: width > 412 ? height * 0.13 : height * 0.15,
                    // color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Image.asset(
                            "lib/assets/img/Hard.png",
                            width: width * 0.09,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.035),
                          child: Text(
                            "a bit down".toUpperCase(),
                            style: TextStyle(
                                fontFamily: "FaturaHeavy",
                                fontSize: width > 412 ? 8 : 7,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.11,
                    height: width > 412 ? height * 0.13 : height * 0.15,
                    // color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Image.asset(
                            "lib/assets/img/Bad.png",
                            width: width * 0.09,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.035),
                          child: Text(
                            "poorly".toUpperCase(),
                            style: TextStyle(
                                fontFamily: "FaturaHeavy",
                                fontSize: width > 412 ? 8 : 7,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none),
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
            width: width < 412 ? width * 0.9 : width * 0.75,
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
                print("was fonished!");
                _setDouble(value);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
