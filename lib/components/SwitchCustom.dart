import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SwitchCustom extends StatefulWidget {
  SwitchCustom({Key key, @required this.nameState, this.returnState})
      : super(key: key);
  var nameState;
  final Function returnState;

  @override
  _SwitchCustomState createState() => _SwitchCustomState(nameState: nameState);
}

class _SwitchCustomState extends State<SwitchCustom> {
  _SwitchCustomState({this.nameState});

  var nameState;
  static const platform = const MethodChannel('covivre/scan');
  bool status = true;

  @override
  void initState() {
    super.initState();
    _incrementInit();
  }

  Future<void> _startAdvertise() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool risk = sharedPreferences.getBool('risk');
    bool positive = sharedPreferences.getBool('positive');
    bool closeContact = sharedPreferences.getBool('closeContact');
    bool showAtRisk = sharedPreferences.getBool('showAtRisk');
    bool showMeetingRooms = sharedPreferences.getBool('showMeetingRooms');

    print(
        "state before risk - $risk, positive - $positive, closeContact - $closeContact, showAtRisk - $showAtRisk, showMeetingRooms - $showMeetingRooms");

    var map = {
      "risk": risk,
      "positive": positive,
      "closeContact": closeContact,
      "showAtRisk": showAtRisk,
      "showMeetingRooms": showMeetingRooms
    };
    String scanStartResult;
    try {
      final int result = await platform.invokeMethod('startAdvertise', map);
      scanStartResult = '$result % .';
    } on PlatformException catch (e) {
      scanStartResult = "Failed to get info: '${e.message}'.";
    }
    print(scanStartResult);
  }

  Future<void> _stopAdvertise() async {
    String scanStartResult;
    try {
      final int result = await platform.invokeMethod('stopAdvertise');
      scanStartResult = '$result % .';
    } on PlatformException catch (e) {
      scanStartResult = "Failed to get info: '${e.message}'.";
    }
    print(scanStartResult);
  }

  _incrementInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool status = sharedPreferences.getBool(nameState);
    print("state before $status");
    if (status == null) {
      await sharedPreferences.setBool(nameState, false);
      bool name = sharedPreferences.getBool(nameState);
      setState(() {
        this.status = name;
      });
    } else {
      bool name = sharedPreferences.getBool(nameState);
      setState(() {
        this.status = name;
      });
    }

    returnBool();
  }

  bool returnBool() {
    print("returnBool: $status");
    return status;
  }

  _incrementEdit(val) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(nameState, val);
    var name = sharedPreferences.getBool(nameState);
    var risk = sharedPreferences.getBool("risk");
    var positive = sharedPreferences.getBool("positive");
    var closeContact = sharedPreferences.getBool("closeContact");
    print('Name is $name');
    status = val;
    if (risk || positive || closeContact) {
      _stopAdvertise();
      _startAdvertise();
    } else if (!risk && !positive && !closeContact) {
      _stopAdvertise();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FlutterSwitch(
      width: width * 0.16,
      height: 30,
      toggleSize: 20.0,
      value: status,
      borderRadius: 30.0,
      activeColor: Theme.of(context).colorScheme.base,
      toggleColor: Theme.of(context).colorScheme.switchCircle,
      inactiveColor: Theme.of(context).colorScheme.switchBackground,
      padding: 6.0,
      onToggle: (val) {
        setState(() {
          print("Val is $val");
          _incrementEdit(val);
          status = val;
          print("Val in increment is : $status");
          widget.returnState == null ? print("") : widget.returnState(val);
        });
      },
    );
  }
}
