import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'modelo/ModeloInformacion.dart';

class PruebaList extends StatelessWidget {
  PruebaList({Key key}) : super(key: key);

  double width;

  Widget appBarCategorias() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Categoría: Sedan"),
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
              CourseList.list[0],
              _paquetes(),
            ),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(CourseList.list[1], _tours()),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(
              CourseList.list[2],
              _vehiculos(),
            ),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            _courceInfo(
              CourseList.list[3],
              _encomiendas(),
            ),
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
                        .copyWith(fontSize: 12, color: Colors.blueGrey)),
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

  Widget _paquetes() {
    return Center(
      child: Image(
        height: 147,
        width: 98,
        fit: BoxFit.cover,
        image: NetworkImage(
            "https://imganuncios.mitula.net/nissan_versa_2016_gasolina_nissan_versa_advance_papeles_al_dia_motor_1600_1830096592573291157.jpg"),
      ),
    );
  }

  Widget _tours() {
    return Center(
      child: Image(
        height: 147,
        width: 98,
        fit: BoxFit.cover,
        image: NetworkImage(
            "https://imotorcarsearch.s3.amazonaws.com/vehicles/large/1144595_304039_2_133edf6fc3a9b362.jpg"),
      ),
    );
  }

  Widget _vehiculos() {
    return Center(
      child: Image(
        height: 147,
        width: 98,
        fit: BoxFit.cover,
        image: NetworkImage(
            "https://autosdeprimera.com/v2/wp-content/uploads/2011/08/toyota-corolla-xei-exterior-s.jpg"),
      ),
    );
  }

  Widget _encomiendas() {
    return Center(
      child: Image(
        height: 147,
        width: 98,
        fit: BoxFit.cover,
        image: NetworkImage(
            "https://static.cargurus.com/images/site/2009/10/08/13/12/2010_hyundai_elantra-pic-7842769328096699962-640x480.jpeg"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: Column(
        children: <Widget>[appBarCategorias(), _listado()],
      ),
    )));
  }
}
