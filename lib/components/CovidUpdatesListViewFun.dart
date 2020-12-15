import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class CovidUpdatesListViewFun extends StatefulWidget {
  CovidUpdatesListViewFun({Key key}) : super(key: key);

  @override
  _CovidUpdatesListViewFunState createState() =>
      _CovidUpdatesListViewFunState();
}

class _CovidUpdatesListViewFunState extends State<CovidUpdatesListViewFun> {
  final List<String> mems = <String>[
    'lib/assets/img/BackgroundImage.png',
    'lib/assets/img/Location.png',
    'lib/assets/img/safe-shield-protection.png'
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: new Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView.builder(
            itemCount: this.mems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1, vertical: height * 0.03),
                child: Container(
                  // color: Colors.white,
                  width: width * 0.9,
                  child: Image.asset(
                    mems[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )),
    );
  }
}
