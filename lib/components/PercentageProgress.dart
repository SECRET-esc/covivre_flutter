import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class PercentageProgress extends StatefulWidget {
  PercentageProgress({Key key}) : super(key: key);

  @override
  _PercentageProgressState createState() => _PercentageProgressState();
}

class _PercentageProgressState extends State<PercentageProgress>
    with SingleTickerProviderStateMixin {
  double value = 39;
  Animation<double> animation;
  AnimationController _controller;
  String i;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0, end: value).animate(_controller)
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
    double height = MediaQuery.of(context).size.height;

    return Container(
      // color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$i%',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width < 376 ? 40 : 50,
                  decoration: TextDecoration.none)),
          Text(
            "Risk".toUpperCase(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.base,
                decoration: TextDecoration.none,
                fontSize: width < 376 ? 38 : 42),
          ),
        ],
      ),
    );
  }
}
