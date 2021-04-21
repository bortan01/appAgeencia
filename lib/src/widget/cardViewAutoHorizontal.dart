import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/card_provider.dart';

class CardViewAutoHorizontal extends StatelessWidget {
  final int index;
  final String subtitulo;
  final String distancia;
  final String titulo;
  final AssetImage assetImage;
  final String superficie;
  final Color color;
  final Color colortexto;
  const CardViewAutoHorizontal({
    Key key,
    @required this.index,
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
    final cd = new CardProvider();
    /* Imagen */
    final imagenVehiculo = new Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: Image(
        image: assetImage,
        height: 75.0,
        width: 75.0,
        fit: BoxFit.cover,
      ),
    );
    /* Tarjeta con detalles */
    final tarjetaDetalles = Container(
        width: 250,
        height: 100.0,
        margin: new EdgeInsets.only(left: 30.0),
        /* margen Tarjeta */
        decoration: new BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 10.0, offset: Offset(0.0, 8.0))
          ], /* Aplica sombra */
        ),
        child: InkWell(
          onTap: () {
            print("el indice es " + index.toString());
            cd.cambiarCard(index);
          },
          borderRadius: new BorderRadius.circular(8.0),
          child: Container(
            margin: const EdgeInsets.only(left: 55.0, top: 12.0, right: 12.0, bottom: 12.0),
            /*  Margen del contenido dentro de la tarjeta  */
            constraints: new BoxConstraints.expand(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(titulo,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: colortexto),
                    overflow: TextOverflow.ellipsis),
                new Text(subtitulo,
                    style: TextStyle(fontSize: 12.0, color: colortexto), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ));
    /* Creamos una vista superpuesta  */
    return Container(
        margin: const EdgeInsets.all(12.0),
        child: Stack(
          children: <Widget>[
            tarjetaDetalles,
            imagenVehiculo,
          ],
        ));
  }
}
