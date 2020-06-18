import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
//import 'package:peliculas/src/providers/peliculas_provider.dart';

class DetallePaquetes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Paquete paquete = ModalRoute.of(context).settings.arguments;
    return Scaffold(
//        backgroundColor: Colors.blueAccent,
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(paquete),
            new SliverList(
                delegate: new SliverChildListDelegate([
              new SizedBox(
                height: 10.0,
              ),
              _posterTitulo(paquete, context),
              _descripcion(paquete),
              //_crearCasting(pelicula)
            ]))
          ],
        ));
  }

  Widget _crearAppbar(Paquete paquete) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black54,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:   EdgeInsets.symmetric(horizontal: 40.0 , vertical: 20.0),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0 , vertical: 20.0),
          child: Text(
            paquete.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          //  overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(paquete.getBackgroudImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Paquete paquete, BuildContext context) {
    print(paquete.originalTitle);
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[

          Hero(
            child: ClipRRect(
              child: new Image(
                image: NetworkImage(paquete.getPosterImg()),
                height: 150,
              ),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            tag: paquete.uniqueId,
          ),
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(

                child: new Text(
                  paquete.title,
                  style: Theme.of(context).textTheme.title,
                  overflow:
                      TextOverflow.ellipsis, //por si el titulo es muy grande
                ),

              ),
              new Text(paquete.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              new Row(
                children: <Widget>[
                  new Icon(Icons.star_border),
                  new Text(
                    paquete.voteAverage.toString(),
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _descripcion(Paquete paquete) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: new Text(
        paquete.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// poner una } al final del ultimo else y colocar <List> antes de snapshot
  /// y agregar un ultimo else con con indicator

}
