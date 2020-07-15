import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    ///color del appbar
    primaryColor: Colors.blue,

    bottomAppBarColor: Colors.white,
  );

  static TextStyle titleStyle =
      const TextStyle(color: Color(0xff5a5d85), fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: Color(0xff797878), fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}
