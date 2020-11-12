import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class BaseButton extends StatefulWidget {
  BaseButton(
      {Key key,
      @required this.title,
      this.upperCase,
      @required this.width,
      this.onTap})
      : super(key: key);
  final String title;
  bool upperCase;
  double width;
  Function onTap;

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  void initState() {
    super.initState();
    if (widget.upperCase == null) {
      widget.upperCase = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.upperCase == null) {
        widget.upperCase = true;
      }
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        if (widget.onTap == null) {
          print("was tapped!");
        } else {
          widget.onTap();
        }
      },
      child: Container(
          width: width * widget.width,
          height: width > 412 ? height * 0.05 : height * 0.04,
          alignment: Alignment.center,
          constraints: BoxConstraints(maxHeight: 42.2, minHeight: 40.2),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.base,
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            widget.upperCase ? (widget.title).toUpperCase() : widget.title,
            style: TextStyle(
                fontSize: width > 412 ? 17 : 15,
                fontFamily: "FaturaBold",
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.buttonText),
          )),
    );
  }
}
