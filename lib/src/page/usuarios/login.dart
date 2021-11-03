import 'package:flutter/material.dart';
import 'package:peliculas/src/models/usuarios/login_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:peliculas/src/utils/helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  double screenHeight;

  String _usuario;
  String _contrasena;
  UserServices userServices;
  bool _guardando = false;
  bool _ocultarPassword = true;

  @override
  void initState() {
    super.initState();
    userServices = new UserServices();
    _usuario = "";
    _contrasena = "";
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
      title: Text("Iniciar Sesión"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    child: Text(
                      "Iniciar Sesión",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _inputUsuario(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputContrasena(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _inputBoton(),
                    ],
                  ),
                  _inputOlvide(),
                  _registrarme(),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
          ],
        )
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

  Widget _inputUsuario() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Correo Electronico',
        labelText: 'Digite su Correo Electronico',
        helperText: 'Correo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String value) {
        setState(() {
          _usuario = value;
        });
      },
    );
  }

  Widget _inputContrasena() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      obscureText: _ocultarPassword,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Contraseña',
        labelText: 'Digite su Contraseña',
        helperText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          child: Icon(Icons.remove_red_eye),
          onTap: () {
            setState(() {
              _ocultarPassword = !_ocultarPassword;
            });
          },
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _contrasena = value;
        });
      },
    );
  }

  Widget _inputOlvide() {
    return new FlatButton(
      child: Text('¿Olvidastes tu contraseña?', style: TextStyle(color: Colors.black54)),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'olvide');
      },
    );
  }

  Widget _registrarme() {
    return new FlatButton(
      child: Text(
        '¿No estás registrado?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'registro');
      },
    );
  }

  Widget _inputBoton() {
    return new FlatButton(
      child: (_guardando) ? CircularProgressIndicator() : Text("Iniciar Sesión"),
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: (_guardando) ? null : verificarCredenciales,
    );
  }

  verificarCredenciales() async {
    setState(() {
      //para bloquear el boton guardar
      _guardando = true;
    });
    //primera consulta es solo para obtener el token
    final respuesta = await userServices.loginCliente(new LoginModel(password: _contrasena, username: _usuario.trim()
    ));
    //verificamos si todo esta bien
    if (!respuesta['err']) {
      String token = respuesta['token'];
      //inicializamos el usuaario de firebase con el token recibido
      bool existInFirebase = await userServices.signByToken(token);
      if (existInFirebase) {
        //si el usuario firebase fue identificado procedemos a guardar las preferencias
        userServices.guardarPreferencias(respuesta);
        //redireccionamos y reemplazamos la ruta
        Navigator.pushReplacementNamed(context, "home");
      } else {
        mostrarMensanjeError(context, respuesta['mensaje']);
      }
      setState(() {});
      _guardando = false;
    } else {
      mostrarMensanjeError(context, respuesta['mensaje']);
      setState(() {});
      _guardando = false;
    }
  }
}
