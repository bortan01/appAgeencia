import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/galeria.dart';

class Lista extends StatelessWidget {
  final ListaModel model;
  const Lista({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _titulo(),
        _poster(),
        _descripcion(),
      ],
    );
  }

  Widget _poster() {
    return Container(
        height: 320, padding: EdgeInsets.symmetric(horizontal: 15.0), child: Galeria(galeria: model.fotos));
  }

  Widget _descripcion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            model.descripcion,
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
            textAlign: TextAlign.justify,
            style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            "Toca para ver más",
            style: AppTheme.h6Style.copyWith(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 12),

        ///para evitar problemas por si la pantalla es peque;a

        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: _chip(model.tag1, Colors.green, height: 5),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: _chip(model.tag2, Colors.blue, height: 5),
            ),
          ],
        )
      ],
    );
  }

  Widget _chip(String text, Color textColor, {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        maxLines: 3,
        style: TextStyle(color: isPrimaryCard ? Colors.white : textColor, fontSize: 15),
      ),
    );
  }

  Widget _titulo() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(model.nombre,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.lightBlue, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
