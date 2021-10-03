import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:peliculas/src/widget/drawerDefault.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[_pagina1(), _pagina2(context)],
      ),
    );
  }

  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
    );
  }

  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/logo.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text('', style: estiloTexto),
          Expanded(child: Container()),
          Text('', style: estiloTexto),
          Text('', style: estiloTexto),
          Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white)
        ],
      ),
    );
  }

  ///aqui empieza la page 2
  Widget _pagina2(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // _fondoApp(),
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/img/fondoMenu.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[_titulos(), _botonesRedondeados(context)],
            ),
          )
        ],
      ),
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(1.0),
        centerTitle: true,
        title: Text(
          'Martínez Travels & Tours',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: getDrawerDefault(context),
      //bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  ///elementos para page 2

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            // Text(
            //   'Agencia de Viajes',
            //   style: TextStyle(color: Colors.white, fontSize: 18.0),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.purpleAccent, Icons.beach_access, 'Tours', context, "HomeTours"),
          _crearBotonRedondeado(Colors.blue, Icons.map, 'Paquetes', context, "HomePaquetes"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.pinkAccent, Icons.directions_car, 'Vehículos', context, "menuVehiculos"),
          _crearBotonRedondeado(Colors.orange, Icons.contact_mail, 'Encomiendas', context, "menuEncomienda"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.deepPurpleAccent, Icons.airplanemode_active, 'Vuelos', context, "HomeVuelos"),
          _crearBotonRedondeado(Colors.green, Icons.assignment, 'Asesiría Migratoria', context, "HomeAsesoria"),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.brown, Icons.add_shopping_cart, 'Servicos Adquiridos', context, "menuProductos"),
          _crearBotonRedondeado(Colors.teal, Icons.chat, 'Chat', context, "chat"),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto, BuildContext context, String ruta) {
    return ClipRect(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(color: Colors.white60, borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icono, color: Colors.white, size: 30.0),
              ),
              Text(texto, style: TextStyle(color: color)),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
    );
  }
}
