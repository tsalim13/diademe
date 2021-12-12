import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: Color(0xffF8F9FC),
  backgroundColor: Color(0xffF8F9FC),
  primaryColor: Color(0xffFBAF03),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0.0,
  ),

  //text theme
  textTheme: TextTheme(
    //default text style of Text Widget
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black87),
    subtitle1: TextStyle(color: Colors.black),
    headline3: TextStyle(),
    headline5: TextStyle(),
    headline6: TextStyle(),
    caption: TextStyle(),
    overline: TextStyle(),
  ) /*.apply(displayColor: Colors.black)*/,
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
