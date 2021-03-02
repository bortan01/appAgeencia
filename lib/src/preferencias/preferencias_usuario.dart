import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del uid
  get uid {
    return _prefs.getString('uid') ?? '';
  }

  set uid(String value) {
    _prefs.setString('uid', value);
  }

  // GET y SET del id_cliente
  get idCliente {
    return _prefs.getString('idCliente') ?? '';
  }

  set idCliente(String value) {
    _prefs.setString('idCliente', value);
  }

  // GET y SET del nombre
  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  // GET y SET del correo
  get correo {
    return _prefs.getString('correo') ?? '';
  }

  set correo(String value) {
    _prefs.setString('correo', value);
  }

  // GET y SET del celular
  get celular {
    return _prefs.getString('celular') ?? '';
  }

  set celular(String value) {
    _prefs.setString('celular', value);
  }

  // GET y SET del dui
  get dui {
    return _prefs.getString('dui') ?? '';
  }

  set dui(String value) {
    _prefs.setString('dui', value);
  }

  // GET y SET del foto
  get foto {
    return _prefs.getString('foto') ?? '';
  }

  set foto(String value) {
    _prefs.setString('foto', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
