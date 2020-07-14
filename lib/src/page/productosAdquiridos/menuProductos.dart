import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:peliculas/src/widget/drawerDefault.dart';

class MenuProductos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[_pagina2(context)],
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

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('Servicos Adquiridos',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.blueAccent, Icons.directions_car,
              'Autos Alquilados', context, "carrosAlqui"),
          _crearBotonRedondeado(Colors.purpleAccent, Icons.beach_access,
              'Tours Asitidos', context, "toursAsistidos"),
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
