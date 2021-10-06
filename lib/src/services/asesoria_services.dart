import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/asesoria/HistoriaAsesoria_model.dart';
import 'package:peliculas/src/models/vuelos/CotizarVuelo_model.dart';
import 'package:peliculas/src/models/vuelos/VueloSave_model.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AsesoriaServices with ChangeNotifier, DiagnosticableTreeMixin {
  Future<List<HistoriaAsesoriaModel>> obtenerListaAsesoria(String idCliente) async {
    final url = '${Conf.urlServidor}Cita/CitaWeb?id_cliente=$idCliente';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final res = historiaAsesoriaModelFromJson(response.body);
      print(res);
      return res;
    } else {
      return [];
    }
  }

  Future<CotizarVueloModel> obtenerDataCotizacion() async {
    final url = '${Conf.urlServidor}promocionVuelo/cotizar';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final res = cotizarVueloModelFromJson(response.body);
      return res;
    } else {
      return null;
    }
  }

  Future<bool> guardarCotizacion(VueloSaveModel cotizacion) async {
    print("haciendo peticion de guardar cotizacion");
    final url = '${Conf.urlServidor}cotizarVuelo/cotizacionv';
    final response = await http
        .post(url, body: cotizacion.toJson(), headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return true;
    } else {
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return false;
    }
  }
}
