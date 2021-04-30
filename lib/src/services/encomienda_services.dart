import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/encomienda/detalleEncomienda_model.dart';
import 'package:peliculas/src/models/encomienda/encomienda_model.dart';
import 'package:peliculas/src/models/encomienda/historialEncomienda_model.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:http/http.dart' as http;

class EncomiendaServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<EncomiendaModel> obtenerEncomienda() async {
    print('haciendo peticion de vehiculos');
    final url = '${Conf.urlServidor}Producto/productos';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // final jsonResponse = convert.jsonDecode(response.body);
      final res = encomiendaModelFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }

  Future<HistorialEncomiendaModel> obtenerHistorial() async {
    print('haciendo peticion encomiendas');
    final url = '${Conf.urlServidor}Encomienda/show';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = historialEncomiendaModelFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }

  Future<DetalleEncomienda> obtenerDetalle(String idEncomienda) async {
    print('haciendo peticion detalle encomiendas');
    final url = '${Conf.urlServidor}Detalle_envio/detalleEnvio?id_encomienda=$idEncomienda';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = detalleEncomiendaFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }
}
