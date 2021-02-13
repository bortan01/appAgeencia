import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:peliculas/src/services/conf.dart';

class TurServices {
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
}
