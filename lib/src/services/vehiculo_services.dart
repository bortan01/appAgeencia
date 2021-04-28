import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:peliculas/src/models/vehiculo/categoria_model.dart';
import 'package:peliculas/src/models/vehiculo/cotizacionResponse.dart';
import 'package:peliculas/src/models/vehiculo/cotizacionCliente_model.dart';
import 'package:peliculas/src/models/vehiculo/tipoVehiculo_model.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/services/conf.dart';

class VehiculoServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<VehiculosModel> obtenerVehiculos(String idCategoria) async {
    final url = '${Conf.urlServidor}vehiculo/show?idCategoria=$idCategoria';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = vehiculosModelFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }

  Future<List<Categoria>> obtenerCategoria() async {
    print('haciendo peticion de vehiculos');
    final url = '${Conf.urlServidor}categoriasAutos/categorias';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = categoriaModelFromJson(response.body);
      return res.categorias;
    } else {
      return [];
    }
  }

  Future<List<ModeloVehiculo>> obtenerModelo() async {
    print('haciendo peticion de vehiculos');
    final url = '${Conf.urlServidor}modeloVehiculo/modelo';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = tipoVehiculoFromJson(response.body);
      return res.modelo;
    } else {
      return [];
    }
  }

  Future<bool> guardarReserva(CotizacionClienteModel cotizacion) async {
    print("haciendo peticion de guardar cotizacion");
    final url = '${Conf.urlServidor}cotizarVehiculo/cotizar';
    final response = await http.post(url, body: cotizacion.toJson());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final res = CotizacionResponse.fromJson(jsonResponse);
      print(res.mensaje);
      return true;
    } else {
      return false;
    }
  }
}
