import 'package:covivre/screens/PageArticle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CovidUpdatesListViewForYou extends StatefulWidget {
  CovidUpdatesListViewForYou({Key key}) : super(key: key);

  @override
  _CovidUpdatesListViewForYouState createState() =>
      _CovidUpdatesListViewForYouState();
}

class _CovidUpdatesListViewForYouState
    extends State<CovidUpdatesListViewForYou> {
  TextEditingController _controller;
  // if true conteiner will expand and show all settings for tags
  bool listState = false;
  // if true "..." will hide and show all selected tags
  bool showMoreTags = false;
  // stored all id markers, init in init state
  List<int> markers = [];
  // all tags
  List<String> tags = List();
  // generate index for detect on select color background all tags
  List<bool> selected = List();
  // all tags that are selected
  List<String> myTags = List();
  // generate index for detect on select color background my tags
  List<bool> myTagsSelected = List();

  // maybe i can get height from height image but i not think so..
  // _getHeight(String url) {
  //   var height = Image.asset(url).height;
  //   print(height);
  //   return height;
  // }

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
    tags = [
      'Create',
      'Something',
      'Boring',
      'Fun',
      'sdsdsdsdsdsd',
      'dsdsdsdsds',
      '2131d21d1'
    ];
    selected = List.generate(tags.length, (index) => false);
  }

  _getMarkers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var state = prefs.getStringList('marker');
    // print('state is ${state}');
    if (state == null) {
      prefs.setStringList('marker', ["0"]);
      setState(() {
        this.markers = [0];
      });
    } else {
      List<int> result = state.map(int.parse).toList();
      // print("result is $result");
      setState(() {
        this.markers = result;
      });
    }
  }

  void addToMyTag(String name) {
    myTagsSelected.clear();
    setState(() {
      if (!myTags.contains(name)) {
        myTags.add(name);
      }

      myTagsSelected = List.generate(myTags.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print('markers is $markers');
    return Stack(children: [
      Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.amber,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Filtrer les articles par localisation:",
                            style: TextStyle(
                                fontFamily: "FaturaBook",
                                fontSize: width > 412 ? 18 : 16,
                                decoration: TextDecoration.none,
                                color: Colors.white),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
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
                                      child:
                                          Image.asset(articles[index + 1][5]),
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
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: width * 0.03,
                      ),
                    ),
                  )
                ],
              ))),
      Positioned(
        top: height * 0.03,
        left: width * 0.05,
        child: AnimatedContainer(
          width: width * 0.9,
          alignment: Alignment.topCenter,
          duration: Duration(milliseconds: 650),
          curve: Curves.fastOutSlowIn,
          height: listState
              ? width > 412
                  ? height * 0.683
                  : height * 0.73
              : height * 0.06,
          child: Container(
            decoration: BoxDecoration(
                border: listState
                    ? null
                    : Border(
                        bottom: BorderSide(width: 0.8, color: Colors.white))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    !listState
                        ? myTags.length > 0
                            ? Container(
                                width: width * 0.75,
                                height: width > 412 ? 45 : 40,
                                // color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        // width: !showMoreTags
                                        //     ? width * 0.45
                                        //     : width * 0.75,
                                        height: width > 412 ? 45 : 40,
                                        // color: Colors.amber,
                                        child: ListView.builder(
                                            physics: !showMoreTags
                                                ? NeverScrollableScrollPhysics()
                                                : null,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: myTags.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (index <= 1) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.045,
                                                  margin: index == 0
                                                      ? null
                                                      : EdgeInsets.only(
                                                          left: width * 0.02),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        myTags[index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "FaturaBook",
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            print(
                                                                'was tapped!');
                                                            myTags.removeAt(
                                                                index);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        145, 143, 153, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                );
                                              } else if (showMoreTags) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  height: height * 0.045,
                                                  margin: index == 0
                                                      ? null
                                                      : EdgeInsets.only(
                                                          left: width * 0.02),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        myTags[index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "FaturaBook",
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            print(
                                                                'was tapped!');
                                                            myTags.removeAt(
                                                                index);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        145, 143, 153, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                );
                                              }
                                            }),
                                      ),
                                    ),
                                    showMoreTags
                                        ? Container()
                                        : myTags.length > 2
                                            ? Container(
                                                alignment: Alignment.centerLeft,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showMoreTags = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: height * 0.045,
                                                    width: width * 0.13,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "...",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily:
                                                            "FaturaBook",
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          145, 143, 153, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                ),
                              )
                            : Container(
                                width: width * 0.45,
                                height: width > 412 ? 45 : 40,
                                alignment: Alignment.center,
                                child: Text(
                                  'You not added some tags',
                                  style: TextStyle(
                                      fontFamily: "FaturaDemi",
                                      color: Color.fromRGBO(145, 143, 153, 1),
                                      fontSize: 16),
                                ),
                              )
                        : SizedBox(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          listState = !listState;
                          if (showMoreTags) showMoreTags = false;
                        });
                      },
                      child: Icon(
                        listState
                            ? Icons.expand_less_sharp
                            : Icons.expand_more_sharp,
                        color: !listState
                            ? Color.fromRGBO(145, 143, 153, 1)
                            : Colors.black,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                if (listState)
                  Container(
                    width: double.infinity,
                    height: height * 0.6,
                    // color: Colors.black
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              // color: Colors.red,
                              child: Container(
                                  // color: Colors.black,
                                  alignment: Alignment.center,
                                  child: Container(
                                    constraints: BoxConstraints(minHeight: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    width: width * 0.85,
                                    height: height * 0.055,
                                    child: Row(
                                      children: [
                                        Container(
                                            width: width * 0.65,
                                            padding: EdgeInsets.only(
                                                left: width * 0.05),
                                            child: TextField(
                                              cursorColor: Colors.black,
                                              onSubmitted: (val) {
                                                print(height * 0.07);
                                              },
                                              autocorrect: true,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Search here...",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        width > 412 ? 18 : 16,
                                                    fontFamily: "FaturaMedium"),
                                              ),
                                            )),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          // color: Colors.yellow,
                                          width: width * 0.15,
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.black,
                                            size: width * 0.09,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                        Flexible(
                            flex: 3,
                            child: Container(
                              // color: Colors.amber,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      height: 30,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05),
                                      // color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              child: Text(
                                                "Selected",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "FaturaHeavy",
                                                    fontSize:
                                                        width > 412 ? 16 : 14,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              // color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Erase everything",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "FaturaHeavy",
                                                          fontSize: width > 412
                                                              ? 16
                                                              : 14),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('was tapped!');
                                                      setState(() {
                                                        myTags.clear();
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                        size: width * 0.07,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 5,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: height * 0.005),
                                        child: Container(
                                          // color: Colors.amber,
                                          child: myTags.length != 0
                                              ? ListView.builder(
                                                  itemCount: myTags.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTapDown: (TapDownDetails
                                                          details) {
                                                        print('tap down');
                                                        setState(() {
                                                          myTagsSelected[
                                                              index] = true;
                                                        });
                                                      },
                                                      onTapCancel: () {
                                                        print('tap cancel');
                                                        setState(() {
                                                          myTagsSelected[
                                                              index] = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: width *
                                                                    0.051,
                                                                right: width *
                                                                    0.058),
                                                        width: double.infinity,
                                                        height: 45,
                                                        color: myTagsSelected[
                                                                index]
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .base
                                                            : Colors
                                                                .transparent,
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Container(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.05),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  myTags[index],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "FaturaMedium",
                                                                      fontSize:
                                                                          18,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none),
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    myTags.removeAt(
                                                                        index);
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .black,
                                                                    size: width >
                                                                            412
                                                                        ? 22
                                                                        : 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                              : Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "You not added some tags",
                                                    style: TextStyle(
                                                      fontFamily: "FaturaDemi",
                                                      fontSize: 18,
                                                      color: Color.fromRGBO(
                                                          145, 143, 153, 1),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ))
                                ],
                              ),
                            )),
                        Flexible(
                            flex: 4,
                            child: Container(
                              // color: Colors.black,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05),
                                      alignment: Alignment.centerLeft,
                                      // color: Colors.deepOrangeAccent,
                                      child: Text(
                                        "Metropolis",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "FaturaHeavy",
                                            fontSize: width > 412 ? 16 : 14,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      // color: Colors.yellow,
                                      child: ListView.builder(
                                          itemCount: tags.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTapDown:
                                                  (TapDownDetails details) {
                                                print('tap down');
                                                setState(() {
                                                  selected[index] = true;
                                                });
                                              },
                                              onTapCancel: () {
                                                print('tap cancel');
                                                setState(() {
                                                  selected[index] = false;
                                                });
                                              },
                                              child: Ink(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.05),
                                                  width: double.infinity,
                                                  height: 50,
                                                  color: selected[index]
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .base
                                                      : Colors.transparent,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      addToMyTag(tags[index]);
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.05),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        tags[index],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "FaturaMedium",
                                                            fontSize: 18,
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: listState ? Colors.white : Colors.transparent,
            borderRadius: listState ? BorderRadius.circular(15) : null,
          ),
        ),
      )
    ]);
  }
}
