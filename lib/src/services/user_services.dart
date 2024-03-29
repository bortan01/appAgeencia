import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mime_type/mime_type.dart';
import 'package:peliculas/src/models/image/documentos_model.dart';
import 'package:peliculas/src/models/image/responseImagen_model.dart';
import 'package:peliculas/src/models/usuarios/login_model.dart';
import 'package:peliculas/src/models/usuarios/resposeUpdate_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/conf.dart';
import 'package:peliculas/src/models/usuarios/signUp_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserServices {
  final FirebaseAuth _firebaseAuth;
  PreferenciasUsuario _usuarioPref = new PreferenciasUsuario();

  //Constructor
  UserServices({FirebaseAuth firebaseAuth}) : this._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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

  // obtener datos del usuario
  Future<void> restablecerPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("usuario no encontrado");
    }
  }

  Future<Map<String, dynamic>> loginCliente(LoginModel login) async {
    print("haciendo peticion de login cliente");

    final url = '${Conf.urlServidor}Usuario/loginUser';
    final response = await http
        .post(url, body: login.toJson(), headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
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
        } else if (resp["mensaje"] == 'INVALID_PASSWORD') {
          return {"err": true, "mensaje": "Contraseña Incorrecta"};
        } else if (resp["mensaje"] ==
            'TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.') {
          return {
            "err": true,
            "mensaje":
                "acceso a esta cuenta se ha inhabilitado temporalmente debido a muchos intentos fallidos de inicio de sesión. Puede restaurarlo inmediatamente restableciendo su contraseña o puede intentarlo de nuevo más tarde."
          };
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
    _usuarioPref.paginaInicio = "home";
  }

  void eliminarPreferencias() {
    _usuarioPref.nombre = "";

    _usuarioPref.dui = "";
    _usuarioPref.uid = "";
    _usuarioPref.foto = "";
    _usuarioPref.correo = "";
    _usuarioPref.uidChat = "";
    _usuarioPref.celular = "";
    _usuarioPref.idCliente = "";
    _usuarioPref.uidAdministrador = "";
    _usuarioPref.paginaInicio = "login";
  }

  Future<Map<String, dynamic>> registrarUsuario(SignUpModel signUp) async {
    print("haciendo peticion de guardar usuario");
    final url = '${Conf.urlServidor}Usuario/registroUser';
    final data = signUp.toJson();
    final response =
        await http.post(url, body: data, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    switch (response.statusCode) {
      case 200:
        final jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse;
        break;
      case 400:
        final jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse["mensaje"] == "The email address is already in use by another account.") {
          return {"err": true, "mensaje": "Correo Electrónico ya esta registrado"};
        }
        return jsonResponse;
        break;
      case 500:
        return {"err": true, "mensaje": "erro de servidor"};
        break;
      default:
        return {"err": true, "mensaje": "por favor intente más tarde"};
        break;
    }
  }

  Future<ImagenResponse> subirFotoPerfil(File foto) {
    final PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();
    Map<String, String> qParams = {'identificador': _preferenciasUsuario.idCliente, 'tipo': 'usuario_perfil'};
    final url = Uri.parse('${Conf.urlServidor}/Imagen/savePhotoPerfil');
    return subirFoto(qParams, url, foto);
  }

  Future<ImagenResponse> subirDocumentos(File foto) {
    final PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();
    Map<String, String> qParams = {'identificador': _preferenciasUsuario.idCliente, 'tipo': 'usuario_documentos'};
    final url = Uri.parse('${Conf.urlServidor}/Imagen/save');
    return subirFoto(qParams, url, foto);
  }

  Future<ImagenResponse> subirFoto(Map<String, String> qParams, Uri url, File foto) async {
    final mimeType = mime(foto.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );
    //mimeType[0] es la imagen mimeType[1] es la extencion
    final file = await http.MultipartFile.fromPath('foto', foto.path, contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields.addAll(qParams);

    //ejecutamos la peticion
    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);

    if (res.statusCode != 200 && res.statusCode != 201) {
      return new ImagenResponse(err: true, mensaje: 'Favor intente más tarde');
    }
    //extraemos el url de la respuesta
    final respData = convert.jsonDecode(res.body);
    return new ImagenResponse.fromJson(respData);
  }

  Future<List<DocumentosModel>> getGaleriaDocumentos() async {
    final PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();
    List<DocumentosModel> listaDocumentos = [];
    print('haciendo peticion a getGaleriaDocumentos');
    final url =
        '${Conf.urlServidor}Imagen/show?tipo=usuario_documentos&identificador=${_preferenciasUsuario.idCliente}';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      jsonResponse.forEach((element) {
        listaDocumentos.add(DocumentosModel.fromJson(element));
      });
      return listaDocumentos;
    } else {
      return [];
    }
  }

  Future<DocumentosModel> getPhotoProfile() async {
    final PreferenciasUsuario _preferenciasUsuario = new PreferenciasUsuario();
    DocumentosModel photoProfile;
    print('haciendo peticion a foto de perfil');
    final url = '${Conf.urlServidor}Imagen/show?tipo=usuario_perfil&identificador=${_preferenciasUsuario.idCliente}';
    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      jsonResponse.forEach((element) {
        photoProfile = DocumentosModel.fromJson(element);
      });
      return photoProfile;
    } else {
      return null;
    }
  }

  Future<bool> eliminarFoto(String id) async {
    final url = '${Conf.urlServidor}Imagen/delete';
    final data = {'key': id};
    final response =
        await http.post(url, body: data, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    return response.statusCode == 200;
  }

  Future<ResponseUpdateModel> actulizarDatos(SignUpModel signUp) async {
    final url = '${Conf.urlServidor}Usuario/update';
    final data = signUp.toJsonForUpdate();
    data['id_cliente'] = _usuarioPref.idCliente;
    final response =
        await http.put(url, body: data, headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'});
    switch (response.statusCode) {
      case 200:
        final jsonResponse = responseUpdateModelFromJson(response.body);
        return jsonResponse;
        break;
      default:
        return null;
        break;
    }
  }

  Future<bool> actualizarFecha() async {
    final url = '${Conf.urlServidor}Usuario/updateFecha';
    print(url);
    final response = await http.put(url,
        headers: {HttpHeaders.authorizationHeader: 'Basic your_api_token_here'},
        body: {"uuid": _usuarioPref.uid, "mensajePendiente": "Nuevo Mensaje"});
    if (response.statusCode == 200) {
      // final res = response.body;
      return true;
    } else {
      // final res = response.body;
      return false;
    }
  }
}
