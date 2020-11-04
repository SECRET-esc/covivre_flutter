import 'package:flutter/material.dart';
import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/screens/FirstLunchScreens/FirstPage.dart';
import 'package:covivre/screens/FirstLunchScreens/SecondPage.dart';
import 'package:covivre/screens/FirstLunchScreens/ThirdPage.dart';
import 'package:covivre/screens/FirstLunchScreens/FourthPage.dart';
import 'package:covivre/screens/FirstLunchScreens/FifthPage.dart';

class FirstLunch extends StatefulWidget {
  FirstLunch({Key key, this.onTapNext, this.finishTour}) : super(key: key);
  VoidCallback onTapNext;
  VoidCallback finishTour;

  @override
  _FirstLunchState createState() => _FirstLunchState();
}

class _FirstLunchState extends State<FirstLunch> {
  double coundSlide = 1;

  _returnSlide() {
    if (coundSlide == 1) {
      return FirstPage(onTapNext: () {
        setState(() {
          coundSlide++;
          widget.onTapNext();
        });
      });
    } else if (coundSlide == 2) {
      return SecondPage(onTapNext: () {
        setState(() {
          coundSlide++;
          widget.onTapNext();
        });
      });
    } else if (coundSlide == 3) {
      return ThirdPage(onTapNext: () {
        setState(() {
          coundSlide++;
          widget.onTapNext();
        });
      });
    } else if (coundSlide == 4) {
      return FourthPage(onTapNext: () {
        setState(() {
          coundSlide++;
          widget.onTapNext();
        });
      });
    } else if (coundSlide == 5) {
      return FifthPage(
        onTapNext: () {
          setState(() {
            widget.finishTour();
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _returnSlide();
  }
}
