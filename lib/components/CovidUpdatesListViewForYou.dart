import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class CovidUpdatesListViewForYou extends StatefulWidget {
  CovidUpdatesListViewForYou({Key key}) : super(key: key);

  @override
  _CovidUpdatesListViewForYouState createState() =>
      _CovidUpdatesListViewForYouState();
}

class _CovidUpdatesListViewForYouState
    extends State<CovidUpdatesListViewForYou> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => new Container(
            decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(15)),
            child: new Center(
              child: Stack(alignment: Alignment.center, children: [
                Container(
                  width: width / 2.2,
                  // color: Colors.amber,
                  child:
                      Image.asset("lib/assets/img/safe-shield-protection.png"),
                ),
                Text(
                  '$index',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "FaturaBold",
                      fontSize: 30),
                ),
              ]),
            ),
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 1.5 : 1),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: width * 0.03,
        ),
      ),
    );
  }
}
