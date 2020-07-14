import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';
import 'package:peliculas/src/widget/movie_horizontal.dart';

class HomePageX extends StatelessWidget {
  final PeliculaProvider peliculaProvider = new PeliculaProvider();
  @override
  Widget build(BuildContext context) {
    peliculaProvider.getPopulares();
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Agencia Martinez y Tours"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: new Container(
        color: Colors.greenAccent,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  _swiperTarjetas() {
    return FutureBuilder(
        future: peliculaProvider.getEncines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          /// si snatshop tiene datos
          if (snapshot.hasData) {
            return new CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: new CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {
    // PeliculaProvider p = new PeliculaProvider();
    // p.getPopulares();

    return new Container(
      ///para que tome todo el espacio
      width: double.infinity,

      child: new Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new Text("populares",
                style: Theme.of(context).textTheme.subtitle1),
            padding: EdgeInsets.only(left: 25.0),
          ),
          new SizedBox(
            height: 5.0,
          ),
          new StreamBuilder(
              stream: peliculaProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return new MovieHorizontal(
                      peliculas: snapshot.data,
                      siguientePagina: peliculaProvider.getPopulares,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
