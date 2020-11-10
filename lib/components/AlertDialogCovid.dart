import 'package:covivre/components/CheckBox.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class AlertDialogCovid extends StatefulWidget {
  AlertDialogCovid(
      {Key key, this.titleText, this.text, this.hideDialog, this.getStateShow})
      : super(key: key);
  final String titleText;
  final String text;
  final VoidCallback hideDialog;
  final Function getStateShow;
  @override
  _AlertDialogCovidState createState() => _AlertDialogCovidState();
}

class _AlertDialogCovidState extends State<AlertDialogCovid> {
  bool valueBool = false;
  getValue(bool value) {
    setState(() {
      this.valueBool = value;
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: height * 0.6,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          Container(
            // color: Colors.red,
            width: width * 0.9,
            child: Image.asset("lib/assets/img/PopupImage.png"),
          ),
          Positioned(
            top: height * 0.25,
            left: width * 0.1,
            child: Container(
              width: width * 0.7,
              height: height * 0.2,
              alignment: Alignment.center,
              // color: Colors.black,
              child: Column(
                children: [
                  Text(
                    widget.titleText,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "FaturaHeavy",
                        fontSize: 21,
                        decoration: TextDecoration.none),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            fontFamily: "FaturaMedium",
                            color: Colors.black,
                            fontSize: 18,
                            decoration: TextDecoration.none),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.4,
            left: width * 0.1,
            child: Container(
              width: width * 0.7,
              height: height * 0.2,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        CheckBox(
                          isChecked: false,
                          backgroundColor: Colors.white,
                          getValue: getValue,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            "Don’t show me again",
                            style: TextStyle(
                                fontFamily: "FaturaMedium",
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.getStateShow(this.valueBool);
                      widget.hideDialog();
                    },
                    child: Container(
                      width: width * 0.7,
                      height: height * 0.055,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.base,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        "ok".toUpperCase(),
                        style: TextStyle(
                            fontFamily: "FaturaDemi",
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20),
                      ),
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
