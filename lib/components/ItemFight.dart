import 'package:covivre/components/CheckBox.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class ItemFight extends StatefulWidget {
  ItemFight(
      {Key key,
      @required this.title,
      @required this.content,
      this.urlImage,
      this.urlNavigationSee,
      this.showNavigate})
      : super(key: key);
  final String title;
  final String content;
  final String urlNavigationSee;
  final String urlImage;
  bool showNavigate = true;

  @override
  _ItemFightState createState() => _ItemFightState();
}

class _ItemFightState extends State<ItemFight> {
  bool checkbox = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _seeBoll() {
      if (widget.showNavigate == null) {
        return GestureDetector(
          onTap: () {
            widget.urlNavigationSee != null
                ? Navigator.pushNamed(context, widget.urlNavigationSee)
                : print("was tapped!");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(
              "See how".tr().toUpperCase(),
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).colorScheme.base,
                  fontFamily: "FaturaMedium",
                  fontSize: width > 412 ? 12 : 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      } else {
        return Container();
      }
    }

    setState(() {
      print(widget.title);
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
                child: Image.asset(widget.urlImage != null
                    ? widget.urlImage
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
                        widget.title,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontFamily: "FaturaMedium",
                            fontSize: width > 412 ? 22 : 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Text(
                        widget.content,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Theme.of(context).colorScheme.switchCircle,
                            fontFamily: "FaturaMedium",
                            fontSize: width > 412 ? 13 : 10,
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
                  child: CheckBox(),
                )),
          ],
        ),
      ),
    );
  }
}
