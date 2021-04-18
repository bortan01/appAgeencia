import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/encomienda/encomienda_model.dart';
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
}
