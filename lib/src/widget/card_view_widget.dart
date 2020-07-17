import 'package:flutter/material.dart';

class CardViewAutoView extends StatelessWidget {
  final String subtitulo;
  final String distancia;
  final String titulo;
  final AssetImage assetImage;
  final String superficie;
  final Color color;
  final Color colortexto;
  const CardViewAutoView({
    Key key,
    @required this.assetImage,
    @required this.titulo,
    this.subtitulo,
    this.distancia,
    this.superficie,
    this.color = Colors.white10,
    this.colortexto = Colors.white10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    /* Imagen */
    final imagenVehiculo = new Container(
      margin: EdgeInsets.only(left: width * 0.27),
      alignment: FractionalOffset.centerLeft,
      child: Image(image: assetImage, height: 150.0, width: 150.0),
    );
    /* Tarjeta con detalles */
    final tarjetaDetalles = new Container(
        width: width,
        height: 300.0,
        /* Margen de la tarjeta */
        margin: new EdgeInsets.only(top: 35.0),
        decoration: new BoxDecoration(
          color: Color(0xFF4B9DFE),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 8.0))
          ], /* Aplica sombra */
        ),
        child: Container(
          /* Margen del contenido */
          margin: const EdgeInsets.only(
              left: 12.0, top: 75.0, right: 12.0, bottom: 12.0),
          constraints: new BoxConstraints.expand(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(titulo,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: colortexto),
                  overflow: TextOverflow.ellipsis),
              new SizedBox(height: 5.0),
              new Text(subtitulo,
                  style: TextStyle(fontSize: 14.0, color: colortexto),
                  textAlign: TextAlign.center),
              new Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.brightness_7, size: 14.0, color: Colors.amber),
                  new SizedBox(width: 5.0),
                  new Text(distancia,
                      style: TextStyle(fontSize: 12.0, color: colortexto),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              new SizedBox(height: 5.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.transfer_within_a_station,
                      size: 14.0, color: Colors.blueAccent),
                  new SizedBox(width: 5.0),
                  new Text(superficie,
                      style: TextStyle(fontSize: 12.0, color: colortexto),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
        ));
    /* Creamos una vista superpuesta  */
    return Container(
        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: new Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            tarjetaDetalles,
            imagenVehiculo,
          ],
        ));
  }
}
