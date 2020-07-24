import 'package:flutter/material.dart';

class Codigo extends StatefulWidget {
  @override
  _CodigoPageState createState() => _CodigoPageState();
}

class _CodigoPageState extends State<Codigo> {
  double screenHeight;

  String _codigo = "";

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
      title: Text("Codigo de Verificación"),
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
                      "Codigo de Verificación",
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
                  _inputUsuario(),
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
                  _inputOlvide(),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
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
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Codigo de Verificación',
        labelText: 'Digite su Codigo de Verificación',
        helperText: 'Codigo de Verificación',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String persona) {
        _codigo = persona;
        setState(() {});
      },
    );
  }

  Widget _inputOlvide() {
    return new FlatButton(
      child: Text(
        '¡A continuación ingresa tu nueva contraseña!',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
  }

  Widget _inputBoton() {
    return new FlatButton(
      child: Text("Enviar"),
      color: Color(0xFF4B9DFE),
      textColor: Colors.white,
      padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: () {
        Navigator.pushNamed(context, 'nuevaContra');
      },
    );
  }
}
