import 'package:flutter/material.dart';
import 'package:covivre/components/BaseButton.dart';

class FourthPage extends StatefulWidget {
  FourthPage({Key key, @required this.onTapNext}) : super(key: key);
  final VoidCallback onTapNext;
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
            Color.fromRGBO(30, 28, 51, 1).withOpacity(0.8), BlendMode.srcOut),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  backgroundBlendMode: BlendMode.dstOut),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.56, left: width * 0.7),
                height: width * 0.28,
                width: width * 0.28,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
      Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height * 0.4,
              // color: Colors.pink.withOpacity(0.1),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height * 0.4,
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.yellow,
                            child: Text(
                              "Keep up the good fight!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaBold",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            // color: Colors.yellow,
                            child: Text(
                              "Small actions do make a difference.\nYou too, be a fighter!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaMedium",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // color: Colors.black,
                                child: BaseButton(
                                    title: "next",
                                    width: 0.25,
                                    onTap: widget.onTapNext),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        // color: Colors.black,
                        ),
                  ),
                ],
              ),
              // color: Colors.amber.withOpacity(0.1),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height * 0.4,
              // color: Colors.pink.withOpacity(0.1),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height * 0.4,
              // color: Colors.green.withOpacity(0.1),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.2),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
