import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  Header({this.title, this.showItems, this.context, this.stateBluetooth});
  final String title;
  bool context = false;
  bool showItems = true;
  final bool stateBluetooth;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool bluetoothEnable = true;
  bool showIconBluetoooth = false;

  @override
  void initState() {
    super.initState();
    if (widget.stateBluetooth != null) {
      this.bluetoothEnable = widget.stateBluetooth;
    } else {
      print("state bluetooth = null");
      _sync();
    }
  }

  _sync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool state = prefs.getBool('bluetooth state');
    if (state == null) {
      setState(() {
        prefs.setBool('bluetooth state', false);
        this.bluetoothEnable = false;
      });
    } else {
      setState(() {
        this.bluetoothEnable = state;
      });
    }
  }

  _changeState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bluetooth state', state);
    print('bluetooth state was changed!');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    setState(() {
      widget.showItems == null
          ? widget.showItems = true
          : widget.showItems = widget.showItems;
    });

    _stateBluetooth() {
      print("Bluetooth state is $bluetoothEnable");
      if (bluetoothEnable) {
        return Container(
          margin: EdgeInsets.only(right: width * 0.04),
          width: width * 0.10,
          height: width * 0.10,
          decoration: (BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100))),
          child: Icon(
            Icons.bluetooth_audio,
            color: Theme.of(context).colorScheme.background,
            size: width * 0.064,
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(right: width * 0.04),
          width: width * 0.10,
          height: width * 0.10,
          child: Stack(children: [
            Center(
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: width * 0.10,
                  height: width * 0.10,
                  decoration: (BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100))),
                  child: Icon(
                    Icons.bluetooth_disabled,
                    color: Theme.of(context).colorScheme.background,
                    size: width * 0.06,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: width * 0.034,
                height: width * 0.034,
                decoration: (BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100))),
              ),
            )
          ]),
        );
      }
    }

    return Container(
      height: height * 0.08,
      child: Row(
        children: [
          Flexible(
            child: Container(
              // color: Colors.red,
              alignment: Alignment.center,
              child: (this.widget.title == null
                  ? Stack(alignment: Alignment.center, children: [
                      Positioned(
                        right: width * 0.03,
                        child: Container(
                          // color: Colors.amber,
                          child: Image.asset(
                            'lib/assets/img/CoVivre.png',
                            fit: BoxFit.cover,
                            width: width * 0.65,
                          ),
                        ),
                      ),
                    ])
                  : Container(
                      // color: Colors.black,
                      height: height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(
                                context,
                                widget.context == null
                                    ? false
                                    : widget.context),
                            child: Container(
                                margin: EdgeInsets.only(left: width * 0.05),
                                // color: Colors.amber,
                                width: width * 0.12,
                                child: Icon(Icons.west_rounded,
                                    size: width * 0.13, color: Colors.white)
                                // Image.asset("lib/assets/img/arrow.png"),
                                ),
                          ),
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.only(left: width * 0.04),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontFamily: "Heaters",
                                  fontSize: width > 412 ? 48 : 42,
                                  fontWeight: FontWeight.w500,
                                  height: widget.title.length > 10 ? 0.6 : null,
                                  color: Theme.of(context).colorScheme.base),
                              textWidthBasis: TextWidthBasis.longestLine,
                            ),
                          ))
                        ],
                      ),
                    )),
            ),
          ),
          widget.showItems
              ? Flexible(
                  child: Container(
                    // color: Colors.blue,
                    alignment: this.showIconBluetoooth
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: this.showIconBluetoooth
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        this.showIconBluetoooth
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    bluetoothEnable = !bluetoothEnable;
                                    _changeState(bluetoothEnable);
                                  });
                                },
                                child: _stateBluetooth())
                            : Container(),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, 'CovidUpdates'),
                          child: Container(
                            alignment: Alignment.center,
                            width: width * 0.1,
                            // color: Colors.black,
                            margin: EdgeInsets.only(
                                right: this.showIconBluetoooth
                                    ? null
                                    : width * 0.05),
                            height: width * 0.1,
                            // decoration: (BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(100))
                            // ),
                            child: Image.asset(
                              "lib/assets/img/Info.png",
                              width: width * 0.1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class Boolean {}
