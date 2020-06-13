import 'package:flutter/material.dart';
import 'package:peliculas/src/page/bienvenidos_page.dart';
import 'package:peliculas/src/page/home_page.dart';
import 'package:peliculas/src/page/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Agencia Martinez Travels y Tours',
      initialRoute: '/',
      routes: {
        '/'       : (BuildContext context) => bienvenidosPage(),
        'home'       : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
