import 'package:flutter/material.dart';

import 'ColoresAgencia.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: ColorAgencia.background,
    primaryColor: ColorAgencia.purple,
    accentColor: ColorAgencia.lightblack,
    primaryColorDark: ColorAgencia.Darker,
    primaryColorLight: ColorAgencia.brighter,
    cardTheme: CardTheme(color: ColorAgencia.background),
    textTheme: TextTheme(display1: TextStyle(color: ColorAgencia.black)),
    iconTheme: IconThemeData(color: ColorAgencia.lightblack),
    bottomAppBarColor: ColorAgencia.background,
    dividerColor: ColorAgencia.lightGrey,
    colorScheme: ColorScheme(
        primary: ColorAgencia.purple,
        primaryVariant: ColorAgencia.purple,
        secondary: ColorAgencia.lightBlue,
        secondaryVariant: ColorAgencia.darkBlue,
        surface: ColorAgencia.background,
        background: ColorAgencia.background,
        error: Colors.red,
        onPrimary: ColorAgencia.Darker,
        onSecondary: ColorAgencia.background,
        onSurface: ColorAgencia.Darker,
        onBackground: ColorAgencia.titleTextColor,
        onError: ColorAgencia.titleTextColor,
        brightness: Brightness.dark),
  );

  static TextStyle titleStyle =
      const TextStyle(color: ColorAgencia.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: ColorAgencia.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}
