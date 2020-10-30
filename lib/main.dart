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
      home: HomePage(),
    );
  }
}
