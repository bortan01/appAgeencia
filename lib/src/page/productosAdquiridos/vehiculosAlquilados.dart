import 'package:flutter/material.dart';

import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';

class VehiculoAlquilado extends StatelessWidget {
  VehiculoAlquilado({Key key}) : super(key: key);

  double width;

  Widget _encabezado(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circulosContainer(300, Colors.blue)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circulosContainer(width * .5, Colors.blue)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circulosContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment(-1.0, 0.5),
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_left),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                          Align(
                              alignment: Alignment(1.0, 0.0),
                              child: Text(
                                "Vehiculos Alquilados",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _circulosContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _listado() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _courceInfo(
                CourseList.list[0], _paquetes(Colors.blueAccent, -110, -85),
                background: Colors.blue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(CourseList.list[1], _tours(), background: Colors.blue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(
                CourseList.list[2], _vehiculos(Colors.blueAccent, -110, -85),
                background: Colors.blue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(CourseList.list[3], _encomiendas(),
                background: Colors.blue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
      {Color primaryColor = Colors.blue, String imgPath, Widget backWidget}) {
    return Container(
        height: 190,
        width: width * .34,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Color(0x12000000))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: backWidget,
        ));
  }

  Widget _courceInfo(CourseModel model, Widget decoration, {Color background}) {
    return Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(primaryColor: background, backWidget: decoration),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.nombre,
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(model.descripcion,
                    style: AppTheme.h6Style
                        .copyWith(fontSize: 12, color: Colors.purple)),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    _chip(model.tag1, Colors.green, height: 5),
                    SizedBox(
                      width: 10,
                    ),
                    _chip(model.tag2, Colors.blue, height: 5),
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _paquetes(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.blue,
          ),
        ),
        Positioned(
          top: -30,
          right: -10,
          child: _circulosContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: CircleAvatar(radius: 40, backgroundColor: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _tours() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue,
            child: CircleAvatar(radius: 30, backgroundColor: Colors.blue),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child: CircleAvatar(backgroundColor: Colors.blue, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circulosContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _vehiculos(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.blue,
          ),
        ),
        Positioned(
          top: -30,
          right: -10,
          child: _circulosContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: CircleAvatar(radius: 40, backgroundColor: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _encomiendas() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue,
            child: CircleAvatar(radius: 30, backgroundColor: Colors.blue),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child: CircleAvatar(backgroundColor: Colors.blue, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circulosContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        children: <Widget>[
          _encabezado(context),
          SizedBox(height: 20),
          _listado()
        ],
      ),
    )));
  }
}
