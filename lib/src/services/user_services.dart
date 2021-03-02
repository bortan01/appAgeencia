// import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peliculas/src/models/usuarios/login_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserServices {
  final FirebaseAuth _firebaseAuth;
  PreferenciasUsuario _usuarioPref = new PreferenciasUsuario();
  //Constructor
  UserServices({FirebaseAuth firebaseAuth})
      : this._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  //signIn with custom Token
  Future<bool> signByToken(String token) async {
    try {
      await _firebaseAuth.signInWithCustomToken(token);
      return true;
      // return _firebaseAuth.currentUser;
    } catch (e) {
      print(e.toString());
      return false;
    }
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

  Future<Map<String, dynamic>> loginCliente(LoginModel login) async {
    print("haciendo peticion de login cliente");

    final url = '${Conf.urlServidor}Usuario/loginUser';
    final response = await http.post(url, body: login.toJson());
    Map<String, dynamic> resp = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (resp['nivel'] == 'CLIENTE') {
        return resp;
      } else {
        return {"err": true, "mensaje": "Utilice otro Correo"};
      }
    } else {
      if (resp['err']) {
        if (resp["mensaje"] == 'EMAIL_NOT_FOUND') {
          return {"err": true, "mensaje": "Correo electrónico no registrado"};
        } else if (resp["mensaje"] == 'INVALID_EMAIL') {
          return {"err": true, "mensaje": "Correo electrónico no valido"};
        } else {
          return {"err": true, "mensaje": "Credenciales no validas"};
        }
      } else {
        return {"err": true, "mensaje": "Credenciales no validas"};
      }
    }
  }

  void guardarPreferencias(Map<String, dynamic> data) {
    _usuarioPref.nombre = data['nombre'];
    _usuarioPref.uid = data['user_uuid'];
    _usuarioPref.idCliente = data['id_cliente'];
    _usuarioPref.correo = data['correo'];
    _usuarioPref.celular = data['celular'];
    _usuarioPref.dui = data['dui'];
    _usuarioPref.foto = data['foto'];
  }
}
