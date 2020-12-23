import 'package:covivre/screens/PageArticle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CovidUpdatesListViewMarker extends StatefulWidget {
  CovidUpdatesListViewMarker({Key key}) : super(key: key);

  @override
  _CovidUpdatesListViewMarkerState createState() =>
      _CovidUpdatesListViewMarkerState();
}

class _CovidUpdatesListViewMarkerState
    extends State<CovidUpdatesListViewMarker> {
  List<int> markers = [];
  var articles = {
    1: [
      "Title1",
      "Content1",
      "Date1",
      "Author1",
      "Categories1",
      "lib/assets/img/ExampleImage.jpeg"
    ],
    2: [
      "Title2",
      "Content2",
      "Date2",
      "Author2",
      "Categories2",
      "lib/assets/img/VirusLightGreen.png"
    ]
  };

  @override
  void initState() {
    super.initState();
    _getMarkers();
    print('markers $markers');
  }

  _getMarkers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var state = prefs.getStringList('marker');
    print('state is ${state}');
    if (state == null) {
      prefs.setStringList('marker', []);
    } else if (state == []) {
      prefs.setStringList('marker', []);
    } else {
      List<int> result = state.map(int.parse).toList();
      print("result is $result");
      setState(() {
        this.markers = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: markers.length != 0
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: 1000,
                itemBuilder: (context, index) => markers.contains(index + 1)
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageArticle(
                                        content: articles[index + 1][1],
                                        title: articles[index + 1][0],
                                        date: articles[index + 1][2],
                                        author: articles[index + 1][3],
                                        tag: articles[index + 1][5],
                                        url: articles[index + 1][5],
                                        // stateMarker: false,
                                        stateMarker:
                                            this.markers.contains(index + 1)
                                                ? true
                                                : false ?? false,
                                        id: index + 1,
                                      )));
                        },
                        child: Hero(
                          tag: articles[index + 1][5],
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                      // color: Colors.amber,
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(articles[index + 1][5]),
                                  )),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.only(
                                              right: width * 0.03, top: 3),
                                          width: double.infinity,
                                          child: Text(
                                            articles[index + 1][0],
                                            style: TextStyle(
                                                fontFamily: "FaturaBoldOBbli",
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          color: Colors.amber,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: width * 0.03,
              )
            : Container(
                width: width,
                height: height * 0.6,
                alignment: Alignment.center,
                // color: Colors.white,
                child: Text(
                  "You not added some markers",
                  style: TextStyle(
                      fontFamily: "FaturaDemi",
                      color: Color.fromRGBO(145, 143, 153, 1),
                      fontSize: 20),
                ),
              ),
      ),
    );
  }
}
