import 'package:covivre/constants/ColorsTheme.dart';
import 'package:flutter/material.dart';

class CovidUpdatesListViewPopular extends StatefulWidget {
  CovidUpdatesListViewPopular({Key key}) : super(key: key);

  @override
  _CovidUpdatesListViewPopularState createState() =>
      _CovidUpdatesListViewPopularState();
}

class _CovidUpdatesListViewPopularState
    extends State<CovidUpdatesListViewPopular> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Container(
          width: width,
          height: height * 0.2,
          // color: Colors.amber,
        )
      ],
    );
  }
}
