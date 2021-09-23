import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vuelos/vuelos_model.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:http/http.dart' as http;

class VuelosServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<List<Promocione>> obtenerPromociones() async {
    final url = '${Conf.urlServidor}promocionVuelo/promocion';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final res = vuelosModelFromJson(response.body);
      return res.promociones;
    } else {
      return null;
    }
  }
}
