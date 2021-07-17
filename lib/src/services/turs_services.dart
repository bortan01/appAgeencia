import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/tourPaquete/InfoReserva_model.dart';
import 'package:peliculas/src/models/tourPaquete/InformacionAdicional_model.dart';
import 'package:peliculas/src/models/tourPaquete/Wompi_model.dart';
import 'package:peliculas/src/models/tourPaquete/cotizacionesByClient_model.dart';
import 'package:peliculas/src/models/tourPaquete/cotizar_model.dart';
import 'package:peliculas/src/models/tourPaquete/detalleTur_model.dart';
import 'package:peliculas/src/models/tourPaquete/historialReserva_model.dart';
import 'package:peliculas/src/models/tourPaquete/itinerario_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/conf.dart';

class TurServices with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  PreferenciasUsuario _pref = new PreferenciasUsuario();

  int get count => _count;

  void increment() {
    print("asignando el valor");
    _count++;
    notifyListeners();
  }

  Future<List<dynamic>> obtenerViaje(String tipo) async {
    print('haciendo peticion obtener tur');
    final url = '${Conf.urlServidor}TurPaquete/show?estado=1&tipo=$tipo';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return [];
    }
  }

  Future<InformacionAdicional> obtenerInformacionAdicional(String idTur) async {
    print('haciendo peticion informacion adicional');
    final url = '${Conf.urlServidor}TurPaquete/showAdicional?id_tours=$idTur';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final res = InformacionAdicional.fromJson(jsonResponse);
      return res;
    } else {
      return null;
    }
  }

  Future<InfoReservaModel> obtenerInfomacionToReserva(String idTur) async {
    print('haciendo peticion informacion de reserva 3');
    final url = '${Conf.urlServidor}TurPaquete/showReserva?id_tours=$idTur';
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final res = InfoReservaModel.fromJson(jsonResponse);
      return res;
    } else {
      return null;
    }
  }

  Future<WompiModel> guardarReserva(DetalleTurModel reserva) async {
    print("haciendo peticion de guardar reserva");
    reserva.idCliente = int.parse(_pref.idCliente);
    final url = '${Conf.urlServidor}DetalleTour/saveByClient';
    final response = await http.post(url, body: reserva.toJson());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final res = WompiModel.fromJson(jsonResponse);
      return res;
    } else {
      return null;
    }
  }

  Future<ResponseReserva> reservasByUser() async {
    final url = '${Conf.urlServidor}TurPaquete/showInfoReserva?id_cliente=${_pref.idCliente}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //TRANSFORMANDO DE STRIN A JSON
      final jsonResponse = convert.jsonDecode(response.body);
      //TRANSFORMANDO DE JSON A OBJETO
      final res = ResponseReserva.fromJson(jsonResponse);
      return res;
    } else {
      return null;
    }
  }

  Future<bool> guardaCotizacion(CotizarModel cotizacion) async {
    print("haciendo peticion de guardar cotizacion");
    final url = '${Conf.urlServidor}TurPaquete/cotizacion';
    final response = await http.post(url, body: cotizacion.toJson());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return true;
    } else {
      return false;
    }
  }

  Future<CotizacionesPaquetesCliente> obtenerCotizacionesByCliente() async {
    final url = '${Conf.urlServidor}TurPaquete/cotizacionByClient?id_cliente=${_pref.idCliente}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final cotizacion = cotizacionesPaquetesClienteFromJson(response.body);
      return cotizacion;
    } else {
      return null;
    }
  }

  Future<ItinerarioModel> obtenerItinerario(String id) async {
    final url = '${Conf.urlServidor}Itinerario/itinerarioForApp?id_tours=$id';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final cotizacion = itinerarioModelFromJson(response.body);
      return cotizacion;
    } else {
      return null;
    }
  }
}
