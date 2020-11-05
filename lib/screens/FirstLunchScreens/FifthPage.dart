import 'package:flutter/material.dart';
import 'package:covivre/components/BaseButton.dart';

class FifthPage extends StatefulWidget {
  FifthPage({Key key, @required this.onTapNext}) : super(key: key);
  final VoidCallback onTapNext;
  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
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
                margin: EdgeInsets.only(
                    top: width > 412 ? height * 0.0570 : height * 0.0300,
                    left: width * 0.36),
                height: width * 0.15,
                width: width * 0.15,
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
            flex: 1,
            child: Container(
              width: width,
              height: height * 0.4,
              // color: Colors.pink.withOpacity(0.1),
            ),
          ),
          Expanded(
            flex: width > 412 ? 7 : 9,
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
                              "",
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
                              "One last thing before you start using the app!\n\nTo evaluate your risk of contracting or transmitting the virus without localizing you, the app needs Bluetooth to measure your distance from other CoVivre users nearby.\n\nBe sure that your phone has Bluetooth turned on and don’t worry about your battery: Bluetooth is used only for a few seconds every 2 minutes.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaMedium",
                                  fontSize: width > 412 ? 22 : 18,
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
                                    title: "enable",
                                    width: 0.25,
                                    onTap: () {
                                      widget.onTapNext();
                                    }),
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
            flex: 1,
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
