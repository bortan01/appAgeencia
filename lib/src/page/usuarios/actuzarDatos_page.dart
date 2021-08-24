import 'package:flutter/material.dart';
import 'package:peliculas/src/models/usuarios/resposeUpdate_model.dart';
import 'package:peliculas/src/models/usuarios/signUp_model.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class ActualizarDatosPage extends StatefulWidget {
  @override
  _ActualizarDatosPagePageState createState() => _ActualizarDatosPagePageState();
}

class _ActualizarDatosPagePageState extends State<ActualizarDatosPage> {
  double screenHeight;
  PreferenciasUsuario _pref = new PreferenciasUsuario();
  String _nombre = "";
  String _correo = "";
  String _password = "";
  String _password2 = "";
  String _celular = "";
  String _dui = "";
  bool _guardando = false;
  bool _ocultarPassword1 = true;
  bool _ocultarPassword2 = true;
  final formKey = GlobalKey<FormState>();
  UserServices _userServices = new UserServices();

  @override
  void initState() {
    super.initState();
    _nombre = _pref.nombre;
    _correo = _pref.correo;
    _dui = _pref.dui;
    _celular = _pref.celular;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBarAlquiler(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            paginaFondo(),
            imagenPortada(context),
            cajaFormulario(context),
          ],
        ),
      ),
    );
  }

  Widget appBarAlquiler() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Actualizar Información"),
    );
  }

  Widget paginaFondo() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "",
            style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cajaFormulario(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      child: Text(
                        "Crear Cuenta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _inputNombre(),
                    SizedBox(height: 20),
                    _inputCorreo(),
                    SizedBox(height: 20),
                    _inputPassword(),
                    SizedBox(height: 20),
                    _inputRepetirPassoword(),
                    SizedBox(height: 20),
                    _inputCelular(),
                    SizedBox(height: 20),
                    SizedBox(height: 15),
                    _inputDui(),
                    _inputBoton(),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget imagenPortada(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/img/portada.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _inputNombre() {
    return new TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      autofocus: false,
      //envia un paramettro inplicito
      validator: (value) => helper.betweenLengthRequired(value, 40, 3),
      initialValue: _nombre,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Nombre Completo',
        labelText: 'Digite su Nombre Completo',
        helperText: 'Nombre Completo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }

  Widget _inputCorreo() {
    return new TextFormField(
      //envia un paramettro inplicito
      validator: (value) => helper.isMailRequired(value),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: _correo,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Email',
        labelText: 'Digite su Email',
        helperText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.email),
      ),
      onChanged: (String value) {
        _correo = value;
        setState(() {});
      },
    );
  }

  Widget _inputPassword() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      obscureText: _ocultarPassword1,
      // validator: (value) => helper.betweenLengthRequired(value, 20, 8),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Password',
        labelText: 'Digite su Password',
        helperText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          child: Icon(Icons.remove_red_eye),
          onTap: () {
            _ocultarPassword1 = !_ocultarPassword1;
            setState(() {});
          },
        ),
      ),
      onChanged: (String value) {
        _password = value;
        setState(() {});
      },
    );
  }

  Widget _inputRepetirPassoword() {
    return new TextFormField(
      obscureText: _ocultarPassword2,
      autofocus: false,
      validator: (value) => helper.repeatPassword(_password, _password2),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Repita su Password',
        labelText: 'Repita su Password',
        helperText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          child: Icon(Icons.remove_red_eye),
          onTap: () {
            setState(() {
              _ocultarPassword2 = !_ocultarPassword2;
            });
          },
        ),
      ),
      onChanged: (String value) {
        _password2 = value;
        setState(() {});
      },
    );
  }

  Widget _inputDui() {
    return new TextFormField(
      // inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      validator: (value) => helper.minLength(value, 10),
      initialValue: _dui,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: '12345678-9',
        labelText: 'Digite su Dui (opcional)',
        helperText: 'Dui',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.credit_card),
      ),
      onChanged: (String value) {
        _dui = value;
        setState(() {});
      },
    );
  }

  Widget _inputCelular() {
    return new TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      validator: (value) => helper.minLength(value, 8),
      initialValue: _celular,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Célular (opcional)',
        labelText: 'Digite su Célular (opcional)',
        helperText: 'Celular',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.phone),
      ),
      onChanged: (String value) {
        _celular = value;
        setState(() {});
      },
    );
  }

  Widget _inputBoton() {
    return new FlatButton(
      child: (_guardando) ? Text("Por favor espere...") : Text("Actualizar Información"),
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: (_guardando) ? null : _actualizar,
    );
  }

  void _actualizar() async {
    if (formKey.currentState.validate()) {
      //para ejecutar el on save

      _guardando = true;
      setState(() {});
      formKey.currentState.save();
      final signUp = new SignUpModel(
        nombre: _nombre.trim(),
        correo: _correo.trim(),
        password: _password.trim(),
        celular: _celular.trim(),
        dui: _dui.toString(),
      );
      ResponseUpdateModel respuesta = await _userServices.actulizarDatos(signUp);
      _guardando = false;
      setState(() {});
      if (respuesta != null) {
        helper.mostrarMensajeOk(context, "Datos Actualizados exitósamente");
        _actalizarPreferencias(respuesta);
      } else {
        helper.mostrarMensanjeError(context, "Intente más tarde");
      }
      Navigator.pop(context);
    }
  }

  void _actalizarPreferencias(ResponseUpdateModel respuesta) {
    if (respuesta.usuario.nombre != "") {
      _pref.nombre = respuesta.usuario.nombre;
    }
    if (respuesta.usuario.dui != "") {
      _pref.dui = respuesta.usuario.dui;
    }
    if (respuesta.usuario.celular != "") {
      _pref.celular = respuesta.usuario.celular;
    }
  }
}
