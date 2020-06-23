import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_models.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculas = ['spiderman', 'batman', 'golden boy', 'lala', 'luffy', 'zorro'];
  final peliculasRecientes =['spiderman','capitan america '];


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: las acciones de nuestro appBar 
    //EJMPLO ICONO PARA LIMPIAR TEXTO ETC
    return [
      new IconButton(
          icon: new Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: icono a la izquierda del appBar
    return new IconButton(
        icon: new AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
         // print("cargando icono prerss");
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: crea los resultados que vamos a mostrar
    return new Center(
      child: new Container(
        height:  100.0,
        color: Colors.orange,
        child: new Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: son las sugerencias que aparecen cuando las personas escriben
    if(query.isEmpty){
      return Container();
    }
    PeliculaProvider peli = new PeliculaProvider();
    return FutureBuilder(
        future: peli.buscarPelicula(query),

        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final peliculaSeleccionada = snapshot.data;
              return new ListView(
                children:
                  peliculaSeleccionada.map((mypeli){
                    return new ListTile(
                      leading: FadeInImage(
                        image: NetworkImage(mypeli.getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: new Text(mypeli.title),
                      subtitle: new Text(mypeli.originalTitle),
                      onTap: (){
                        close(context, null);
                        mypeli.uniqueId ='';
                        Navigator.pushNamed(context, 'detalle', arguments: mypeli);
                      },
                    );
                  }).toList()
                ,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }else{
            return Center(child: CircularProgressIndicator());
          }
          }
          );


  }

  respaldoCortado(){
    final listaSugerida = (query.isEmpty)?
    peliculasRecientes : peliculas.where((p){
      return p.toLowerCase().startsWith(query.toLowerCase());
    }).toList();

    return new ListView.builder(
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.movie),
          title: new Text(listaSugerida[index]),
          onTap: (){
            seleccion =listaSugerida[index];
            showResults(context);
          },
        );
      },
      itemCount: listaSugerida.length,


    );
  }

}
