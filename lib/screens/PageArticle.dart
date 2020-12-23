import 'package:covivre/components/Header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/utils.dart';

class PageArticle extends StatefulWidget {
  PageArticle(
      {Key key,
      this.tag,
      this.url,
      this.stateMarker,
      this.author,
      this.content,
      this.date,
      this.id,
      this.title})
      : super(key: key);
  int id;
  String content;
  String title;
  String author;
  String date;
  String tag;
  String url;
  bool stateMarker;
  @override
  _PageArticleState createState() => _PageArticleState();
}

class _PageArticleState extends State<PageArticle>
    with TickerProviderStateMixin {
  bool stateMarker;
  AnimationController controller;
  Animation growAnimation;
  Animation slideAnimation;
  String contentText =
      '''Attaché à donner l’accès aux tests PCR Covid 19 au plus grand nombre, la Ville de Nice s’est engagé à anticiper et adapter l’offre de dépistage aux besoins des Niçoises et des Niçois. Face à l’accélération du virus sur notre territoire. Ces tests sont gratuits.

Les tests seront pratiqués par des infirmiers diplômés d’Etat et analysés par un laboratoire accrédité indépendant. Les résultats seront communiqués aux patients par mail ou par adresse postale.
Centre COVID Palais des Expositions
L’entrée se fait via le parvis de l’Europe (masque obligatoire pour l’accès au site).

Les conditions à remplir pour bénéficier du test:
- Etre résident niçois et pouvoir en justifier (se munir d’un justificatif d’identité + de domicile à jour).
- Etre majeur à la date du test.
- Présenter des symptômes de la Covid-19 et / ou être un cas-contact. Un médecin sera présent sur site pour vérifier si ces conditions sont remplies et rendre un avis médical.
''';

  List<int> markers = [];

  @override
  initState() {
    super.initState();
    print('widget.stateMarker == ${widget.stateMarker}');
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          ..addListener(() {
            print('${growAnimation.value}');
            setState(() {});
          });
    growAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    slideAnimation = Tween<double>(begin: 30, end: 0).animate(controller);
    controller.forward();
    _getMarkers();
  }

  _getMarkers() async {
    print('in get markers ');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setStringList('marker', []);
    var state = prefs.getStringList('marker');
    if (state == null) {
      prefs.setStringList('marker', ["0"]);
      setState(() {
        this.markers = [0];
      });
    } else {
      print('state is not null $state');
      List<int> result = state.map(int.parse).toList();
      setState(() {
        this.markers = result;
      });
    }
  }

  _addMarker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> state = prefs.getStringList('marker');
    if (!state.contains(widget.id.toString())) {
      state.add(widget.id.toString());
    }
    print('(add Marker)state now is $state');
    await prefs.setStringList('marker', state);
    return;
  }

  _removeMarker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> state = prefs.getStringList('marker');
    if (state.contains(widget.id.toString())) {
      state.remove(widget.id.toString());
    }
    print('(remove Marker)state now is $state');
    await prefs.setStringList('marker', state);
    return;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  _changeMarker(bool state) {
    if (!state) {
      _removeMarker();
    } else {
      _addMarker();
    }
    setState(() {
      this.stateMarker = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print('marker $markers');
    return Hero(
      tag: widget.tag,
      child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(172, 169, 191, 1)),
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                child: Stack(children: [
                  Image.asset(
                    widget.url,
                  ),
                  Positioned(
                    top: height * 0.05,
                    child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: width * 0.05),
                        height: height * 0.05,
                        // color: Colors.amber,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.west_rounded,
                              size: width * 0.13, color: Colors.white),
                        )),
                  ),
                ]),
              ),
            ),
            Container(
              color: Colors.white,
              child: Container(
                width: width,
                padding: EdgeInsets.only(bottom: 0),
                // height: height * 0.3,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(172, 169, 191, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.03, bottom: height * 0.03),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                        child: Container(
                          width: double.infinity,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: this.growAnimation.value,
                                child: Container(
                                  width: width * 0.7,
                                  margin: EdgeInsets.only(
                                      left: slideAnimation.value),
                                  // color: Colors.amber,
                                  child: Text(
                                    // "Les dépistages mobiles dans les quartiers prioritaires de Nice",
                                    widget.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: "FaturaHeavy",
                                        fontWeight: FontWeight.w500,
                                        fontSize: width > 412 ? 25 : 23),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Opacity(
                                  opacity: growAnimation.value,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: slideAnimation.value),
                                    child: Text(
                                      // "Mr. Deam",
                                      widget.author,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "FaturaMedium",
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none,
                                          fontSize: width > 412 ? 18 : 16),
                                    ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: growAnimation.value,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: slideAnimation.value),
                                  child: Text(
                                    // "23 Nov. 2020",
                                    widget.date,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "FaturaMedium",
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontSize: width > 412 ? 18 : 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.03,
                      right: width * 0.03,
                      child: GestureDetector(
                        onTap: () {
                          _changeMarker(this.stateMarker == null
                              ? !widget.stateMarker
                              : !this.stateMarker);
                        },
                        child: Icon(
                          this.stateMarker == null
                              ? widget.stateMarker
                                  ? Icons.bookmark
                                  : Icons.bookmark_border
                              : this.stateMarker
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, bottom: height * 0.03),
                child: Container(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Opacity(
                    opacity: growAnimation.value,
                    child: Container(
                      padding: EdgeInsets.only(left: slideAnimation.value),
                      width: width * 0.9,
                      child: Text(
                        // contentText,
                        widget.content,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            decoration: TextDecoration.none,
                            fontFamily: "FaturaBook",
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ]),
    );
  }
}
