import 'package:flutter/material.dart';
import 'ColoresAgencia.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    ///color del appbar
    primaryColor: ColorAgencia.blue3,
    //color blanco pra letras
    bottomAppBarColor: ColorAgencia.blanco,

    // primarySwatch: Colors.blue,
    // iconTheme: IconThemeData(color: ColorAgencia.lightblack),
    // dividerColor: ColorAgencia.lightGrey,
    // colorScheme: ColorScheme(
    //     primary: ColorAgencia.purple,
    //     primaryVariant: ColorAgencia.purple,
    //     ///color de los botones
    //     secondary: ColorAgencia.blue4,
    //     secondaryVariant: ColorAgencia.darkBlue,
    //     surface: ColorAgencia.blanco,
    //     background: ColorAgencia.blanco,
    //     error: Colors.red,
    //     onPrimary: ColorAgencia.Darker,
    //     onSecondary: ColorAgencia.blanco,
    //     onSurface: ColorAgencia.Darker,
    //     onBackground: ColorAgencia.titleTextColor,
    //     onError: ColorAgencia.titleTextColor,
    //     brightness: Brightness.dark),
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
