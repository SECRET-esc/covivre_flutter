import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  Header({Key key, this.title}) : super(key: key);
  String title;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.08,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 8,
              child: Container(
                  // color: Colors.red,
                  alignment: Alignment.center,
                  child: (this.widget.title == null
                      ? GestureDetector(
                          onTap: () => print("Was tapped!"),
                          child: Container(
                              margin: EdgeInsets.only(right: width * 0.08),
                              width: width * 0.4,
                              height: height * 0.2,
                              color: Theme.of(context).colorScheme.insteadImg))
                      : Container(
                          // color: Colors.black,
                          height: height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: width * 0.05, left: width * 0.05),
                                  // color: Colors.amber,
                                  width: width * 0.12,
                                  child:
                                      Image.asset("lib/assets/img/arrow.png"),
                                ),
                              ),
                              Flexible(
                                  child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontFamily: "Heaters",
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                    height:
                                        widget.title.length > 10 ? 0.6 : null,
                                    color: Theme.of(context).colorScheme.base),
                                textWidthBasis: TextWidthBasis.longestLine,
                              ))
                            ],
                          ))))),
          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.blue,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => print("Was tapped!"),
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      color: Theme.of(context).colorScheme.insteadImg,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("Was tapped!"),
                    child: Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      color: Theme.of(context).colorScheme.insteadImg,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Boolean {}
