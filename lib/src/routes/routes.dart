import 'package:flutter/material.dart';
import 'package:peliculas/src/home.dart';
import 'package:peliculas/src/page/chat/ChatScreen.dart';
import 'package:peliculas/src/page/chatAdmin/WhatsAppHome.dart';
import 'package:peliculas/src/page/ejemplo/avatar_page.dart';
import 'package:peliculas/src/page/ejemplo/bienvenidos_page.dart';
import 'package:peliculas/src/page/ejemplo/home_page.dart';
import 'package:peliculas/src/page/ejemplo/pelicula_detalle.dart';
import 'package:peliculas/src/page/ejemplo/scroll_page.dart';
import 'package:peliculas/src/page/ejemplo/alert_page.dart';

import 'package:peliculas/src/page/ejemplo/card_page.dart';
import 'package:peliculas/src/page/ejemplo/animated_container.dart';
import 'package:peliculas/src/page/ejemplo/input_page.dart';
import 'package:peliculas/src/page/ejemplo/slider_page.dart';
import 'package:peliculas/src/page/ejemplo/listView.dart';
import 'package:peliculas/src/page/ejemplo/home_componentes.dart';
import 'package:peliculas/src/page/ejemplo/lista_peliculas.dart';
import 'package:peliculas/src/page/encomienda/encomienda.dart';
import 'package:peliculas/src/page/encomienda/historialEnco.dart';
import 'package:peliculas/src/page/encomienda/listaEncomienda.dart';
import 'package:peliculas/src/page/encomienda/menuEncomienda.dart';
import 'package:peliculas/src/page/paquetes/CarritoCompra.dart';
import 'package:peliculas/src/page/paquetes/DetallePaquetes.dart';
import 'package:peliculas/src/page/paquetes/HomePaquetes.dart';
import 'package:peliculas/src/page/usuarios/codigoVerificacion.dart';
import 'package:peliculas/src/page/usuarios/ingreseContra.dart';
import 'package:peliculas/src/page/usuarios/login.dart';
import 'package:peliculas/src/page/usuarios/recuperarContrasena.dart';
import 'package:peliculas/src/page/vehiculos/HomeCategoria.dart';
import 'package:peliculas/src/page/vehiculos/HomeVehiculos.dart';
import 'package:peliculas/src/page/vehiculos/DetalleVehiculos.dart';


Map<String, WidgetBuilder> getAplicationRoute() {
  return <String, WidgetBuilder>{
    'bienvenidoos': (BuildContext context) => bienvenidosPage(),
    'homeX': (BuildContext context) => HomePageX(),
    'homeComponentes': (BuildContext context) => HomeComponents(),
    'detalle': (BuildContext context) => PeliculaDetalle(),
    'scrollPage': (BuildContext context) => ScrollPage(),
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
    //MODULO PAQUETES
    'HomePaquetes': (BuildContext context) => HomePaquetes(),  
    'DetallePaquetes': (BuildContext context) => DetallePaquetes(),
    'CarritoCompra': (BuildContext context) => CarritoCompra(),  
    //MODULO CATEGORIA VEHICULO
    'carritos': (BuildContext context) => HomeCategoria(), 
    //MODULO VEHICULO
    'HomeVehiculos': (BuildContext context) => HomeVehiculos(), 
    'DetalleVehiculos': (BuildContext context) => DetalleVehiculos(), 
    //MODULO ENCOMIENDA  
    'encomienda': (BuildContext context) => EncomiendaPage(),
    'menuEncomienda': (BuildContext context) => MenuEncomienda(),
    'listaEncomienda': (BuildContext context) => ListaEncomienda(),
    'HistoEncomienda': (BuildContext context) => HistorialEncomienda(),
    //MODULO CHAT
    'chat':(BuildContext context)=> ChatScreen(),
    //MODULO DE CHAT ADMIN
    'chatAdmin':(BuildContext context)=> WhatsAppHome(),

    'login':(BuildContext context)=> Login(),
    'olvide':(BuildContext context)=> Olvide(),
    'codigo':(BuildContext context)=> Codigo(),
    'nuevaContra':(BuildContext context)=> IngreseContra(),
  };
}
