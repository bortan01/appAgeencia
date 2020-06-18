import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo_models.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Vehiculo> carro;
  final Function siguientePagina;

  MovieHorizontal({@required this.carro, @required this.siguientePagina});
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _scrimSize = MediaQuery.of(context).size;

    /// este metodo se dispara cada vez que se mueve el scroll horizontal
    _pageController.addListener(() {
      if (_pageController.position.pixels >=  _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _scrimSize.height * 0.33,
      child: new PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //es necesario este parametro
        itemCount: carro.length,
        // children: _tarjetas(),
        itemBuilder: (context, i) {
          return _crearTarjeta(context, carro[i]);
        },
      ),
    );
  }

  List<Widget> _tarjetas() {
    return carro.map((peli) {
      //  return Container
      return new Container(
        color: Colors.red,
        margin: const EdgeInsets.only(right: 15.0),
        child: new Column(
          children: <Widget>[
            ClipRRect(
              child: new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 200.0,
                  image: NetworkImage(
                    peli.getPosterImg(),
                  )),
              borderRadius: BorderRadius.circular(20.0),
            ),
            new Text(
              peli.title,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();
  }

  Widget _crearTarjeta(BuildContext context, Vehiculo carro) {
    carro.uniqueId = '${carro.id}-poster';
    final tarjeta = new Container(
     // color: Colors.red,
      margin: const EdgeInsets.only(right: 15.0),
      child: new Column(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              child: new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 200.0,
                  image: NetworkImage(
                    carro.getPosterImg(),
                  )),
              borderRadius: BorderRadius.circular(20.0),
            ),
            tag: carro.uniqueId,
            transitionOnUserGestures: false,
          ),
          new Text(
            carro.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return new GestureDetector(
      onTap: () {
        // print('nombre de la pelicula ${peli.toString()}');
        Navigator.pushNamed(context, 'detalle', arguments: carro);
      },
      child: tarjeta,
    );
  }
}
