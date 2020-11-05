import 'package:flutter/material.dart';
import 'package:covivre/components/BaseButton.dart';
import 'package:covivre/components/PercentageProgress.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.onTapNext}) : super(key: key);
  final VoidCallback onTapNext;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
                margin: EdgeInsets.only(top: height * 0.15),
                height: 0,
                width: 0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(200),
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
            flex: 4,
            child: Container(
              width: width,
              height: height * 0.4,
              alignment: Alignment.bottomCenter,
              child: PercentageProgress(),
              //  color: Colors.pink
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height * 0.4,
              // color: Colors.yellow,
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                      alignment: Alignment.bottomCenter,
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // alignment: Alignment.bottomCenter,
                            // color: Colors.yellow,
                            child: Text(
                              "Your risk at a glance",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaBold",
                                  fontSize: width > 412 ? 22 : 18,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            // color: Colors.yellow,
                            child: Text(
                              "Know your risk of contracting or transmitting the virus.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaMedium",
                                  fontSize: width > 412 ? 20 : 18,
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
                                  onTap: widget.onTapNext,
                                ),
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
                      width: width > 412 ? 20 : 15,
                      height: width > 412 ? 20 : 15,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: width > 412 ? 20 : 15,
                      height: width > 412 ? 20 : 15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: width > 412 ? 20 : 15,
                      height: width > 412 ? 20 : 15,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: width > 412 ? 20 : 15,
                      height: width > 412 ? 20 : 15,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 91, 108, 1),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Container(
                      width: width > 412 ? 20 : 15,
                      height: width > 412 ? 20 : 15,
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
