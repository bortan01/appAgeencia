import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/vehiculo/categoria_model.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/services/conf.dart';

class VehiculoServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<VehiculosModel> obtenerVehiculos(String idModelo) async {
    print('haciendo peticion de vehiculos');
    final url = '${Conf.urlServidor}vehiculo/show?idModelo=$idModelo';
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

  
}
