import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<Registro> {
  double screenHeight;

  String _nombre = "";
  String _usuario = "";
  String _correo = "";
  String _contrasena = "";

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
      title: Text("Registrarme"),
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
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
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
                      "Registrarme",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _inputNombre(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputUsuario(),
                  SizedBox(
                    height: 20,
                  ),
                  _inputEmail(),
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
                      Expanded(
                        child: Container(),
                      ),
                      _inputBoton(),
                    ],
                  ),
                  _inputLogin(),
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
            Text(
              "Puede completar datos adicionales en Pagina Web",
              style: TextStyle(color: Colors.grey),
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

  Widget _inputNombre() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      autofocus: false,
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

  Widget _inputUsuario() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Nombre de Usuario',
        labelText: 'Digite su Nombre de Usuario',
        helperText: 'Usuario',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String persona) {
        _usuario = persona;
        setState(() {});
      },
    );
  }

  Widget _inputEmail() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Correo Electronico',
        labelText: 'Digite su Correo Electronico',
        helperText: 'Correo Electronico',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.email),
      ),
      onChanged: (String persona) {
        _correo = persona;
        setState(() {});
      },
    );
  }

  Widget _inputContrasena() {
    return new TextField(
      textCapitalization: TextCapitalization.words,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Contraseña',
        labelText: 'Digite su Contraseña',
        helperText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.lock),
      ),
      onChanged: (String persona) {
        _contrasena = persona;
        setState(() {});
      },
    );
  }

  Widget _inputLogin() {
    return new FlatButton(
      child: Text(
        '¿Ya estoy registrado?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'login');
      },
    );
  }

  Widget _inputBoton() {
    return new FlatButton(
      child: Text("Registrarme"),
      color: Color(0xFF4B9DFE),
      textColor: Colors.white,
      padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: () {
        Navigator.pushNamed(context, 'login');
      },
    );
  }
}
