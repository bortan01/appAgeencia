// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peliculas/src/models/usuarios/login_model.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserServices {
  final FirebaseAuth _firebaseAuth;

  //Constructor
  UserServices({FirebaseAuth firebaseAuth})
      : this._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  //signIn with custom Token
  Future<User> signIn(String token) async {
    await _firebaseAuth.signInWithCustomToken(token);
    return _firebaseAuth.currentUser;
  }

  //signOut
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  // para consultar si esta logueado o no y quien es
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // obtener datos del usuario
  Future<String> getUser() async {
    return (_firebaseAuth.currentUser.email);
  }

  Future<dynamic> loginCliente(LoginModel login) async {
    print("haciendo peticion de login cliente");

    final url = '${Conf.urlServidor}Usuario/loginUser';
    final response = await http.post(url, body: login.toJson());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return null;
    }
  }
}
