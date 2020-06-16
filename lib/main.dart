 import 'package:flutter/material.dart';
import 'package:peliculas/src/page/bienvenidos_page.dart';
import 'package:peliculas/src/page/home_page.dart';
import 'package:peliculas/src/page/pelicula_detalle.dart';
import 'package:peliculas/src/page/scroll_page.dart';
import 'package:peliculas/src/page/basico_page.dart';
import 'package:peliculas/src/page/alert_page.dart';
import 'package:peliculas/src/page/avatar_page.dart';
import 'package:peliculas/src/page/card_page.dart';
import 'package:peliculas/src/page/animated_container.dart';
import 'package:peliculas/src/page/input_page.dart';
import 'package:peliculas/src/page/slider_page.dart';
import 'package:peliculas/src/page/listView.dart';
import 'package:peliculas/src/page/home_componentes.dart';
import 'package:peliculas/src/page/lista_peliculas.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
      const Locale('es', 'ES'), // American English
      const Locale('en', 'US'), // Israeli Hebrew
       // ...
      ],
      title: 'Agencia Martinez Travels y Tours',
      initialRoute: '/',
      routes: {
        '/'       : (BuildContext context) => bienvenidosPage(),
        'home'       : (BuildContext context) => HomePage(),
        'homeComponentes': (BuildContext context) => HomeComponents(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
        'scrollPage' : (BuildContext context) => ScrollPage(),
        'basico' : (BuildContext context) => BasicoPage(),
        'alert' : (BuildContext context) => AlertPage(),
        'avatar': (BuildContext context) => AvatarPage(),
        'card': (BuildContext context) => CardPage(),
        'AnimateContarinerPage': (BuildContext context) => AnimateContarinerPage(),
        'inputs': (BuildContext context) => InputPage(),
        'slider': (BuildContext context) => SliderPage(),
        'list': (BuildContext context) => ListaPage(),
        'listaPeliculas': (BuildContext context) => ListaPeliculas(),

      },
    );
  }
}
