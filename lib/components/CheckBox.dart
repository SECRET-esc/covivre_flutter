import 'package:flutter/material.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class CheckBox extends StatefulWidget {
  CheckBox(
      {Key key,
      this.isChecked,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor})
      : super(key: key);
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size ?? 30,
      height: widget.size ?? 30,
      color: Theme.of(context).colorScheme.background,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
              color: _isSelected
                  ? widget.selectedColor ?? Theme.of(context).colorScheme.base
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
              border: _isSelected
                  ? null
                  : Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    )),
          child: _isSelected
              ? Icon(
                  Icons.check_sharp,
                  color: widget.selectedIconColor ??
                      Theme.of(context).colorScheme.background,
                  size: widget.iconSize ?? 30,
                )
              : null,
        ),
      ),
    );
  }
}
