import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/services/conf.dart';

class TurServices with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;

  int get count => _count;

  void increment() {
    print("asignando el valor");
    _count++;
    notifyListeners();
  }

  Future<List<dynamic>> obtenerTur() async {
    print('haciendo peticion obtener tur');
    final url = '${Conf.urlServidor}TurPaquete/show';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return [];
    }
  }

  Future<dynamic> obtenerInformacionAdicional(String idTur) async {
    print('haciendo peticion informacion adicional');
    final url = '${Conf.urlServidor}TurPaquete/showAdicional?id_tours=$idTur';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }

  Future<dynamic> obtenerInfomacionToReserva(String idTur) async {
    print('haciendo peticion informacion de reserva');
    final url =
        '${Conf.urlServidor}TurPaquete/showReserva?id_tours=$idTur&tipo=tur';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }
}
