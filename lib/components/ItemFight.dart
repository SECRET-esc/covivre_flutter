import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';

// ignore: must_be_immutable
class ItemFight extends StatefulWidget {
  ItemFight({
    Key key,
    @required this.title,
    @required this.contant,
    this.urlImage,
    this.urlNavigationSee,
  }) : super(key: key);
  final String title;
  final String contant;
  final String urlNavigationSee;
  final String urlImage;

  @override
  _ItemFightState createState() => _ItemFightState(
      title: title,
      contant: contant,
      urlImage: urlImage,
      urlNavigationSee: urlNavigationSee);
}

class _ItemFightState extends State<ItemFight> {
  _ItemFightState({
    this.title,
    this.contant,
    this.urlImage,
    this.urlNavigationSee,
  });
  bool checkbox = false;
  final String title;
  final String contant;
  final String urlNavigationSee;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _seeBoll() {
      if (title != null) {
        return GestureDetector(
          onTap: () {
            urlNavigationSee != null
                ? Navigator.pushNamed(context, urlNavigationSee)
                : print("was tapped!");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(
              "> see how".toUpperCase(),
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.base,
                  fontFamily: "FaturaMedium",
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      } else {
        return Container();
      }
    }

    setState(() {
      print(title);
    });
    return Container(
      width: width,
      height: height * 0.12,
      decoration: BoxDecoration(
          // color: Colors.amber,
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.white))),
      child: Container(
        // color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.amber,
              child: Container(
                width: width * 0.18,
                child: Image.asset(urlImage != null
                    ? urlImage
                    : "lib/assets/img/Location.png"),
              ),
            ),
            Flexible(
              child: Container(
                width: width * 0.7,
                margin: EdgeInsets.only(left: width * 0.01),
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontFamily: "FaturaMedium",
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        contant,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Theme.of(context).colorScheme.switchCircle,
                            fontFamily: "FaturaMedium",
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    _seeBoll()
                  ],
                ),
              ),
            ),
            Container(
                // color: Colors.amber,
                alignment: Alignment.center,
                width: width * 0.1,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.black,
                  // child: Checkbox(
                  //   value: checkbox,
                  //   onChanged: (bool val) {
                  //     setState(() {
                  //       checkbox = val;
                  //     });
                  //   },
                  //   materialTapTargetSize: MaterialTapTargetSize.padded,
                  //   activeColor: Theme.of(context).colorScheme.base,
                  //   checkColor: Theme.of(context).colorScheme.buttonText,
                  // ),
                )),
          ],
        ),
      ),
    );
  }
}
