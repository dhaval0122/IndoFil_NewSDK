import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';

class ButtonWidgets extends StatelessWidget {
  final String? buttonName;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? textColor;

  ButtonWidgets(
      {this.buttonName, this.onTap, this.buttonColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return (Material(
      color: Colors.transparent,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: buttonColor ?? Color(colorPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(p_5),
            ),
            padding: EdgeInsets.all(12),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        // splashColor: Colors.grey,
        onPressed: onTap,
        // elevation: 7,
        // padding: EdgeInsets.all(12),
        // color: buttonColor ?? Color(colorPrimary),
        child: Text(buttonName != null ? buttonName! : "",
            style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto')),
      ),
    ));
  }
}
