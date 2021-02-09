import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:peliculas/src/services/conf.dart';

class TurServices {
  obtenerTur() async {
    final url = '${Conf.urlServidor}TurPaquete/show';
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
