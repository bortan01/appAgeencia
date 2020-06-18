import 'package:flutter/material.dart';
import 'package:peliculas/src/home.dart';
import 'package:peliculas/src/page/ejemplo/avatar_page.dart';
import 'package:peliculas/src/page/ejemplo/bienvenidos_page.dart';
import 'package:peliculas/src/page/ejemplo/home_page.dart';
import 'package:peliculas/src/page/ejemplo/pelicula_detalle.dart';
import 'package:peliculas/src/page/ejemplo/scroll_page.dart';
import 'package:peliculas/src/page/ejemplo/basico_page.dart';
import 'package:peliculas/src/page/ejemplo/alert_page.dart';

import 'package:peliculas/src/page/ejemplo/card_page.dart';
import 'package:peliculas/src/page/ejemplo/animated_container.dart';
import 'package:peliculas/src/page/ejemplo/input_page.dart';
import 'package:peliculas/src/page/ejemplo/slider_page.dart';
import 'package:peliculas/src/page/ejemplo/listView.dart';
import 'package:peliculas/src/page/ejemplo/home_componentes.dart';
import 'package:peliculas/src/page/ejemplo/lista_peliculas.dart';
import 'package:peliculas/src/page/encomienda/encomienda.dart';
import 'package:peliculas/src/page/paquetes/HomePaquetes.dart';
import 'package:peliculas/src/page/vehiculos/HomeVehiculos.dart';

Map<String, WidgetBuilder> getAplicationRoute() {
  return <String, WidgetBuilder>{
    'bienvenidoos': (BuildContext context) => bienvenidosPage(),
    'homeX': (BuildContext context) => HomePageX(),
    'homeComponentes': (BuildContext context) => HomeComponents(),
    'detalle': (BuildContext context) => PeliculaDetalle(),
    'scrollPage': (BuildContext context) => ScrollPage(),
    'encomienda': (BuildContext context) => EncomiendaPage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'AnimateContarinerPage': (BuildContext context) => AnimateContarinerPage(),
    'inputs': (BuildContext context) => InputPage(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListaPage(),
    'listaPeliculas': (BuildContext context) => ListaPeliculas(),
    //AQUI EMPIEZAN LOS NUESTROS 
    '/': (BuildContext context) => Home(),  
    'HomePaquetes': (BuildContext context) => HomePaquetes(),  
    'carritos': (BuildContext context) => HomeVehiculos(),   
  };
}