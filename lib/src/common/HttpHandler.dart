import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peliculas/src/common/Constans.dart';
import 'package:peliculas/src/models/Media.dart';

class HttpHandler{
  static final _httpHandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  static HttpHandler get(){
    return _httpHandler;
  }
  Future<dynamic> getJson(Uri uri) async{
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  Future<List<Media>> fetchMovies(){
    var uri = new Uri.https(_baseUrl, "3/movie/popular",{
      'api_key' : API_KEY,
      'page' : "1",
      'language' : _language
    });

    fetchNotes();

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) =>new Media(item)).toList()
    ));
  }

  Future<List<Media>> fetchShow(){
    var uri = new Uri.https(_baseUrl, "3/tv/popular",{
      'api_key' : API_KEY,
      'page' : "1",
      'language' : _language
    });

    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) =>new Media(item)).toList()
    ));
  }
}

Future<List<Null>> fetchNotes() async {

  var ur2 = 'http://www.christianmeza.com/api/index.php';


  var response2 = await http.get(ur2);


//var responseJson = json.decode(response2.body);
//  print(responseJson);
//  print('estoy impirmiiendo');

}