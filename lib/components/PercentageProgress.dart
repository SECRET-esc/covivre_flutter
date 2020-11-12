import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';

class PercentageProgress extends StatefulWidget {
  PercentageProgress({Key key, this.small}) : super(key: key);
  bool small;

  @override
  _PercentageProgressState createState() => _PercentageProgressState();
}

class _PercentageProgressState extends State<PercentageProgress>
    with SingleTickerProviderStateMixin {
  double value = 0;
  Animation<double> animation;
  AnimationController _controller;
  String i;
  @override
  void initState() {
    super.initState();
    if (widget.small == null) {
      widget.small = false;
    }
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: value == 0 ? 0 : value)
        .animate(_controller)
          ..addListener(() {
            setState(() {
// The state that has changed here is the animation objects value
              i = animation.value.toStringAsFixed(0);
            });
          });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    setState(() {
      if (widget.small == null) {
        widget.small = false;
      }
    });
    return Container(
      width: widget.small ? width * 0.5 : width * 0.8,
      height: widget.small ? width * 0.5 : width * 0.8,
      // color: Colors.amber,
      child: Stack(children: [
        Container(
          alignment: Alignment.center,
          // color: Theme.of(context).colorScheme.insteadImg,
          child: Positioned(
            top: 0,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: widget.small ? width * 0.25 : width * 0.6,
                child: Image.asset(
                  "lib/assets/img/DeadVirusBackground.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: CircularPercentIndicator(
            radius: widget.small ? width * 0.33 : width * 0.7,
            lineWidth: 15.0,
            animation: true,
            backgroundColor: Colors.grey.withOpacity(0.1),
            circularStrokeCap: CircularStrokeCap.round,
            percent: value < 100 ? value * 0.01 : 1,
            animationDuration: 2000,
            backgroundWidth: 6,
            center: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value == 0 ? "--%" : '$i%',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "FaturaBoldOBbli",
                        fontWeight: FontWeight.w600,
                        fontSize: widget.small
                            ? width < 412
                                ? 20
                                : 30
                            : width < 412
                                ? 40
                                : 55,
                        decoration: TextDecoration.none)),
                Text(
                  "Risk".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "FaturaBoldOBbli",
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.base,
                      decoration: TextDecoration.none,
                      fontSize: widget.small
                          ? width < 376
                              ? 15
                              : 35
                          : width < 376
                              ? 40
                              : 60),
                ),
              ],
            ),
            progressColor: value != 0
                ? value < 10
                    ? Color.fromRGBO(62, 178, 0, 1.0)
                    : value < 20
                        ? Theme.of(context).colorScheme.base
                        : value < 50
                            ? Color.fromRGBO(237, 174, 62, 1)
                            : value > 51
                                ? Color.fromRGBO(222, 91, 91, 1)
                                : Colors.transparent
                : Colors.transparent,
          ),
        ),
      ]),
    );
  }
}
