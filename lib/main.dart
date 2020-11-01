import 'package:covivre/screens/CovidUpdates.dart';
import 'package:covivre/screens/StaySafe.dart';
import 'package:covivre/screens/I.dart';
import 'package:covivre/screens/Fight.dart';

import 'package:flutter/material.dart';
import './screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covivre',
      theme: ThemeData(backgroundColor: Color.fromRGBO(31, 28, 50, 1.0)),
      initialRoute: 'HomePage',
      routes: {
        'HomePage': (context) => HomePage(),
        'StaySafe': (context) => StaySafe(),
        'I': (context) => I(),
        'Fight': (context) => Fight(),
        'CovidUpdates': (context) => CovidUpdates(),
      },
    );
  }
}
