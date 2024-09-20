import 'package:flutter/material.dart';

ThemeData lightBlueTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFF004a96),
  primaryColorDark: const Color(0xFF004a96),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    secondary: const Color(0xFFA6C0DA), // Replaces accentColor
  ),
);


ThemeData greenTheme = ThemeData.light().copyWith(
//  primaryColor: const Color(0xFF33932c),
//  primaryColorDark: const Color(0xff306c30),
//  accentColor: const Color(0xFF33932c),
//  primaryColor: const Color(0xFF33932c),
  primaryColor: const Color(0xFF65AC1E),
  primaryColorDark: const Color(0xFF4E9F74),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    secondary: const Color(0xFF65AC1E), // Replaces accentColor
  ),
  // accentColor: const Color(0xFF65AC1E),

  //  primaryColorDark: const Color(0x80004a96),
//  hintColor: Colors.white,
//  primaryColorLight: const Color(0xFFC8E5FF),
//  backgroundColor:  const Color(0xFFe9eef5),
//  dialogBackgroundColor: const Color(0x80004a96),
//  cardColor: const Color(0xFFffffff),
//  dividerColor:const Color(0xFF94a5a6) ,
//  splashColor:const Color(0xFF3697d3) ,
//  selectedRowColor:Color(0xFFfaa71a) ,
//  canvasColor: const Color(0xFF662621),
//  secondaryHeaderColor: const Color(0xFF35495e),
//  cursorColor: const Color(0xFF22af5f),
//  focusColor: const Color(0xFFcc2027),
//  errorColor: const Color(0xFF22BDE6),
//  disabledColor: const Color(0xFFa48772),
//  highlightColor: const Color(0xFF5065a2),
//  indicatorColor: const Color(0xFF000000),
//  textTheme:
//  TextTheme().apply(bodyColor: Colors.black, displayColor: Colors.black),
);

ThemeData yellowTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFFf39500),
  primaryColorDark: const Color(0x80ba6700),
  // accentColor: const Color(0xFFffc646),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    secondary: const Color(0xFFffc646), // Replaces accentColor
  ),
);

ThemeData orangeTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xffc60022),
  primaryColorDark: const Color(0x808d0000),
  // accentColor: const Color(0xffff4e4b),
  colorScheme: ThemeData.light().colorScheme.copyWith(
    secondary: const Color(0xffff4e4b), // Replaces accentColor
  ),
);

//ThemeData blueTheme = ThemeData.light().copyWith(
//  hintColor: Colors.black,
//  primaryColor: const Color(0xFF004a96),
//  secondaryHeaderColor: const Color(0xFF004a96),
//  brightness: Brightness.light,
//  textTheme:
//  TextTheme().apply(bodyColor: Colors.black, displayColor: Colors.black),
//  accentColor: const Color(0xFFA6C0DA),);
