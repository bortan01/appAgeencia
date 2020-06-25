import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:peliculas/src/widget/drawerDefault.dart';

class MenuEncomienda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[_pagina2(context)],
      ),
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
                image: new AssetImage("assets/img/1.png"),
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
        backgroundColor: Theme.of(context).accentColor.withOpacity(1.0),
        title: Text('Martínez Travels & Tours',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
      ),
      drawer: getDrawerDefault(context),
      //bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  ///elementos para page 2

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(52, 152, 219, 1.0),
                Color.fromRGBO(133, 193, 233, 1.0)
              ])),
        ));

    return Stack(
      children: <Widget>[gradiente, Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('Encomienda',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: Colors.pinkAccent,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 30.0),
              title: Container()),
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(
              Colors.blue, Icons.map, 'Cotizador', context, "encomienda"),
          _crearBotonRedondeado(Colors.purpleAccent, Icons.beach_access,
              'Encomiendas', context, "envio"),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto,
      BuildContext context, String ruta) {
    return ClipRect(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ruta);
        },
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20.0)),
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
