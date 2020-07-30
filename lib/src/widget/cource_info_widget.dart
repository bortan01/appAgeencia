import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';

class CourceInfoWidget extends StatelessWidget {
  final CourseModel model;

  const CourceInfoWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: 200,
        width: width - 20,
        child: Row(
          children: <Widget>[_fotografia(width), _texto()],
        ));
  }

  AspectRatio _fotografia(double width) {
    return AspectRatio(
      aspectRatio: .7,
      child: Hero(
        tag: model.id.toString(),
        child: Container(
            height: 190,
            width: width * .34,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      color: Color(0x12000000))
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: new FadeInImage(
                  placeholder: AssetImage("assets/gif/loading.gif"),
                  image: NetworkImage(model.imagen),
                  fadeInDuration: Duration(milliseconds: 200),
                  fit: BoxFit.cover,
                ))),
      ),
    );
  }

  Expanded _texto() {
    return Expanded(
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
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            textAlign: TextAlign.justify,
            style: AppTheme.h6Style
                .copyWith(fontSize: 12, color: Colors.blueGrey)),
        SizedBox(height: 15),

        ///para evitar problemas por si la pantalla es peque;a

        Column(
          children: <Widget>[
            _chip(model.tag1, Colors.green, height: 5),
            SizedBox(
              height: 5.0,
            ),
            _chip(model.tag2, Colors.blue, height: 5),
          ],
        )
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
        maxLines: 1,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }
}
