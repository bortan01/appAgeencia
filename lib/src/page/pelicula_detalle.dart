import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_models.dart';
import 'package:peliculas/src/models/pelicula_models.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula),
            new SliverList(
                delegate: new SliverChildListDelegate([
              new SizedBox(
                height: 10.0,
              ),
              _posterTitulo(pelicula, context),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _crearCasting(pelicula)
            ]))
          ],
        ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
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
            pelicula.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          //  overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroudImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Pelicula pelicula, BuildContext context) {
    print(pelicula.originalTitle);
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[

          Hero(
            child: ClipRRect(
              child: new Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150,
              ),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            tag: pelicula.uniqueId,
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
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow:
                      TextOverflow.ellipsis, //por si el titulo es muy grande
                ),

              ),
              new Text(pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              new Row(
                children: <Widget>[
                  new Icon(Icons.star_border),
                  new Text(
                    pelicula.voteAverage.toString(),
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

  _descripcion(Pelicula pelicula) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: new Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// poner una } al final del ultimo else y colocar <List> antes de snapshot
  /// y agregar un ultimo else con con indicator
  _crearCasting(Pelicula pelicula) {
    PeliculaProvider peli = new PeliculaProvider();

    return new FutureBuilder(
        future: peli.getCast(pelicula.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return _crearActoresView(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearActoresView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: new PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: new PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) {
          return _actorTarjeta(actores[i]);
        },
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return new Container(
      color: Colors.yellowAccent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              image: new NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          new Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
