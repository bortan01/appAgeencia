import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/TourPaquete/detalleTur_model.dart';
import 'package:peliculas/src/models/tourPaquete/InfoReserva_model.dart';
import 'package:peliculas/src/services/conf.dart';

class TurServices with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

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

  Future<InfoReservaModel> obtenerInformacionAdicional(String idTur) async {
    print('haciendo peticion informacion adicional');
    final url = '${Conf.urlServidor}TurPaquete/showAdicional?id_tours=$idTur';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final res = InfoReservaModel.fromJson(jsonResponse);
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

  Future<dynamic> guardarReserva(DetalleTurModel reserva) async {
    print("haciendo peticion de guardar reserva");

    final url = '${Conf.urlServidor}DetalleTour/saveByClient';
    reserva.asientosSeleccionados = "1_3,1_4";
    reserva.labelAsiento = "13,41";
    reserva.descripcionProducto = "algo";
    final response = await http.post(url, body: reserva.toJson());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }
}
