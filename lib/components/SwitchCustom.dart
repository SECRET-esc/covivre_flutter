import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SwitchCustom extends StatefulWidget {
  SwitchCustom({Key key, @required this.nameState}) : super(key: key);
  var nameState;

  @override
  _SwitchCustomState createState() => _SwitchCustomState(nameState: nameState);
}

class _SwitchCustomState extends State<SwitchCustom> {
  _SwitchCustomState({this.nameState});
  var nameState;
  bool status = true;
  @override
  void initState() {
    super.initState();
    _incrementInit();
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
    print('Name is $name');
    status = val;
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
        });
      },
    );
  }
}
