import 'package:covivre/components/BaseButton.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:covivre/components/SwitchCustom.dart';

class StaySafeNow extends StatefulWidget {
  StaySafeNow({Key key}) : super(key: key);

  @override
  _StauSafeNowState createState() => _StauSafeNowState();
}

class _StauSafeNowState extends State<StaySafeNow> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
            flex: 6,
            child: Container(
              // color: Colors.black,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.pink,
                      alignment: Alignment.center,
                      child: Text(
                        "Last scan: 24 Oct, 9:28 PM",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                            fontSize: 22,
                            fontFamily: "FaturaMedium",
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 3,
          child: Container(
            // color: Colors.blue,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'show "at-risk" people'.toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SwitchCustom(nameState: "show at risk"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'show safe meeting rooms'.toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14,
                                fontFamily: "FaturaMedium",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SwitchCustom(nameState: "show meeting rooms"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [BaseButton(title: "scan now", width: 0.44)],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      // color: Colors.amber
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
