import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_models.dart';
import 'package:peliculas/src/models/vehiculo_models.dart';
import 'package:http/http.dart' as http;

class VehiculoProvider {
  String _apikey = '58ece4f5ea5201f6dc37d53153377fe5';
  String _url = "api.themoviedb.org";
  String _languaje = "es-ES";
  int _populares_page = 0;
  bool _cargando = false;
  List<Vehiculo> _populares = new List();

  /// el list de peliculas hace referencia a que va a fluir al interior del stream
  /// el broadcast es para que muchos lugares escuchando al stream
  final _popularesStreamController =
      new StreamController<List<Vehiculo>>.broadcast();

  ///proceso para introducir peliculas
  Function(List<Vehiculo>) get popularesSink =>
      _popularesStreamController.sink.add;

  ///para escuchar datos
  Stream<List<Vehiculo>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Vehiculo>> getEncines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _languaje,
    });
    return await _procesarRespueta(url);
  }

  Future<List<Vehiculo>> getPopulares() async {
    if(_cargando){
      return [];
    }
    _cargando =true;
    _populares_page++;
    print('cargando siguientes......');
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _languaje,
      'page': _populares_page.toString(),
    });
    final resultado = await _procesarRespueta(url);

    _populares.addAll(resultado);
    popularesSink(_populares);
    _cargando= false;
    return resultado;
  }

  Future<List<Vehiculo>> _procesarRespueta(Uri url) async {
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);

    // print(decodeData['results']);
    final carritos = new Vehiculos.fromJsonList(decodeData['results']);
    //(carritos.items[1].title);
    return carritos.items;
  }

  Future<List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apikey,
      'language' : _languaje
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }

  Future<List<Vehiculo>> buscarAuto(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _languaje,
      'query' :query,
    });
    return await _procesarRespueta(url);
  }

}
