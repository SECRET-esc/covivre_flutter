import 'package:flutter/material.dart';
import 'package:covivre/components/BaseButton.dart';
import 'package:easy_localization/easy_localization.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key, @required this.onTapNext}) : super(key: key);
  final VoidCallback onTapNext;
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
                    top: width > 412 ? height * 0.5150 : height * 0.53),
                height: width > 412 ? width * 0.5 : width * 0.4,
                width: width > 412 ? width * 0.5 : width * 0.4,
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
                              "Tour First Page Title".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaBold",
                                  fontSize: width > 412 ? 22 : 17,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            // color: Colors.yellow,
                            child: Text(
                              "Tour First Page Content".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FaturaMedium",
                                  fontSize: width > 412 ? 22 : 15,
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
                                    title: "Tour Button".tr(),
                                    width: 0.3,
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
