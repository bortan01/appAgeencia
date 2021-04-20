import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/services/conf.dart';

class VehiculoServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<VehiculosModel> obtenerVehiculos() async {
    print('haciendo peticion de vehiculos');
    final url = '${Conf.urlServidor}vehiculo/vehiculos';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = vehiculosModelFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }
}
