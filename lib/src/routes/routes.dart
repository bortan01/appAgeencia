import 'package:flutter/material.dart';
import 'package:peliculas/src/home.dart';
import 'package:peliculas/src/page/asesoria/HomeAsesoria.dart';
import 'package:peliculas/src/page/chat/ChatScreen.dart';
import 'package:peliculas/src/page/ejemplo/avatar_page.dart';
import 'package:peliculas/src/page/ejemplo/bienvenidos_page.dart';
import 'package:peliculas/src/page/ejemplo/scroll_page.dart';
import 'package:peliculas/src/page/ejemplo/alert_page.dart';
import 'package:peliculas/src/page/ejemplo/card_page.dart';
import 'package:peliculas/src/page/ejemplo/animated_container.dart';
import 'package:peliculas/src/page/ejemplo/input_page.dart';
import 'package:peliculas/src/page/ejemplo/slider_page.dart';
import 'package:peliculas/src/page/ejemplo/listView.dart';
import 'package:peliculas/src/page/ejemplo/home_componentes.dart';
import 'package:peliculas/src/page/encomienda/detalleEncomiendaPage.dart';
import 'package:peliculas/src/page/encomienda/encomienda.dart';
import 'package:peliculas/src/page/encomienda/historialEnco.dart';
import 'package:peliculas/src/page/encomienda/listaEncomienda.dart';
import 'package:peliculas/src/page/encomienda/menuEncomienda.dart';
import 'package:peliculas/src/page/inicio/pruebaList.dart';
import 'package:peliculas/src/page/productosAdquiridos/detalleHistorialVehiculo.dart';
import 'package:peliculas/src/page/productosAdquiridos/itinerario_page.dart';
import 'package:peliculas/src/page/tourPaquete/CotizacionesByClient.dart';
import 'package:peliculas/src/page/tourPaquete/HomePaquetes.dart';
import 'package:peliculas/src/page/productosAdquiridos/encomiendasRealizadas.dart';
import 'package:peliculas/src/page/productosAdquiridos/menuProductos.dart';
import 'package:peliculas/src/page/productosAdquiridos/tourPaqueteHistorial.dart';
import 'package:peliculas/src/page/productosAdquiridos/vehiculosAlquilados.dart';
import 'package:peliculas/src/page/tourPaquete/HomeTours.dart';
import 'package:peliculas/src/page/tourPaquete/cotizarTours.dart';
import 'package:peliculas/src/page/usuarios/SubirImagenes_page.dart';
import 'package:peliculas/src/page/usuarios/aboutAs_page.dart';
import 'package:peliculas/src/page/usuarios/actuzarDatos_page.dart';
import 'package:peliculas/src/page/usuarios/login.dart';
import 'package:peliculas/src/page/usuarios/recuperarContrasena.dart';
import 'package:peliculas/src/page/usuarios/registro.dart';
import 'package:peliculas/src/page/usuarios/subirDocumentos_page.dart';
import 'package:peliculas/src/page/vehiculos/FormularioAlquiler.dart';
import 'package:peliculas/src/page/vehiculos/ListaVehiculos.dart';
import 'package:peliculas/src/page/vehiculos/Menu.dart';
import 'package:peliculas/src/page/vehiculos/cotizacionesRealizadas_page.dart';
import 'package:peliculas/src/page/vehiculos/cotizarVehiculo.dart';
import 'package:peliculas/src/page/vuelos/HomeVuelos.dart';
import 'package:peliculas/src/page/vuelos/ListaPromociones.dart';

Map<String, WidgetBuilder> getAplicationRoute() {
  return <String, WidgetBuilder>{
    'bienvenidoos': (BuildContext context) => BienvenidosPage(),
    'homeComponentes': (BuildContext context) => HomeComponents(),
    'scrollPage': (BuildContext context) => ScrollPage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'AnimateContarinerPage': (BuildContext context) => AnimateContarinerPage(),
    'inputs': (BuildContext context) => InputPage(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListaPage(),
    //AQUI EMPIEZAN LOS NUESTROS
    'home': (BuildContext context) => Home(),
    //MODULO PAQUETES
    'HomePaquetes': (BuildContext context) => HomePaquetes(),
    //MODULO TOURS
    'CotizarTours': (BuildContext context) => CotizarTours(),
    'HomeTours': (BuildContext context) => HomeTours(),
    //MODULO VEHICULO
    'menuVehiculos': (BuildContext context) => HomeMenu(),
    'ListaVehiculos': (BuildContext context) => ListaVehiculos(),
    'CotizacionesRealizadasPage': (BuildContext context) => CotizacionesRealizadasPage(),
    //'DetalleVehiculos': (BuildContext context) => DetalleVehiculos(),
    'Alquiler': (BuildContext context) => Alquiler(),
    'CotizarAuto': (BuildContext context) => CotizaVehiculo(),
    //MODULO ENCOMIENDA
    'encomienda': (BuildContext context) => EncomiendaPage(),
    'menuEncomienda': (BuildContext context) => MenuEncomienda(),
    'listaEncomienda': (BuildContext context) => ListaEncomienda(),
    'HistoEncomienda': (BuildContext context) => HistorialEncomienda(),
    'DetalleEncomienda': (BuildContext context) => DetalleEncomiendaPage(),
    //MODULO CHAT
    'chat': (BuildContext context) => ChatScreen(),
    //MODULO DE USUARIO.
    'login': (BuildContext context) => Login(),
    'subirImagenes': (BuildContext context) => SubirImagenes(),
    'subirDocumentos': (BuildContext context) => SubirDocumentos(),
    'olvide': (BuildContext context) => Olvide(),
    'ActualizarDatosPage': (BuildContext context) => ActualizarDatosPage(),
    'registro': (BuildContext context) => Registro(),
    'pruebas': (BuildContext context) => PruebaList(),
    'aboutAs': (BuildContext context) => AboutAsPage(),
    //MODULO DE PRODUCTOS ADQUIRIDOS
    'menuProductos': (BuildContext context) => MenuProductos(),
    'TourPaqueteHistorial': (BuildContext context) => TourPaqueteHistorial(),
    'DetalleHistorialVehiculo': (BuildContext context) => DetalleHistorialVehiculos(),
    'carrosAlqui': (BuildContext context) => VehiculoAlquilado(),
    'enviosRealizados': (BuildContext context) => EncomiendasRealizadas(),
    'CotizacionesPaquetesPage': (BuildContext context) => CotizacionesPaquetesPage(),
    'itinerario': (BuildContext context) => ItinerarioPage(),
    // MODULO DE VUELOS
    'HomeVuelos': (BuildContext context) => HomeVuelos(),
    'VerPromociones': (BuildContext context) => ListaPromociones(),
    'HomeAsesoria': (BuildContext context) => HomeAsesoria(),

  };
}
