import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';

ThemeData appTheme = ThemeData(
  hintColor: Colors.black,
  primaryColor: const Color(colorPrimary),
  secondaryHeaderColor: const Color(colorPrimary),
  brightness: Brightness.light,
  textTheme:
      TextTheme().apply(bodyColor: Colors.black, displayColor: Colors.black),
  accentColor: const Color(colorPrimary),
  buttonColor: Colors.white,
);

TextStyle errorStyle = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto');

TextStyle inputTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto');

TextStyle hintStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Roboto',
  color: Colors.black54,
);

TextStyle textStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Roboto',
  color: Colors.black,
);

TextStyle textPrimaryStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Roboto',
  color: const Color(colorPrimary),
);

TextStyle prifixTxtStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w700,
  fontFamily: 'Roboto',
  color: Colors.black,
);

TextStyle prifixTxtPrimaryStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w700,
  fontFamily: 'Roboto',
  color: const Color(colorPrimary),
);

TextStyle textNormalStyle = TextStyle(
  fontSize: 14.0,
  color: Colors.black,
);

TextStyle titleBoldStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

TextStyle normalPrimaryStyle = TextStyle(
  fontSize: 14.0,
  color: const Color(colorPrimary),
);

TextStyle boldPrimaryStyle = TextStyle(
  fontSize: 14.0,
  color: const Color(colorPrimary),
  fontWeight: FontWeight.w700,
);
