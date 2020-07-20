import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';

class CourceInfoWidget extends StatelessWidget {
  final CourseModel model;

  const CourceInfoWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(
                  primaryColor: Colors.blue,
                  imagen: model.imagen,
                  width: width,
                  id: model.id),
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

  _card({Color primaryColor, String imagen, double width, int id}) {
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
          child: Center(
            child: Hero(
              tag: id,
              child: Image(
                height: 147,
                width: 98,
                fit: BoxFit.cover,
                image: NetworkImage(imagen),
              ),
            ),
          ),
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
}
